package com.grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.HackathonTeamEnviteEntity;
import com.grownited.entity.HackathonTeamInviteEntity;
import java.util.List;


public interface HackathonTeamInviteRepository extends JpaRepository<HackathonTeamInviteEntity, Integer>{
	
	Optional<HackathonTeamInviteEntity> findFirstByHackathonIdAndInviteduserIdAndInviteStatus(Integer hackathonId, 
			Object inviteduserId, String inviteStatus);

}
