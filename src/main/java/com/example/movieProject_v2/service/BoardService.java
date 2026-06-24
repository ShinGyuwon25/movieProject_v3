package com.example.movieProject_v2.service;

import com.example.movieProject_v2.entity.Board;
import com.example.movieProject_v2.entity.Comment;
import com.example.movieProject_v2.repository.BoardRepository;
import com.example.movieProject_v2.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;
    private final CommentRepository commentRepository;

    // 게시글 목록 (페이징)
    public Page<Board> getBoardList(int page) {
        int pageSize = 10;
        Pageable pageable = PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.DESC, "seq"));
        return boardRepository.findAll(pageable);
    }

    // 게시글 상세 + 조회수 증가
    @Transactional
    public Board getBoardView(Integer seq) {
        boardRepository.incrementViews(seq);
        return boardRepository.findById(seq).orElse(null);
    }

    // 게시글 저장
    public void saveBoard(Board board, MultipartFile uploadFile, String realPath, String memberName, Integer memberSeq) {
        board.setName(memberName);
        board.setMemberSeq(memberSeq);
        board.setTime(new Timestamp(System.currentTimeMillis()));
        board.setContent(board.getContent().replace("\n", "<br>"));

        if (!uploadFile.isEmpty()) {
            String savedName = saveFile(uploadFile, realPath);
            board.setFilename(savedName);
        } else {
            board.setFilename("empty.jpg");
        }
        boardRepository.save(board);
    }

    // 게시글 수정
    public void updateBoard(Board bdo, MultipartFile uploadFile, String realPath) {
        Board existing = boardRepository.findById(bdo.getSeq()).orElseThrow();
        existing.setTitle(bdo.getTitle());
        existing.setContent(bdo.getContent());
        existing.setScore(bdo.getScore());
        existing.setTime(new Timestamp(System.currentTimeMillis()));
        existing.setMtitle(bdo.getMtitle());
        existing.setMyear(bdo.getMyear());
        existing.setMgenre(bdo.getMgenre());
        existing.setMcountry(bdo.getMcountry());

        if (!uploadFile.isEmpty()) {
            String savedName = saveFile(uploadFile, realPath);
            existing.setFilename(savedName);
        }
        boardRepository.save(existing);
    }

    // 게시글 삭제
    public void deleteBoard(Integer seq) {
        boardRepository.deleteById(seq);
    }

    // 게시글 검색
    public List<Board> searchBoard(String searchCon, String searchKey) {
        if (searchCon.equals("title")) {
            return boardRepository.findByTitleContainingOrderBySeqDesc(searchKey);
        } else {
            return boardRepository.findByContentContainingOrderBySeqDesc(searchKey);
        }
    }

    // 댓글 목록
    public List<Comment> getCommentList(Integer boardSeq) {
        return commentRepository.findByBoardSeq(boardSeq);
    }

    // 댓글 저장
    public void saveComment(Comment comment, String memberName, Integer memberSeq) {
        comment.setTime(new Timestamp(System.currentTimeMillis()));
        comment.setName(memberName);
        comment.setMemberSeq(memberSeq);
        commentRepository.save(comment);
    }

    // 댓글 수정
    public void updateComment(Comment cdo) {
        Comment existing = commentRepository.findById(cdo.getSeq()).orElseThrow();
        existing.setContent(cdo.getContent());
        existing.setTime(new Timestamp(System.currentTimeMillis()));
        commentRepository.save(existing);
    }

    // 댓글 삭제
    public void deleteComment(Integer seq) {
        commentRepository.deleteById(seq);
    }

    // 댓글 조회
    public Comment getComment(Integer seq) {
        return commentRepository.findById(seq).orElse(null);
    }

    // 게시글 조회
    public Board getBoard(Integer seq) {
        return boardRepository.findById(seq).orElse(null);
    }

    // 파일 저장 (내부용)
    private String saveFile(MultipartFile uploadFile, String realPath) {

        // 허용할 확장자 목록
        String originalFileName = uploadFile.getOriginalFilename();
        String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1).toLowerCase();
        List<String> allowedExt = List.of("jpg", "jpeg", "png", "gif");

        if (!allowedExt.contains(ext)) {
            log.error("허용되지 않는 파일 형식: {}", ext);
            return "empty.jpg";
        }

        try {
            File dir = new File(realPath);
            if (!dir.exists()) dir.mkdirs();

            String nameWithoutExt = originalFileName.substring(0, originalFileName.lastIndexOf("."));
            String sanitized = nameWithoutExt.replaceAll("[^a-zA-Z0-9.-]", "_");
            String savedName = sanitized + UUID.randomUUID().toString().substring(0, 3) + "." + ext;

            uploadFile.transferTo(new File(realPath + savedName));
            return savedName;
        } catch (IOException e) {
            log.error("파일 저장 실패", e);
            return "empty.jpg";
        }
    }
}