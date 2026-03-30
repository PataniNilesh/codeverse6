package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonTeamMembersEntity;

@Repository
public interface HackathonTeamMembersRepository extends JpaRepository<HackathonTeamMembersEntity, Integer>{

}
