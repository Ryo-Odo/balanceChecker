<!-- header.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<v-app-bar app :height="30">
  <v-container>
    <v-row align="center">
      <v-col cols="6">
        <v-toolbar-title>balanceChecker</v-toolbar-title>
      </v-col>
      <v-col class="text-right" cols="6">
        ${user.name} 様ログイン中 |
        <a href="/balanceChecker/edit" class="text-white">メンバー情報編集</a> |
        <a href="/balanceChecker/delete" class="text-white">退会</a> |
        <a href="/balanceChecker/logout" class="text-white">ログアウト</a>
      </v-col>
    </v-row>
  </v-container>
</v-app-bar>
