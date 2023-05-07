package com.practice.category.dao;

import com.practice.category.entity.Category;
import org.springframework.data.repository.CrudRepository;

public interface CategoryDAO extends CrudRepository<Category, Long> {
}
