package com.example.movieProject_v3.repository;

import com.example.movieProject_v3.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MemberRepository extends JpaRepository<Member, Integer> {

    // 아이디 중복체크
    @Query("SELECT COUNT(m) > 0 FROM Member m WHERE m.id = :userId")
    boolean existsByUserId(@Param("userId") String userId);

    // 이름 중복체크
    boolean existsByName(String name);

    // 아이디로 회원 찾기 (로그인용)
    @Query("SELECT m FROM Member m WHERE m.id = :userId")
    Member findById2(@Param("userId") String userId);

    // 프로필 사진 가져오기
    @Query("SELECT m.profileImg FROM Member m WHERE m.name = :name")
    String findProfileImgByName(@Param("name") String name);
}