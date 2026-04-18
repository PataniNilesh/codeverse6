package com.grownited.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.repository.HackathonRepository;
import com.grownited.repository.UserRepository;

@Controller
public class AdminController {
	

	@Autowired
	HackathonRepository hackathonRepository;

	@Autowired
	UserRepository userRepository;
	
	@GetMapping(value = {"admin-dashboard","/"})
	public String adminDashboard(Model model) {
		long totalHackathon = hackathonRepository.count();
		long totalUpcoming = hackathonRepository.countByStatus("UPCOMING");
		long totalCompleted = hackathonRepository.countByStatus("COMPLETED");
		long totalParticipant = userRepository.countByRole("PARTICIPANT");

		model.addAttribute("totalHackathon", totalHackathon);
		model.addAttribute("totalUpcoming", totalUpcoming);
		model.addAttribute("totalCompleted", totalCompleted);
		model.addAttribute("totalParticipant", totalParticipant);
		
		// chart
				List<Object[]> data = userRepository.getMonthUserCount();

				List<String> months = new ArrayList<>();
				List<Long> counts = new ArrayList<>();

				for(Object[] row : data) {
				    months.add((String) row[0]);
				    counts.add((Long) row[1]);
				}

				model.addAttribute("months", months);
				model.addAttribute("counts", counts);
		
		return "AdminDashboard";
	}
}
