<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>버스킹 회원가입</title>

  <!-- ✅ 공통 CSS (c:url로 고정) -->
  <link rel="stylesheet" href="<c:url value='/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/css/main.css'/>" />

  <style>
    /* ====== 회원가입 페이지 단일 파일 CSS (로그인 디자인과 동일) ====== */

    body.join-page {
      margin: 0;
      min-height: 100vh;
      font-family: "맑은 고딕", sans-serif;
      overflow-x: hidden;
    }

    /* 배경 + 오버레이 */
    .join-bg {
      position: fixed;
      inset: 0;
      background: url("<c:url value='/images/busking.png'/>") center / cover no-repeat;
      z-index: 0;
    }
    .join-bg::after {
      content: "";
      position: absolute;
      inset: 0;
      background: rgba(0, 0, 0, 0.45);
    }

    /* 가운데 정렬 */
    .join-wrap {
      position: relative;
      z-index: 1;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 18px 16px;
      gap: 10px;
      transform: translateY(-10px);
    }

    /* 상단 로고 */
    .join-brand img {
      width: clamp(220px, 28vw, 320px);
      height: auto;
      display: block;
      filter: drop-shadow(0 10px 18px rgba(0,0,0,0.35));
    }

    /* 카드 */
    .join-card {
      width: 520px;
      max-width: 92vw;
      background: rgba(255, 255, 255, 0.92);
      border-radius: 16px;
      padding: 22px 28px 18px;
      box-shadow: 0 20px 60px rgba(0,0,0,0.35);
      backdrop-filter: blur(2px);
    }

    .join-title {
      margin: 0 0 14px;
      font-size: 18px;
      color: #222;
      text-align: center;
      font-weight: 700;
    }

    /* 폼: 2열 그리드(화면 좁아지면 1열) */
    .join-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 12px 14px;
    }
    @media (max-width: 520px) {
      .join-grid { grid-template-columns: 1fr; }
    }

    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .field label {
      font-size: 12px;
      color: #333;
    }

    .field input {
      height: 40px;
      border: 1px solid #d6d6d6;
      border-radius: 8px;
      padding: 0 12px;
      outline: none;
      background: #fff;
      font-size: 14px;
    }
    .field input:focus { border-color: #888; }

    /* 전체 폭 쓰는 행 */
    .full { grid-column: 1 / -1; }

    /* 성별 라디오 */
    .gender-row {
      display: flex;
      align-items: center;
      gap: 14px;
      height: 40px;
      padding: 0 6px;
    }
    .gender-row label {
      font-size: 14px;
      color: #444;
      display: flex;
      align-items: center;
      gap: 6px;
      cursor: pointer;
    }

    /* 버튼 */
    .join-btn {
      width: 100%;
      height: 42px;
      margin-top: 14px;
      border: none;
      border-radius: 8px;
      background: #222;
      color: #fff;
      cursor: pointer;
      font-weight: 700;
      font-size: 14px;
    }
    .join-btn:hover { background: #111; }

    /* 하단 링크 */
    .join-links {
      margin-top: 12px;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 18px;
      font-size: 12px;
      color: #666;
    }
    .join-links a {
      color: #666;
      text-decoration: none;
      font-weight: 600;
    }
    .join-links a:hover { text-decoration: underline; }

    .divider {
      width: 1px;
      height: 10px;
      background: #cfcfcf;
      display: inline-block;
    }

    .slash { color:#999; margin:0 2px; }
    .find-text { font-weight: 500; }

    /* common.css의 header가 뜨면 숨김 */
    header.header { display: none !important; }
  </style>
</head>

<body class="join-page">

  <div class="join-bg"></div>

  <div class="join-wrap">
    <div class="join-brand">
      <a href="<c:url value='/'/>" aria-label="메인페이지로 이동">
        <img src="<c:url value='/images/buskinglogo.png'/>" alt="BUSKING RESERVATION" />
      </a>
    </div>

    <div class="join-card">
      <h2 class="join-title">회원가입</h2>
      <c:if test="${not empty errorMessage}">
<script>
    alert("${errorMessage}");
</script>
</c:if>

      <!-- ✅ 컨트롤러에 맞게: POST /member/register -->
      <form method="post" action="<c:url value='/member/register'/>">
        <div class="join-grid">

          <!-- 아이디 -->
          <div class="field">
            <label for="memberId">아이디</label>
            <input type="text" id="memberId" name="memberId" required placeholder="아이디를 입력하세요">
          </div>

          <!-- 비밀번호 -->
          <div class="field">
            <label for="pw">비밀번호</label>
            <input type="password" id="pw" name="pw" required placeholder="비밀번호를 입력하세요">
          </div>

          <!-- 이름 -->
          <div class="field">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required placeholder="이름을 입력하세요">
          </div>

          <!-- 닉네임 -->
          <div class="field">
            <label for="nickname">닉네임</label>
            <input type="text" id="nickname" name="nickname" required placeholder="닉네임을 입력하세요">
          </div>

          <!-- 이메일 -->
          <div class="field full">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="example@email.com">
          </div>

          <!-- 전화번호 -->
          <div class="field">
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="phone" placeholder="010-1234-5678">
          </div>

          <!-- 생년월일 (컨트롤러 InitBinder: LocalDate yyyy-MM-dd 파싱됨) -->
          <div class="field">
            <label for="birthDate">생년월일</label>
            <input type="date" id="birthDate" name="birthDate">
          </div>

          <!-- 성별 -->
          <div class="field full">
            <label>성별</label>
            <div class="gender-row">
              <label for="genderM">
                <input type="radio" name="gender" value="M" id="genderM">
                남
              </label>
              <label for="genderF">
                <input type="radio" name="gender" value="F" id="genderF">
                여
              </label>
            </div>
          </div>

        </div>

        <!-- ✅ submit으로 바꿔야 컨트롤러 POST /member/register로 감 -->
        <button type="submit" class="join-btn">가입하기</button>

        <div class="join-links">
          <a href="<c:url value='/member/login'/>">로그인으로</a>
          <span class="divider"></span>

          <!-- ⚠️ find-id/find-pw는 컨트롤러에 POST만 있으므로
               GET 페이지가 없다면 정적 html로 연결해야 404가 안 남 -->
          <a class="find-link" href="<c:url value='/member/find-id'/>">ID</a>
          <span class="slash">/</span>
          <a class="find-link" href="<c:url value='/member/find-pw'/>">PW</a>
          <span class="find-text">찾기</span>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
