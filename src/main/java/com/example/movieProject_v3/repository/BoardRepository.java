package com.example.movieProject_v3.repository;

import com.example.movieProject_v3.entity.Board;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

    // 장르 필터링
    List<Board> findByMgenreOrderBySeqDesc(String mgenre);

    // 국가 필터링
    List<Board> findByMcountryOrderBySeqDesc(String mcountry);

    // 조회수 높은순
    Page<Board> findAllByOrderByViewsDesc(Pageable pageable);

    // 별점 높은순
    Page<Board> findAllByOrderByScoreDesc(Pageable pageable);

    // 내 글 목록
    List<Board> findByNameOrderBySeqDesc(String name);

}
