package com.grownited.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.UserDetailEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;

@Controller
public class SessionController {
	@Autowired
	UserRepository userRepository;
	
	
	@GetMapping("/signup")
	public String openSignupPage() {
		return "Signup"; // jsp name 
	}
	
	
	@GetMapping("/login")
	public String openLoginPage() {
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
		userRepository.save(userEntity);
		
		userDetailEntity.setUserId(userEntity.getUserId());
		
		return "Login";
	}

}
