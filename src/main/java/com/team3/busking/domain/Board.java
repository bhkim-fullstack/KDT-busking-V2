package com.team3.busking.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "board")
@Getter @Setter
public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long boardId;

    // ✅ 작성자 FK
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private Member member;

    @Column(name = "board_type_id", nullable = false)
    private Long boardTypeId;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Column(name = "create_writer_at", columnDefinition = "DATETIME")
    private LocalDateTime createWriterAt = LocalDateTime.now();

    @Column(columnDefinition = "TEXT")
    private String answer;
    
    /**
     * 생성일자를 "YYYY년 MM월 DD일 HH:mm" 형식으로 반환
     */
    public String getFormattedCreateWriterAt() {
        if (this.createWriterAt == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm");
        return this.createWriterAt.format(formatter);
    }
    
}
