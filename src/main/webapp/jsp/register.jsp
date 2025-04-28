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