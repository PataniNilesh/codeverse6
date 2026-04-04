package com.grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonParticipantEntity;

@Repository
public interface HackathonParticipantRepository extends JpaRepository<HackathonParticipantEntity, Integer>{
	
	boolean existsByHackathonIdAndParticipantId(Integer hackathonId, Integer participantId);
	
	List<HackathonParticipantEntity> findByParticipantId(Integer participantId);

}
