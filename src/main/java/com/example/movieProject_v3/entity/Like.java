package com.example.movieProject_v3.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "mylike")
@Getter
@Setter
public class Like {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer seq;

    @Column(nullable = false)
    private Integer boardSeq;

    @Column(nullable = false)
    private Integer memberSeq;

}
