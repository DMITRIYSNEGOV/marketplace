package com.practice.provider.dao;

import com.practice.provider.entity.Provider;
import org.springframework.data.repository.CrudRepository;

public interface ProviderDAO extends CrudRepository<Provider, Long> {
}
