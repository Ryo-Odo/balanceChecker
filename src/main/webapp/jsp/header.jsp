<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<p>balanceChecker</p>
	<p style="text-align: right">${user.name }様ログイン中</p>
	<p style="text-align: right">
		<a href="/balanceChecker/logout">ログアウト</a>
	</p>
	<p>
		<a href="/balanceChecker/edit">メンバー情報編集</a>
	</p>
	<p>
		<a href="/balanceChecker/delete">退会</a>
	</p>
</div>