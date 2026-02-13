package com.grownited.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.entity.UserDetailEntity;
import com.grownited.entity.UserEntity;
import com.grownited.repository.UserDetailRepository;
import com.grownited.repository.UserRepository;

@Controller
public class UserController {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	UserDetailRepository userDetailRepository;
	
	@GetMapping("listuser")
	public String listUser(Model model) {
		
		List<UserEntity> allUser = userRepository.findAll();
		model.addAttribute("userList",allUser);
		return "ListUser";
	}
	
	@GetMapping("viewuser") 
	public String viewUser(Integer userId, Model model) {
		
		// read userId
		// select * from users here userId = rock?
		Optional<UserEntity> op = userRepository.findById(userId); // optional
		Optional<UserDetailEntity> opUserDetail = userDetailRepository.findByUserId(userId);
		if (op.isEmpty()) {
			// error set
			// list redirect
			return "";
		} else {
			
			UserEntity userEntity = op.get();
			UserDetailEntity userDetailEntity = opUserDetail.get();
			
			model.addAttribute("user",userEntity);
			model.addAttribute("userDetail", userDetailEntity);
			return "ViewUser";
			
		}
		
	}

}
