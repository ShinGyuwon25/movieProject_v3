package com.example.movieProject_v2.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.sql.Timestamp;

@Entity
@Table(name = "mycomment")
@Getter
@Setter
@NoArgsConstructor

public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer seq;

    @Column(name = "boardSeq")
    private Integer boardSeq;

    @Column(length = 30, nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    private Timestamp time;

    @Column
    private Integer memberSeq;

    @Column
    private Integer parentSeq;

}
