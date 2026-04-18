package com.grownited.service;

import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
//import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.grownited.entity.UserEntity;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MailerService {
	
	@Autowired
	JavaMailSender javaMailSender;
	
	@Autowired
	ResourceLoader resourceLoader;

//	public void sendWelcomeMail(UserEntity user) {
//		
//		
//		
//		SimpleMailMessage message = new SimpleMailMessage();
//		
//		message.setTo(user.getEmail());
//		message.setFrom("patanin899@gmail.com");
//		message.setSubject("Codeverse - Welcome aboard !!! ");
//		message.setText("Hey "+user.getFirstName()+", We are happy to welcome you on Codeverse.");
//		
//		javaMailSender.send(message);
//	}

	
//	public void sendWelcomeMail(UserEntity user) {
//
//	    MimeMessage message = javaMailSender.createMimeMessage();
//
//	    Resource resource =
//	            resourceLoader.getResource("classpath:templates/WelcomeMailTemplate.html");
//
//	    try {
//
//	        String html = new String(
//	                resource.getInputStream().readAllBytes(),
//	                StandardCharsets.UTF_8
//	        );
//
//	        String body = html
//	                .replace("${name}", user.getFirstName())
//	                .replace("${email}", user.getEmail())
//	                .replace("${loginUrl}", "http://localhost:9999/login")
//	                .replace("${companyName}", "CodeVerse");
//
//	        MimeMessageHelper helper = new MimeMessageHelper(message, true);
//
//	        helper.setTo(user.getEmail());
//	        helper.setSubject("Codeverse - Welcome aboard !!!");
//	        helper.setText(body, true);
//
//	        javaMailSender.send(message);
//
//	    } catch (MessagingException | IOException e) {
//	        e.printStackTrace();
//	    }
//	}
	
	public void sendWelcomeMail(UserEntity user) {

	    try {

	        MimeMessage message = javaMailSender.createMimeMessage();

	        Resource resource =
	                resourceLoader.getResource("classpath:templates/WelcomeMailTemplate.html");

	        String html = new String(
	                resource.getInputStream().readAllBytes(),
	                StandardCharsets.UTF_8
	        );

	        String body = html
	                .replace("${name}", user.getFirstName())
	                .replace("${email}", user.getEmail())
	                .replace("${loginUrl}", "http://localhost:9999/login")
	                .replace("${companyName}", "CodeVerse");

	        MimeMessageHelper helper =
	                new MimeMessageHelper(message, true, "UTF-8");

	        helper.setTo(user.getEmail());
	        helper.setSubject("Codeverse - Welcome aboard !!!");
	        helper.setText(body, true);

	        javaMailSender.send(message);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public void sendOtpEmail(UserEntity user, String otp) {
		try {
			MimeMessage otpNum = javaMailSender.createMimeMessage();
			
			MimeMessageHelper helper = new MimeMessageHelper(otpNum);
			
			helper.setTo(user.getEmail());
			helper.setSubject("Your Forget Password Otp");
			helper.setText(
					"Hello,\n\nYour OTP for password reset is: " + otp +
	                "\n\nRegards,\nCodeVerse"
			);
			
			javaMailSender.send(otpNum);
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
	
	public void sendJudgeInviteMail(UserEntity user, String tempPassword) {
		MimeMessage message = javaMailSender.createMimeMessage();
		try {
			String body = "<div style='font-family:Arial,sans-serif;line-height:1.6'>"
					+ "<h2>CodeVerse Judge Invitation</h2>"
					+ "<p>Hello " + safe(user.getFirstName()) + ",</p>"
					+ "<p>You have been invited as a <b>Judge</b> in CodeVerse.</p>"
					+ "<p><b>Login Email:</b> " + safe(user.getEmail()) + "<br/>"
					+ "<b>Temporary Password:</b> " + safe(tempPassword) + "</p>"
					+ "<p>Please login and change your password immediately.</p>"
					+ "<p><a href='http://localhost:9797/login'>Login to CodeVerse</a></p>"
					+ "<p>Thanks,<br/>CodeVerse Team</p></div>";

			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setTo(user.getEmail());
			helper.setSubject("CodeVerse - Judge Invitation");
			helper.setText(body, true);
			javaMailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	private String safe(String text) {
		return text == null ? "" : text;
	}
	
	
//	public void sendExternalInviteEmail(
//	        String email,
//	        String teamName,
//	        String hackathonTitle,
//	        String role,
//	        String inviterName,
//	        String inviterEmail
//	) {
//	    try {
//	        MimeMessage message = javaMailSender.createMimeMessage();
//
//	        String body =
//	            "<div style='font-family:Arial,sans-serif;line-height:1.6'>"
//	            + "<h2>🚀 Hackathon Team Invitation</h2>"
//
//	            + "<p><b>" + inviterName + "</b> (" + inviterEmail + ") "
//	            + "has invited you to join their team.</p>"
//
//	            + "<p><b>Hackathon:</b> " + hackathonTitle + "</p>"
//	            + "<p><b>Team:</b> " + teamName + "</p>"
//	            + "<p><b>Your Role:</b> " + role + "</p>"
//
//	            + "<br/>"
//	            + "<p>Click below to join:</p>"
//	            + "<a href='http://localhost:9797/login'>Accept Invitation</a>"
//
//	            + "<br/><br/>"
//	            + "<p>Regards,<br/>CodeVerse Team</p>"
//	            + "</div>";
//
//	        MimeMessageHelper helper = new MimeMessageHelper(message, true);
//
//	        helper.setTo(email);
//	        helper.setSubject("Team Invitation from " + inviterName);
//	        helper.setText(body, true);
//
//	        javaMailSender.send(message);
//
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	}
}