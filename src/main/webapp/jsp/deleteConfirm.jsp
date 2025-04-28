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
	<h1>会員情報削除確認画面</h1>
	<p>下記内容でよろしければ、退会ボタンを押してください</p>
	
	<c:if test="${not empty deleteError}">
		<div style="color:red;">
			<p>${deleteError}</p>
		</div>
	</c:if>
	
	<h2>会員情報</h2>
	<form action="/balanceChecker/delete" method="post">
		<table border="1">
			<tr>
				<th>ユーザーID</th>
				<td><input type="hidden" name="deleteLoginId" value="${user.loginId}">${user.loginId}</td>
			</tr>
			<tr>
				<th>お名前</th>
				<td>${user.name}</td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td>${user.password}</td>
			</tr>
		</table>
		<input type="submit" value="退会する">
	</form>
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