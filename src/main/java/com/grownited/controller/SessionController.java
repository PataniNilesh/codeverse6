package com.grownited.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.grownited.entity.UserDetailEntity;
import com.grownited.entity.UserEntity;
import com.grownited.entity.UserTypeEntity;
import com.grownited.repository.UserDetailRepository;
import com.grownited.repository.UserRepository;
import com.grownited.repository.UserTypeRepository;
import com.grownited.service.ForgetPasswordService;
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
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	ForgetPasswordService forgetPasswordService;
	
	@Autowired
	Cloudinary cloudinary;
	
	
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
			
			if(passwordEncoder.matches(password, dbUser.getPassword())) {
				session.setAttribute("user",dbUser);

			
//			if (dbUser.getPassword().equals(password)) {
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
	
	@PostMapping("/send-otp")
	public String sendOtp(String email, Model model) {
		boolean sent = forgetPasswordService.otpMaker(email);
		
		if (!sent) {
			model.addAttribute("error", "Email not registered");
			return "ForgetPassword";
		}
		
		model.addAttribute("email", email);
		return "VerifyOtp";
	}
	
	@PostMapping("/verify-otp")
	public String verifyOtp(String email, String otp, Model model) {
		boolean valid = forgetPasswordService.otpVeryfier(email, otp);
		
		if (!valid) {
			model.addAttribute("error", "Invalid OTP");
			model.addAttribute("email", email);
			return "VerifyOtp";
		}
		model.addAttribute("email", email);
		return "ResetPassword";
	}
	
	@PostMapping("/reset")
	public String resetPassword(String email, String password) {
		forgetPasswordService.updatePassword(email, password);
		return "redirect:/login";
	}
	
	@PostMapping("/register")
	public String register(UserEntity userEntity, UserDetailEntity userDetailEntity, MultipartFile profilePic) {
				
		System.out.println(userEntity.getFirstName());
		System.out.println(userEntity.getLastName());
		System.out.println("Processor => " + Runtime.getRuntime().availableProcessors());
		System.out.println(userDetailEntity.getCountry());
		System.out.println(userDetailEntity.getState());
		
		
		userEntity.setRole("PARTICIPANT");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
		//encode password
		String encodedPassword = passwordEncoder.encode(userEntity.getPassword());
		System.out.println(encodedPassword);
		
		userEntity.setPassword(encodedPassword);
		
		// file uploading
		System.out.println(profilePic.getOriginalFilename());
		
		try {
			Map map = cloudinary.uploader().upload(profilePic.getBytes(), null);
			String profilePicUrl = map.get("secure_url").toString();
			System.out.println(profilePicUrl);
			userEntity.setProfilePicUrl(profilePicUrl);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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
