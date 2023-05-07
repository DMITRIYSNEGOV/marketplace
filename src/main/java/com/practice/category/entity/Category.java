package com.practice.category.entity;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "category", schema = "shop")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "category_seq")
    @SequenceGenerator(name = "category_seq",
        sequenceName = "category_seq", schema = "shop")
    Long id;

    @Column(name = "name")
    String name;

    @OneToOne
    @JoinColumn(name = "subcategory")
    Category subcategory;
}
