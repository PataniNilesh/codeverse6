package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.grownited.entity.HackathonParticipantEntity;

public interface HackathonParticipantRepository extends JpaRepository<HackathonParticipantEntity, Integer>{
	
	boolean existsByHackathonIdAndParticipantId(Integer hackathonId, Integer participantId);

}
