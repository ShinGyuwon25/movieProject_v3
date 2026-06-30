package com.example.movieProject_v3.repository;

import com.example.movieProject_v3.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

    // boardSeq 기준 등록된 댓글 목록 조회
    List<Comment> findByBoardSeq(Integer boardSeq);

    // 내 댓글 목록
    List<Comment> findByNameOrderBySeqDesc(String name);

    // 답글 목록 조회
    List<Comment> findByParentSeqOrderBySeqAsc(Integer parentSeq);
}
