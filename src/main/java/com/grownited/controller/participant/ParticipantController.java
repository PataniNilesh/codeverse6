package com.grownited.controller.participant;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.entity.HackathonEntity;
import com.grownited.repository.HackathonRepository;

@Controller
public class ParticipantController {
	
	@Autowired
	HackathonRepository hackathonRepository;
	
	@GetMapping("/participant/participant-dashboard")
	public String participantDashboard() {
		return "particpant/ParticipantDashboard";
	}
	
	@GetMapping("participant/home")
	public String home(Model model) {
		model.addAttribute("hackathon", hackathonRepository.findAll());
		return "participant/Home";
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
