package com.practice.utils;

public interface Converter<Entity, ShortResponseDTO, FullResponseDTO, RequestDTO>{
    ShortResponseDTO toShortDTO(Entity entity);

    FullResponseDTO toFullDTO(Entity entity);

    Entity toEntity(RequestDTO requestDTO);
}
