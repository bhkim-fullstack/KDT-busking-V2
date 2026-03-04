package com.team3.busking.domain;

import java.time.LocalDate;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "member")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Member {

    // ✅ DB PK
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 로그인 ID
    @Column(name = "member_id", length = 20, nullable = false, unique = true)
    private String memberId;

    @Column(length = 100, nullable = false)
    private String pw;

    @Column(length = 50, nullable = false)
    private String name;

    @Column(length = 50)
    private String nickname;

    @Column(length = 225)
    private String email;

    @Column(length = 11)
    private String phone;

    // 생년월일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "birth_date")
    private LocalDate birthDate;

    @Column(length = 1)
    private String gender;

    // 생성일 (DB default 사용)
    @Column(
        name = "created_member_at",
        insertable = false,
        updatable = false
    )
    private LocalDateTime createdMemberAt;
    
    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<MemberRole> roles = new ArrayList<>();
    
    public String getFormattedPhone() {

        if (this.phone == null) return "";

        String onlyNumber = this.phone.replaceAll("[^0-9]", "");

        // ✅ 휴대폰 (010-1234-5678)
        if (onlyNumber.matches("^01\\d{8,9}$")) {
            if (onlyNumber.length() == 11) {
                return onlyNumber.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
            } else { // 10자리 휴대폰 (옛날 011 등)
                return onlyNumber.replaceAll("(\\d{3})(\\d{3})(\\d{4})", "$1-$2-$3");
            }
        }

        // ✅ 서울 지역번호 (02-1234-5678 / 02-123-4567)
        if (onlyNumber.startsWith("02")) {
            if (onlyNumber.length() == 10) {
                return onlyNumber.replaceAll("(\\d{2})(\\d{4})(\\d{4})", "$1-$2-$3");
            } else if (onlyNumber.length() == 9) {
                return onlyNumber.replaceAll("(\\d{2})(\\d{3})(\\d{4})", "$1-$2-$3");
            }
        }

        // ✅ 그 외 지역번호 (031, 051 등)
        if (onlyNumber.length() == 10) {
            return onlyNumber.replaceAll("(\\d{3})(\\d{3})(\\d{4})", "$1-$2-$3");
        } else if (onlyNumber.length() == 11) {
            return onlyNumber.replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-$2-$3");
        }

        return this.phone; // 형식이 맞지 않으면 원본 반환
    }
//    입력값	결과
//    01012345678	010-1234-5678
//    0111234567	011-123-4567
//    0212345678	02-1234-5678
//    021234567	02-123-4567
//    0311234567	031-123-4567
    
//    대한민국 번호 구조는:
//    	휴대폰 → 3자리(010) + 3~4자리 + 4자리
//    	서울(02) → 2자리 + 3~4자리 + 4자리
//    	기타 지역 → 3자리 + 3~4자리 + 4자리
}
