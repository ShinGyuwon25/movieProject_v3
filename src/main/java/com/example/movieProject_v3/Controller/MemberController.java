package com.example.movieProject_v3.Controller;

import com.example.movieProject_v3.entity.Member;
import com.example.movieProject_v3.service.BoardService;
import com.example.movieProject_v3.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
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
    private final BoardService boardService;


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
            model.addAttribute("savedId", mdo.getId());
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
                                   Model model,
                                   HttpServletRequest request) {
        String error = memberService.register(mdo, confirmPass, address, domain);
        if (error != null) {
            String[] errorParts = error.split(":", 2);
            model.addAttribute("errorField", errorParts[0]);
            model.addAttribute("errorMsg", errorParts[1]);
            model.addAttribute("savedId", mdo.getId());
            model.addAttribute("savedName", mdo.getName());
            model.addAttribute("savedAddress", request.getParameter("address"));
            model.addAttribute("savedDomain", request.getParameter("domain"));
            return "register";
        }
        return "redirect:login.do";
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
                                   @RequestParam String domain,
                                   @RequestParam Integer seq) {
        mdo.setSeq(seq);
        String error = memberService.updateMember(mdo, confirmPass, address, domain);
        if (error != null) {
            model.addAttribute("error", error);
            model.addAttribute("savedName", mdo.getName());
            model.addAttribute("mymember", memberService.getMember(mdo.getSeq()));
            return "modifyMember";
        }
        Member updated = memberService.getMember(mdo.getSeq());
        session.setAttribute("log", updated);
        return "redirect:/myPage.do";
    }

    // 마이페이지
    @RequestMapping(value = "/myPage.do")
    public String myPage(Model model, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";
        model.addAttribute("mymember", memberService.getMember(log.getSeq()));
        model.addAttribute("myBoards", boardService.getMyBoards(log.getName()));
        model.addAttribute("myComments", boardService.getMyComments(log.getName()));
        model.addAttribute("myLikedBoards", boardService.getMyLikedBoards(log.getSeq())); // ← 추가
        return "myPage";
    }

    // 회원 탈퇴
    @RequestMapping(value = "/deleteMember.do")
    public String deleteMember(HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";
        memberService.deleteMember(log.getSeq());
        session.invalidate();
        return "redirect:/boardList.do";
    }
}