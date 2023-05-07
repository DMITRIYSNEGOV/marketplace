package com.practice.provider.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.practice.manufacturer.entity.Manufacturer;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProviderFullResponse {
    Long id;
    String name;
    String email;
    String address;
    String phone;
    List<Manufacturer> manufacturers;
}
