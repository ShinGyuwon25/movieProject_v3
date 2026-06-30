package com.example.movieProject_v3.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "mymember")
@Getter
@Setter
@NoArgsConstructor

public class Member {
    @Id // Primary Key
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto Increment (자동 증가)
    private Integer seq;

    @Column(length = 30, nullable = false, unique = true)
    private String id;

    @Column(length = 30, nullable = false)
    private String name;

    @Column(length = 60, nullable = false)
    private String pass;

    @Column(length = 50)
    private String email;
}
