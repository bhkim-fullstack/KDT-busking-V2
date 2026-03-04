	package com.team3.busking.domain;
	
	import jakarta.persistence.*;
	
	import lombok.Getter;
	import lombok.Setter;
	
	import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
	
	@Entity
	@Table(name = "gear")
	@Getter
	@Setter
	public class Gear {

	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long id;

	    @Column(name = "gear_quantity", nullable = false)
	    private int gearQuantity;

	    @Column(name = "gear_name", nullable = false, length = 100)
	    private String gearName;
	    
	    @Column(name = "gear_description", columnDefinition = "TEXT")
	    private String gearDescription;

	    @Column(name = "gear_price", nullable = false)
	    private int gearPrice;

	    @Column(name = "gear_thumbnail", length = 255)
	    private String gearThumbnail;

	    @Column(name = "created_at", insertable = false, updatable = false)
	    private LocalDateTime createdAt;
	    
	    
	}
