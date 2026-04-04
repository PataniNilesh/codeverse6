package com.grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonTeamInviteEntity;
import java.util.List;

@Repository
public interface HackathonTeamInviteRepository extends JpaRepository<HackathonTeamInviteEntity, Integer>{
	
	Optional<HackathonTeamInviteEntity> findFirstByHackathonIdAndInvitedUserIdAndInviteStatus(Integer hackathonId, 
			Integer invitedUserId, String inviteStatus);
	
	long countByTeamIdAndInviteStatus(Integer teamId, String inviteStatus);

}
