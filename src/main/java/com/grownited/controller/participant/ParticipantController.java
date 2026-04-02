package com.grownited.controller.participant;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.HackathonDescriptionEntity;
import com.grownited.entity.HackathonEntity;
import com.grownited.entity.HackathonTeamEntity;
import com.grownited.entity.HackathonTeamInviteEntity;
import com.grownited.entity.HackathonTeamMembersEntity;
import com.grownited.entity.UserDetailEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class ParticipantController {

	@Autowired
    UserRepository userRepository;

	@Autowired
    UserDetailRepository userDetailRepository;
	
	@Autowired
	HackathonRepository hackathonRepository;
	
	@Autowired
	HackathonDescriptionRepository hackathonDescriptionReposiotry;
	
	@Autowired
	HackathonParticipantRepository hackathonParticipantRepository;
	
	@Autowired
	HackathonTeamRepository hackathonTeamRepository;

	@Autowired
	HackathonTeamMembersRepository hackathonTeamMembersRepository;
	
	@Autowired
	HackathonTeamInviteRepository hackathonTeamInviteRepository;
		
	
	@GetMapping("/participant/participant-dashboard")
	public String participantDashboard() {
		return "particpant/ParticipantDashboard";
	}
	
	@GetMapping("participant/home")
	public String home(Model model) {
		model.addAttribute("hackathon", hackathonRepository.findAll());
		return "participant/Home";
	}
	
	@GetMapping("participant/profile")
	public String profile(String success, String error, HttpSession session, Model model) {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		
		if(user == null) {
			return "redirect:/login";
		}
		
		UserDetailEntity userDetail = userDetailRepository.findByUserId(user.getUserId()).orElse(new UserDetailEntity());
		model.addAttribute("user", user);
		model.addAttribute("userDetail", userDetail);
		model.addAttribute("success", success);
		model.addAttribute("error", error);
		
		return "participant/ParticipantProfile";
	}
	
	@PostMapping("participant/profile/save")
	@Transactional
	public String saveProfile(String firstName, String lastName,String contactNum,
			String gender,Integer birthYear, String qualification,String designation,
			String organization,String city, String state,String country,HttpSession session) {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		
		if(user == null) {
			return "redirect:/login";
		}
		if(!StringUtils.hasText(firstName) || !StringUtils.hasText(lastName)) {
			
			return "redirect:/participant/profile/?error=invalidName";
		}
		
		user.setFirstName(firstName.trim());
		user.setLastName(lastName.trim());
		user.setContactNum(StringUtils.hasText(contactNum) ? contactNum.trim() : null);
		user.setGender(StringUtils.hasText(gender) ? gender.trim() : null);
		user.setBirthYear(birthYear);
		user.setQualification(StringUtils.hasText(qualification) ? qualification.trim() : null);
		user.setDesignation(StringUtils.hasText(designation) ? designation.trim() : null);
		user.setOrganization(StringUtils.hasText(organization) ? organization.trim() : null);
		userRepository.save(user);
		
		UserDetailEntity userDetail = userDetailRepository.findByUserId(user.getUserId()).orElse(new UserDetailEntity());
		userDetail.setUserId(user.getUserId());
		userDetail.setQualification(StringUtils.hasText(qualification) ? qualification.trim() : null);
		userDetail.setCity(StringUtils.hasText(city) ? city.trim() : null);
		userDetail.setState(StringUtils.hasText(state) ? state.trim() : null);
		userDetail.setCountry(StringUtils.hasText(country) ? country.trim() : null);
		userDetailRepository.save(userDetail);
		
		session.setAttribute("user", user);
		
		return "redirect:/participant/profile?success=updated";
		
	}
	
	@GetMapping("/participant/hackathon/{hackathonId}")
	public String hackathonDetails(Integer hackathonId,String joined,String success,String error, HttpSession session, Model model) {
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		
		if(opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		HackathonEntity hackathon = opHackathon.get();
		Optional<HackathonDescriptionEntity> description = hackathonDescriptionReposiotry.findFirstByHackathonId(hackathonId);
		UserEntity user = (UserEntity) session.getAttribute("user");
		
		LocalDate today = LocalDate.now();
		boolean registrationOpen = hackathon.getRegistrationStartDate() != null && hackathon.getRegistrationEndDate() != null
				&& !today.isBefore(hackathon.getRegistrationStartDate()) && !today.isAfter(hackathon.getRegistrationEndDate());
		
		boolean alreadyRegistered = false;
		boolean alreadyInTeam = false;
		Integer teamId = null;
		HackathonTeamInviteEntity pendingInvite = null;
		if (user != null) {
			alreadyRegistered = hackathonParticipantRepository.existsByHackathonIdAndParticipantId(hackathonId, user.getUserId());
			alreadyInTeam = hackathonTeamRepository.existsByHackathonIdAndTeamLeaderId(hackathonId, user.getUserId())
					|| hackathonTeamMembersRepository.existsByHackathonIdAndMemberId(hackathonId, user.getUserId());
			teamId = findTeamIdForUser(hackathonId, user.getUserId());
			pendingInvite = hackathonTeamInviteRepository.
					findFirstByHackathonIdAndInviteduserIdAndInviteStatus(hackathonId, user.getUserId(), "PENDING")
					.orElse(null);
		}
		
		model.addAttribute("hackathon", hackathon);
		model.addAttribute("hackathonDescription", description.orElse(null));
		model.addAttribute("registrationOpen", registrationOpen);
		model.addAttribute("alreadyRegistered", alreadyRegistered);
		model.addAttribute("alreadyInTeam", alreadyInTeam);
		model.addAttribute("canJoin", user != null && registrationOpen && !alreadyRegistered);
		model.addAttribute("pendingInvite", pendingInvite);
		model.addAttribute("teamId", teamId);
		model.addAttribute("teamCount", hackathonTeamRepository.countByHackathonId(hackathonId));
		model.addAttribute("joined", joined);
		model.addAttribute("success", success);
		model.addAttribute("error", error);
		

		
		return "participant/HackathonDetails";
	}
	
	private Integer findTeamIdForUser(Integer hackathonId, Integer userId) {
		
		Optional<HackathonTeamMembersEntity> memberRow = hackathonTeamMembersRepository.findFirstByHackathonIdAndMemberId(hackathonId, userId);
		
		if (memberRow.isPresent()) {
			return memberRow.get().getTeamId();
		}
		Optional<HackathonTeamEntity> leaderTeam = hackathonTeamRepository.findFirstByHackathonIdAndTeamLeaderId(hackathonId, userId);
		return leaderTeam.map(HackathonTeamEntity::getHackathonTeamId).orElse(null);
	}

}
