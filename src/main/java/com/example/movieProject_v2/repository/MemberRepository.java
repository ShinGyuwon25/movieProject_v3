package com.example.movieProject_v2.repository;

import com.example.movieProject_v2.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberRepository extends JpaRepository<Member, Integer> {

    // 아이디 중복체크
    @Query("SELECT COUNT(m) > 0 FROM Member m WHERE m.id = :userId")
    boolean existsByUserId(@Param("userId") String userId);

    // 이름 중복체크
    boolean existsByName(String name);

    // 로그인
    Member findByIdAndPass(String id, String pass);

    // 아이디로 회원 찾기 (로그인용)
    @Query("SELECT m FROM Member m WHERE m.id = :userId")
    Member findById2(@Param("userId") String userId);
}