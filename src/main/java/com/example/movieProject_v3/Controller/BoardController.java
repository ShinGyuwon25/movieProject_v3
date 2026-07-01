package com.example.movieProject_v3.Controller;

import com.example.movieProject_v3.entity.Board;
import com.example.movieProject_v3.entity.Comment;
import com.example.movieProject_v3.entity.Member;
import com.example.movieProject_v3.service.BoardService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import java.util.List;

@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    // 1. boardList
    @RequestMapping(value = "/boardList.do")
    public String boardList(@RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "latest") String sort,
                            Model model) {
        Page<Board> boardPage = boardService.getBoardListSorted(page, sort);
        model.addAttribute("bList", boardPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", boardPage.getTotalPages());
        model.addAttribute("currentSort", sort);
        return "boardList";
    }

    // 2. boardView
    @RequestMapping(value = "/boardView.do")
    public String boardView(@RequestParam Integer seq, Model model, HttpSession session) {
        Board myboard = boardService.getBoardView(seq);
        List<Comment> cList = boardService.getCommentList(seq);
        model.addAttribute("myboard", myboard);
        model.addAttribute("cList", cList);
        model.addAttribute("authorName", myboard.getName());
        model.addAttribute("likeCount", boardService.getLikeCount(seq));

        Member log = (Member) session.getAttribute("log"); // ← 추가
        if (log != null) {
            model.addAttribute("isLiked", boardService.isLiked(seq, log.getSeq())); // ← 추가
        }

        return "boardView";
    }

    // 3. insertBoard
    @RequestMapping(value = "/insertBoard.do")
    public String insertBoard(Model model, HttpSession session) {
        Member mymember = (Member) session.getAttribute("log");
        if (mymember == null) return "errorPage";
        model.addAttribute("mymember", mymember);
        return "insertBoard";
    }

    // 4. insertProcBoard
    @RequestMapping(value = "/insertProcBoard.do", method = RequestMethod.POST)
    public String insertProcBoard(@RequestParam("score") float score, Board bdo,
                                  HttpSession session, HttpServletRequest request,
                                  @RequestParam("uploadFile") MultipartFile uploadFile,
                                  @RequestParam(value = "posterUrl", required = false, defaultValue = "") String posterUrl) {
        Member mymember = (Member) session.getAttribute("log");
        if (mymember == null) return "errorPage";

        bdo.setScore(score);
        String realPath = request.getSession().getServletContext().getRealPath("/poster/poster/");
        boardService.saveBoard(bdo, uploadFile, realPath, mymember.getName(), mymember.getSeq(), posterUrl);
        return "redirect:boardList.do";
    }

    // 5. modifyBoard
    @RequestMapping(value = "/modifyBoard.do")
    public String modifyBoard(@RequestParam Integer seq, Model model, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        Board myboard = boardService.getBoard(seq);

        if (log == null || !log.getSeq().equals(myboard.getMemberSeq())) return "errorPage";
        model.addAttribute("myboard", myboard);
        return "modifyBoard";
    }

    @RequestMapping(value = "/modifyProcBoard.do", method = RequestMethod.POST)
    public String modifyProcBoard(@RequestParam("score") float score, Board bdo,
                                  HttpSession session, HttpServletRequest request,
                                  @RequestParam("uploadFile") MultipartFile uploadFile,
                                  @RequestParam(value = "posterUrl", required = false, defaultValue = "") String posterUrl) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";

        bdo.setScore(score);
        String realPath = request.getSession().getServletContext().getRealPath("/poster/poster/");
        boardService.updateBoard(bdo, uploadFile, realPath, posterUrl);
        return "redirect:/boardView.do?seq=" + bdo.getSeq();
    }

    // 7. deleteBoard
    @RequestMapping(value = "/deleteBoard.do")
    public String deleteBoard(@RequestParam Integer seq, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        Board myboard = boardService.getBoard(seq);

        if (log == null || !log.getSeq().equals(myboard.getMemberSeq())) return "errorPage";
        boardService.deleteBoard(seq);
        return "redirect:boardList.do";
    }

    // 8. searchBoard
    @RequestMapping(value = "/searchBoard.do")
    public String searchBoard(@RequestParam String searchCon,
                              @RequestParam String searchKey, Model model) {
        List<Board> sList;

        if (searchCon.equals("genre")) {
            sList = boardService.filterByGenre(searchKey);
        } else if (searchCon.equals("country")) {
            sList = boardService.filterByCountry(searchKey);
        } else if (searchCon.equals("title")) {
            sList = boardService.searchBoard("title", searchKey);
        } else {
            sList = boardService.searchBoard("content", searchKey);
        }

        if (sList.isEmpty()) {
            model.addAttribute("searchMessage", "검색 결과가 없습니다.");
        } else {
            model.addAttribute("bList", sList);
        }
        return "boardList";
    }

    // 9. insertComment
    @RequestMapping(value = "/insertComment.do", method = RequestMethod.POST)
    public String insertComment(Comment cdo, HttpSession session) {
        Member mymember = (Member) session.getAttribute("log");
        if (mymember == null) return "errorPage";
        boardService.saveComment(cdo, mymember.getName(), mymember.getSeq());
        return "redirect:boardView.do?seq=" + cdo.getBoardSeq();
    }

    // 10. modifyComment
    @RequestMapping(value = "/modifyComment.do")
    public String modifyComment(@RequestParam Integer seq, HttpSession session, Model model) {
        Member log = (Member) session.getAttribute("log");
        Comment mycomment = boardService.getComment(seq);

        if (log == null || mycomment == null || !log.getSeq().equals(mycomment.getMemberSeq())) return "errorPage";
        model.addAttribute("mycomment", mycomment);
        return "boardView";
    }

    // 11. modifyProcComment
    @RequestMapping(value = "/modifyProcComment.do", method = RequestMethod.POST)
    public String modifyProcComment(Comment cdo, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";
        boardService.updateComment(cdo);
        return "redirect:/boardView.do?seq=" + cdo.getBoardSeq();
    }

    // 12. deleteComment
    @RequestMapping(value = "/deleteComment.do")
    public String deleteComment(@RequestParam Integer seq, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        Comment mycomment = boardService.getComment(seq);

        if (log == null || mycomment == null || !log.getSeq().equals(mycomment.getMemberSeq())) return "errorPage";
        Integer boardSeq = mycomment.getBoardSeq();
        boardService.deleteComment(seq);
        return "redirect:/boardView.do?seq=" + boardSeq;
    }

    // + like (좋아요)
    @RequestMapping(value = "/toggleLike.do")
    @ResponseBody
    public String toggleLike(@RequestParam Integer seq, HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "error";

        boolean liked = boardService.toggleLike(seq, log.getSeq());
        int count = boardService.getLikeCount(seq);
        return liked + ":" + count; // 예: "true:5"
    }
}