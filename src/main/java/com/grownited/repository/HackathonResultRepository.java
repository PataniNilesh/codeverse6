package com.grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonResultEntity;

@Repository
public interface HackathonResultRepository extends JpaRepository<HackathonResultEntity, Integer>{

	
	Optional<HackathonResultEntity> findByHackathonIdAndJudgeIdAndTeamId(Integer hackathonId, Integer judgeId, Integer teamId);
}
