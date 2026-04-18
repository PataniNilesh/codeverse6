package com.grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.grownited.entity.UserEntity;
import java.util.List;



//db query -> table?
@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer>{
	
	//findByXXXX(xxx);
	
	//select * from users where email = :email
	Optional<UserEntity>  findByEmail(String email);
	
	List<UserEntity> findByRole(String role); //
	
	long countByRole(String role);
	
	// SQL HQL
	@Query(value = "select monthname(created_at) as Month, count(monthname(created_at))  as total  from users group by monthname(created_at)", nativeQuery = true)
	List<Object[]> getMonthUserCount();//

	 
}