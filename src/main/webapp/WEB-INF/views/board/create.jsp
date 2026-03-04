<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>게시글 작성</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/common.css" />
  
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/board.css" />
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
          <span class="current">게시글 작성</span>
        </div>
      </div>
    </div>
  </div>
</section>


<main class="main">
  <div class="board-create-wrap">
    <div class="board-create-box">

      <!-- 제목 -->
      <div class="board-title">게시글 작성</div>

      <form action="<%= request.getContextPath() %>/board/create"
            method="post"
            class="board-form">

        <div class="form-group">
          <label>게시판</label>
          <select name="boardTypeId" required>
            <option value="1" <c:if test="${board.boardTypeId == 1}">selected</c:if>>
              자유게시판
            </option>
            <option value="2" <c:if test="${board.boardTypeId == 2}">selected</c:if>>
              Q&A
            </option>
          </select>
        </div>

        <div class="form-group">
          <label>제목</label>
          <input type="text"
                 name="title"
                 placeholder="제목을 입력하세요"
                 value="${board.title}"
                 required />
        </div>

        <div class="form-group">
          <label>내용</label>
          <textarea name="content"
                    placeholder="내용을 입력하세요"
                    required>${board.content}</textarea>
        </div>

        

        <!-- 버튼 영역 -->
        <div class="form-buttons">
          <a href="<%= request.getContextPath() %>/board/main?typeId=${board.boardTypeId}"
             class="btn-outline btn-secondary">
            취소
          </a>

          <button type="submit"
                  class="btn-outline btn-primary">
            작성 완료
          </button>
        </div>

      </form>

    </div>
  </div>
</main>

  </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
