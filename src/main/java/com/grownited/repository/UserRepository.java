package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.UserEntity;


//db query -> table?
@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer>{
	 
}