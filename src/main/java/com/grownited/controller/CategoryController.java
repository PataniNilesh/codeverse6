package com.grownited.controller;

import java.util.List;
import java.util.Optional;

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
		// insert
		categoryRepository.save(categoryEntity);
		return "AdminDashboard";
	}

	@GetMapping("listCategory")
	public String listCategory(Model model) {
		// select * from categories ;
		// 1
		// 2
		// 3
		// 4
		// List<Entity>
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList", categoryList);//

		return "ListCategory";
	}

	@GetMapping("editCategory")
	public String editCategory(Integer categoryId, Model model) {
		CategoryEntity category = categoryRepository.findById(categoryId).get();
		model.addAttribute("category", category);
		return "EditCategory";
	}

	@PostMapping("updateCategory")
	public String updateCategory(CategoryEntity newCategoryData) {

		Optional<CategoryEntity> op = categoryRepository.findById(newCategoryData.getCategoryId());

		if(op.isPresent()) {
			CategoryEntity dbCategory = op.get() ; 
			dbCategory.setCategoryName(newCategoryData.getCategoryName());
			categoryRepository.save(dbCategory);//update 
		}
		
		return "redirect:/listCategory";
	}
	
	@GetMapping("deleteCategory")
	public String deleteCategory(Integer categoryId) {
		categoryRepository.deleteById(categoryId);
		return "redirect:/listCategory";
	}
}
