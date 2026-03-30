package com.grownited.entity;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "hackathon_participant")
public class HackathonParticipantEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer hackathonTeamParticipantId;
	
	Integer hackathonId;
	Integer participantId;
	LocalDate joinedDate;
	
	
	public Integer getHackathonTeamParticipantId() {
		return hackathonTeamParticipantId;
	}
	public void setHackathonTeamParticipantId(Integer hackathonTeamParticipantId) {
		this.hackathonTeamParticipantId = hackathonTeamParticipantId;
	}
	public Integer getHackathonId() {
		return hackathonId;
	}
	public void setHackathonId(Integer hackathonId) {
		this.hackathonId = hackathonId;
	}
	public Integer getParticipantId() {
		return participantId;
	}
	public void setParticipantId(Integer participantId) {
		this.participantId = participantId;
	}
	public LocalDate getJoinedDate() {
		return joinedDate;
	}
	public void setJoinedDate(LocalDate joinedDate) {
		this.joinedDate = joinedDate;
	}
	
	
	
}
