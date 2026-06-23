package com.example.movieProject_v2.repository;

import com.example.movieProject_v2.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BoardRepository extends JpaRepository<Board, Integer> {

    // 조회수 증가
    @Modifying
    @Query("UPDATE Board b SET b.views = b.views + 1 WHERE b.seq = :seq")
    void incrementViews(@Param("seq") Integer seq);

    // 제목으로 검색
    List<Board> findByTitleContainingOrderBySeqDesc(String searchKey);

    // 내용으로 검색
    List<Board> findByContentContainingOrderBySeqDesc(String searchKey);

}
