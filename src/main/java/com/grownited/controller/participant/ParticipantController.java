package com.grownited.controller.participant;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.entity.HackathonEntity;
import com.grownited.entity.UserDetailEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.HackathonRepository;
import com.grownited.repository.UserDetailRepository;
import jakarta.servlet.http.HttpSession;

@Controller
public class ParticipantController {

	@Autowired
    UserDetailRepository userDetailRepository;
	
	@Autowired
	HackathonRepository hackathonRepository;

    ParticipantController(UserDetailRepository userDetailRepository) {
        this.userDetailRepository = userDetailRepository;
    }
	
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
	
	@GetMapping("/participant/hackathon/{hackathonId}")
	public String hackathonDetails(Integer hackathonId, Model model) {
		
		Optional<HackathonEntity> opHackathon = hackathonRepository.findById(hackathonId);
		
		if(opHackathon.isEmpty()) {
			return "redirect:/participant/home";
		}
		
		HackathonEntity hackathon = opHackathon.get();
		model.addAttribute("hackathon", hackathon);

		
		return "participant/HackathonDetails";
	}

}
