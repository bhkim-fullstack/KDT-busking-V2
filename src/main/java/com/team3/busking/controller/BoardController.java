package com.team3.busking.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.team3.busking.domain.Board;
import com.team3.busking.domain.Member;
import com.team3.busking.service.BoardService;
import com.team3.busking.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {

    private final BoardService boardService;
    private final MemberService memberService;

    public BoardController(BoardService boardService, 
                      MemberService memberService) {
        this.boardService = boardService;
        this.memberService = memberService;
    }

    /* =========================
       게시판 목록
       ========================= */
    @GetMapping("/main")
    public String boardMain(
            @RequestParam(defaultValue = "1") Long typeId, // 1: 홍보, 2: Q&A
            Model model) {

        List<Board> list = boardService.getBoardsByBoardTypeId(typeId);
        
        model.addAttribute("list", list);
        model.addAttribute("typeId", typeId);
        
        
     // 2️⃣ 작성자 리스트 만들기

        return "board/main"; // JSP / Thymeleaf 뷰
    }

    /* =========================
       게시글 상세
       ========================= */
    @GetMapping("/view")
    public String view(HttpSession session, @RequestParam Long id, Model model) {
       Member loginUser = (Member) session.getAttribute("loginUser");
       if(loginUser == null) {
          
       }
       
       
        Board board = boardService.getBoardById(id)
                .orElseThrow(() -> new IllegalArgumentException("글 없음"));

        model.addAttribute("board", board);

        // Q&A 게시글이면 answer도 보여줄 수 있도록 qna_view 사용
        if (board.getBoardTypeId() == 2) {
            return "board/qna_view"; // 사용자용 Q&A 상세 페이지
        }
        return "board/board_view"; // 일반 게시글 상세
    }

    /* =========================
       글쓰기 폼
       ========================= */
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("board", new Board());
        return "board/create";
    }

    /* =========================
       글쓰기 처리
       ========================= */
    @PostMapping("/create")
    public String createSubmit(HttpSession session, Board board) {
        Member loginMember = (Member) session.getAttribute("loginUser");
        if (loginMember == null) return "redirect:/member/login";

        boardService.createBoard(
                loginMember.getId(),
                board.getBoardTypeId(),
                board.getTitle(),
                board.getContent()
        );

        return "redirect:/board/main?typeId=" + board.getBoardTypeId();
    }

    /* =========================
       수정 폼
       ========================= */
    @GetMapping("/update")
    public String updateForm(@RequestParam Long id, Model model) {
        Board board = boardService.getBoardById(id)
                .orElseThrow(() -> new IllegalArgumentException("글 없음"));

       
        
        model.addAttribute("board", board);
        return "board/update";
    }

    /* =========================
       수정 처리
       ========================= */
    @PostMapping("/update")
    public String updateSubmit(Board board) {
        // 서비스에서 기존 DB 조회 후 안전하게 update
        boardService.updateBoard(board);
        return "redirect:/board/view?id=" + board.getBoardId();
    }

    /* =========================
       삭제
       ========================= */
    @PostMapping("/delete")
    public String delete(@RequestParam Long id) {
        boardService.deleteBoard(id);
        return "redirect:/board/main";
    }
}
