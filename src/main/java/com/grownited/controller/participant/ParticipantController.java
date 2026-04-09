package com.grownited.controller.participant;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.grownited.controller.AdminController;
import com.grownited.entity.HackathonDescriptionEntity;
import com.grownited.entity.HackathonEntity;
import com.grownited.entity.HackathonParticipantEntity;
import com.grownited.entity.HackathonSubmissionEntity;
import com.grownited.entity.HackathonTeamEntity;
import com.grownited.entity.HackathonTeamInviteEntity;
import com.grownited.entity.HackathonTeamMembersEntity;
import com.grownited.entity.UserDetailEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class ParticipantController {

    private final AdminController adminController;


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
	
	@Autowired
	HackathonSubmissionRepository hackathonSubmissionRepository;

	
	
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
	
	@PostMapping("participant/hackathon/{hackathonId}/team")
	@Transactional
	public String manageTeam(Integer hackathonId, HttpSession session, Model model, String success, String error) {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if(opHackathon.isEmpty()) {
			return "redirect:/particiapnt/home";
		}
		
		Integer teamId = findTeamIdForUser(hackathonId, user.getUserId());
		boolean joinedHackathon = hackathonParticipantRepository.existsByHackathonIdAndParticipantId(hackathonId, user.getUserId());
		
		if(!joinedHackathon) {
			return "redirect/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		boolean hasTeam = teamId != null;
		boolean isTeamLeader = false;
		HackathonTeamEntity team = null;
		HackathonTeamInviteEntity pendingInvite = null;
		HackathonTeamEntity pendingInviteTeam = null;
		List<HackathonTeamMembersEntity> teamMembers = new ArrayList<>();
		Map<Integer, UserEntity> memberMap = new HashMap<>();
		List<UserEntity> participantUsers = new ArrayList<>();
		List<HackathonTeamInviteEntity> inviteList = new ArrayList<>();
		
		
		if(hasTeam) {
			Optional<HackathonTeamEntity> opTeam = hackathonTeamRepository.findById(teamId);
			if(opTeam.isEmpty()) {
				return "redirect:/participant/hakcathon/" + hackathonId + "?error=notRegistered";
			}
			team = opTeam.get();
			isTeamLeader = user.getUserId().equals(team.getTeamLeaderId());
			
			teamMembers = hackathonTeamMembersRepository.findByTeamIdOrderByHackathonTeamMemberIdAsc(teamId);
			for(HackathonTeamMembersEntity member : teamMembers) {
				Optional<UserEntity> opMember = userRepository.findById(member.getMemberId());
				opMember.ifPresent(userEntity -> memberMap.put(member.getMemberId(), userEntity));
			}
			
			List<Integer> existingMemberIds = teamMembers.stream().map(HackathonTeamMembersEntity::getMemberId)
					.collect(Collectors.toList());
			List<Integer> joinedParticipantIds = hackathonParticipantRepository.findByHackathonId(hackathonId)
					.stream().map(HackathonParticipantEntity::getParticipantId).collect(Collectors.toList());
			participantUsers = userRepository.findAllById(joinedParticipantIds).stream()
					.filter(u -> "PARTICIPANT".equals(u.getRole()))
					.filter(u -> u.getActive() != null && u.getActive())
					.filter(u -> !existingMemberIds.contains(u.getUserId()))
					.filter(u -> !u.getUserId().equals(user.getUserId()))
					.filter(u -> !hackathonTeamMembersRepository.existsByHackathonIdAndMemberId(hackathonId, user.getUserId()))
					.collect(Collectors.toList());
			
			inviteList = hackathonTeamInviteRepository.findByTeamIdOrderByHackathonTeamInviteIdDesc(teamId);
		} else {
			pendingInvite = hackathonTeamInviteRepository
					.findFirstByHackathonIdAndInvitedUserIdAndInviteStatus(hackathonId, user.getUserId(), "PENDING")
					.orElse(null);
			if(pendingInvite != null && pendingInvite.getTeamId() != null) {
				pendingInviteTeam = hackathonTeamRepository.findById(pendingInvite.getTeamId()).orElse(null);
				
			}
		}
		
		List<HackathonTeamEntity> availableTeams = hackathonTeamRepository.findByHackathonId(hackathonId);
		availableTeams = availableTeams.stream().filter(t -> {
			long size = hackathonTeamMembersRepository.countByTeamId(t.getHackathonTeamId());
			return opHackathon.get().getMaxTeamSize() == null || size < opHackathon.get().getMaxTeamSize();
		}).collect(Collectors.toList());
		if(hasTeam) {
			Integer myTeamId = teamId;
			availableTeams = availableTeams.stream().filter(t -> !t.getHackathonTeamId().equals(myTeamId)).collect(Collectors.toList());		
		}
		
		model.addAttribute("hackathon", opHackathon.get());
		model.addAttribute("teamId", teamId);
		model.addAttribute("teamMembers", teamMembers);
		model.addAttribute("memberMap", memberMap);
		model.addAttribute("participantUsers", participantUsers);
		model.addAttribute("inviteList", inviteList);
		model.addAttribute("teams", team);
		model.addAttribute("isTeamLeader", isTeamLeader);
		model.addAttribute("hasTeam", hasTeam);
		model.addAttribute("pendingInvite", pendingInvite);
		model.addAttribute("pendingInviteTeam", pendingInviteTeam);
		model.addAttribute("availableTeams", availableTeams);
		model.addAttribute("teamSizeCount", teamMembers.size());
		model.addAttribute("teamMaxSize", opHackathon.get().getMaxTeamSize());
		boolean inviteAllowed = opHackathon.get().getRegistrationEndDate() == null 
				|| !LocalDate.now().isAfter(opHackathon.get().getRegistrationEndDate());
		model.addAttribute("inviteAllowed", inviteAllowed);
		model.addAttribute("succes", success);
		model.addAttribute("error", error);			
		return "participant/ManageTeam";
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/team/create")
	@Transactional
	public String createTeam(Integer hackathonId ,String teamName, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		if(!hackathonParticipantRepository.existsByHackathonIdAndParticipantId(hackathonId, user.getUserId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		Integer existingTeamId = findTeamIdForUser(hackathonId, user.getUserId());
		if(existingTeamId != null) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=alreadyInHackathon";
		}
		
		if(!StringUtils.hasText(teamName)) {
			return "redirect:participant/hackathon/" + hackathonId + "/team?error=invalidTeamName";
		}
		
		HackathonTeamEntity team = new HackathonTeamEntity();
		team.setHackathonId(hackathonId);
		team.setTeamLeaderId(user.getUserId());
		team.setTeamStatus("QUALIFY");
		team.setTeamName(teamName.trim());
		hackathonTeamRepository.save(team);
		
		HackathonTeamMembersEntity leaderMember = new HackathonTeamMembersEntity();
		leaderMember.setTeamId(team.getHackathonTeamId());
		leaderMember.setHackathonId(hackathonId);
		leaderMember.setMemberId(user.getUserId());
		leaderMember.setRoleTitle("TEAM_LEADER");
		hackathonTeamMembersRepository.save(leaderMember);
		
		return "redirect:/participant/hackathon/" + hackathonId + "/team?success=teamCreated";
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/team/join-team")
	@Transactional
	public String joinExistingTeam(Integer hackathonId,Integer joinTeamId, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		if(!hackathonParticipantRepository.existsByHackathonIdAndParticipantId(hackathonId, user.getUserId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		Integer existingTeamId = findTeamIdForUser(hackathonId, user.getUserId());
		if(existingTeamId != null) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=alreadyInHackathon";
		}
		
		Optional<HackathonTeamEntity> opTeam = hackathonTeamRepository.findById(joinTeamId);
		if (opTeam.isEmpty() || !hackathonId.equals(opTeam.get().getHackathonId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=invalidTeam";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if (opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		if (opHackathon.get().getRegistrationEndDate() != null 
				&& LocalDate.now().isAfter(opHackathon.get().getRegistrationEndDate())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=inviteClosed";
		}
		
		long teamSize = hackathonTeamMembersRepository.countByTeamId(joinTeamId);
		Integer maxSize = opHackathon.get().getMaxTeamSize();
		if (maxSize != null && teamSize >= maxSize) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=teamFull";
		}
		
		HackathonTeamMembersEntity member = new HackathonTeamMembersEntity();
		member.setTeamId(joinTeamId);
		member.setHackathonId(hackathonId);
		member.setMemberId(user.getUserId());
		member.setRoleTitle("MEMBER");
		hackathonTeamMembersRepository.save(member);
		
		return "redirect:/participant/hackathon/" + hackathonId + "/team?success=teamJoined";
		
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/team/invite-member")
	@Transactional
	public String inviteRegisteredMember(Integer hackathonId,Integer invitedUserId,HttpSession session) {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if (opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		if (opHackathon.get().getRegistrationEndDate() != null 
				&& LocalDate.now().isAfter(opHackathon.get().getRegistrationEndDate())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=inviteclosed";
		}
		
		Integer teamId = findTeamIdForUser(hackathonId, user.getUserId());
		if (teamId == null) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		Optional<HackathonTeamEntity> opTeam = hackathonTeamRepository.findById(teamId);
		if(opTeam.isEmpty() || !user.getUserId().equals(opTeam.get().getTeamLeaderId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=notLeader";
		}
		
		long teamSize = hackathonTeamMembersRepository.countByTeamId(teamId);
		if (opHackathon.get().getMaxTeamSize() != null && teamSize >= opHackathon.get().getMaxTeamSize()) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=teamFull";
		}
		
		Optional<UserEntity> opInvited = userRepository.findById(invitedUserId);
		if (opInvited.isEmpty() || !"PARTICIPANT".equals(opInvited.get().getRole())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=invalidUser";
		}
		
		boolean alreadyInHackathon = hackathonTeamMembersRepository.existsByHackathonIdAndMemberId(hackathonId, invitedUserId);
		if (alreadyInHackathon) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=alreadyInHackathon";
		}
		
		boolean pendingInviteExists = hackathonTeamInviteRepository.existsByHackathonIdAndInvitedUserIdAndInviteStatus(hackathonId, invitedUserId, "PENDING");
		if (pendingInviteExists) {
			return "redirect:/particiapnt/hackathon/" + hackathonId + "/team?error=inviteExists";
		}
		
		HackathonTeamInviteEntity internalInvite = new HackathonTeamInviteEntity();
		internalInvite.setTeamId(teamId);
		internalInvite.setHackathonId(hackathonId);
		internalInvite.setInvitedBy(user.getUserId());
		internalInvite.setInviteType("INTERNAL");
		internalInvite.setInvitedUserId(invitedUserId);
		internalInvite.setInvitedEmail(opInvited.get().getEmail());
		internalInvite.setRoleTitle("MEMBER");
		internalInvite.setInviteStatus("PENDING");
		internalInvite.setCreatedAt(LocalDate.now());
		hackathonTeamInviteRepository.save(internalInvite);
		
		return "redirect:/participant/hackathon/" + hackathonId + "/team?succes=memberInvited";
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/team/invite-external");
	@Transactional
	public String inviteExternalMember(HttpSession session, Integer hackathonId,String roleTitle, String externalEmail) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if (opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		Integer teamId = findTeamIdForUser(hackathonId, user.getUserId());
		if (teamId == null) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		Optional<HackathonTeamEntity> opTeam = hackathonTeamRepository.findById(teamId);
		if (opTeam.isEmpty() || !user.getUserId().equals(opTeam.get().getTeamLeaderId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=notLeader";
		}
		
		if (!StringUtils.hasText(externalEmail) || !externalEmail.contains("@")) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=invalidEmail";
		}
		
		boolean duplicatePending = hackathonTeamInviteRepository.existsByTeamIdAndInvitedEmailAndInviteStatus(teamId, externalEmail.trim(), "PENDING");
		if (duplicatePending) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=inviteExists"; 
		}
		
		HackathonTeamInviteEntity externalInvite = new HackathonTeamInviteEntity();
		externalInvite.setTeamId(teamId);
		externalInvite.setHackathonId(hackathonId);
		externalInvite.setInvitedBy(user.getUserId());
		externalInvite.setInviteType("EXTERNAL");
		externalInvite.setInvitedEmail(externalEmail.trim());
		externalInvite.setRoleTitle(StringUtils.hasText(roleTitle) ? roleTitle.trim() : "MEMBER");
		externalInvite.setInviteStatus("PENDING");
		externalInvite.setCreatedAt(LocalDate.now());
		hackathonTeamInviteRepository.save(externalInvite);
		
		return "redirect:/participant/hackathon/" + hackathonId + "/team?success=externalInvited";
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/team/remove-member")
	@Transactional
	public String removeMember(Integer hackathonId,Integer memberId,HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		Integer teamId = findTeamIdForUser(hackathonId, user.getUserId());
		if (teamId == null) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		Optional<HackathonTeamEntity> opteam = hackathonTeamRepository.findById(teamId);
		if (opteam.isEmpty() || !user.getUserId().equals(opteam.get().getTeamLeaderId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=notLeader";
		}
		
		if(memberId.equals(opteam.get().getTeamLeaderId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=cannotRemoveLeader";
		}
		
		Optional<HackathonTeamMembersEntity> opMember = hackathonTeamMembersRepository.findFirstByTeamIdAndMemberId(teamId, memberId);
		if (opMember.isEmpty()) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=memberNotFound";
		}
		
		hackathonTeamMembersRepository.deleteById(opMember.get().getHackathonTeamMemberId());
		return "redirect:/participant/hackathon/" + hackathonId + "/team?success=memberRemoved";
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/invite/{inviteId}/accept")
	@Transactional
	public String acceptInvitation(Integer hackathonId, Integer inviteId, HttpSession session) {
		return handleInvitationResponse(hackathonId, inviteId, session, true, false);
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/invite/{inviteId}/reject")
	@Transactional
	public String rejectInvitation(Integer hackathonId, Integer inviteId, HttpSession session) {
		return handleInvitationResponse(hackathonId, inviteId, session, false, false);
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/team/invite/{inviteId}/accept")
	@Transactional
	public String acceptInvitationFromTeamPage((Integer hackathonId, Integer inviteId, HttpSession session) {
		return handleInvitationResponse(hackathonId, Integer, session, true, true);
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/team/invite/{inviteId}/reject")
	@Transactional
	public String rejectInvitationFromTeamPage((Integer hackathonId, Integer inviteId, HttpSession session) {
		return handleInvitationResponse(hackathonId, Integer, session, false, true);
	}
	
	
	private String handleInvitationResponse(Integer hackathonId,Integer inviteId ,HttpSession session,boolean accept, boolean redirectToHomePage) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		String basePath = "redirect:/participant/hackathon/" + hackathonId;
		if (redirectToHomePage) {
			basePath += "/team";
		}
		
		Optional<HackathonTeamInviteEntity> opInvite = hackathonTeamInviteRepository.findById(inviteId);
		if (opInvite.isEmpty()) {
			return basePath + "?error=inviteNotFound";
		}
		
		HackathonTeamInviteEntity invite = opInvite.get();
		if (!"PENDING".equals(invite.getInviteStatus()) || invite.getHackathonId() == null 
				|| !invite.getHackathonId().equals(hackathonId) ||invite.getInvitedUserId() == null 
				|| !invite.getInvitedUserId().equals(user.getUserId())) {
			return basePath + "?error=inviteInvalid";
		}
		
		if (!accept) {
			invite.setInviteStatus("REJECTED");
			hackathonTeamInviteRepository.save(invite);
			return basePath + "?success=inviteRejected";
		}
		
		boolean alreadyInHackathon = hackathonTeamMembersRepository.existsByHackathonIdAndMemberId(hackathonId, user.getUserId());
		if(alreadyInHackathon) {
			invite.setInviteStatus("REJECTED");
			hackathonTeamInviteRepository.save(invite);
			return basePath + "/error=alredyInHackathon";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if (opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		ensureParticipantRegistration(hackathonId, user.getUserId());
		
		long teamSize = hackathonTeamMembersRepository.countByTeamId(invite.getTeamId());
		Integer maxSize = opHackathon.get().getMaxTeamSize();
		if (maxSize != null && teamSize >= maxSize) {
			return basePath + "?error=teamFull";
		}
		
		HackathonTeamMembersEntity member = new HackathonTeamMembersEntity();
		member.setTeamId(invite.getTeamId());
		member.setHackathonId(hackathonId);
		member.setMemberId(user.getUserId());
		member.setRoleTitle(StringUtils.hasText(invite.getRoleTitle()) ? invite.getRoleTitle() : "MEMBER");
		hackathonTeamMembersRepository.save(member);
		
		invite.setInviteStatus("ACCEPTED");
		hackathonTeamInviteRepository.save(invite);
		return basePath + "?success=inviteAccepted";
	}
	
	@GetMapping("participant/hackathon/{hackathonId}/submission")
	public String openSubmission(Integer hackathonId, HttpSession session, Model model, String success, String error) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if(user == null) {
			return "redirect:/login";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if (opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		if (!isSubmissionOpen(opHackathon.get(), LocalDate.now())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=submissionClosed";
		}
		
		Integer teamId = findTeamIdForUser(hackathonId, user.getUserId());
		if (teamId == null) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		Optional<HackathonTeamEntity> opTeam = hackathonTeamRepository.findById(teamId);
		if (opTeam.isEmpty() || !user.getUserId().equals(opTeam.get().getTeamLeaderId())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/team?error=notLeader";
		}
		
		HackathonSubmissionEntity submission = hackathonSubmissionRepository.findByHackathonIdAndTeamId(hackathonId, teamId)
				.orElse(new HackathonSubmissionEntity());
		submission.setHackathonId(hackathonId);
		submission.setTeamId(teamId);
		
		model.addAttribute("hackathon", opHackathon.get());
		model.addAttribute("submission", submission);
		model.addAttribute("success", success);
		model.addAttribute("error", error);
		return "participant/HackathonSubmission";
	}
	
	@PostMapping("participant/hackathon/{hackathonId}/submission/save")
	@Transactional
	public String saveSubmission(Integer hackathonId,HackathonSubmissionEntity formSubmission, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) {
			return "reirect:/login";
		}
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		if (opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		if (!isSubmissionOpen(opHackathon.get(), LocalDate.now())) {
			return "redirect:/participant/hackathon/" + hackathonId + "/submission?error=submissionClosed";
		}
		
		Integer teamId = findTeamIdForUser(hackathonId, user.getUserId());
		if (teamId == null) {
			return "redirect:/participant/hackathon/" + hackathonId + "?error=notRegistered";
		}
		
		HackathonSubmissionEntity submission = hackathonSubmissionRepository.findByHackathonIdAndTeamId(hackathonId, teamId)
				.orElse(new HackathonSubmissionEntity());
		
		submission.setHackathonId(hackathonId);
		submission.setTeamId(teamId);
		submission.setCodeBaseUrl(formSubmission.getCodeBaseUrl());
		submission.setDocumentationUrl(formSubmission.getDocumentationUrl());
		submission.setSubmitedDate(LocalDate.now());
		hackathonSubmissionRepository.save(submission);
		
		return "redirect:/participant/hackathon/" + hackathonId + "/submission?success=saved";
	}
	
	private void ensureParticipantRegistration(Integer hackathonId, Integer userId) {
		boolean exists = hackathonParticipantRepository.existsByHackathonIdAndParticipantId(hackathonId, userId);
		if(exists) {
			return;
		}
		
		HackathonParticipantEntity participant = new HackathonParticipantEntity();
		participant.setHackathonId(hackathonId);
		participant.setParticipantId(userId);
		participant.setJoinedDate(LocalDate.now());
		hackathonParticipantRepository.save(participant);
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
