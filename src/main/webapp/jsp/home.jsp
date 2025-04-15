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
    <v-main>
      <v-text-field
        v-model="searchQuery"
        label="食品名またはその他を検索"
        prepend-inner-icon="mdi-magnify"
        clearable
        @input="onInput"
      ></v-text-field>

      <v-list v-if="filteredFoods.length">
        <v-list-item
          v-for="food in filteredFoods"
          :key="food.id"
        >
          <v-list-item-content>
            <v-list-item-title>
              {{ food.id }} - {{ food.foodName }}
            </v-list-item-title>
            <v-list-item-subtitle>
              {{ food.other }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>

      <div v-else>
        <p>該当する食品が見つかりませんでした。</p>
      </div>
    </v-main>
  </v-app>
</div>



  
  
  
  
  
  
  
  
  
  
  
  
  
  
<script>
  const { createApp, ref } = Vue;
  const { createVuetify } = Vuetify; // ← Vuetifyを取り出す

  createApp({
    setup() {
      const searchQuery = ref('');
      const filteredFoods = ref([]);

      const onInput = () => {
        if (searchQuery.value.trim().length === 0) {
          filteredFoods.value = [];
          return;
        }

        axios.post('/balanceChecker/api/foodSearch', { keyword: searchQuery.value })
          .then(response => {
            console.log('検索語:', searchQuery.value);
            console.log('受信データ:', response.data);
            filteredFoods.value = response.data;
          })
          .catch(error => {
            console.error('検索エラー:', error);
          });
      };

      return {
        searchQuery,
        filteredFoods,
        onInput
      };
    }
  }).use(Vuetify.createVuetify()).mount('#app') 
</script>


</body>
</html>