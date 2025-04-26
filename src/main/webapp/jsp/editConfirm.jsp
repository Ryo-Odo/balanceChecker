<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
	<!DOCTYPE html>	
	<html class="common_html">
	<head>
		<link rel="stylesheet" href="/balanceChecker/css/common_style.css">
		<script src="https://cdn.jsdelivr.net/npm/vue@3.5.13/dist/vue.global.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/vuetify@3.8.1/dist/vuetify.min.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/vuetify@3.8.1/dist/vuetify.min.js"></script>
		<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
		<link href="https://cdn.jsdelivr.net/npm/@mdi/font@6.x/css/materialdesignicons.min.css" rel="stylesheet">
		<meta charset="UTF-8">
		<title>ログイン画面</title>
	</head>
	<body class="common_body">
		<div id="app">
			<v-app>
				<v-main>
					<v-container class="d-flex align-center justify-center fill-height">
						<v-row justify="center" align="center">
							<v-col md="12">
								<div class="common_div">
	<h1>メンバー情報確認画面</h1>
	<p style="text-align: right">${user.name} 様ログイン中</p>
	<p style="text-align: right"><a href="/balanceChecker/logout">ログアウト</a></p>
	
	<h2>変更内容確認</h2>
	<p>下記内容でよろしければ、変更ボタンを押してください。</p>
	<form action="/balanceChecker/editConfirm" method="post">
		<table border="1">
			<tr>
				<th>お名前</th>
				<td><input type="hidden" name="editName" value="${editName}">${editName}</td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td><input type="hidden" name="editPassword" value="${editPassword}">${editPassword}</td>
				<input type="hidden" name="loginId" value="${user.loginId}" />
			</tr>
		</table>
		<input type="submit" value="変更する">
	</form>
	<p><a href="/balanceChecker/jsp/login.jsp">トップ画面に戻る</a></p>
								</div>
							</v-col>
						</v-row>
					</v-container>
				</v-main>
			</v-app>
		</div>
		<script>
			const { createApp, ref, computed, onMounted, onUnmounted,  watch } = Vue;
			const { createVuetify } = Vuetify;
			createApp({
				setup() {
					
				}
			}).use(createVuetify()).mount('#app');
		</script>
	</body>
	</html>