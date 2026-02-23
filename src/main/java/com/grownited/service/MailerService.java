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
	

}