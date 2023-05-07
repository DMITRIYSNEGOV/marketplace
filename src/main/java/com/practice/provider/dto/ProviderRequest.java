package com.practice.provider.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProviderRequest {
    String name;
    String email;
    String address;
    String phone;
}
