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

    // 조회수 증가
    @Transactional
    public void incrementViews(Integer seq) {
        boardRepository.incrementViews(seq);
    }

    // 게시글 저장
    public void saveBoard(Board board, MultipartFile uploadFile, String realPath, String memberName, Integer memberSeq, String posterUrl) {
        board.setName(memberName);
        board.setMemberSeq(memberSeq);
        board.setTime(new Timestamp(System.currentTimeMillis()));
        board.setContent(board.getContent()
                .replace("\r\n", "\n")
                .replace("\r", "\n")
                .replace("\n", "<br>"));

        if (!uploadFile.isEmpty()) {
            // 직접 업로드한 파일 우선
            String savedName = saveFile(uploadFile, realPath);
            board.setFilename(savedName);
        } else if (!posterUrl.isEmpty()) {
            // TMDB 포스터 URL 저장
            board.setFilename(posterUrl);
        } else {
            board.setFilename("empty.jpg");
        }
        boardRepository.save(board);
    }

    // 게시글 수정
    public void updateBoard(Board bdo, MultipartFile uploadFile, String realPath, String posterUrl) {
        Board existing = boardRepository.findById(bdo.getSeq()).orElseThrow();
        existing.setTitle(bdo.getTitle());
        existing.setContent(bdo.getContent()
                .replace("\r\n", "\n")  // CRLF 정규화
                .replace("\r", "\n")    // CR 정규화
                .replace("<br>", "")    // 기존 <br> 제거
                .replace("\n", "<br>")); // 줄바꿈 → <br>
        existing.setScore(bdo.getScore());
        existing.setTime(new Timestamp(System.currentTimeMillis()));
        existing.setMtitle(bdo.getMtitle());
        existing.setMyear(bdo.getMyear());
        existing.setMgenre(bdo.getMgenre());
        existing.setMcountry(bdo.getMcountry());

        if (!uploadFile.isEmpty()) {
            String savedName = saveFile(uploadFile, realPath);
            existing.setFilename(savedName);
        } else if (!posterUrl.isEmpty()) {
            existing.setFilename(posterUrl); // ← TMDB URL 저장
        }
        boardRepository.save(existing);
    }

    // 게시글 삭제
    @Transactional
    public void deleteBoard(Integer seq) {
        commentRepository.deleteByBoardSeq(seq);
        likeRepository.deleteByBoardSeq(seq);
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
        } else if (sort.equals("likes")) {
            return boardRepository.findAllByOrderByLikeCountDesc(pageable);
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

        Board board = boardRepository.findById(comment.getBoardSeq()).orElseThrow();
        board.setCommentCount(board.getCommentCount() + 1);
        boardRepository.save(board);
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
        Comment comment = commentRepository.findById(seq).orElseThrow();
        Integer boardSeq = comment.getBoardSeq();
        commentRepository.deleteById(seq);

        Board board = boardRepository.findById(boardSeq).orElseThrow();
        board.setCommentCount(Math.max(0, board.getCommentCount() - 1));
        boardRepository.save(board);
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
        Board board = boardRepository.findById(boardSeq).orElseThrow();

        if (existing.isPresent()) {
            likeRepository.delete(existing.get());
            board.setLikeCount(board.getLikeCount() - 1);
            boardRepository.save(board);
            return false;
        } else {
            Like like = new Like();
            like.setBoardSeq(boardSeq);
            like.setMemberSeq(memberSeq);
            likeRepository.save(like);
            board.setLikeCount(board.getLikeCount() + 1);
            boardRepository.save(board);
            return true;
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

    // 내가 좋아요한 글 목록
    public List<Board> getMyLikedBoards(Integer memberSeq) {
        List<Like> likes = likeRepository.findByMemberSeqOrderBySeqDesc(memberSeq);
        return likes.stream()
                .map(like -> boardRepository.findById(like.getBoardSeq()).orElse(null))
                .filter(board -> board != null)
                .collect(java.util.stream.Collectors.toList());
    }

    // 영화 평균 별점
    public Double getAvgScore(String mtitle) {
        if (mtitle == null || mtitle.isEmpty()) return null;
        return boardRepository.findAvgScoreByMtitle(mtitle);
    }

    // 영화 리뷰 개수
    public Integer getReviewCount(String mtitle) {
        if (mtitle == null || mtitle.isEmpty()) return 0;
        return boardRepository.findReviewCountByMtitle(mtitle);
    }
}