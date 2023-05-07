package com.practice.manufacturer.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.sun.istack.NotNull;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ManufacturerRequest {
    @NotNull
    String name;

    @NotNull
    String address;

    @NotNull
    String workingDaysMode;

    @NotNull
    String phone;

    @NotNull
    String linkUrl;

    @NotNull
    String description;

    @NotNull
    String workingTimeMode;
}
