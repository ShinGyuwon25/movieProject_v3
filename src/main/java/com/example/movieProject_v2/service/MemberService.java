package com.example.movieProject_v2.service;

import com.example.movieProject_v2.entity.Member;
import com.example.movieProject_v2.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    // 로그인
    public Member login(String id, String pass) {
        Member member = memberRepository.findById2(id);
        if (member != null && passwordEncoder.matches(pass, member.getPass())) {
            return member;
        }
        return null;
    }

    // 회원가입
    public String register(Member mdo, String confirmPass, String address, String domain) {
        mdo.setEmail(address + domain);

        if (memberRepository.existsByUserId(mdo.getId())) return "id:중복된 아이디입니다.";
        if (memberRepository.existsByName(mdo.getName())) return "name:중복된 이름입니다.";
        if (!mdo.getPass().equals(confirmPass)) return "pass:비밀번호가 일치하지 않습니다.";
        if (mdo.getId().length() < 5) return "id:아이디는 5자 이상이어야 합니다.";
        if (!mdo.getId().matches(".*[a-zA-Z].*")) return "id:아이디는 영어를 포함해야 합니다.";
        if (mdo.getName().length() < 2) return "name:이름은 2자 이상이어야 합니다.";
        if (mdo.getPass().length() < 6 || !mdo.getPass().matches(".*[a-zA-Z].*") || !mdo.getPass().matches(".*\\d.*"))
            return "pass:비밀번호는 6자 이상이며, 영어와 숫자를 포함해야 합니다.";

        mdo.setPass(passwordEncoder.encode(mdo.getPass()));
        memberRepository.save(mdo);
        return null; // null이면 성공
    }

    // 회원정보 조회
    public Member getMember(Integer seq) {
        return memberRepository.findById(seq).orElse(null);
    }

    // 회원정보 수정
    public String updateMember(Member mdo, String confirmPass, String address, String domain) {
        mdo.setEmail(address + domain);

        if (!mdo.getPass().equals(confirmPass)) return "비밀번호가 일치하지 않습니다.";

        try {
            Member existing = memberRepository.findById(mdo.getSeq()).orElseThrow();

            if (!existing.getName().equals(mdo.getName()) && memberRepository.existsByName(mdo.getName())) {
                return "중복된 이름입니다.";
            }

            existing.setName(mdo.getName());
            existing.setPass(passwordEncoder.encode(mdo.getPass()));
            existing.setEmail(mdo.getEmail());
            memberRepository.save(existing);
            return null; // null이면 성공
        } catch (Exception e) {
            log.error("회원정보 수정 실패", e);
            return "오류가 발생했습니다.";
        }
    }

    // 회원 탈퇴
    public void deleteMember(Integer seq) {
        memberRepository.deleteById(seq);
    }

}
