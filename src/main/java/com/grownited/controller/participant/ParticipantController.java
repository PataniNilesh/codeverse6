package com.grownited.controller.participant;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ParticipantController {
	
	@GetMapping("participant-dashboard")
	public String participantDashboard() {
		return "ParticipantDashboard";
	}

}
