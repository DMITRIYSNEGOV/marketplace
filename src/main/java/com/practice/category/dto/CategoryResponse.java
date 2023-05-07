package com.practice.category.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CategoryResponse {
    Long id;
    String name;
    CategoryResponse subcategory;
}
