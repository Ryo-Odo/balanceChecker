<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
</head>
<body>
	<h1>ログイン画面</h1>
	<c:if test = "${loginError != null }" >
		<div style=""color:red;">
			<p>${loginError }</p>
		</div>
	</c:if>
	
	<form action="/balanceChecker/login" method="post">
		<table>
			<tr>
				<th>ユーザーID</th>
				<td><input type="text" name="loginId"></td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td><input type="password" name="password"></td>
			</tr>
		</table>
		<input type="submit" value="ログイン">
	</form>
	<p><a href="/balanceChecker/register">新規会員登録はこちら</a></p>
	</form>

</body>
</html>