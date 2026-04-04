package com.grownited.controller.participant;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
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
import com.grownited.entity.HackathonParticipantEntity;
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
	
	@GetMapping("participant/my-hackathons")
	public String myHackathons(Model model, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		LocalDate today = LocalDate.now();
		
		Map<Integer, MyHackathonrow> rowMap = new LinkedHashMap<>();
		
		List<HackathonParticipantEntity> joinedHackathons = hackathonParticipantRepository.findByParticipantId(user.getUserId());
		for(HackathonParticipantEntity joined : joinedHackathons) {
			Optional<HackathonEntity> opHackathon = hackathonRepository.findById(joined.getHackathonId());
			if(opHackathon.isPresent()) {
				MyHackathonrow row = new MyHackathonrow();
				row.setHackathon(opHackathon.get());
				row.setTeamId(null);
				row.setTeamName("Not Joined Any Team");
				row.setLeader(false);
				row.setRoleTitle("PARTICIPANT");
				row.setTeamSize(0);
				row.setPendingInvites(0);
				row.setSubmissionEnabled(isSubmissionOpen(opHackathon.get(), today));
				rowMap.put(opHackathon.get().getHackathonId(), row);
			}
		}
		
		List<HackathonTeamEntity> leaderTeams = hackathonTeamRepository.findByTeamLeaderId(user.getUserId());
		for(HackathonTeamEntity team : leaderTeams) {
			Optional<HackathonEntity> opHackathon = hackathonRepository.findById(team.getHackathonId());
			if(opHackathon.isPresent()) {
				HackathonEntity h = opHackathon.get();
				MyHackathonrow row = new MyHackathonrow();
				row.setHackathon(h);
				row.setTeamId(team.getHackathonTeamId());
				row.setTeamName(team.getTeamName());
				row.setLeader(true);
				row.setRoleTitle("TEAM_LEADER");
				row.setTeamSize((int) hackathonTeamMembersRepository.countByTeamId(team.getHackathonTeamId()));
				row.setPendingInvites((int) hackathonTeamInviteRepository.countByTeamIdAndInviteStatus(team.getHackathonTeamId(), "PENDING"));
				row.setSubmissionEnabled(isSubmissionOpen(h, today));
				rowMap.put(h.getHackathonId(), row);
			}
		}
		
		List<HackathonTeamMembersEntity> memberships = hackathonTeamMembersRepository.findByMemberId(user.getUserId());
		for(HackathonTeamMembersEntity member : memberships) {
			if(rowMap.containsKey(member.getHackathonId())) {
				continue;
			}
			
			Optional<HackathonEntity> opHackathon = hackathonRepository.findById(member.getHackathonId());
			Optional<HackathonTeamEntity> opTeam = hackathonTeamRepository.findById(member.getTeamId());
			if(opHackathon.isPresent() && opTeam.isPresent()) {
				MyHackathonrow row = new MyHackathonrow();
				row.setHackathon(opHackathon.get());
				row.setTeamId(opTeam.get().getHackathonTeamId());
				row.setTeamName(opTeam.get().getTeamName());
				row.setLeader(user.getUserId().equals(opTeam.get().getTeamLeaderId()));
				row.setRoleTitle(member.getRoleTitle());
				row.setTeamSize((int) hackathonTeamMembersRepository.countByTeamId(opTeam.get().getHackathonTeamId()));
				row.setPendingInvites((int) hackathonTeamInviteRepository.countByTeamIdAndInviteStatus(opTeam.get().getHackathonTeamId(), "PENDING"));
				row.setSubmissionEnabled(isSubmissionOpen(opHackathon.get(), today));
				rowMap.put(opHackathon.get().getHackathonId(), row);
			}
		}
		
		model.addAttribute("myHackathons", rowMap.values());
		model.addAttribute("totalCount", rowMap.size());
		
		return "participant/MyHackathons";
		
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
			pendingInvite = hackathonTeamInviteRepository
					.findFirstByHackathonIdAndInvitedUserIdAndInviteStatus(hackathonId, user.getUserId(), "PENDING")
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
	
	@PostMapping("participant/hackathon/{hackathonId}/join")
	@Transactional
	public String joinHackathon(Integer hackathonId, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if(opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		HackathonEntity hackathon = opHackathon.get();
		LocalDate today = LocalDate.now();
		boolean registrationOpen = hackathon.getRegistrationStartDate() != null && hackathon.getRegistrationEndDate() != null 
				&& !today.isBefore(hackathon.getRegistrationStartDate()) && !today.isAfter(hackathon.getRegistrationEndDate());
		
		if(!registrationOpen) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=registrationClosed";
		}
		
		boolean alreadyRegistered = hackathonParticipantRepository.existsByHackathonIdAndParticipantId(hackathonId, user.getUserId());
		if(alreadyRegistered) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=alreadyRegistered";
		}
		
		HackathonParticipantEntity participant = new HackathonParticipantEntity();
		participant.setHackathonId(hackathonId);
		participant.setParticipantId(user.getUserId());
		participant.setJoinedDate(today);
		hackathonParticipantRepository.save(participant);
		
		return "redirect:/participant/hackathon/" + hackathonId + "?joined=true";
		
	}
	
	private Integer findTeamIdForUser(Integer hackathonId, Integer userId) {
		
		Optional<HackathonTeamMembersEntity> memberRow = hackathonTeamMembersRepository.findFirstByHackathonIdAndMemberId(hackathonId, userId);
		
		if (memberRow.isPresent()) {
			return memberRow.get().getTeamId();
		}
		Optional<HackathonTeamEntity> leaderTeam = hackathonTeamRepository.findFirstByHackathonIdAndTeamLeaderId(hackathonId, userId);
		return leaderTeam.map(HackathonTeamEntity::getHackathonTeamId).orElse(null);
	}
	
	private boolean isSubmissionOpen(HackathonEntity hackathon, LocalDate today) {
		if(hackathon == null || hackathon.getSubmissionDeadline() == null) {
			return false;
		}
		return !today.isAfter(hackathon.getSubmissionDeadline());
	}
	
	public static class MyHackathonrow {
		private HackathonEntity hackathon;
		private Integer teamId;
		private String teamName;
		private boolean leader;
		private String roleTitle;
		private int teamSize;
		private int pendingInvites;
		private boolean submissionEnabled;
		
		
		public HackathonEntity getHackathon() {
			return hackathon;
		}
		public void setHackathon(HackathonEntity hackathon) {
			this.hackathon = hackathon;
		}
		public Integer getTeamId() {
			return teamId;
		}
		public void setTeamId(Integer teamId) {
			this.teamId = teamId;
		}
		public String getTeamName() {
			return teamName;
		}
		public void setTeamName(String teamName) {
			this.teamName = teamName;
		}
		public boolean isLeader() {
			return leader;
		}
		public void setLeader(boolean leader) {
			this.leader = leader;
		}
		public String getRoleTitle() {
			return roleTitle;
		}
		public void setRoleTitle(String roleTitle) {
			this.roleTitle = roleTitle;
		}
		public int getTeamSize() {
			return teamSize;
		}
		public void setTeamSize(int teamSize) {
			this.teamSize = teamSize;
		}
		public int getPendingInvites() {
			return pendingInvites;
		}
		public void setPendingInvites(int pendingInvites) {
			this.pendingInvites = pendingInvites;
		}
		public boolean isSubmissionEnabled() {
			return submissionEnabled;
		}
		public void setSubmissionEnabled(boolean submissionEnabled) {
			this.submissionEnabled = submissionEnabled;
		}
		
		
		
	}

}
