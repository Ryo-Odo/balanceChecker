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
<script src="https://cdn.jsdelivr.net/npm/fuse.js/dist/fuse.min.js"></script>
<!-- Fuse.js 検索機能ライブラリ -->
<meta charset="UTF-8">
<title>ホーム画面</title>
</head>
<body>
	<jsp:include page="header.jsp" />
  <div id="app">
    <v-app>
      <v-container>
        <v-text-field
          v-model="searchQuery"
          label="食品名またはその他を検索"
          prepend-inner-icon="mdi-magnify"
          clearable
        ></v-text-field>

        <v-list v-if="filteredFoods.length">
          <v-list-item
            v-for="food in filteredFoods"
            :key="food.id"
          >
            <v-list-item-content>
              <v-list-item-title>{{ food.foodName }}</v-list-item-title>
              <v-list-item-subtitle>{{ food.other }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <div v-else>
          <p>該当する食品が見つかりませんでした。</p>
        </div>
      </v-container>
    </v-app>
  </div>

  <script>
    const { createApp, ref, watch, onMounted } = Vue;

    createApp({
      setup() {
        const searchQuery = ref('');
        const foods = ref([]);
        const filteredFoods = ref([]);
        let fuse = null;

        // データ取得とFuse初期化
        onMounted(async () => {
          const response = await axios.get('/balanceChecker/api/foods');
          foods.value = response.data;

          fuse = new Fuse(foods.value, {
            keys: ['foodName', 'other'],
            threshold: 0.3,
            includeScore: true
          });

          filteredFoods.value = foods.value; // 初期表示
        });

        // 検索語句の変更をリアルタイムで監視
        watch(searchQuery, (query) => {
          if (!fuse || query.trim() === '') {
            filteredFoods.value = foods.value;
          } else {
            const results = fuse.search(query);
            filteredFoods.value = results.map(result => result.item);
          }
        });

        return {
          searchQuery,
          filteredFoods
        };
      }
    }).use(Vuetify.createVuetify()).mount('#app');
  </script>
	<jsp:include page="mainApp.jsp" />	
</body>
</html>