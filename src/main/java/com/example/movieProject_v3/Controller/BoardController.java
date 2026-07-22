package com.example.movieProject_v3.Controller;

import com.example.movieProject_v3.entity.Board;
import com.example.movieProject_v3.entity.Comment;
import com.example.movieProject_v3.entity.Member;
import com.example.movieProject_v3.service.BoardService;
import com.example.movieProject_v3.service.MemberService;
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
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    private final MemberService memberService;

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

        // TOP3 따로 변수로 받기
        List<Board> top3List = boardService.getTop3();
        model.addAttribute("top3List", top3List);

        // TOP3 프로필 맵
        if (top3List != null) {
            Map<String, String> profileMap = new java.util.HashMap<>();
            for (Board board : top3List) {
                profileMap.put(board.getName(), memberService.getProfileImgByName(board.getName()));
            }
            model.addAttribute("profileMap", profileMap);
        }

        return "boardList";
    }

    // 2. boardView
    @RequestMapping(value = "/boardView.do")
    public String boardView(@RequestParam Integer seq, Model model, HttpSession session) {
        Board myboard = boardService.getBoard(seq); // 조회수 증가 없이 먼저 가져옴

        if (myboard == null) return "errorPage";

        // 세션에 이 글 본 기록 없으면 조회수 증가
        String viewedKey = "viewed_" + seq;
        if (session.getAttribute(viewedKey) == null) {
            boardService.incrementViews(seq);
            session.setAttribute(viewedKey, true);
        }

        // 조회수 증가 후 다시 가져오기
        myboard = boardService.getBoard(seq);

        List<Comment> cList = boardService.getCommentList(seq);
        model.addAttribute("myboard", myboard);
        model.addAttribute("cList", cList);
        model.addAttribute("authorName", myboard.getName());
        model.addAttribute("likeCount", boardService.getLikeCount(seq));

        Member log = (Member) session.getAttribute("log");
        if (log != null) {
            model.addAttribute("isLiked", boardService.isLiked(seq, log.getSeq()));
        }

        // 평균 별점 추가
        model.addAttribute("avgScore", boardService.getAvgScore(myboard.getMtitle()));
        model.addAttribute("reviewCount", boardService.getReviewCount(myboard.getMtitle()));

        // 작성자 + 댓글 프로필 맵
        model.addAttribute("authorProfileImg", memberService.getProfileImgByName(myboard.getName()));
        Map<String, String> commentProfileMap = new java.util.HashMap<>();
        for (Comment comment : cList) {
            if (comment.getName() != null) {
                commentProfileMap.put(comment.getName(), memberService.getProfileImgByName(comment.getName()));
            }
        }
        model.addAttribute("commentProfileMap", commentProfileMap);

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
        return "redirect:boardView.do?seq=" + bdo.getSeq();
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

    // 마이페이지 - 게시글 일괄 삭제
    @RequestMapping(value = "/deleteSelectedBoards.do", method = RequestMethod.POST)
    public String deleteSelectedBoards(
            @RequestParam(value = "seqs", required = false) List<Integer> seqs,
            HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";
        if (seqs != null && !seqs.isEmpty()) boardService.deleteSelectedBoards(seqs);
        return "redirect:/myPage.do";
    }

    // 마이페이지 - 댓글 일괄 삭제
    @RequestMapping(value = "/deleteSelectedComments.do", method = RequestMethod.POST)
    public String deleteSelectedComments(
            @RequestParam(value = "seqs", required = false) List<Integer> seqs,
            HttpSession session) {
        Member log = (Member) session.getAttribute("log");
        if (log == null) return "errorPage";
        if (seqs != null && !seqs.isEmpty()) boardService.deleteSelectedComments(seqs);
        return "redirect:/myPage.do";
    }
}