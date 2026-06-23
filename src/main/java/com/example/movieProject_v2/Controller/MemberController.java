package com.example.movieProject_v2.Controller;

import com.example.movieProject_v2.entity.Member;
import com.example.movieProject_v2.repository.MemberRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemberController {

    @Autowired
    private MemberRepository memberRepository;

    // login
    @RequestMapping(value = "/login.do", method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    // loginProc
    @RequestMapping(value = "/loginProc.do", method = RequestMethod.POST)
    public String loginProc(Member mdo, HttpSession session, Model model) {
        // 아이디와 비번 일치하는 회원 찾기
        Member log = memberRepository.findByIdAndPass(mdo.getId(), mdo.getPass());

        if (log != null) {
            session.setAttribute("log", log);
            return "redirect:/boardList.do";
        } else {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login";
        }
    }

    // logout
    @RequestMapping(value = "/logout.do")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/boardList.do";
    }

    // insertMember
    @RequestMapping(value = "/insertMember.do", method = RequestMethod.GET)
    public String insertMember() {
        return "register";
    }

    // insertProcMember
    @RequestMapping(value = "/insertProcMember.do", method = RequestMethod.POST)
    public String insertProcMemberGet(Member mdo,
                                      @RequestParam(value = "confirmPass") String confirmPass,
                                      @RequestParam(value = "address") String address,
                                      @RequestParam(value = "domain") String domain,
                                      Model model) {

        mdo.setEmail(address + domain);

        // 아이디 중복체크
        if (memberRepository.existsByUserId(mdo.getId())) {
            model.addAttribute("error", "중복된 아이디입니다.");
            return "register";
        }

        // 이름 중복체크
        if (memberRepository.existsByName(mdo.getName())) {
            model.addAttribute("error", "중복된 이름입니다.");
            return "register";
        }

        // 비번 확인
        if (!mdo.getPass().equals(confirmPass)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "register";
        }

        if (mdo.getId().length() < 5) {
            model.addAttribute("error", "아이디는 5자 이상이어야 합니다.");
            return "register";
        }

        if (!mdo.getId().matches(".*[a-zA-Z].*")) {
            model.addAttribute("error", "아이디는 영어를 포함해야 합니다.");
            return "register";
        }

        if (mdo.getName().length() < 2) {
            model.addAttribute("error", "이름은 2자 이상이어야 합니다.");
            return "register";
        }

        if (mdo.getPass().length() < 6 || !mdo.getPass().matches(".*[a-zA-Z].*") || !mdo.getPass().matches(".*\\d.*")) {
            model.addAttribute("error", "비밀번호는 6자 이상이며, 영어와 숫자를 포함해야 합니다.");
            return "register";
        }

        try {
            // Dao insertMember() 대체
            memberRepository.save(mdo);
            return "redirect:login.do";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    // memberView
    @RequestMapping(value = "/memberView.do")
    public String memberView(Model model, HttpSession session) {
        Member log = (Member) session.getAttribute("log");

        if (log == null) {
            return "errorPage";
        }

        // 세션 기반 최신 회원 정보 동기화
        Member mymember = memberRepository.findById(log.getSeq()).orElse(null);
        model.addAttribute("mymember", mymember);
        return "memberView";
    }

    // modifyMember
    @RequestMapping(value = "/modifyMember.do")
    public String modifyMember(Model model, HttpSession session) {
        Member log = (Member) session.getAttribute("log");

        if (log == null) {
            return "errorPage";
        }
        Member mymember = memberRepository.findById(log.getSeq()).orElse(null);
        model.addAttribute("mymember", mymember);
        return "modifyMember";
    }

    // modifyProc
    @RequestMapping(value = "/modifyProcMember.do", method = RequestMethod.POST)
    public String modifyProcMember(Member mdo, HttpSession session, Model model,
                                   @RequestParam(value = "confirmPass") String confirmPass,
                                   @RequestParam(value = "address") String address,
                                   @RequestParam(value = "domain") String domain) {

        mdo.setEmail(address + domain);

        if (!mdo.getPass().equals(confirmPass)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "redirect:/modifyMember.do?seq=" + mdo.getSeq();
        }

        try {
            // JPA
            Member existingMember = memberRepository.findById(mdo.getSeq()).orElseThrow();
            existingMember.setName(mdo.getName());
            existingMember.setPass(mdo.getPass());
            existingMember.setEmail(mdo.getEmail());

            memberRepository.save(existingMember);
            session.setAttribute("log", existingMember);

            return "redirect:/memberView.do";
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage";
        }
    }
}
