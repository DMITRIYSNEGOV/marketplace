package com.practice.utils;

import com.practice.provider.dto.ProviderFullResponse;
import com.practice.provider.dto.ProviderRequest;
import com.practice.provider.dto.ProviderShortResponse;
import com.practice.provider.entity.Provider;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class ProviderConverter implements Converter<Provider, ProviderShortResponse, ProviderFullResponse, ProviderRequest>{

    @Override
    public ProviderShortResponse toShortDTO(Provider provider) {
        if (provider == null)
            return null;

        ProviderShortResponse providerShortResponse = new ProviderShortResponse();
        BeanUtils.copyProperties(provider, providerShortResponse);
        return providerShortResponse;
    }

    @Override
    public ProviderFullResponse toFullDTO(Provider provider) {
        if (provider == null)
            return null;

        ProviderFullResponse providerFullResponse = new ProviderFullResponse();
        BeanUtils.copyProperties(provider, providerFullResponse);
        providerFullResponse.setManufacturers(provider.getManufacturers());
        return providerFullResponse;
    }

    @Override
    public Provider toEntity(ProviderRequest providerRequest) {
        if (providerRequest == null)
            return null;

        Provider provider = new Provider();
        BeanUtils.copyProperties(providerRequest, provider);
        return provider;
    }
}
