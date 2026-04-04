package com.grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonTeamMembersEntity;

@Repository
public interface HackathonTeamMembersRepository extends JpaRepository<HackathonTeamMembersEntity, Integer>{
	
	boolean existsByHackathonIdAndMemberId(Integer hackathonId, Integer memberId);
	
	Optional<HackathonTeamMembersEntity> findFirstByHackathonIdAndMemberId(Integer hackathonId, Integer memberId);
	
	List<HackathonTeamMembersEntity> findByMemberId(Integer memberId);
	
	long countByTeamId(Integer teamId);

}
