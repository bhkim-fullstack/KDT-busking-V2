<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>예약 완료</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gear/reserveComplete.css" />

  <style>
    .alert.success {
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 15px;
      font-weight: bold;
    }
    .alert.error {
      padding: 10px;
      border-radius: 5px;
      margin-bottom: 15px;
      font-weight: bold;
    }
  </style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/nav.jsp"/>


<section class="page-banner">
  <div class="container">
    <div class="page-banner-inner">
      <div class="page-text">
        <h1 class="page-title">장비 예약</h1>
        <div class="breadcrumb">
          <a href="/">홈</a>
          <span class="divider">›</span>
          <a href="/gear/list">장비 리스트</a>
          <span class="divider">›</span>
          <span class="current">장비 예약</span>
          <span class="divider">›</span>
          <span class="current">장비 예약 성공</span>
        </div>
      </div>
    </div>
  </div>
</section>

<main class="complete-main">
  <div class="container">
  	<div class="complete-wrap">
  	  <div class="complete-box">

        <h2>예약 확인</h2>

        <!-- 화면 내 메시지 표시 -->
        <c:if test="${not empty msg and not empty gearReservation}">
			<!-- 체크 아이콘 -->
					<div class="check-icon">
					  <svg width="42" height="42" fill="none" stroke="currentColor" stroke-width="3">
					    <circle cx="21" cy="21" r="19"></circle>
					    <path d="M12 22l6 6 12-14"></path>
					  </svg>
					</div>
          <div class="alert success">${msg}</div>
		  <!-- 가운데 카드 -->
		  		       <div class="mini-card">
		  		         <div class="mini-thumb"
		  		              style="background-image:url('${pageContext.request.contextPath}/images/gear/${gear.gearThumbnail}')">
		  		         </div>

		  		         <div class="mini-body">
		  		           <div class="mini-gear">
		  		             ${gear.gearName}
		  		           </div>

		  		           <dl class="mini-info">
		  		             <div class="mini-row">
		  		               <dt>장비 설명</dt>
		  		               <dd>${gear.gearDescription}</dd>
		  		             </div>
		  		             <div class="mini-row">
		  		               <dt>장비 가격</dt>
		  		               <dd>${gear.gearPrice}</dd>
		  		             </div>
		  		             <div class="mini-row">
		  		               <dt>예약자</dt>
		  		               <dd>${userName}</dd>
		  		             </div>
		  		             <div class="mini-row">
		  		               <dt>예약 기간</dt>
		  		               <dd>${gearReservation.getFormattedReservationPeriod().replace(" ~ ", " ~ <br>")}</dd>
		  		             </div>
		  		           </dl>
		  		         </div>
		  		       </div>

        </c:if>
        <c:if test="${not empty error}">
          <div class="alert error">${error}</div>
        </c:if>
		
		
        <p>마이페이지에서 예약 내역을 확인할 수 있습니다.</p>

       <div class="complete-actions">
    	  <a class="btn-line" href="${pageContext.request.contextPath}/gear/list">
    	    장비 목록으로
    	  </a>
    	  <a class="btn-dark" href="${pageContext.request.contextPath}/mypage">
    	    마이페이지로
    	  </a>
    	</div>

      </div>
  	</div>
  </div>
</main>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>