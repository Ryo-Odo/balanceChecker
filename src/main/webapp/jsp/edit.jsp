<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員情報編集画面</title>
</head>
<body>
	<h1>メンバー情報編集画面</h1>
	<p style="text-align: right">${user.name} 様ログイン中</p>
	<p style="text-align: right"><a href="/balanceChecker/logout">ログアウト</a></p>
	
	<c:if test="${errorMsg.size() > 0}">
		<ul>
			<c:forEach var="msg" items="${errorMsg}">
				<li style="color:red;">${msg}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<c:if test="${editError != null}">
		<div style="color:red;">
			<p>${editError}</p>
		</div>
	</c:if>
	
	<h2>変更内容入力</h2>
	<form action="/balanceChecker/edit" method="post">
		<table border="1">
			<tr>
				<th>お名前</th>
				<td><input type="text" name="editName" placeholder="1～10文字"></td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td><input type="text" name="editPassword" placeholder="2～10文字"></td>
				<input type="hidden" name="loginId" value="${user.loginId}" />
			</tr>
		</table>
		<input type="submit" value="変更する（確認画面へ）">
	</form>
	<p><a href="/balanceChecker/jsp/login.jsp">トップ画面に戻る</a></p>

</body>
</html>