package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonTeamEntity;

@Repository
public interface HackathonTeamRepository extends JpaRepository<HackathonTeamEntity, Integer>{

}
