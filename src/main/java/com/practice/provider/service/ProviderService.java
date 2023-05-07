package com.practice.provider.service;

import com.practice.manufacturer.dao.ManufacturerDAO;
import com.practice.manufacturer.entity.Manufacturer;
import com.practice.provider.dao.ProviderDAO;
import com.practice.provider.dto.ProviderFullResponse;
import com.practice.provider.dto.ProviderRequest;
import com.practice.provider.dto.ProviderShortResponse;
import com.practice.provider.entity.Provider;
import com.practice.utils.ProviderConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProviderService {
    ProviderConverter providerConverter;
    ProviderDAO providerDAO;
    ManufacturerDAO manufacturerDAO;

    @Autowired
    public ProviderService(ProviderConverter providerConverter, ProviderDAO providerDAO, ManufacturerDAO manufacturerDAO) {
        this.providerConverter = providerConverter;
        this.providerDAO = providerDAO;
        this.manufacturerDAO = manufacturerDAO;
    }

    public List<ProviderShortResponse> getAll() {
        List<Provider> providers = (List<Provider>) providerDAO.findAll();
        return providers.stream()
                .map(providerConverter::toShortDTO)
                .collect(Collectors.toList());
    }

    public ProviderFullResponse getById(Long id) {
        Optional<Provider> optionalProvider = providerDAO.findById(id);
        if (optionalProvider.isEmpty())
            throw new EntityNotFoundException("Не найдено информации о поставщике с id = " + id);

        return providerConverter.toFullDTO(optionalProvider.get());
    }

    public Long create(ProviderRequest request) {
        Provider provider = providerDAO.save(providerConverter.toEntity(request));
        return provider.getId();
    }

    public void deleteById(Long id) {
        providerDAO.deleteById(id);
    }

    @Transactional
    public ProviderFullResponse update(Long id, ProviderRequest request) {
        Optional<Provider> optionalProvider = providerDAO.findById(id);
        if (optionalProvider.isEmpty())
            throw new EntityNotFoundException("Не найдено информации о поставщике с id = " + id);
        Provider provider = providerConverter.toEntity(request);
        provider.setId(id);
        return providerConverter.toFullDTO(providerDAO.save(provider));
    }

    @Transactional
    public void linkManufacturer(Long id, String name) {
        Manufacturer manufacturerByName = manufacturerDAO.getManufacturerByName(name);
        Optional<Provider> optionalProvider = providerDAO.findById(id);
        if (optionalProvider.isEmpty())
            throw new EntityNotFoundException("Не найдено информации о поставщике с id = " + id);
        Provider provider = optionalProvider.get();
        provider.getManufacturers().add(manufacturerByName);
        providerDAO.save(provider);
    }
}
