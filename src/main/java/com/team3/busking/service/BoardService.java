package com.team3.busking.service;

import com.team3.busking.domain.Board;
import com.team3.busking.domain.Member;
import com.team3.busking.repository.BoardRepository;
import com.team3.busking.repository.MemberRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BoardService {

    private final BoardRepository boardRepository;
    private final MemberRepository memberRepository;

    public BoardService(BoardRepository boardRepository, MemberRepository memberRepository) {
        this.boardRepository = boardRepository;
        this.memberRepository = memberRepository;
    }

    // 게시판별 글 조회
    public List<Board> getBoardsByBoardTypeId(Long boardTypeId) {
        return boardRepository.findByBoardTypeIdOrderByBoardIdDesc(boardTypeId);
    }

    // 작성자별 글 조회
    public List<Board> getBoardsByUserId(Long userId) {
        return boardRepository.findByMember_IdOrderByBoardIdDesc(userId);
    }

    // 단일 게시글 조회
    public Optional<Board> getBoardById(Long boardId) {
        return boardRepository.findById(boardId);
    }

    // 게시글 등록
    public Board createBoard(Long userId, Long boardTypeId, String title, String content) {
        Member member = memberRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("회원이 존재하지 않습니다."));

        Board board = new Board();
        board.setMember(member);                 // ✅ Board에 member 연관관계가 있어야 함
        board.setBoardTypeId(boardTypeId);
        board.setTitle(title);
        board.setContent(content);

        return boardRepository.save(board);
    }

    // 게시글 수정 (Q&A 답변 포함)
    @Transactional
    public void updateBoard(Board boardDto) {
        // 1. 기존 DB 엔티티 조회
        Board existing = boardRepository.findById(boardDto.getBoardId())
                .orElseThrow(() -> new IllegalArgumentException("게시글이 존재하지 않습니다."));

        // 2. 값 업데이트
        if (boardDto.getBoardTypeId() == null) {
            throw new IllegalArgumentException("게시판 타입이 선택되지 않았습니다.");
        }
        existing.setBoardTypeId(boardDto.getBoardTypeId());
        existing.setTitle(boardDto.getTitle());
        existing.setContent(boardDto.getContent());


        // ✅ Q&A 답변 업데이트
        if (boardDto.getAnswer() != null) {
            existing.setAnswer(boardDto.getAnswer());
        }

        // 3. save() 호출 없어도 트랜잭션 commit 시 JPA가 자동으로 update
    }

    // 게시글 삭제
    public void deleteBoard(Long id) {
        boardRepository.deleteById(id);
    }
    
    /**
     * 최신 게시글 5개 가져오기
     */
    public List<Board> getLatestBoards() {
        return boardRepository.findTop5ByOrderByCreateWriterAtDesc();
    }
}
