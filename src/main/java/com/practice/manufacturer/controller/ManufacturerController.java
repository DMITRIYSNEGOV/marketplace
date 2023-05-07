package com.practice.manufacturer.controller;

import com.practice.manufacturer.dto.ManufacturerFullResponse;
import com.practice.manufacturer.dto.ManufacturerRequest;
import com.practice.manufacturer.dto.ManufacturerShortResponse;
import com.practice.manufacturer.service.ManufacturerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping(value = "/api/v1/manufacturers", produces = MediaType.APPLICATION_JSON_VALUE)
public class ManufacturerController {

    @Autowired
    private ManufacturerService manufacturerService;

    @GetMapping("/")
    public List<ManufacturerShortResponse> getAllManufacturers() {
        return manufacturerService.getAll();
    }

    @GetMapping("/{id}")
    public ManufacturerFullResponse getManufacturerById(@PathVariable Long id) {
        return manufacturerService.getById(id);
    }

    @PostMapping(path = "/", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> createManufacturer(@RequestBody ManufacturerRequest request) {
        Long id = manufacturerService.create(request);
        final URI uri = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(id)
                .toUri();

        return ResponseEntity.created(uri).build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteManufacturer(@PathVariable Long id) {
        manufacturerService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}")
    public ManufacturerFullResponse updateManufacturer(@PathVariable Long id, @RequestBody ManufacturerRequest request) {
        return manufacturerService.update(id, request);
    }
}
