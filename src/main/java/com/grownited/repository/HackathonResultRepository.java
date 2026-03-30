package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.HackathonResultEntity;

@Repository
public interface HackathonResultRepository extends JpaRepository<HackathonResultEntity, Integer>{

}
