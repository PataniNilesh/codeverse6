package com.grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonPrizeEntity;

@Repository
public interface HackathonPrizeRepository extends JpaRepository<HackathonPrizeEntity, Integer>{

	List<HackathonPrizeEntity> findByHackathonIdOrderByHackathonPrizeIdAsc(Integer hackathonId);
	
}
