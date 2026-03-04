<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>게시글 상세</title>

  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/common.css" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/board.css" />
  
 <style>
.board-view-content {
  max-width: 100%;
  word-wrap: break-word;
  word-break: break-word;
  white-space: pre-wrap;
  overflow-wrap: break-word;
}

.board-view-content p {
  margin: 0;   /* 기본 위아래 여백 제거 */
}


 </style>
</head>

<body>

<jsp:include page="/WEB-INF/views/common/nav.jsp"/>



<section class="page-banner">
  <div class="container">
    <div class="page-banner-inner">
      <div class="page-text">
        <h1 class="page-title">게시판</h1>
        <div class="breadcrumb">
          <a href="/">홈</a>
          <span class="divider">›</span>
          <a href="/board/main?=typeId=1">게시판</a>
          <span class="divider">›</span>
          <span class="current">자유 게시판</span>
        </div>
      </div>
    </div>
  </div>
</section>


<main class="board-page">
  <div class="board-view-wrap">

    <div class="board-view-box">

      <!-- 제목 -->
      <h1 class="board-view-title">
        ${board.title}
      </h1>

      <!-- 작성자 / 날짜 -->
      <div class="board-view-meta">
        작성자 ${board.member.nickname} |
        <c:out value="${board.createWriterAt.toString().substring(0,4)}년 
${board.createWriterAt.toString().substring(5,7)}월 
${board.createWriterAt.toString().substring(8,10)}일 
${board.createWriterAt.toString().substring(11,16)}" />
      </div>

      <!-- 내용 -->
      <div class="board-view-content">${board.content}</div>

      <!-- 버튼 영역 -->
      <div class="board-view-actions">

  <button class="btn-outline"
    onclick="location.href='<%=request.getContextPath()%>/board/main?typeId=${board.boardTypeId}'">
    목록
  </button>

  <c:if test="${not empty sessionScope.loginUser 
              and sessionScope.loginUser.id == board.member.id}">

      <button class="btn-outline"
        onclick="location.href='<%=request.getContextPath()%>/board/update?id=${board.boardId}'">
        수정
      </button>

      <form action="<%=request.getContextPath()%>/board/delete" method="post">
        <input type="hidden" name="id" value="${board.boardId}" />
        <button type="submit" class="btn-outline"
          onclick="return confirm('게시글을 삭제하시겠습니까?');">
          삭제
        </button>
      </form>

  </c:if>

</div>

    </div>
  </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
