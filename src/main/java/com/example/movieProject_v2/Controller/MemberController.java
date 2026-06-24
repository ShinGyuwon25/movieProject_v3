package com.example.movieProject_v2.Controller;

import com.example.movieProject_v2.entity.Member;
import com.example.movieProject_v2.service.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    // 로그인 폼
    @RequestMapping(value = "/login.do", method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    // 로그인 처리
    @RequestMapping(value = "/loginProc.do", method = RequestMethod.POST)
    public String loginProc(Member mdo, HttpSession session, Model model) {
        Member log = memberService.login(mdo.getId(), mdo.getPass());
        if (log != null) {
            session.setAttribute("log", log);
            return "redirect:/boardList.do";
        } else {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login";
        }
    }

    // 로그아웃
    @RequestMapping(value = "/logout.do")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/boardList.do";
    }

    // 회원가입 폼
    @RequestMapping(value = "/insertMember.do", method = RequestMethod.GET)
    public String insertMember() {
        return "register";
    }

    // 회원가입 처리
    @RequestMapping(value = "/insertProcMember.do", method = RequestMethod.POST)
    public String insertProcMember(Member mdo,
                                   @RequestParam String confirmPass,
                                   @RequestParam String address,
                                   @RequestParam String domain,
                                   Model model) {
        String error = memberService.register(mdo, confirmPass, address, domain);
        if (error != null) {
            model.addAttribute("error", error);
            return "register";
        }
        return "redirect:login.do";
    }

    // 회원정보 보기
    @RequestMapping(value = "/memberView.do")
    public String memberView(Model model, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";
        model.addAttribute("mymember", memberService.getMember(log.getSeq()));
        return "memberView";
    }

    // 회원정보 수정 폼
    @RequestMapping(value = "/modifyMember.do")
    public String modifyMember(Model model, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";
        model.addAttribute("mymember", memberService.getMember(log.getSeq()));
        return "modifyMember";
    }

    // 회원정보 수정 처리
    @RequestMapping(value = "/modifyProcMember.do", method = RequestMethod.POST)
    public String modifyProcMember(Member mdo, HttpSession session, Model model,
                                   @RequestParam String confirmPass,
                                   @RequestParam String address,
                                   @RequestParam String domain) {
        String error = memberService.updateMember(mdo, confirmPass, address, domain);
        if (error != null) {
            model.addAttribute("error", error);
            return "redirect:/modifyMember.do";
        }
        Member updated = memberService.getMember(mdo.getSeq());
        session.setAttribute("log", updated);
        return "redirect:/memberView.do";
    }
}