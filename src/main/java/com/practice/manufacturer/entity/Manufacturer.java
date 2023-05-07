package com.practice.manufacturer.entity;

import com.practice.provider.entity.Provider;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "manufacturer", schema = "shop")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Manufacturer implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "manufacturer_seq")
    @SequenceGenerator(name="manufacturer_seq",
            sequenceName="manufacturer_seq", schema = "shop")
    Long id;

    @Column(name = "name", unique = true, nullable = false)
    String name;

    @Column(name = "address", nullable = false)
    String address;

    @Column(name = "working_days_mode", nullable = false)
    String workingDaysMode;

    @Column(name = "phone", unique = true, nullable = false)
    String phone;

    @Column(name = "link_url", unique = true, nullable = false)
    String linkUrl;

    @Column(name = "description", nullable = false)
    String description;

    @Column(name = "working_time_mode")
    String workingTimeMode;

    @ManyToMany(mappedBy = "manufacturers")
    List<Provider> providers = new ArrayList<>();
}
