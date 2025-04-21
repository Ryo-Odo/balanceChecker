<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
  <script src="https://cdn.jsdelivr.net/npm/vue@3.5.13/dist/vue.global.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/vuetify@3.8.1/dist/vuetify.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/vuetify@3.8.1/dist/vuetify.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/@mdi/font@6.x/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
  <meta charset="UTF-8">
  <title>ホーム画面</title>
</head>
<body>
  <jsp:include page="header.jsp" />
  <div id="app">
    <v-app>
      <v-main>
  
<!----------------------------------------------------------------------------------------------------------------->    

        <!-- 検索ボタン -->
        <v-btn color="primary" @click="dialog = true">検索</v-btn>
        <v-btn color="secondary" @click="dialogNutrition = true">栄養素別検索</v-btn>
<!----------------------------------------------------------------------------------------------------------------->    

        <!-- 食品名検索モーダル -->
        <v-dialog v-model="dialog" max-width="800" hide-overlay>
          <v-card>
            <v-card-title class="text-h6">食品名検索</v-card-title>
            <v-card-text>
              <v-text-field
                v-model="searchQuery"
                label="食品名またはその他を検索"
                prepend-inner-icon="mdi-magnify"
                clearable
                @input="onInput"
              ></v-text-field>

              <v-list v-if="paginatedFoods.length">
                <v-list-item v-for="food in paginatedFoods" :key="food.id">
                  <v-list-item-title>{{ food.id }} - {{ food.foodName }}</v-list-item-title>
                  <v-list-item-subtitle>{{ food.other }}</v-list-item-subtitle>
                  <v-btn color="success" @click="addFoodToSelection(food.id)">追加</v-btn>
                </v-list-item>
              </v-list>
              <div v-else><p>該当する食品が見つかりませんでした。</p></div>

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
<!----------------------------------------------------------------------------------------------------------------->  

        <!-- 栄養素別検索モーダル -->
        <v-dialog v-model="dialogNutrition" max-width="800" hide-overlay persistent>
          <v-card>
            <v-card-title class="text-h6">栄養素別検索</v-card-title>          
              <v-card-text>
              <v-select
                v-model="selectedNutrient"
                :items="nutrients"
                item-value="value"
                label="栄養素を選択"
                @update:model-value="submitForm"
              ></v-select>
              
<v-list v-if="paginatedNutrientFoods.length">
  <v-list-item v-for="food in paginatedNutrientFoods" :key="food.id">
    <v-list-item-title>{{ food.id }} - {{ food.foodName }}</v-list-item-title>
    <v-list-item-subtitle>{{ food[selectedNutrient] }}（{{ getNutrientTitle(selectedNutrient) }}）</v-list-item-subtitle>
    <v-btn color="success" @click="addFoodToSelection(food.id)">追加</v-btn>
  </v-list-item>
</v-list>
<div v-else>
  <p v-if="errorMessage">{{ errorMessage }}</p>
  <p v-else>該当する食品が見つかりませんでした。</p>
</div>
              <v-pagination
                v-if="nutrientFoods.length > itemsPerPage"
                v-model="currentNutrientPage"
                :length="totalNutrientPages"
                :total-visible="7"
                class="mt-4"
              ></v-pagination>          
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn text @click="dialogNutrition = false">閉じる</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
<!----------------------------------------------------------------------------------------------------------------->  
  <div class="box1">
  <h3 class="text-h6">選択中の食品</h3>
  <v-list>
<v-list-item v-for="food in selectedFoods" :key="food.id">
  <v-list-item-title>{{ food.foodName }}</v-list-item-title>
  <v-list-item-subtitle>エネルギー: {{ food.calc_energy }} kcal</v-list-item-subtitle>
  <v-text-field
    v-model="food.weight"
    label="グラム数"
    model-value="100"
    type="number"
    min="1"
    step="1"
    @input="onInputWeight(food)"
  ></v-text-field>
</v-list-item>
  </v-list>
  </div>

  <div class="box1">
    <v-row>
    <!-- 年齢 -->
    <v-col cols="12" sm="6" md="3">
      <v-text-field
        label="年齢"
        v-model="user_age"
        type="number"
        min="0"
        max="120"
        density="compact"
        outlined
        required
      ></v-text-field>
    </v-col>

    <!-- 性別 -->
    <v-col cols="12" sm="6" md="3">
      <v-select
        label="性別"
        v-model="user_gender"
        :items="['男性', '女性']"
        density="compact"
        outlined
        required
      ></v-select>
    </v-col>

    <!-- 身長 -->
    <v-col cols="12" sm="6" md="3">
      <v-text-field
        label="身長 (cm)"
        v-model="user_height"
        type="number"
        min="50"
        max="250"
        density="compact"
        outlined
        required
      ></v-text-field>
    </v-col>

    <!-- 体重 -->
    <v-col cols="12" sm="6" md="3">
      <v-text-field
        label="体重 (kg)"
        v-model="user_weight"
        type="number"
        min="20"
        max="300"
        density="compact"
        outlined
        required
      ></v-text-field>
    </v-col>
    
    <!-- 運動量 -->
    <v-col cols="12" sm="6" md="3">
      <v-select
        label="活動レベル"
        v-model="user_activity_level"
        :items="[
        '低い活動レベル (1.2):ほとんど運動しない、デスクワーク中心の人。',
        '軽い活動レベル (1.375):週1～3回の軽い運動、立ち仕事が多い人。',
        '中程度の活動レベル (1.55):週3～5回の中程度の運動、活動的な仕事の人。',
        '高い活動レベル (1.725):週5～7回のハードな運動、肉体労働が多い人。',
        '非常に高い活動レベル (1.9):毎日のハードな運動と肉体労働、アスリートなど。﻿']"
        density="compact"
        outlined
        required
      ></v-select>
    </v-col>
  </v-row>
  </div>
  

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
        const filteredFoods = ref([]);
        const paginatedFoods = ref([]);
        const itemsPerPage = 20;
        const currentPage = ref(1);
        const totalPages = ref(1);
        const errorMessage = ref('');
        const selectedNutrient = ref('');
        const nutrients = ref([
          { title: 'エネルギー', value: 'energy' },
          { title: 'たんぱく質', value: 'protein' },
          { title: '脂質', value: 'lipid' },
          { title: '炭水化物', value: 'carbohydrate' },
          { title: 'ビタミンA', value: 'vitamin_a' },
          { title: 'ビタミンD', value: 'vitamin_d' },
          { title: 'ビタミンE', value: 'vitamin_e' },
          { title: 'ビタミンK', value: 'vitamin_k' },
          { title: 'ビタミンB1', value: 'vitamin_b1' },
          { title: 'ビタミンB2', value: 'vitamin_b2' },
          { title: 'ナイアシン', value: 'niacin' },
          { title: 'ビタミンB6', value: 'vitamin_b6' },
          { title: 'ビタミンB12', value: 'vitamin_b12' },
          { title: '葉酸', value: 'folic_acid' },
          { title: 'パントテン酸', value: 'pantothenic_acid' },
          { title: 'ビオチン', value: 'biotin' },
          { title: 'ビタミンＣ', value: 'vitamin_c' },
          { title: '食物繊維', value: 'food_fiber' },
          { title: 'ナトリウム', value: 'natrium' },
          { title: 'カリウム', value: 'potassium' },
          { title: 'カルシウム', value: 'calcium' },
          { title: 'マグネシウム', value: 'magnesium' },
          { title: 'リン', value: 'phosphorus' },
          { title: '鉄', value: 'iron' },
          { title: '亜鉛', value: 'zinc' },
          { title: '銅', value: 'copper' },
          { title: 'マンガン', value: 'manganese' },
          { title: 'ヨウ素', value: 'iodine' },
          { title: 'セレン', value: 'selenium' },
          { title: 'クロム', value: 'chrome' },
          { title: 'モリブデン', value: 'molybdenum' },
          { title: '食塩相当量', value: 'sodium_content' }
        ]);
        const nutrientFoods = ref([]);
        const paginatedNutrientFoods = ref([]);
        const currentNutrientPage = ref(1);
        const totalNutrientPages = ref(1);
        const selectedFoods = ref([]); // 選択済み食品を保持する配列を定義
        const user_age =  ref(30);            // 初期年齢
        const user_gender =  ref('女性');     // 初期性別
        const user_height = ref(158);        // 初期身長(cm)
        const user_weight = ref(54);          // 初期体重(kg)
        const user_activity_level = ref('軽い活動レベル (1.375):週1～3回の軽い運動、立ち仕事が多い人。')



        const onInput = () => {
          if (searchQuery.value.trim().length === 0) {
            filteredFoods.value = [];
            return;
          }

          axios.post('/balanceChecker/api/foodSearch', { keyword: searchQuery.value })
            .then(response => {
              filteredFoods.value = response.data;
              totalPages.value = Math.ceil(filteredFoods.value.length / itemsPerPage);
              currentPage.value = 1;
              paginateFoods();
            })
            .catch(error => {
              errorMessage.value = '検索エラーが発生しました。';
              console.error('検索エラー:', error);
            });
        };

        const submitForm = async () => {
        	  try {
        	    errorMessage.value = '';
        	    nutrientFoods.value = []; // 前回の結果をリセット
        	    paginatedNutrientFoods.value = [];

        	    const response = await axios.post('/balanceChecker/api/nutrientSearch', {
        	      nutrient: selectedNutrient.value
        	    });

        	    if (Array.isArray(response.data) && response.data.length > 0) {
        	      nutrientFoods.value = response.data;
        	      totalNutrientPages.value = Math.ceil(nutrientFoods.value.length / itemsPerPage);
        	      currentNutrientPage.value = 1;
        	      paginateNutrientFoods();
        	    } else {
        	      errorMessage.value = "該当する食品が見つかりませんでした。";
        	    }
        	  } catch (error) {
        	    console.error('送信失敗:', error);
        	    errorMessage.value = "検索エラーが発生しました。";
        	  }
        	};


        	const addFoodToSelection = (food_Id) => {
        		  if (selectedFoods.value.some(food => food.id === food_Id)) {
        			    return; // すでに追加済みなら何もしない
        			  }

    			  
        		  // 選択した食品IDをサーバーに送信する
        		  axios.post('/balanceChecker/api/addFoodToSelection', {
        		    food_id: food_Id // food_id をリクエストボディに含める
        		  })
        		  .then(response => {
        	          const addedFood = response.data;
        	          addedFood.weight = 100;//ユーザーが変更できる重さ、計算に使う
        	          
        	          addedFood.calc_energy = addedFood.energy;
        	          addedFood.calc_protein = addedFood.protein;
        	          addedFood.calc_energy = addedFood.energy; 
        	          addedFood.calc_protein = addedFood.protein;
        	          addedFood.calc_lipid = addedFood.lipid;
        	          addedFood.calc_food_fiber = addedFood.food_fiber;
        	          addedFood.calc_carbohydrate = addedFood.carbohydrate;
        	          addedFood.calc_natrium = addedFood.natrium;
        	          addedFood.calc_potassium = addedFood.potassium;
        	          addedFood.calc_calcium = addedFood.calcium;
        	          addedFood.calc_magnesium = addedFood.magnesium;
        	          addedFood.calc_phosphorus = addedFood.phosphorus;
        	          addedFood.calc_iron = addedFood.iron;
        	          addedFood.calc_zinc = addedFood.zinc;
        	          addedFood.calc_copper = addedFood.copper;
        	          addedFood.calc_manganese = addedFood.manganese;
        	          addedFood.calc_iodine = addedFood.iodine;
        	          addedFood.calc_selenium = addedFood.selenium;
        	          addedFood.calc_chrome = addedFood.chrome;
        	          addedFood.calc_molybdenum = addedFood.molybdenum;
        	          addedFood.calc_vitamin_a = addedFood.vitamin_a;
        	          addedFood.calc_vitamin_d = addedFood.vitamin_d;
        	          addedFood.calc_vitamin_e = addedFood.vitamin_e;
        	          addedFood.calc_vitamin_k = addedFood.vitamin_k;
        	          addedFood.calc_vitamin_b1 = addedFood.vitamin_b1;
        	          addedFood.calc_vitamin_b2 = addedFood.vitamin_b2;
        	          addedFood.calc_niacin = addedFood.niacin;
        	          addedFood.calc_vitamin_b6 = addedFood.vitamin_b6;
        	          addedFood.calc_vitamin_b12 = addedFood.vitamin_b12;
        	          addedFood.calc_folic_acid = addedFood.folic_acid;
        	          addedFood.calc_pantothenic_acid = addedFood.pantothenic_acid;
        	          addedFood.calc_biotin = addedFood.biotin;
        	          addedFood.calc_vitamin_c = addedFood.vitamin_c;
        	          addedFood.calc_sodium_content = addedFood.sodium_content;
        	          //グラム数による変化を記録する変数、実際の表示や計算に使用する



        	          
        	          console.log('食品追加成功:', addedFood); // ← ここでJSONか確認
        	          selectedFoods.value.push(addedFood);
        	          console.log('現在の選択中食品:', selectedFoods.value); // ← push後の確認
        		  })
        		  .catch(error => {
        		    console.log('食品追加エラー:', error);
        		  });
        		};

        		const onInputWeight = (food) => {
        			  // グラム数が入力されたら、その値に基づいて栄養を再計算
        			  food.calc_energy = Number.parseFloat(((food.weight / 100) * food.energy).toPrecision(12));
        			  food.calc_energy = Number.parseFloat(((food.weight / 100) * food.energy).toPrecision(12));
        			  food.calc_protein = Number.parseFloat(((food.weight / 100) * food.protein).toPrecision(12));
        			  food.calc_lipid = Number.parseFloat(((food.weight / 100) * food.lipid).toPrecision(12));
        			  food.calc_food_fiber = Number.parseFloat(((food.weight / 100) * food.food_fiber).toPrecision(12));
        			  food.calc_carbohydrate = Number.parseFloat(((food.weight / 100) * food.carbohydrate).toPrecision(12));
        			  food.calc_natrium = Number.parseFloat(((food.weight / 100) * food.natrium).toPrecision(12));
        			  food.calc_potassium = Number.parseFloat(((food.weight / 100) * food.potassium).toPrecision(12));
        			  food.calc_calcium = Number.parseFloat(((food.weight / 100) * food.calcium).toPrecision(12));
        			  food.calc_magnesium = Number.parseFloat(((food.weight / 100) * food.magnesium).toPrecision(12));
        			  food.calc_phosphorus = Number.parseFloat(((food.weight / 100) * food.phosphorus).toPrecision(12));
        			  food.calc_iron = Number.parseFloat(((food.weight / 100) * food.iron).toPrecision(12));
        			  food.calc_zinc = Number.parseFloat(((food.weight / 100) * food.zinc).toPrecision(12));
        			  food.calc_copper = Number.parseFloat(((food.weight / 100) * food.copper).toPrecision(12));
        			  food.calc_manganese = Number.parseFloat(((food.weight / 100) * food.manganese).toPrecision(12));
        			  food.calc_iodine = Number.parseFloat(((food.weight / 100) * food.iodine).toPrecision(12));
        			  food.calc_selenium = Number.parseFloat(((food.weight / 100) * food.selenium).toPrecision(12));
        			  food.calc_chrome = Number.parseFloat(((food.weight / 100) * food.chrome).toPrecision(12));
        			  food.calc_molybdenum = Number.parseFloat(((food.weight / 100) * food.molybdenum).toPrecision(12));
        			  food.calc_vitamin_a = Number.parseFloat(((food.weight / 100) * food.vitamin_a).toPrecision(12));
        			  food.calc_vitamin_d = Number.parseFloat(((food.weight / 100) * food.vitamin_d).toPrecision(12));
        			  food.calc_vitamin_e = Number.parseFloat(((food.weight / 100) * food.vitamin_e).toPrecision(12));
        			  food.calc_vitamin_k = Number.parseFloat(((food.weight / 100) * food.vitamin_k).toPrecision(12));
        			  food.calc_vitamin_b1 = Number.parseFloat(((food.weight / 100) * food.vitamin_b1).toPrecision(12));
        			  food.calc_vitamin_b2 = Number.parseFloat(((food.weight / 100) * food.vitamin_b2).toPrecision(12));
        			  food.calc_niacin = Number.parseFloat(((food.weight / 100) * food.niacin).toPrecision(12));
        			  food.calc_vitamin_b6 = Number.parseFloat(((food.weight / 100) * food.vitamin_b6).toPrecision(12));
        			  food.calc_vitamin_b12 = Number.parseFloat(((food.weight / 100) * food.vitamin_b12).toPrecision(12));
        			  food.calc_folic_acid = Number.parseFloat(((food.weight / 100) * food.folic_acid).toPrecision(12));
        			  food.calc_pantothenic_acid = Number.parseFloat(((food.weight / 100) * food.pantothenic_acid).toPrecision(12));
        			  food.calc_biotin = Number.parseFloat(((food.weight / 100) * food.biotin).toPrecision(12));
        			  food.calc_vitamin_c = Number.parseFloat(((food.weight / 100) * food.vitamin_c).toPrecision(12));
        			  food.calc_sodium_content = Number.parseFloat(((food.weight / 100) * food.sodium_content).toPrecision(12));
        			  //元データから、入力されたグラム数に応じて計算に使う変数を変更。丸目誤差切り捨て済み     			  
        			  
        			  console.log('グラム変更後:', food);
        			};
        			        






        	
        const paginateFoods = () => {
          const start = (currentPage.value - 1) * itemsPerPage;
          const end = start + itemsPerPage;
          console.log('ページネーション前:', filteredFoods.value);  // ここで確認
          paginatedFoods.value = filteredFoods.value.slice(start, end);
          console.log('ページネーション後:', paginatedFoods.value);  // ここで確認
          
        };

        


        const paginateNutrientFoods = () => {
        	  const start = (currentNutrientPage.value - 1) * itemsPerPage;
        	  const end = start + itemsPerPage;
        	  console.log('ページネーション前:', nutrientFoods.value);  // ここで確認
        	  paginatedNutrientFoods.value = nutrientFoods.value.slice(start, end);
        	  console.log('ページネーション後:', paginatedNutrientFoods.value);  // ここで確認
        	};


        	
        const getNutrientTitle = (value) => {
          const nutrient = nutrients.value.find(n => n.value === value);
          return nutrient ? nutrient.title : value;
        };

        watch(currentPage, paginateFoods);
        watch(currentNutrientPage, paginateNutrientFoods);
        watch(selectedNutrient, () => {
        	  if (selectedNutrient.value) {
        	    submitForm();
        	  }
        	});
        	        

        return {
          dialog,
          dialogNutrition,
          searchQuery,
          filteredFoods,
          paginatedFoods,
          currentPage,
          totalPages,
          errorMessage,
          onInput,
          paginateFoods,
          itemsPerPage,
          selectedNutrient,
          nutrients,
          submitForm,
          nutrientFoods,
          paginatedNutrientFoods,
          currentNutrientPage,
          totalNutrientPages,
          paginateNutrientFoods,
          getNutrientTitle,
          addFoodToSelection,
          selectedFoods,
          updateCalories,
          user_age,   
          user_gender,     
          user_height,      
          user_weight,    
          user_activity_level,
        };
      }
    }).use(createVuetify()).mount('#app');
  </script>
</body>
</html>
