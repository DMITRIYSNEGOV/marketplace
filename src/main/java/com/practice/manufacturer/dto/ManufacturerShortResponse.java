package com.practice.manufacturer.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ManufacturerShortResponse {
    Long id;
    String name;
    String address;
    String phone;
}
