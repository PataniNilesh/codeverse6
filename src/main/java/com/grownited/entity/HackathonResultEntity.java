package com.grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "hackathon_result")
public class HackathonResultEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer hackathonResultId;
	
	Integer hackathonId;
	Integer judgeId;
	Integer teamId;
	String innovation;
	String implementation;
	String codingStandard;
	String round;
	
	
	public Integer getHackathonResultId() {
		return hackathonResultId;
	}
	public void setHackathonResultId(Integer hackathonResultId) {
		this.hackathonResultId = hackathonResultId;
	}
	public Integer getHackathonId() {
		return hackathonId;
	}
	public void setHackathonId(Integer hackathonId) {
		this.hackathonId = hackathonId;
	}
	public Integer getJudgeId() {
		return judgeId;
	}
	public void setJudgeId(Integer judgeId) {
		this.judgeId = judgeId;
	}
	public Integer getTeamId() {
		return teamId;
	}
	public void setTeamId(Integer teamId) {
		this.teamId = teamId;
	}
	public String getInnovation() {
		return innovation;
	}
	public void setInnovation(String innovation) {
		this.innovation = innovation;
	}
	public String getImplementation() {
		return implementation;
	}
	public void setImplementation(String implementation) {
		this.implementation = implementation;
	}
	public String getCodingStandard() {
		return codingStandard;
	}
	public void setCodingStandard(String codingStandard) {
		this.codingStandard = codingStandard;
	}
	public String getRound() {
		return round;
	}
	public void setRound(String round) {
		this.round = round;
	}


	
	
}
