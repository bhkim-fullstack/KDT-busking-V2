<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>마이페이지</title>
  <link rel="stylesheet" href="css/common.css">
  
  <link rel="stylesheet" href="css/myPage.css">
  
</head>
<body class="mypage-page">


	<jsp:include page="/WEB-INF/views/common/nav.jsp"/>
	
	
<section class="page-banner">
  <div class="container">
    <div class="page-banner-inner">
      <div class="page-text">
        <h1 class="page-title">마이페이지</h1>
        <div class="breadcrumb">
          <a href="/">홈</a>
          <span class="divider">›</span>
          <span class="current">대시보드</span>
        </div>
      </div>
    </div>
  </div>
</section>
	
	
	
<main class="main">
  <div class="container">

    <!-- 프로필 카드 -->
    <section class="profile-card">
      <div class="profile-left">
        <div class="avatar" aria-label="프로필 이미지"></div>
        <div class="profile-basic">
          <div class="nickname-row">
            <h2 class="nickname"><c:out value="${member.nickname}" default="닉네임"/></h2>
            <span class="badge">일반 회원</span>
          </div>
          <c:url var="updateUrl" value="/mypage/update"/>
          <button type="button" class="btn btn-black" onclick="location.href='${updateUrl}'">프로필 수정</button>
        </div>
      </div>
      <div class="profile-right">
        <dl class="info">
          <div class="info-row"><dt>ID</dt><dd><c:out value="${member.memberId}" default="example_user"/></dd></div>
          <div class="info-row"><dt>전화</dt>
          
          <dd>${member.formattedPhone}</dd>
          
          
          
          </div>
          <div class="info-row"><dt>이메일</dt><dd><c:out value="${member.email}" default="user@example.com"/></dd></div>
          <div class="info-row"><dt>가입일</dt><dd><c:out value="${member.createdMemberAt.toString().substring(0,4)}년 
${member.createdMemberAt.toString().substring(5,7)}월 
${member.createdMemberAt.toString().substring(8,10)}일 
${member.createdMemberAt.toString().substring(11,16)}"/></dd></div>
        </dl>
      </div>
    </section>

	<!-- 탭 메뉴 -->
	<section class="tabs">
	  <button class="tab" type="button" data-tab="place">장소 예약 내역</button>
	  <button class="tab" type="button" data-tab="gear">장비 대여 내역</button>
	  <button class="tab" type="button" data-tab="post">내 게시글</button>
	</section>

	<!-- 탭 패널들 -->
	<section class="tab-panels">

	  <!-- 1) 장소 예약 내역 -->
	  <div class="tab-panel" data-panel="place">
	    <section class="list">
	      <c:choose>
	        <c:when test="${empty placeReservations}">
	          <article class="list-item">
	            <div class="item-left">
	              <h3 class="item-title">장소 예약 내역이 없습니다.</h3>
	              <p class="item-meta">예약 후 이곳에서 확인할 수 있어요.</p>
	            </div>
	            <div class="item-right">
	              <button class="btn outline" type="button"
	                      onclick="location.href='${pageContext.request.contextPath}/locale/list'">
	                장소 예약하기
	              </button>
	            </div>
	          </article>
	        </c:when>

	        <c:otherwise>
	          <c:forEach var="r" items="${placeReservations}">
	            <article class="list-item">
	              <div class="item-left">
	                <h3 class="item-title">
	                  장소명 : <c:out value="${r.place.placeName}" /> · 밴드명 : 
	                  <c:out value="${r.bandName}" /> (<c:out value="${r.bandCount}" />명)
	                </h3>
	                <p class="item-meta">
	                  <c:out value="${r.getFormattedReservationPeriod()}" />
	                </p>
	              </div>

	              <div class="item-right">
	                <span class="status ${r.status ? 'done' : 'pending'}">
	                  ${r.status ? '에약 완료' : '예약 취소'}
	                </span>
	                <c:if test="${r.status}">
					    <button class="btn outline" type="button"
					      onclick="location.href='${pageContext.request.contextPath}/mypage/place/return?id=${r.id}&tab=place'">
					      예약 취소하기
					    </button>
					  </c:if>
	              </div>
	            </article>
	          </c:forEach>
	        </c:otherwise>
	      </c:choose>
	    </section>
	  </div>

	  <!-- 2) 장비 대여 내역 -->
	  <div class="tab-panel" data-panel="gear">
	    <section class="list">
	      <c:choose>
	        <c:when test="${empty gearReservations}">
	          <article class="list-item">
	            <div class="item-left">
	              <h3 class="item-title">장비 대여 내역이 없습니다.</h3>
	              <p class="item-meta">대여 후 이곳에서 확인할 수 있어요.</p>
	            </div>
	            <div class="item-right">
	              <button class="btn outline" type="button"
	                      onclick="location.href='${pageContext.request.contextPath}/gear/list'">
	                장비 대여하기
	              </button>
	            </div>
	          </article>
	        </c:when>

	        <c:otherwise>
	          <c:forEach var="gr" items="${gearReservations}">
	            <article class="list-item">
	              <div class="item-left">
	                <h3 class="item-title">
	                  <c:out value="${gr.gear.gearName}" />
	                </h3>
	                <p class="item-meta">
	                  <c:out value="${gr.getFormattedReservationPeriod()}" />
	                </p>
	              </div>

	              <div class="item-right">
					  <span class="status ${gr.status == 'RESERVED' ? 'pending' : 'done'}">
					    <c:out value="${gr.status == 'RESERVED' ? '예약 완료' : '반납 완료'}" />
					  </span>
					
					  <c:if test="${gr.status != 'RETURNED'}">
					    <button class="btn outline" type="button"
					      onclick="location.href='${pageContext.request.contextPath}/mypage/gear/return?id=${gr.id}&tab=gear'">
					      반납하기
					    </button>
					  </c:if>
					</div>
	            </article>
	          </c:forEach>
	        </c:otherwise>
	      </c:choose>
	    </section>
	  </div>

	  <!-- 3) 내 게시글 -->
	  <div class="tab-panel" data-panel="post">
	    <section class="list">
	      <c:choose>
	        <c:when test="${empty posts}">
	          <article class="list-item">
	            <div class="item-left">
	              <h3 class="item-title">게시글이 없습니다.</h3>
	              <p class="item-meta">게시글을 작성하면 여기에서 확인할수 있어요.</p>
	            </div>
	            <div class="item-right">
	              <button class="btn outline" type="button"
	                      onclick="location.href='${pageContext.request.contextPath}/board/main'">
	                게시글 가기
	              </button>
	            </div>
	          </article>
	        </c:when>

	        <c:otherwise>
	          <c:forEach var="post" items="${posts}">
	            <article class="list-item">
	              <div class="item-left">
	                <h3 class="item-title">
	                  <c:out value="${post.title }"/>
	                </h3>
	                <p class="item-meta">
	                  <c:out value="${post.getFormattedCreateWriterAt()}" />
	                </p>
	              </div>

	              <div class="item-right">
	              	<button class="btn outline" type="button"
		                      onclick="location.href='${pageContext.request.contextPath}/board/view?id=<c:url value='${post.boardId}'/>'">
		                게시글 가기
		              </button>
	              
	              </div>
	            </article>
	          </c:forEach>
	        </c:otherwise>
	      </c:choose>
	      
	      
	      
	    </section>
	  </div>

	</section>

  </div>
</main>

<script>
  const tabs = document.querySelectorAll(".tab");
  const panels = document.querySelectorAll(".tab-panel");

  function activateTab(tabName) {
    tabs.forEach(t => {
      t.classList.toggle("active", t.dataset.tab === tabName);
    });

    panels.forEach(p => {
      p.classList.toggle("show", p.dataset.panel === tabName);
    });
  }

  // 탭 클릭 이벤트
  tabs.forEach(tab => {
    tab.addEventListener("click", () => {
      const target = tab.dataset.tab;
      activateTab(target);

      // URL에 탭 정보 추가 (뒤로가기 대응)
      const url = new URL(window.location);
      url.searchParams.set("tab", target);
      window.history.replaceState(null, "", url);
    });
  });

  // 페이지 로드시 URL 파라미터 읽기
  window.addEventListener("DOMContentLoaded", () => {
    const urlParams = new URLSearchParams(window.location.search);
    const currentTab = urlParams.get("tab") || "place"; // 기본값 place
    activateTab(currentTab);
  });
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
