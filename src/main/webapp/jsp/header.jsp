<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<v-container>
    <v-row>
        <v-col cols="8">balanceChecker</v-col>
        <v-col class="text-right" cols="1">${user.name }様ログイン中</v-col>
        <v-col class="text-right" cols="1">ログアウト</v-col>
        <v-col class="text-right" cols="1"><a href="/balanceChecker/edit">メンバー情報編集</a></v-col>
        <v-col class="text-right" cols="1"><a href="/balanceChecker/delete">退会</a></v-col>
    </v-row>
</v-container>
</header>