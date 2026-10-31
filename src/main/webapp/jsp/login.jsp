<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
	<!DOCTYPE html>	
	<html class="common_html">
	<head>
		<link rel="stylesheet" href="/balanceChecker/css/common_style.css?v=2">
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
	<h1>ログイン画面</h1>
	
	
	<c:if test = "${loginError != null }" >
		<div style="color:red;">
			<p>${loginError }</p>
		</div>
	</c:if>
	
	<form action="/balanceChecker/login" method="post" class="login-form">
		<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
		<table class="login-table">
			<tr>
				<th><label for="loginId">ユーザーID</label></th>
				<td><input id="loginId" class="login-input" type="text" name="loginId" autocomplete="username" placeholder="ユーザーIDを入力"></td>
			</tr>
			<tr>
				<th><label for="password">パスワード</label></th>
				<td><input id="password" class="login-input" type="password" name="password" autocomplete="current-password" placeholder="パスワードを入力"></td>
			</tr>
		</table>
		<input type="submit" value="ログイン" class="login-button">
	</form>
	<form action="/balanceChecker/guest-login" method="post" class="guest-login-form">
		<input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
		<input type="submit" value="ゲストとして試す" class="guest-login-button">
	</form>
	<p>登録なしですぐに主要機能をお試しいただけます。</p>
	<p><a href="/balanceChecker/register">新規会員登録はこちら</a></p>
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
