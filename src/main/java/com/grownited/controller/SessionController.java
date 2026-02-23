package com.grownited.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.UserDetailEntity;
import com.grownited.entity.UserEntity;
import com.grownited.entity.UserTypeEntity;
import com.grownited.repository.UserDetailRepository;
import com.grownited.repository.UserRepository;
import com.grownited.repository.UserTypeRepository;
import com.grownited.service.MailerService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SessionController {
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	UserTypeRepository userTypeRepository;
	
	@Autowired
	UserDetailRepository userDetailRepository;
	
	@Autowired
	MailerService mailerService;
	
	
	@GetMapping("/signup")
	public String openSignupPage(Model model) {
		
		List<UserTypeEntity> allUserType =  userTypeRepository.findAll();
		// userType -> send Signup ->
		model.addAttribute("allUserType",allUserType);
		return "Signup"; // jsp name 
	}
	
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}
	
	@PostMapping("/authenticate")
	public String authenticate(String email, String password, Model model,HttpSession session) {
		Optional<UserEntity> op = userRepository.findByEmail(email);
		
		if (op.isPresent()) {
			UserEntity dbUser = op.get();
			session.setAttribute("user",dbUser);
			if (dbUser.getPassword().equals(password)) {
				if (dbUser.getRole().equals("ADMIN")) {
					return "redirect:/admin-dashboard";// url
				} else if (dbUser.getRole().equals("PARTICIPANT")) {
					return "redirect:/participant-dashboard"; // url 
				} else if (dbUser.getRole().equals("JUDGE")) {
					return "redirect:/judge-dashboard";
				}
			}
		}
		
		model.addAttribute("error","Invalid credentials");
		return "Login";
		
	}
	
	@GetMapping("/forgetpassword")
	public String openForgetPassword() {
		return "ForgetPassword";
	}
	
	@PostMapping("/register")
	public String register(UserEntity userEntity, UserDetailEntity userDetailEntity) {
		System.out.println(userEntity.getFirstName());
		System.out.println(userEntity.getLastName());
		System.out.println("Processor => " + Runtime.getRuntime().availableProcessors());
		System.out.println(userDetailEntity.getCountry());
		System.out.println(userDetailEntity.getState());
		
		
		userEntity.setRole("PARTICIPANT");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
		//users insert -> UserRepository
		//new -> X
		userRepository.save(userEntity); // users insert -> userId
		userDetailEntity.setUserId(userEntity.getUserId());
		userDetailRepository.save(userDetailEntity);
		
		//welcome mail send
		mailerService.sendWelcomeMail(userEntity);
		return "Login";
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "Login";
	}
}
