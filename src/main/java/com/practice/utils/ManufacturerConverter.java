package com.practice.utils;

import com.practice.manufacturer.dto.ManufacturerFullResponse;
import com.practice.manufacturer.dto.ManufacturerRequest;
import com.practice.manufacturer.dto.ManufacturerShortResponse;
import com.practice.manufacturer.entity.Manufacturer;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class ManufacturerConverter implements Converter<Manufacturer, ManufacturerShortResponse, ManufacturerFullResponse, ManufacturerRequest>{

    @Override
    public ManufacturerShortResponse toShortDTO(Manufacturer manufacturer) {
        if (manufacturer == null)
            return null;

        ManufacturerShortResponse manufacturerShortResponse = new ManufacturerShortResponse();
        BeanUtils.copyProperties(manufacturer, manufacturerShortResponse);
        return manufacturerShortResponse;
    }

    @Override
    public ManufacturerFullResponse toFullDTO(Manufacturer manufacturer) {
        if (manufacturer == null)
            return null;
        ManufacturerFullResponse manufacturerFullResponse = new ManufacturerFullResponse();
        BeanUtils.copyProperties(manufacturer, manufacturerFullResponse);
        return manufacturerFullResponse;
    }

    @Override
    public Manufacturer toEntity(ManufacturerRequest manufacturerRequest) {
        if (manufacturerRequest == null)
            return null;

        Manufacturer manufacturer = new Manufacturer();
        BeanUtils.copyProperties(manufacturerRequest, manufacturer);
        return manufacturer;
    }
}
