package com.grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonDescriptionEntity;

@Repository
public interface HackathonDescriptionRepository extends JpaRepository<HackathonDescriptionEntity, Integer> {
	
	Optional<HackathonDescriptionEntity> findFirstByHackathonId(Integer hackathonId);

}
