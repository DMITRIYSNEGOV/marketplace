package com.practice.provider.entity;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.practice.manufacturer.entity.Manufacturer;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "provider", schema = "shop")
public class Provider implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "provider_seq")
    @SequenceGenerator(name="provider_seq",
            sequenceName="provider_seq", schema = "shop",
    initialValue = 1, allocationSize = 1)
    Long id;

    @Column(name = "name", unique = true, nullable = false)
    String name;

    @Column(name = "email", unique = true, nullable = false)
    String email;

    @Column(name = "address")
    String address;

    @Column(name = "phone")
    String phone;

    @JsonBackReference
    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(
            name = "manufacturer_provider",
            joinColumns = {@JoinColumn(name = "provider_id")},
            inverseJoinColumns = {@JoinColumn(name = "manufacturer_id")},
            schema = "shop"
    )
    List<Manufacturer> manufacturers = new ArrayList<>();
}





