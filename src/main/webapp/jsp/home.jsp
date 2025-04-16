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
	<jsp:include page="header.jsp" />
<div id="app">
<v-app>
    <v-main>
      <!-- 検索ボタン -->
      <v-btn color="primary" @click="dialog = true">
        検索
      </v-btn>

      <!-- 栄養素別検索ボタン -->
      <v-btn color="secondary" @click="dialogNutrition = true">
        栄養素別検索
      </v-btn>
      
              <!-- 食品検索モーダル -->
      <v-dialog v-model="dialog" max-width="800" hide-overlay>
        <v-card>
          <v-card-title class="text-h6">
            食品検索
          </v-card-title>

          <v-card-text>
            <v-text-field
              v-model="searchQuery"
              label="食品名またはその他を検索"
              prepend-inner-icon="mdi-magnify"
              clearable
              @input="onInput"
            ></v-text-field>

            <v-list v-if="paginatedFoods.length">
              <v-list-item
                v-for="food in paginatedFoods"
                :key="food.id"
              >
                <v-list-item-content>
                  <v-list-item-title>{{ food.id }} - {{ food.foodName }}</v-list-item-title>
                  <v-list-item-subtitle>{{ food.other }}</v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-list>

            <div v-else>
              <p>該当する食品が見つかりませんでした。</p>
            </div>

            <!-- ページネーション -->
            <v-pagination
              v-if="filteredFoods.length > itemsPerPage"
              v-model="currentPage"
              :length="totalPages"
              :total-visible="7"
              class="mt-4"
            ></v-pagination>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn text @click="dialog = false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>











<!-- 栄養素別検索モーダル -->
      <v-dialog v-model="dialogNutrition" max-width="800" hide-overlay>
        <v-card>
          <v-card-title class="text-h6">
            栄養素別検索
          </v-card-title>

          <v-card-text>
            <!-- 栄養素選択ドロップダウン -->
            <v-select
  			v-model="selectedNutrient"
 			:items="nutrients"
  			label="栄養素を選択"
			></v-select>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn text @click="dialogNutrition = false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-main>
 </v-app>
</div>

<script>
  const { createApp, ref, watch } = Vue;
  const { createVuetify } = Vuetify;

  createApp({
    setup() {
      const dialog = ref(false);
      const dialogNutrition = ref(false);
      const searchQuery = ref('');
      const selectedNutrientInput = ref(''); // 栄養素入力フィールド
      const filteredFoods = ref([]);
      const nutrientFoods = ref([]);
      const paginatedFoods = ref([]);
      const paginatedNutrientFoods = ref([]);
      const itemsPerPage = 20;
      const currentPage = ref(1);
      const currentNutrientPage = ref(1);
      const totalPages = ref(1);
      const totalNutrientPages = ref(1);
      const errorMessage = ref('');

      const selectedNutrient = ref(""); // 文字列（名前）だけを受け取る
      
      const nutrients = ref([
    	  "たんぱく質",
    	  "炭水化物",
    	  "脂質",
    	  "ビタミンA",
    	  "ビタミンC"
    	]);

      // 食品検索処理
      const onInput = () => {
        if (searchQuery.value.trim().length === 0) {
          filteredFoods.value = [];
          return;
        }

        axios.post('/balanceChecker/api/foodSearch', { keyword: searchQuery.value })
          .then(response => {
            filteredFoods.value = response.data;
            totalPages.value = Math.ceil(filteredFoods.value.length / itemsPerPage);
            paginateFoods();
          })
          .catch(error => {
            errorMessage.value = '検索エラーが発生しました。';
            console.error('検索エラー:', error);
          });
      };

      // 栄養素別検索処理
      const onNutritionInput = () => {
        if (!selectedNutrientInput.value.trim()) {
          nutrientFoods.value = [];
          return;
        }

        axios.post('/balanceChecker/api/nutrientSearch', { nutrient: selectedNutrientInput.value })
          .then(response => {
            nutrientFoods.value = response.data;
            totalNutrientPages.value = Math.ceil(nutrientFoods.value.length / itemsPerPage);
            paginateNutrientFoods();
          })
          .catch(error => {
            errorMessage.value = '栄養素検索エラーが発生しました。';
            console.error('栄養素検索エラー:', error);
          });
      };

      // ページネーション用のフィルタリング
      const paginateFoods = () => {
        const start = (currentPage.value - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        paginatedFoods.value = filteredFoods.value.slice(start, end);
      };

      const paginateNutrientFoods = () => {
        const start = (currentNutrientPage.value - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        paginatedNutrientFoods.value = nutrientFoods.value.slice(start, end);
      };

      return {
        dialog,
        dialogNutrition,
        searchQuery,
        selectedNutrientInput,
        filteredFoods,
        paginatedFoods,
        paginatedNutrientFoods,
        currentPage,
        currentNutrientPage,
        totalPages,
        totalNutrientPages,
        errorMessage,
        onInput,
        onNutritionInput,
        paginateFoods,
        paginateNutrientFoods,
        itemsPerPage,
        selectedNutrient,
        nutrients,
      };
    }
  }).use(Vuetify.createVuetify()).mount('#app');
</script>



</body>
</html>