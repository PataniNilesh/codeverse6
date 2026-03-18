package com.grownited.service;


public interface ForgetPasswordService {
	
	boolean otpMaker(String email);
	
	boolean otpVeryfier(String email, String otp);
	
	void updatePassword(String email, String newPassword);

}
