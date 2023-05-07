package com.practice.manufacturer.dao;

import com.practice.manufacturer.entity.Manufacturer;
import org.springframework.data.repository.CrudRepository;

public interface ManufacturerDAO extends CrudRepository<Manufacturer, Long> {
    Manufacturer getManufacturerByName(String name);
}
