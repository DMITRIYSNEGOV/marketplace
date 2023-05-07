package com.practice.manufacturer.service;

import com.practice.manufacturer.dao.ManufacturerDAO;
import com.practice.manufacturer.dto.ManufacturerFullResponse;
import com.practice.manufacturer.dto.ManufacturerRequest;
import com.practice.manufacturer.dto.ManufacturerShortResponse;
import com.practice.manufacturer.entity.Manufacturer;
import com.practice.utils.ManufacturerConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ManufacturerService {

    ManufacturerDAO manufacturerDAO;
    ManufacturerConverter manufacturerConverter;

    @Autowired
    public ManufacturerService(ManufacturerDAO manufacturerDAO, ManufacturerConverter manufacturerConverter) {
        this.manufacturerDAO = manufacturerDAO;
        this.manufacturerConverter = manufacturerConverter;
    }

    public List<ManufacturerShortResponse> getAll() {
        List<Manufacturer> manufacturers = (List<Manufacturer>) manufacturerDAO.findAll();
        return manufacturers.stream()
                .map(manufacturerConverter::toShortDTO)
                .collect(Collectors.toList());
    }

    public ManufacturerFullResponse getById(Long id) {
        Optional<Manufacturer> optionalManufacturer = manufacturerDAO.findById(id);
        if (optionalManufacturer.isEmpty()) {
            throw new EntityNotFoundException("Не найдено информации о производителе с id = " + id);
        }

        return manufacturerConverter.toFullDTO(optionalManufacturer.get());
    }

    public Long create(ManufacturerRequest request) {
        Manufacturer manufacturer = manufacturerDAO.save(manufacturerConverter.toEntity(request));
        return manufacturer.getId();
    }

    public void deleteById(Long id) {
        manufacturerDAO.deleteById(id);
    }

    @Transactional
    public ManufacturerFullResponse update(Long id, ManufacturerRequest request) {
        Optional<Manufacturer> optionalManufacturer = manufacturerDAO.findById(id);
        if (optionalManufacturer.isEmpty())
            throw new EntityNotFoundException("Не найдено информации о производителе с id = " + id);
        Manufacturer manufacturer = manufacturerConverter.toEntity(request);
        manufacturer.setId(id);
        return manufacturerConverter.toFullDTO(manufacturerDAO.save(manufacturer));
    }
}
