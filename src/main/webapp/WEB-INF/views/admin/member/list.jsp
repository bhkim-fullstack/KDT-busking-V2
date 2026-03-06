<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>

	<link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/admin.css'/>">
    <style>
    
main {
	flex: 1;
	background-color: #fff;
	padding: 40px;
}

h2 {
	margin-bottom: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

thead {
	background-color: #f3f3f3;
}

th, td {
	padding: 14px;
	border-bottom: 1px solid #ddd;
	text-align: center;
	font-size: 14px;
}

.manage-btns {
	display: flex;
	justify-content: center;
	gap: 8px;
}

.manage-btns a, .manage-btns button {
	border: none;
	padding: 6px 14px;
	border-radius: 6px;
	font-size: 13px;
	cursor: pointer;
	color: white;
	text-decoration: none;
	display: inline-block;
}

.edit-btn {
	background-color: #007bff;
}

.delete-btn {
	background-color: #f44336;
}
    </style>
	</head>

	<body>

	    <!-- 기존 사용자 헤더 그대로 사용 -->
	    <jsp:include page="/WEB-INF/views/common/nav.jsp"/>

	    <!-- 🔥 admin 전용 영역 시작 -->
	    <div class="admin-page">

	        <div class="admin-container">

	            <!-- 사이드 메뉴 -->
	            <aside class="admin-aside">
	                <ul>
	                	<li><a href="<c:url value='/admin/main'/>">대시보드</a></li>
	                    <li><a href="<c:url value='/admin/board/list'/>">게시판 관리</a></li>
	                    <li><a href="<c:url value='/admin/board/qna_list'/>">Q&A 관리</a></li>
	                    <li><a href="<c:url value='/admin/gear/list'/>">장비 예약 관리</a></li>
	                    <li><a href="<c:url value='/admin/locale/list'/>">장소 예약 관리</a></li>
						<li><a href="<c:url value='/admin/gear/update_list'/>">장비 관리</a></li>
						<li><a href="<c:url value='/admin/locale/update_list'/>">장소 관리</a></li>
						<li><a href="<c:url value='/admin/member/list'/>">회원 관리</a></li>
	                </ul>
	            </aside>   

		<main>
			<h2>회원 관리</h2>

			<table>
				<thead>
					<tr>
						<th>번호(ID)</th>
						<th>아이디</th>
						<th>이름</th>
						<th>가입일</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="m" items="${memberList}">
						<tr>
							<td>${m.id}</td>
							<td>${m.memberId}</td>
							<td>${m.name}</td>
							<td>
								<c:out value="${m.createdMemberAt.toString().substring(0,4)}년 
${m.createdMemberAt.toString().substring(5,7)}월 
${m.createdMemberAt.toString().substring(8,10)}일 
${m.createdMemberAt.toString().substring(11,16)}" />

							</td>
							<td class="manage-btns"><a class="edit-btn"
								href="<c:url value='/admin/member/${m.id}/edit'/>">수정</a>

								<form method="post"
									action="<c:url value='/admin/member/${m.id}/delete'/>"
									onsubmit="return confirm('정말 삭제할까요?');"
									style="display: inline;">
									<button class="delete-btn" type="submit">삭제</button>
								</form></td>
						</tr>
					</c:forEach>

					<c:if test="${empty memberList}">
						<tr>
							<td colspan="4" style="padding: 30px; color: #777;">회원이
								없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</main>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
