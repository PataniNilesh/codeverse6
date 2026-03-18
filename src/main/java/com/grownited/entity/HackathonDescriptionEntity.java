package com.grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "hackathon_description")
public class HackathonDescriptionEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer hackathonDescriptionId;
	String hackathonDetails;
	
	
	
	
}
