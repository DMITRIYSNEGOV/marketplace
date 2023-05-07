package com.practice.provider.controller;

import com.practice.provider.dto.ProviderFullResponse;
import com.practice.provider.dto.ProviderRequest;
import com.practice.provider.dto.ProviderShortResponse;
import com.practice.provider.service.ProviderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.websocket.server.PathParam;
import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/v1/providers")
public class ProviderController {
    @Autowired
    ProviderService providerService;

    @GetMapping(path = "/")
    public List<ProviderShortResponse> getAllProviders() {
        return providerService.getAll();
    }

    @GetMapping(path = "/{id}")
    public ProviderFullResponse getProviderById(@PathVariable Long id) {
        return providerService.getById(id);
    }

    @PostMapping(path = "/", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> createProvider(@RequestBody ProviderRequest request) {
        Long id = providerService.create(request);
        final URI uri = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(id)
                .toUri();

        return ResponseEntity.created(uri).build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProvider(@PathVariable Long id) {
        providerService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}")
    public ProviderFullResponse updateProvider(@PathVariable Long id, @RequestBody ProviderRequest request) {
        return providerService.update(id, request);
    }

    @GetMapping(path = "/{id}/linkManufacturer", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Void> linkManufacturerByName(@PathVariable Long id, @RequestParam(name = "name") String manufacturerName) {
        providerService.linkManufacturer(id, manufacturerName);
        return ResponseEntity.noContent().build();
    }
}
