package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.UserDetailEntity;

@Repository
public interface UserDetailRepository extends JpaRepository<UserDetailEntity, Integer>{

}