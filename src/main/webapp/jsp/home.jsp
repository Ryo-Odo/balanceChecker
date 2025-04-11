<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ホーム画面</title>
</head>
<body>
	<h1>ホーム画面</h1>
	<p style="text-align: right">${user.name }様ログイン中</p>
	<p style="text-align: right">
		<a href="/balanceChecker/logout">ログアウト</a>
	</p>
	<h2>エヌ・ミニアプリ</h2>
	<p>
		<a href="/balanceChecker/edit">メンバー情報の編集</a>
	</p>
	<p>
		<a href="/balanceChecker/delete">退会する方はこちら</a>
	</p>
</body>
</html>