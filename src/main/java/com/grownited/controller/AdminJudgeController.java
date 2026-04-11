package com.grownited.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailerService;

@Controller
public class AdminJudgeController {

	@Autowired
	UserRepository userRepository;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	MailerService mailerService;

	@GetMapping("newJudge")
	public String newJudge() {
		return "NewJudge";
	}
	
	@PostMapping
	public String saveJudge(UserEntity userEntity, Model model) {
		Optional<UserEntity> opUser = userRepository.findByEmail(userEntity.getEmail());
		if (opUser.isPresent()) {
			model.addAttribute("error", "User already exists with this email.");
			return "NewJudge";
		}
		
		String tempPassword = generatedRandomPassword(10);
		

		userEntity.setRole("JUDGE");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		userEntity.setPasswordResetRequired(true);
		userEntity.setPassword(passwordEncoder.encode(tempPassword));
		userRepository.save(userEntity);
		
		mailerService.sendJudgeInviteMail(userEntity, tempPassword);
		return "redirect:/lsitJudge?invited=true";
	}
	
	@GetMapping("listJudge")
	public String listJudge(Model model) {
		List<UserEntity> judgeList = userRepository.findByRole("JUDGE");
		model.addAttribute("judgeList", judgeList);
		return "ListJudge";
	}
	
	private String generatedRandomPassword(int len) {
		String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789@#%";
		Random random = new Random();
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < len; i++) {
			sb.append(chars.charAt(random.nextInt(chars.length())));
		}
		return sb.toString();
	}
	
}
