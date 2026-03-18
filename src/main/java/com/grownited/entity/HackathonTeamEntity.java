package com.grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "hackathon_team")
public class HackathonTeamEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer hackathonTeamId;
	Integer hackathon_id;
	Integer team_leader_id;
	String teamName;
	String teamStatus;
	
	
	public Integer getHackathonTeamId() {
		return hackathonTeamId;
	}
	public void setHackathonTeamId(Integer hackathonTeamId) {
		this.hackathonTeamId = hackathonTeamId;
	}
	public Integer getHackathon_id() {
		return hackathon_id;
	}
	public void setHackathon_id(Integer hackathon_id) {
		this.hackathon_id = hackathon_id;
	}
	public Integer getTeam_leader_id() {
		return team_leader_id;
	}
	public void setTeam_leader_id(Integer team_leader_id) {
		this.team_leader_id = team_leader_id;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getTeamStatus() {
		return teamStatus;
	}
	public void setTeamStatus(String teamStatus) {
		this.teamStatus = teamStatus;
	}
	
	
	
	


}
