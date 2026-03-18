package com.grownited.service;

import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;

@Service
public class ForgetPasswordServiceImple implements ForgetPasswordService {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	MailerService mailerService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Override
	public boolean otpMaker(String email) {
		
		Optional<UserEntity> optionalUser = userRepository.findByEmail(email);
		
		if (optionalUser.isEmpty()) {
			return false;
		}
		
		UserEntity user = optionalUser.get();
		
		// generate 6 - digit otp
		String otp = String.valueOf(new Random().nextInt(900000) + 100000);
		
		user.setOtp(otp);
		userRepository.save(user);
		
		mailerService.sendOtpEmail(user, otp);
		
		return true;
		
	}
	
	@Override
	public boolean otpVeryfier(String email, String otp) {
		Optional<UserEntity> optionalUser = userRepository.findByEmail(email);
		if (optionalUser.isEmpty()) {
			return false;
		}
		
		UserEntity user = optionalUser.get();
		return otp.equals(user.getOtp());
		
	}
	
	@Override
	public void updatePassword(String email, String newPassword) {
		UserEntity user = userRepository.findByEmail(email).orElseThrow();
		
		String encodedPassword = passwordEncoder.encode(newPassword);
		user.setPassword(encodedPassword);
		
		// otp clear after use
		user.setOtp(null);
		
		userRepository.save(user);
	}
}
