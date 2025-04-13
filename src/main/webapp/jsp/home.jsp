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
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@mdi/font@6.x/css/materialdesignicons.min.css" rel="stylesheet">
<!-- フォントとアイコン -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<!-- Axios CDN -->
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






    <div id="app">
        <v-app>
            <v-main class="pa-4">
                <h2>食品リスト</h2>
                <v-data-table
                    :headers="headers"
                    :items="foods"
                    class="elevation-1"
                    item-value="food_name"
                >
                    <template v-slot:[`item.foodName`]="{ item }">
                        <td>{{ item.foodName }}</td> <!-- 食品名 -->
                    </template>
                    <template v-slot:[`item.energy`]="{ item }">
                        <td>{{ item.energy }} kcal</td> <!-- エネルギー -->
                    </template>
                </v-data-table>
            </v-main>
        </v-app>
    </div>

    <script>
        const { createApp } = Vue;

        createApp({
            data() {
                return {
                    foods: [],
                    headers: [
                        { text: '食品名', value: 'foodName' },
                        { text: 'エネルギー(kcal)', value: 'energy' }
                    ]
                };
            },
            mounted() {
                axios.get('/balanceChecker/api/foods')
                    .then(response => {
                        this.foods = response.data;  // レスポンスデータを格納
                    })
                    .catch(error => {
                        console.error('食品データの取得に失敗しました', error);
                    });
            }
        }).use(Vuetify.createVuetify()).mount('#app');
    </script>
</body>
</html>