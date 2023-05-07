package com.practice.category.service;

import com.practice.category.dao.CategoryDAO;
import com.practice.category.dto.CategoryResponse;
import com.practice.category.entity.Category;
import com.practice.utils.CategoryConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {
    CategoryDAO categoryDAO;
    CategoryConverter categoryConverter;

    @Autowired
    public CategoryService(CategoryDAO categoryDAO, CategoryConverter categoryConverter) {
        this.categoryDAO = categoryDAO;
        this.categoryConverter = categoryConverter;
    }

    public List<CategoryResponse> getAll() {
        List<Category> categories = (List<Category>) categoryDAO.findAll();
        return categories.stream()
                .map(categoryConverter::toShortDTO)
                .collect(Collectors.toList());
    }
}
