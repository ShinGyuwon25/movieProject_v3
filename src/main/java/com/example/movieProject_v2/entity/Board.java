package com.example.movieProject_v2.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.sql.Timestamp;

@Entity
@Table(name = "myboard")
@Getter
@Setter
@NoArgsConstructor

public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer seq;

    @Column(length = 100, nullable = false)
    private String title;

    @Column(length = 50, nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    private Float score;

    // 코드 filename -> DB 컬럼명 poster
    @Column(name = "poster", length = 100)
    private String filename;

    private Timestamp time;

    @Column(columnDefinition = "int default 0")
    private Integer views = 0; // 기본값 0

    @Column(length = 100)
    private String mtitle;

    private Integer myear;

    @Column(length = 30)
    private String mgenre;

    @Column(length = 30)
    private String mcountry;

    @Column
    private Integer memberSeq;
}
