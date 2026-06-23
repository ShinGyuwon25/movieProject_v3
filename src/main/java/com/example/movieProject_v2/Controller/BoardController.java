package com.example.movieProject_v2.Controller;

import com.example.movieProject_v2.entity.Board;
import com.example.movieProject_v2.entity.Comment;
import com.example.movieProject_v2.entity.Member;
import com.example.movieProject_v2.repository.BoardRepository;
import com.example.movieProject_v2.repository.CommentRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

@Controller
public class BoardController {

    @Autowired
    private BoardRepository boardRepository;

    @Autowired
    private CommentRepository commentRepository;

    // 1. boardList
    @RequestMapping(value = "/boardList.do")
    public String boardList(@RequestParam(defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        // 페이징 (0페이지 시작, seq 내림차순 정렬)
        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.DESC, "seq"));

        Page<Board> boardPage = boardRepository.findAll(pageable);

        model.addAttribute("bList", boardPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", boardPage.getTotalPages());

        return "boardList";
    }

    // 2. boardView
    @Transactional // 트랜직선(조회수 업데이트+상세 조회)
    @RequestMapping(value = "/boardView.do")
    public String boardView(@RequestParam Integer seq, Model model) {
        boardRepository.incrementViews(seq); // DB에 조회수 증가

        Board myboard = boardRepository.findById(seq).orElse(null);
        model.addAttribute("myboard", myboard);

        List<Comment> cList = commentRepository.findByBoardSeq(seq);
        model.addAttribute("cList", cList);

        return "boardView";
    }

    // 3. insertBoard
    @RequestMapping(value = "/insertBoard.do")
    public String insertBoard(Model model, HttpSession session) {
        Member mymember = (Member) session.getAttribute("log");
        model.addAttribute("mymember", mymember);
        return "insertBoard";
    }

    // 4. insertProcBoard
    @RequestMapping(value = "/insertProcBoard.do", method = RequestMethod.POST)
    public String insertProcBoardPost(@RequestParam("score") float score,
                                      Board bdo, HttpSession session, HttpServletRequest request,
                                      @RequestParam("uploadFile") MultipartFile uploadFile) {

        Member mymember = (Member) session.getAttribute("log");
        bdo.setName(mymember.getName());
        bdo.setScore(score);
        bdo.setTime(new Timestamp(System.currentTimeMillis()));
        bdo.setContent(bdo.getContent().replace("\n", "<br>"));

        // 포스터 파일 저장
        String realPath = request.getSession().getServletContext().getRealPath("/poster/poster/");
        File dir = new File(realPath);
        if(!dir.exists()) dir.mkdirs(); // 폴더 없으면 에러 안 나게

        if (!uploadFile.isEmpty()) {
            try {
                String originalFileName = uploadFile.getOriginalFilename();
                String sanitizedFileName = sanitizeFileName(originalFileName);
                String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
                String saveFileName = sanitizedFileName + UUID.randomUUID().toString().substring(0, 3) + ext;

                bdo.setFilename(saveFileName);
                uploadFile.transferTo(new File(realPath + saveFileName));
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            bdo.setFilename("empty.jpg");
        }

        boardRepository.save(bdo);
        return "redirect:boardList.do";
    }

    private String sanitizeFileName(String fileName) {
        // 확장자 제거 후 특수문자 치환
        String nameWithoutExt = fileName.substring(0, fileName.lastIndexOf("."));
        return nameWithoutExt.replaceAll("[^a-zA-Z0-9.-]", "_");
    }

    // 5. modifyBoard
    @RequestMapping(value = "/modifyBoard.do")
    public String modifyBoard(@RequestParam Integer seq, Model model, HttpSession session) {
        Board myboard = boardRepository.findById(seq).orElse(null);
        model.addAttribute("myboard", myboard);

        Member log = (Member) session.getAttribute("log");
        if (log == null || !log.getName().equals(myboard.getName())) {
            return "errorPage";
        }
        return "modifyBoard";
    }

    // 6. modifyProcBoard
    @RequestMapping(value = "/modifyProcBoard.do", method = RequestMethod.POST)
    public String modifyProcBoard(@RequestParam("score") float score, Board bdo,
                                  HttpSession session, HttpServletRequest request,
                                  @RequestParam("uploadFile") MultipartFile uploadFile) {

        Board existingBoard = boardRepository.findById(bdo.getSeq()).orElseThrow();

        // 기본 정보 수정
        existingBoard.setTitle(bdo.getTitle());
        existingBoard.setContent(bdo.getContent());
        existingBoard.setScore(score);
        existingBoard.setTime(new Timestamp(System.currentTimeMillis()));

        // 영화 정보 수정
        existingBoard.setMtitle(bdo.getMtitle());
        existingBoard.setMyear(bdo.getMyear());
        existingBoard.setMgenre(bdo.getMgenre());
        existingBoard.setMcountry(bdo.getMcountry());

        // 파일 업로드
        String realPath = request.getSession().getServletContext().getRealPath("/poster/poster/");
        if (!uploadFile.isEmpty()) {
            try {
                String originalFileName = uploadFile.getOriginalFilename();
                String sanitizedFileName = sanitizeFileName(originalFileName);
                String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
                String saveFileName = sanitizedFileName + UUID.randomUUID().toString().substring(0, 3) + ext;

                existingBoard.setFilename(saveFileName);
                uploadFile.transferTo(new File(realPath + saveFileName));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        boardRepository.save(existingBoard);
        return "redirect:/boardView.do?seq=" + bdo.getSeq();
    }

    // 7. deleteBoard
    @RequestMapping(value = "/deleteBoard.do")
    public String deleteBoard(@RequestParam Integer seq, HttpSession session) {
        Board myboard = boardRepository.findById(seq).orElse(null);
        Member log = (Member) session.getAttribute("log");

        if (log == null || myboard == null || !log.getName().equals(myboard.getName())) {
            return "errorPage";
        }

        boardRepository.deleteById(seq);
        return "redirect:boardList.do";
    }

    // 8. searchBoard
    @RequestMapping(value = "/searchBoard.do")
    public String searchBoard(@RequestParam("searchCon") String searchCon,
                              @RequestParam("searchKey") String searchKey, Model model) {

        List<Board> sList;
        if (searchCon.equals("title")) {
            sList = boardRepository.findByTitleContainingOrderBySeqDesc(searchKey);
        } else if (searchCon.equals("content")) {
            sList = boardRepository.findByContentContainingOrderBySeqDesc(searchKey);
        } else {
            return "redirect:boardList.do";
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
        cdo.setTime(new Timestamp(System.currentTimeMillis()));
        Member mymember = (Member) session.getAttribute("log");
        cdo.setName(mymember.getName());

        commentRepository.save(cdo);
        return "redirect:boardView.do?seq=" + cdo.getBoardSeq();
    }

    // 10. modifyComment 화면 이동
    @RequestMapping(value = "/modifyComment.do")
    public String modifyComment(@RequestParam Integer seq, HttpSession session, Model model) {
        Comment mycomment = commentRepository.findById(seq).orElse(null);
        model.addAttribute("mycomment", mycomment);

        Member log = (Member) session.getAttribute("log");
        if (log == null || mycomment == null || !log.getName().equals(mycomment.getName())) {
            return "errorPage";
        }
        return "boardView";
    }

    // 11. modifyProcComment
    @RequestMapping(value = "/modifyProcComment.do", method = RequestMethod.POST)
    public String modifyProcComment(Comment cdo, HttpSession session) {
        Comment existingComment = commentRepository.findById(cdo.getSeq()).orElseThrow();
        existingComment.setContent(cdo.getContent());
        existingComment.setTime(new Timestamp(System.currentTimeMillis()));

        commentRepository.save(existingComment);
        return "redirect:/boardView.do?seq=" + existingComment.getBoardSeq();
    }

    // 12. deleteComment
    @RequestMapping(value = "/deleteComment.do")
    public String deleteComment(@RequestParam Integer seq, HttpSession session) {
        Comment mycomment = commentRepository.findById(seq).orElse(null);
        Member log = (Member) session.getAttribute("log");

        if (log == null || mycomment == null || !log.getName().equals(mycomment.getName())) {
            return "errorPage";
        }

        Integer boardSeq = mycomment.getBoardSeq();
        commentRepository.deleteById(seq);
        return "redirect:/boardView.do?seq=" + boardSeq;
    }
}
