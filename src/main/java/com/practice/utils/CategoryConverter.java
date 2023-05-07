package com.practice.utils;

import com.practice.category.dto.CategoryResponse;
import com.practice.category.entity.Category;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class CategoryConverter implements Converter<Category, CategoryResponse, CategoryResponse, CategoryResponse> {

    @Override
    public CategoryResponse toShortDTO(Category entity) {
        if (entity == null)
            return null;
        CategoryResponse categoryResponse = new CategoryResponse();
        BeanUtils.copyProperties(entity, categoryResponse);
        categoryResponse.setSubcategory(this.toShortDTO(entity.getSubcategory()));
        return categoryResponse;
    }

    @Override
    public CategoryResponse toFullDTO(Category entity) {
        return null;
    }

    @Override
    public Category toEntity(CategoryResponse category) {
        return null;
    }
}
