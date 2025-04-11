<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新規登録</title>
<link rel="stylesheet" type="text/css" href="/balanceChecker/css/stylesheet.css" />
</head>
<body>
	<h1>新規会員登録</h1>
	
	<c:if test="${errorMsg.size() > 0 }">
		<ul>
			<c:forEach var="msg" items="${errorMsg}">
				<li style="color:red;">${msg}</li>
			</c:forEach>		
		</ul>
	</c:if>
	<c:if test="${regsterError != null}">
		<div style="color:red">
			<p>${registerError}</p>
		</div>
	</c:if>
	
	<h2>会員登録フォーム</h2>
		<p>下記フォームより、ユーザー情報をご登録ください</p>
	<form action="/balanceChecker/register" method="post">
		<table border="1">
			<tr>
				<th>ユーザーID</th>
				<td><input type="text" name="loginId" placeholder="1～8文字"></td>
			</tr>
			
			<tr>
				<th>パスワード</th>
				<td><input type="text" name="password" placeholder="2～10文字"></td>
			</tr>
			
			<tr>
				<th>お名前</th>
				<td><input type="text" name="name" placeholder="1～10文字"></td>
			</tr>
		</table>
		<input type="submit" value="登録">
	</form>
	<p><a href="/balanceChecker/login">ログイン画面に戻る</a></p>
</body>
</html>