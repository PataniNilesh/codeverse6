package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonTeamEntity;
import java.util.List;
import java.util.Optional;


@Repository
public interface HackathonTeamRepository extends JpaRepository<HackathonTeamEntity, Integer>{
	
	boolean existsByHackathonIdAndTeamLeaderId(Integer hackathonId, Integer teamLeaderId);
	
	Optional<HackathonTeamEntity> findFirstByHackathonIdAndTeamLeaderId(Integer hackathonId, Integer teamLeaderId);
	
	long countByHackathonId(Integer hackathonId);
	
	List<HackathonTeamEntity> findByHackathonId(Integer hackathonId);
	
	List<HackathonTeamEntity> findByTeamLeaderId(Integer teamLeaderId);
	
	

}
