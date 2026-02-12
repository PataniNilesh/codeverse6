package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.CategoryEntity;
import com.grownited.repository.CategoryRepository;


@Controller
public class CategoryController {

	@Autowired // inject
	CategoryRepository categoryRepository;
	
	@GetMapping("newCategory")
	public String newCategory() {
		return "NewCategory";
	}
	
	@PostMapping("saveCategory")
	public String saveCategory(CategoryEntity categoryEntity) {
		
		categoryEntity.setActive(true);
		//insert
		categoryRepository.save(categoryEntity);
		return "AdminDashboard";
	}
	
	@GetMapping("listCategory") 
	public String lisCategory(Model model) {
			
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList", categoryList);
			
		return "ListCategory";
		}
}
