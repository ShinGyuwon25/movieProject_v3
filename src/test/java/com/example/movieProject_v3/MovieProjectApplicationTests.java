package com.example.movieProject_v3;

import com.example.movieProject_v3.entity.Member;
import com.example.movieProject_v3.service.MemberService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class MovieProjectApplicationTests {

    @Autowired
    private MemberService memberService;

    @BeforeEach
    void setUp() {
        Member member = new Member();
        member.setId("test123");
        member.setName("테스터");
        member.setPass("test12");
        memberService.register(member, "test12", "test", "@test.com");
    }

    @Test
    @DisplayName("회원가입 성공")
    void 회원가입_성공() {
        Member member = new Member();
        member.setId("test123");
        member.setName("테스터");
        member.setPass("test12");

        String result = memberService.register(member, "test12", "test", "@test.com");
        assertThat(result).isEqualTo("중복된 아이디입니다.");
    }

    @Test
    @DisplayName("아이디 4자면 회원가입 실패")
    void 아이디_너무_짧으면_실패() {
        Member member = new Member();
        member.setId("ab12");
        member.setName("테스터2");
        member.setPass("test12");

        String result = memberService.register(member, "test12", "test", "@test.com");
        assertThat(result).isEqualTo("아이디는 5자 이상이어야 합니다.");
    }

    @Test
    @DisplayName("비밀번호 불일치면 회원가입 실패")
    void 비밀번호_불일치_실패() {
        Member member = new Member();
        member.setId("test456");
        member.setName("테스터3");
        member.setPass("test12");

        String result = memberService.register(member, "wrong12", "test", "@test.com");
        assertThat(result).isEqualTo("비밀번호가 일치하지 않습니다.");
    }

    @Test
    @DisplayName("로그인 성공")
    void 로그인_성공() {
        Member result = memberService.login("test123", "test12");
        assertThat(result).isNotNull();
    }

    @Test
    @DisplayName("비밀번호 틀리면 로그인 실패")
    void 비밀번호_틀리면_로그인_실패() {
        Member result = memberService.login("test123", "wrongpass");
        assertThat(result).isNull();
    }
}