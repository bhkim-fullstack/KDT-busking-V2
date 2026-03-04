	package com.team3.busking.domain;
	
	import jakarta.persistence.*;
	import lombok.Getter;
	import lombok.Setter;
	
	import org.hibernate.annotations.CreationTimestamp;
	
	import java.time.LocalDate;
	import java.time.LocalDateTime;
	import java.time.LocalTime;
	
	@Entity
	@Getter
	@Setter
	@Table(
	    name = "place_reservation",
	    uniqueConstraints = {
	        @UniqueConstraint(
	            name = "uq_place_reservation_slot",
	            columnNames = {"place_id", "reservation_date", "start_time"}
	        )
	    }
	)
	public class PlaceReservation {
	
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(name = "id")
	    private Long id;
	
	    @Column(name = "user_id", nullable = false)
	    private Long userId;
	
	    @ManyToOne(fetch = FetchType.LAZY, optional = false)
	    @JoinColumn(name = "place_id", nullable = false)
	    private Place place;
	
	    @Column(name = "band_name", nullable = false, length = 100)
	    private String bandName;
	
	    @Column(name = "band_count", nullable = false)
	    private Integer bandCount;
	
	    @Column(name = "phone", length = 50)
	    private String phone;
	
	    @Column(name = "email", length = 100)
	    private String email;
	
	    @Column(name = "reservation_date", nullable = false)
	    private LocalDate reservationDate;
	
	    @Column(name = "start_time", nullable = false)
	    private LocalTime startTime;
	
	    @Column(name = "end_time")
	    private LocalTime endTime;
	
	    @Column(name = "status", nullable = false)
	    private Boolean status = true;
	
	    @CreationTimestamp
	    @Column(name = "created_at", updatable = false)
	    private LocalDateTime createdAt;
	    
	    /**
	     * 예약 일시를 "yyyy년 MM월 dd일 HH:mm ~ HH:mm" 형식으로 반환
	     */
	    public String getFormattedReservationPeriod() {
	        if (reservationDate == null || startTime == null) return "";

	        if (endTime == null) {
	            return reservationDate.getYear() + "년 "
	                    + String.format("%02d", reservationDate.getMonthValue()) + "월 "
	                    + String.format("%02d", reservationDate.getDayOfMonth()) + "일 "
	                    + startTime.toString();
	        }

	        return String.format("%d년 %02d월 %02d일 %s ~ %s",
	                reservationDate.getYear(),
	                reservationDate.getMonthValue(),
	                reservationDate.getDayOfMonth(),
	                startTime.toString(),
	                endTime.toString()
	        );
	    }
	
	    
	}