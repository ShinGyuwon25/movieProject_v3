package com.example.movieProject_v2.repository;

import com.example.movieProject_v2.entity.Like;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface LikeRepository extends JpaRepository<Like, Integer> {

    // 특정 글에 특정 회원이 좋아요 눌렀는지 확인
    Optional<Like> findByBoardSeqAndMemberSeq(Integer boardSeq, Integer memberSeq);

    // 특정 글의 좋아요 개수
    int countByBoardSeq(Integer boardSeq);
}