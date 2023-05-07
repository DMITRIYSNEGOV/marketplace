package com.practice.provider.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProviderShortResponse {
    Long id;
    String name;
    String email;
}
