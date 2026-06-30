package com.example.movieProject_v3.service;

import com.example.movieProject_v3.entity.Board;
import com.example.movieProject_v3.entity.Comment;
import com.example.movieProject_v3.repository.BoardRepository;
import com.example.movieProject_v3.repository.CommentRepository;
import com.example.movieProject_v3.repository.LikeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.example.movieProject_v3.entity.Like;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;
    private final CommentRepository commentRepository;
    private final LikeRepository likeRepository;

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

    // 정렬된 게시글 목록
    public Page<Board> getBoardListSorted(int page, String sort) {
        int pageSize = 10;
        Pageable pageable = PageRequest.of(page - 1, pageSize);
        if (sort.equals("views")) {
            return boardRepository.findAllByOrderByViewsDesc(pageable);
        } else if (sort.equals("score")) {
            return boardRepository.findAllByOrderByScoreDesc(pageable);
        } else {
            return boardRepository.findAll(
                    PageRequest.of(page - 1, pageSize, Sort.by(Sort.Direction.DESC, "seq"))
            );
        }
    }

    // 장르 필터링
    public List<Board> filterByGenre(String mgenre) {
        return boardRepository.findByMgenreOrderBySeqDesc(mgenre);
    }

    // 국가 필터링
    public List<Board> filterByCountry(String mcountry) {
        return boardRepository.findByMcountryOrderBySeqDesc(mcountry);
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

    // 내가 쓴 글 목록
    public List<Board> getMyBoards(String name) {
        return boardRepository.findByNameOrderBySeqDesc(name);
    }

    // 내가 쓴 댓글 목록
    public List<Comment> getMyComments(String name) {
        return commentRepository.findByNameOrderBySeqDesc(name);
    }

    // 좋아요
    @Transactional
    public boolean toggleLike(Integer boardSeq, Integer memberSeq) {
        Optional<Like> existing = likeRepository.findByBoardSeqAndMemberSeq(boardSeq, memberSeq);
        if (existing.isPresent()) {
            likeRepository.delete(existing.get());
            return false; // 좋아요 취소
        } else {
            Like like = new Like();
            like.setBoardSeq(boardSeq);
            like.setMemberSeq(memberSeq);
            likeRepository.save(like);
            return true; // 좋아요 추가
        }
    }

    // 좋아요 개수
    public int getLikeCount(Integer boardSeq) {
        return likeRepository.countByBoardSeq(boardSeq);
    }

    // 내가 좋아요 눌렀는지 확인
    public boolean isLiked(Integer boardSeq, Integer memberSeq) {
        return likeRepository.findByBoardSeqAndMemberSeq(boardSeq, memberSeq).isPresent();
    }
}