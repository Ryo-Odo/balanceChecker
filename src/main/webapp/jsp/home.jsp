<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/vue@3.5.13/dist/vue.global.js"></script>
<!-- Vue3 CDN -->
<link href="https://cdn.jsdelivr.net/npm/vuetify@3.8.1/dist/vuetify.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/vuetify@3.8.1/dist/vuetify.min.js"></script>
<!-- Vuetify3 CDN -->

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

	<div id="app"></div>
	<script src="js/app.js"></script>



</body>
</html>