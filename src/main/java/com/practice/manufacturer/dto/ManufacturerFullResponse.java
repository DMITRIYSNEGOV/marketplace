package com.practice.manufacturer.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ManufacturerFullResponse {
    Long id;
    String name;
    String address;
    String workingDaysMode;
    String phone;
    String linkUrl;
    String description;
    String workingTimeMode;
}
