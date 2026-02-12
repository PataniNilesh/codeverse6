package com.grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.UserTypeEntity;
import com.grownited.repository.UserTypeRepository;


@Controller 
public class UserTypeController {

	@Autowired
	UserTypeRepository userTypeRepository;
	
	@GetMapping("newUserType")
	public String newUserType() {
		return "NewUserType";
	}
	
	@PostMapping("saveUserType")
	public String saveUserType(UserTypeEntity userTypeEntity) {
		userTypeRepository.save(userTypeEntity);
		return "AdminDashboard"; 
	}
}