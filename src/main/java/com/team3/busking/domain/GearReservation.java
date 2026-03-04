package com.team3.busking.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;



@Entity
@Getter
@Setter
@Table(name = "gear_reservation")
public class GearReservation {
	public enum GearReservationStatus{
		RESERVED,
	    RETURNED,
	    CANCELED
	}

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id") // ✅ DB: gear_reservation.id
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "gear_id", nullable = false) // ✅ DB: gear_id (FK → gear.id)
    private Gear gear;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false) // ✅ DB: member_id (FK → member.id)
    private Member member;

    @Column(name = "start_datetime", nullable = false)
    private LocalDateTime startDatetime;

    @Column(name = "end_datetime", nullable = false)
    private LocalDateTime endDatetime;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private GearReservationStatus status;

    @Column(name = "created_at", insertable = false, updatable = false) // ✅ DB: DEFAULT CURRENT_TIMESTAMP
    private LocalDateTime createdAt;
    
    /**
     * 생성일자를 "YYYY년 MM월 DD일 HH:mm" 형식으로 반환
     */
    public String getFormattedCreateWriterAt() {
        if (this.createdAt == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm");
        return this.createdAt.format(formatter);
    }
    
    /**
     * 예약 기간을 "yyyy년 MM월 dd일 HH:mm ~ HH:mm" 형식으로 반환
     * (같은 날짜인 경우 날짜는 한 번만 출력)
     */
    public String getFormattedReservationPeriod() {
        if (this.startDatetime == null || this.endDatetime == null) return "";

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

        if (startDatetime.toLocalDate().equals(endDatetime.toLocalDate())) {
            return startDatetime.format(dateFormatter) + " "
                    + startDatetime.format(timeFormatter)
                    + " ~ "
                    + endDatetime.format(timeFormatter);
        } else {
            DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm");
            return startDatetime.format(fullFormatter)
                    + " ~ "
                    + endDatetime.format(fullFormatter);
        }
    }
    
    
}
