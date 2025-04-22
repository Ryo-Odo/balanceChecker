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
                    <v-container style="max-width: 1480px; margin: 0 auto;" class="box1">
                        <v-row>
                            <v-col cols="12" sm="6">
                                <v-container class="box1">
                                    <v-container class="box1">
                                    <div class="box1">
                                        <p>tdeeの値{{tdee}}</p>
                                        <p>たんぱく質（下限）: {{ protein_low_standard }}</p>
										<p>たんぱく質（上限）: {{ protein_high_standard }}</p>
										<p>脂質（下限）: {{ lipid_low_standard }}</p>
										<p>脂質（上限）: {{ lipid_high_standard }}</p>
										<p>炭水化物（下限）: {{ carbohydrate_low_standard }}</p>
										<p>炭水化物（上限）: {{ carbohydrate_high_standard }}</p>
										<p>食物繊維: {{ fiber_standard }}</p>
										
										<p>ビタミンA: {{ vitamin_a_standard }}</p>
										<p>ビタミンA 上限: {{ vitamin_a_upper_limit }}</p>
										<p>ビタミンD: {{ vitamin_d_standard }}</p>
										<p>ビタミンD 上限: {{ vitamin_d_upper_limit }}</p>
										<p>ビタミンE: {{ vitamin_e_standard }}</p>
										<p>ビタミンE 上限: {{ vitamin_e_upper_limit }}</p>
										<p>ビタミンK: {{ vitamin_k_standard }}</p>
										<p>ビタミンB1: {{ vitamin_b1_standard }}</p>
										<p>ビタミンB2: {{ vitamin_b2_standard }}</p>
										<p>ナイアシン: {{ niacin_standard }}</p>
										<p>ナイアシン 上限: {{ niacin_upper_limit }}</p>
										<p>ビタミンB6: {{ vitamin_b6_standard }}</p>
										<p>ビタミンB6 上限: {{ vitamin_b6_upper_limit }}</p>
										<p>ビタミンB12: {{ vitamin_b12_standard }}</p>
										<p>葉酸: {{ folic_acid_standard }}</p>
										<p>葉酸 上限: {{ folic_acid_upper_limit }}</p>
										<p>パントテン酸: {{ pantothenic_acid_standard }}</p>
										<p>ビオチン: {{ biotin_standard }}</p>
										<p>ビタミンC: {{ vitamin_c_standard }}</p>
										
										<p>食塩相当量（基準）: {{ sodium_content_standard }}</p>
										<p>ナトリウム（換算値）: {{ natrium_standard }}</p>
										<p>カリウム: {{ potassium_standard }}</p>
										<p>カルシウム: {{ calcium_standard }}</p>
										<p>カルシウム 上限: {{ calcium_upper_limit }}</p>
										<p>マグネシウム: {{ magnesium_standard }}</p>
										<p>リン: {{ phosphorus_standard }}</p>
										<p>リン 上限: {{ phosphorus_upper_limit }}</p>
										<p>鉄: {{ iron_standard }}</p>
										<p>亜鉛: {{ zinc_standard }}</p>
										<p>亜鉛 上限: {{ zinc_upper_limit }}</p>
										<p>銅: {{ copper_standard }}</p>
										<p>銅 上限: {{ copper_upper_limit }}</p>
										<p>マンガン: {{ manganese_standard }}</p>
										<p>マンガン 上限: {{ manganese_upper_limit }}</p>
										<p>ヨウ素: {{ iodine_standard }}</p>
										<p>ヨウ素 上限: {{ iodine_upper_limit }}</p>
										<p>セレン: {{ selenium_standard }}</p>
										<p>セレン 上限: {{ selenium_upper_limit }}</p>
										<p>クロム: {{ chrome_standard }}</p>
										<p>クロム 上限: {{ chrome_upper_limit }}</p>
										<p>モリブデン: {{ molybdenum_standard }}</p>
										<p>モリブデン 上限: {{ molybdenum_upper_limit }}</p>
										                                        
                                    </div>
                                        <!----------------------------------------------------------------------------------------------------------------->
                                        <!-- 検索ボタン -->
                                        <v-btn color="primary" @click="dialog = true">検索</v-btn>
                                        <v-btn color="secondary" @click="dialogNutrition = true">栄養素別検索</v-btn>
                                        <!----------------------------------------------------------------------------------------------------------------->
                                    </v-container>
                                    <v-container class="box1">
                                        <v-progress-linear
                                            :model-value="Math.min(100, Math.round((total_energy || 0) / recommended * 100))"
                                            height="20"
                                            color="green"
                                            rounded
                                            striped
                                        ></v-progress-linear>
                                    </v-container>
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
                                                        <v-list-item-subtitle>{{ food[selectedNutrient] }}（{{ getNutrientTitle(selectedNutrient) }}</v-list-item-subtitle>
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
                                </v-container>
                            </v-col>
                            <v-col cols="12" sm="6">
                                <v-container class="box1">
                                    <!----------------------------------------------------------------------------------------------------------------->
                                    <div class="box1">
                                        <v-row>
                                            <!-- 年齢 -->
                                            <v-col cols="12" sm="6" md="6">
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
                                                <!-- 性別 -->
                                                <v-select
                                                    label="性別"
                                                    v-model="user_gender"
                                                    :items="['男性', '女性']"
                                                    density="compact"
                                                    outlined
                                                    required
                                                ></v-select>
                                                <!-- 身長 -->
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
                                                <!-- 体重 -->
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
                                                <!-- 運動量 -->
                                                <v-select
                                                    label="活動レベル"
                                                    v-model="user_activity_level"
                                                    :items="[
                                                        { title: '低い活動レベル (1.2):ほとんど運動しない、デスクワーク中心の人。', value: 1.2 },
                                                        { title: '軽い活動レベル (1.375):週1～3回の軽い運動、立ち仕事が多い人。', value: 1.375 },
                                                        { title: '中程度の活動レベル (1.55):週3～5回の中程度の運動、活動的な仕事の人。', value: 1.55 },
                                                        { title: '高い活動レベル (1.725):週5～7回のハードな運動、肉体労働が多い人。', value: 1.725 },
                                                        { title: '非常に高い活動レベル (1.9):毎日のハードな運動と肉体労働、アスリートなど。', value: 1.9 }
                                                    ]"
                                                    item-title="title"
                                                    item-value="value"
                                                    density="compact"
                                                    outlined
                                                    required
                                                ></v-select>
                                            </v-col>
                                        </v-row>
                                     <div class="box1">
                                        <p>想定総消費カロリー：{{ tdee.toFixed(1) }} kcal</p>
                                    </div>
                                    </div>
                                    <!----------------------------------------------------------------------------------------------------------------->
                                    <div class="box1">
                                        <div class="box1">
                                            <p>合計カロリー：{{ total_energy.toFixed(1) }} kcal</p>
                                        </div>
                                        <h3 class="text-h6">選択中の食品</h3>
                                        <p>食品数: {{selectedFoods.length}}</p>
                                        <v-list>
                                            <v-list-item v-for="food in selectedFoods" :key="food.id">
                                                <v-list-item-title>{{ food.foodName }}</v-list-item-title>
                                                <v-list-item-subtitle>エネルギー: {{ food.calc_energy }} kcal</v-list-item-subtitle>
                                                <v-text-field
                                                    v-model="food.weight"
                                                    label="グラム数"
                                                    type="number"
                                                    min="1"
                                                    step="1"
                                                    @input="onInputWeight(food)"
                                                ></v-text-field>
                                            </v-list-item>
                                        </v-list>
                                    </div>
                                    <!----------------------------------------------------------------------------------------------------------------->  
                                </v-container>
                            </v-col>
                        </v-row>
                    </v-container>
                </v-main>
            </v-app>
        </div>
        <script>
    const { createApp, ref, computed, watch } = Vue;
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
        const user_activity_level = ref(1.375);//初期活動レベルの値

        //基礎代謝計算
        const bmr = computed(() => {

          if (user_gender.value === '男性') {
            /* ハリスベネディクト
            return 13.397 * user_weight.value + 4.799 * user_height.value - 5.677 * user_age.value + 88.362; 
            */
            return 10 * user_weight.value + 6.25 * user_height.value - 5 * user_age.value + 5;
          } else {
            /* ハリスベネディクト
            return 9.247 * user_weight.value + 3.098 * user_height.value - 4.33 * user_age.value + 447.593; 
            */
            return 10 * user_weight.value + 6.25 * user_height.value - 5 * user_age.value - 161
            
          }
        });

        // TDEEの計算（基礎代謝 × 活動レベル）
        const tdee = computed(() => {
          return bmr.value * user_activity_level.value;
        });
                
        


        //合計栄養素変数
		const total_protein = ref(0);
		const total_energy = ref(0);
		const total_lipid = ref(0);
		const total_food_fiber = ref(0);
		const total_carbohydrate = ref(0);
		const total_natrium = ref(0);
		const total_potassium = ref(0);
		const total_calcium = ref(0);
		const total_magnesium = ref(0);
		const total_phosphorus = ref(0);
		const total_iron = ref(0);
		const total_zinc = ref(0);
		const total_copper = ref(0);
		const total_manganese = ref(0);
		const total_iodine = ref(0);
		const total_selenium = ref(0);
		const total_chrome = ref(0);
		const total_molybdenum = ref(0);
		const total_vitamin_a = ref(0);
		const total_vitamin_d = ref(0);
		const total_vitamin_e = ref(0);
		const total_vitamin_k = ref(0);
		const total_vitamin_b1 = ref(0);
		const total_vitamin_b2 = ref(0);
		const total_niacin = ref(0);
		const total_vitamin_b6 = ref(0);
		const total_vitamin_b12 = ref(0);
		const total_folic_acid = ref(0);
		const total_pantothenic_acid = ref(0);
		const total_biotin = ref(0);
		const total_vitamin_c = ref(0);
		const total_sodium_content = ref(0);

		const updateNutrition = () => {
			  total_protein.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_protein || 0), 0);
			  total_energy.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_energy || 0), 0);
			  total_lipid.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_lipid || 0), 0);
			  total_food_fiber.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_food_fiber || 0), 0);
			  total_carbohydrate.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_carbohydrate || 0), 0);
			  total_natrium.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_natrium || 0), 0);
			  total_potassium.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_potassium || 0), 0);
			  total_calcium.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_calcium || 0), 0);
			  total_magnesium.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_magnesium || 0), 0);
			  total_phosphorus.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_phosphorus || 0), 0);
			  total_iron.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_iron || 0), 0);
			  total_zinc.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_zinc || 0), 0);
			  total_copper.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_copper || 0), 0);
			  total_manganese.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_manganese || 0), 0);
			  total_iodine.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_iodine || 0), 0);
			  total_selenium.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_selenium || 0), 0);
			  total_chrome.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_chrome || 0), 0);
			  total_molybdenum.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_molybdenum || 0), 0);
			  total_vitamin_a.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_a || 0), 0);
			  total_vitamin_d.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_d || 0), 0);
			  total_vitamin_e.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_e || 0), 0);
			  total_vitamin_k.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_k || 0), 0);
			  total_vitamin_b1.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_b1 || 0), 0);
			  total_vitamin_b2.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_b2 || 0), 0);
			  total_niacin.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_niacin || 0), 0);
			  total_vitamin_b6.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_b6 || 0), 0);
			  total_vitamin_b12.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_b12 || 0), 0);
			  total_folic_acid.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_folic_acid || 0), 0);
			  total_pantothenic_acid.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_pantothenic_acid || 0), 0);
			  total_biotin.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_biotin || 0), 0);
			  total_vitamin_c.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_vitamin_c || 0), 0);
			  total_sodium_content.value = selectedFoods.value.reduce((sum, food) => sum + Number(food?.calc_sodium_content || 0), 0);
			};

		//各栄養素目標値、下限と上限
		//たんぱく質
		const protein_low_standard = computed(() => tdee.value * 0.13 / 4);
		const protein_high_standard = computed(() => tdee.value * 0.20 / 4);
		//脂質
		const lipid_low_standard = computed(() => tdee.value * 0.2 / 9);
		const lipid_high_standard = computed(() => tdee.value * 0.3 / 9);
		//炭水化物
		const carbohydrate_low_standard = computed(() => tdee.value * 0.5 / 4);
		const carbohydrate_high_standard = computed(() => tdee.value * 0.65 / 4);
		//食物繊維
		const fiber_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 0;
		    if (user_age.value <= 5) return 8;
		    if (user_age.value <= 7) return 10;
		    if (user_age.value <= 9) return 11;
		    if (user_age.value <= 11) return 13;
		    if (user_age.value <= 14) return 17;
		    if (user_age.value <= 17) return 19;
		    if (user_age.value <= 29) return 20;
		    if (user_age.value <= 49) return 22;
		    if (user_age.value <= 64) return 22;
		    if (user_age.value <= 74) return 21;
		    return 20;
		  } else {
		    if (user_age.value <= 2) return 0;
		    if (user_age.value <= 5) return 8;
		    if (user_age.value <= 7) return 9;
		    if (user_age.value <= 9) return 11;
		    if (user_age.value <= 11) return 13;
		    if (user_age.value <= 14) return 16;
		    if (user_age.value <= 17) return 18;
		    if (user_age.value <= 64) return 18;
		    if (user_age.value <= 74) return 18;
		    return 17;
		  }
		});
		//ビタミンA
		const vitamin_a_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 400;
		    if (user_age.value <= 5) return 500;
		    if (user_age.value <= 7) return 500;
		    if (user_age.value <= 9) return 500;
		    if (user_age.value <= 11) return 600;
		    if (user_age.value <= 14) return 800;
		    if (user_age.value <= 17) return 900;
		    if (user_age.value <= 29) return 850;
		    if (user_age.value <= 49) return 900;
		    if (user_age.value <= 64) return 900;
		    if (user_age.value <= 74) return 850;
		    return 800;
		  } else {
		    if (user_age.value <= 2) return 350;
		    if (user_age.value <= 5) return 500;
		    if (user_age.value <= 7) return 500;
		    if (user_age.value <= 9) return 500;
		    if (user_age.value <= 11) return 600;
		    if (user_age.value <= 14) return 700;
		    if (user_age.value <= 17) return 650;
		    if (user_age.value <= 29) return 650;
		    if (user_age.value <= 49) return 700;
		    if (user_age.value <= 64) return 700;
		    if (user_age.value <= 74) return 700;
		    return 650;
		  }
		});
		const vitamin_a_upper_limit = computed(() => {
		  if (user_age.value <= 2) return 600;
		  if (user_age.value <= 5) return 700;
		  if (user_age.value <= 7) return 950;
		  if (user_age.value <= 9) return 1200;
		  if (user_age.value <= 11) return 1500;
		  if (user_age.value <= 14) return 2100;
		  if (user_age.value <= 17) return 2600;
		  return 2700;
		});
		//ビタミンD
		const vitamin_d_standard = computed(() => {
		    if (user_age.value <= 2) return 3.5;
		    if (user_age.value <= 5) return 4.5;
		    if (user_age.value <= 7) return 5.5;
		    if (user_age.value <= 9) return 6.5;
		    if (user_age.value <= 11) return 8;
		    return 9;
		});
		const vitamin_d_upper_limit = computed(() => {
		  if (user_age.value <= 2) return 25;
		  if (user_age.value <= 5) return 30;
		  if (user_age.value <= 7) return 40;
		  if (user_age.value <= 9) return 40;
		  if (user_age.value <= 11) return 60;
		  if (user_age.value <= 14) return 80;
		  if (user_age.value <= 17) return 90;
		  return 100;
		});
		//ビタミンE
		const vitamin_e_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 3;
		    if (user_age.value <= 5) return 4;
		    if (user_age.value <= 7) return 4.5;
		    if (user_age.value <= 9) return 5;
		    if (user_age.value <= 11) return 5;
		    if (user_age.value <= 14) return 6.5;
		    if (user_age.value <= 17) return 7;
		    if (user_age.value <= 29) return 6.5;
		    if (user_age.value <= 49) return 6.5;
		    if (user_age.value <= 64) return 6.5;
		    if (user_age.value <= 74) return 7.5;
		    return 7;
		  } else {
		    if (user_age.value <= 2) return 3;
		    if (user_age.value <= 5) return 4;
		    if (user_age.value <= 7) return 4;
		    if (user_age.value <= 9) return 5;
		    if (user_age.value <= 11) return 5.5;
		    if (user_age.value <= 14) return 6;
		    if (user_age.value <= 17) return 6;
		    if (user_age.value <= 29) return 5;
		    if (user_age.value <= 49) return 6;
		    if (user_age.value <= 64) return 6;
		    if (user_age.value <= 74) return 7;
		    return 6;
		  }
		});
		const vitamin_e_upper_limit = computed(() => {
			if (user_gender.value === '男性') {
			    if (user_age.value <= 2) return 150;
			    if (user_age.value <= 5) return 200;
			    if (user_age.value <= 7) return 300;
			    if (user_age.value <= 9) return 350;
			    if (user_age.value <= 11) return 450;
			    if (user_age.value <= 14) return 650;
			    if (user_age.value <= 17) return 750;
			    return 800;
			  } else {
			    if (user_age.value <= 2) return 150;
			    if (user_age.value <= 5) return 200;
			    if (user_age.value <= 7) return 300;
			    if (user_age.value <= 9) return 350;
			    if (user_age.value <= 11) return 450;
			    if (user_age.value <= 14) return 600;
			    if (user_age.value <= 17) return 650;
			    if (user_age.value <= 29) return 650;
			    if (user_age.value <= 49) return 700;
			    if (user_age.value <= 64) return 700;
			    if (user_age.value <= 74) return 700;
			    return 650;
			  }
			});
		//ビタミンK
		const vitamin_k_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 50;
		    if (user_age.value <= 5) return 60;
		    if (user_age.value <= 7) return 80;
		    if (user_age.value <= 9) return 90;
		    if (user_age.value <= 11) return 110;
		    if (user_age.value <= 14) return 140;
		    return 150;
		  } else {
		    if (user_age.value <= 2) return 60;
		    if (user_age.value <= 5) return 70;
		    if (user_age.value <= 7) return 90;
		    if (user_age.value <= 9) return 110;
		    if (user_age.value <= 11) return 130;
		    return 150;
		  }
		});
		//ビタミンB1
		const vitamin_b1_standard = computed(() => {
		  if (user_gender.value === '男性') {
			if (user_age.value <= 2) return 0.4;
			if (user_age.value <= 5) return 0.5;
			if (user_age.value <= 7) return 0.7;
			if (user_age.value <= 9) return 0.8;
			if (user_age.value <= 11) return 0.9;
			if (user_age.value <= 14) return 1.1;
			if (user_age.value <= 17) return 1.2;
			if (user_age.value <= 29) return 1.1;
			if (user_age.value <= 49) return 1.2;
			if (user_age.value <= 64) return 1.1;
		    return 1;
		  } else {
			if (user_age.value <= 2) return 0.4;
			if (user_age.value <= 5) return 0.5;
			if (user_age.value <= 7) return 0.6;
			if (user_age.value <= 9) return 0.7;
			if (user_age.value <= 11) return 0.9;
			if (user_age.value <= 14) return 1;
			if (user_age.value <= 17) return 1;
			if (user_age.value <= 29) return 0.8;
			if (user_age.value <= 49) return 0.9;
			if (user_age.value <= 64) return 0.8;
			if (user_age.value <= 74) return 0.8;
		    return 0.7;
		  }
		});
		//ビタミンB2
		const vitamin_b2_standard = computed(() => {
		  if (user_gender.value === '男性') {
			if (user_age.value <= 2) return 0.6;
			if (user_age.value <= 5) return 0.8;
			if (user_age.value <= 7) return 0.9;
			if (user_age.value <= 9) return 1.1;
			if (user_age.value <= 11) return 1.4;
			if (user_age.value <= 14) return 1.6;
			if (user_age.value <= 17) return 1.7;
			if (user_age.value <= 29) return 1.6;
			if (user_age.value <= 49) return 1.7;
			if (user_age.value <= 64) return 1.6;
		    return 1.4;
		  } else {
			if (user_age.value <= 2) return 0.5;
			if (user_age.value <= 5) return 0.8;
			if (user_age.value <= 7) return 0.9;
			if (user_age.value <= 9) return 1;
			if (user_age.value <= 11) return 1.3;
			if (user_age.value <= 14) return 1.4;
			if (user_age.value <= 17) return 1.4;
			if (user_age.value <= 29) return 1.2;
			if (user_age.value <= 49) return 1.2;
			if (user_age.value <= 64) return 1.2;
		    return 1.1;
		  }
		});
		//ナイアシン
		const niacin_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 6;
		    if (user_age.value <= 5) return 8;
		    if (user_age.value <= 7) return 9;
		    if (user_age.value <= 9) return 11;
		    if (user_age.value <= 11) return 13;
		    if (user_age.value <= 14) return 15;
		    if (user_age.value <= 17) return 16;
		    if (user_age.value <= 29) return 15;
		    if (user_age.value <= 49) return 16;
		    if (user_age.value <= 64) return 15;
		    if (user_age.value <= 74) return 14;
		    return 13;
		  } else {
		    if (user_age.value <= 2) return 5;
		    if (user_age.value <= 5) return 7;
		    if (user_age.value <= 7) return 8;
		    if (user_age.value <= 9) return 10;
		    if (user_age.value <= 11) return 12;
		    if (user_age.value <= 14) return 14;
		    if (user_age.value <= 17) return 13;
		    if (user_age.value <= 29) return 11;
		    if (user_age.value <= 49) return 12;
		    if (user_age.value <= 64) return 11;
		    if (user_age.value <= 74) return 11;
		    return 10;
		  }
		});
		const niacin_upper_limit = computed(() => {
			if (user_gender.value === '男性') {
				if (user_age.value <= 2) return 60;
			    if (user_age.value <= 5) return 80;
			    if (user_age.value <= 7) return 100;
			    if (user_age.value <= 9) return 150;
			    if (user_age.value <= 11) return 200;
			    if (user_age.value <= 14) return 250;
			    if (user_age.value <= 17) return 300;
			    if (user_age.value <= 29) return 300;
			    if (user_age.value <= 49) return 350;
			    if (user_age.value <= 64) return 350;
			    return 300;
			  } else {
			    if (user_age.value <= 2) return 60;
			    if (user_age.value <= 5) return 80;
			    if (user_age.value <= 7) return 100;
			    if (user_age.value <= 9) return 150;
			    if (user_age.value <= 11) return 200;
			    return 250;
			  }
			});
		//ビタミンB6
		const vitamin_b6_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 0.5;
		    if (user_age.value <= 5) return 0.6;
		    if (user_age.value <= 7) return 0.7;
		    if (user_age.value <= 9) return 0.9;
		    if (user_age.value <= 11) return 1;
		    if (user_age.value <= 14) return 1.4;
		    if (user_age.value <= 17) return 1.5;
		    if (user_age.value <= 29) return 1.5;
		    if (user_age.value <= 49) return 1.5;
		    if (user_age.value <= 64) return 1.5;
		    return 1.4;
		  } else {
		    if (user_age.value <= 2) return 0.5;
		    if (user_age.value <= 5) return 0.6;
		    if (user_age.value <= 7) return 0.7;
		    if (user_age.value <= 9) return 0.9;
		    if (user_age.value <= 11) return 1.2;
		    if (user_age.value <= 14) return 1.3;
		    if (user_age.value <= 17) return 1.3;
		    return 1.2;
		  }
		});
		const vitamin_b6_upper_limit = computed(() => {
			if (user_gender.value === '男性') {
				if (user_age.value <= 2) return 10;
			    if (user_age.value <= 5) return 15;
			    if (user_age.value <= 7) return 20;
			    if (user_age.value <= 9) return 25;
			    if (user_age.value <= 11) return 30;
			    if (user_age.value <= 14) return 40;
			    if (user_age.value <= 17) return 50;
			    if (user_age.value <= 29) return 55;
			    if (user_age.value <= 49) return 60;
			    if (user_age.value <= 64) return 60;
			    if (user_age.value <= 74) return 55;
			    return 50;
			  } else {
				if (user_age.value <= 2) return 10;
			    if (user_age.value <= 5) return 15;
			    if (user_age.value <= 7) return 20;
			    if (user_age.value <= 9) return 25;
			    if (user_age.value <= 11) return 30;
			    if (user_age.value <= 14) return 40;
			    if (user_age.value <= 17) return 45;
			    if (user_age.value <= 29) return 45;
			    if (user_age.value <= 49) return 45;
			    if (user_age.value <= 64) return 45;
			    if (user_age.value <= 74) return 45;
			    return 40;
			  }
			});
		//ビタミンB12 
		const vitamin_b12_standard = computed(() => {
		    if (user_age.value <= 2) return 1.5;
		    if (user_age.value <= 5) return 1.5;
		    if (user_age.value <= 7) return 2;
		    if (user_age.value <= 9) return 2.5;
		    if (user_age.value <= 11) return 3;
		    return 4;
		    });
	    //葉酸
	    const folic_acid_standard = computed(() => {
		    if (user_age.value <= 2) return 90;
		    if (user_age.value <= 5) return 100;
		    if (user_age.value <= 7) return 130;
		    if (user_age.value <= 9) return 150;
		    if (user_age.value <= 11) return 180;
		    if (user_age.value <= 14) return 230;
		    return 240;
		});
		const folic_acid_upper_limit = computed(() => {
				if (user_age.value <= 2) return 200;
			    if (user_age.value <= 5) return 300;
			    if (user_age.value <= 7) return 400;
			    if (user_age.value <= 9) return 500;
			    if (user_age.value <= 11) return 700;
			    if (user_age.value <= 14) return 900;
			    if (user_age.value <= 17) return 900;
			    if (user_age.value <= 29) return 900;
			    if (user_age.value <= 49) return 1000;
			    if (user_age.value <= 64) return 1000;
			    return 900;
			});
		//パントテン酸
		const pantothenic_acid_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 3;
		    if (user_age.value <= 5) return 4;
		    if (user_age.value <= 7) return 5;
		    if (user_age.value <= 9) return 6;
		    if (user_age.value <= 11) return 6;
		    if (user_age.value <= 14) return 7;
		    if (user_age.value <= 17) return 7;
		    return 6;
		  } else {
		    if (user_age.value <= 2) return 3;
		    if (user_age.value <= 5) return 4;
		    if (user_age.value <= 7) return 5;
		    if (user_age.value <= 9) return 6;
		    if (user_age.value <= 11) return 6;
		    if (user_age.value <= 14) return 6;
		    if (user_age.value <= 17) return 6;
		    return 5;
		  }
		});
		//ビオチン
		const biotin_standard = computed(() => {
		    if (user_age.value <= 2) return 20;
		    if (user_age.value <= 5) return 20;
		    if (user_age.value <= 7) return 30;
		    if (user_age.value <= 9) return 30;
		    if (user_age.value <= 11) return 40;
		    return 50;
		});
		//ビタミンC
		const vitamin_c_standard = computed(() => {
		    if (user_age.value <= 2) return 35;
		    if (user_age.value <= 5) return 40;
		    if (user_age.value <= 7) return 50;
		    if (user_age.value <= 9) return 60;
		    if (user_age.value <= 11) return 70;
		    if (user_age.value <= 14) return 90;
		    return 100;
		});
		//食塩相当量
		const sodium_content_standard = computed(() => {
			if (user_gender.value === '男性') {
				if (user_age.value <= 2) return 3;
			    if (user_age.value <= 5) return 3.5;
			    if (user_age.value <= 7) return 4.5;
			    if (user_age.value <= 9) return 5;
			    if (user_age.value <= 11) return 6;
			    if (user_age.value <= 14) return 7;
			    return 7.5;
			  } else {
				if (user_age.value <= 2) return 2.5;
			    if (user_age.value <= 5) return 3.5;
			    if (user_age.value <= 7) return 4.5;
			    if (user_age.value <= 9) return 5;
			    if (user_age.value <= 11) return 6;
			    return 6.5;
			  }
			});
		//ナトリウム、公式資料にないので食塩から換算して基準を算出
		const natrium_standard = computed(() => {
			    return sodium_content_standard.value * 2.54;
			});
		//カリウム
		const potassium_standard = computed(() => {
			if (user_gender.value === '男性') {
				if (user_age.value <= 2) return 0;
			    if (user_age.value <= 5) return 1600;
			    if (user_age.value <= 7) return 1800;
			    if (user_age.value <= 9) return 2000;
			    if (user_age.value <= 11) return 2200;
			    if (user_age.value <= 14) return 2600;
			    return 3000;
			  } else {
				if (user_age.value <= 2) return 0;
			    if (user_age.value <= 5) return 1400;
			    if (user_age.value <= 7) return 1600;
			    if (user_age.value <= 9) return 1800;
			    if (user_age.value <= 11) return 2000;
			    if (user_age.value <= 14) return 2400;
			    return 2600;
			  }
			});
		//カルシウム、17歳以下は耐容上限ないので表示するとき分岐忘れずに
		const calcium_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 450;
		    if (user_age.value <= 5) return 600;
		    if (user_age.value <= 7) return 600;
		    if (user_age.value <= 9) return 650;
		    if (user_age.value <= 11) return 700;
		    if (user_age.value <= 14) return 1000;
		    if (user_age.value <= 17) return 800;
		    if (user_age.value <= 29) return 800;
		    return 750;
		  } else {
		    if (user_age.value <= 2) return 400;
		    if (user_age.value <= 5) return 550;
		    if (user_age.value <= 7) return 550;
		    if (user_age.value <= 9) return 750;
		    if (user_age.value <= 11) return 750;
		    if (user_age.value <= 14) return 800;
		    if (user_age.value <= 17) return 650;
		    if (user_age.value <= 29) return 650;
		    if (user_age.value <= 49) return 650;
		    if (user_age.value <= 64) return 650;
		    if (user_age.value <= 74) return 650;
		    return 600;
		  }
		});
		const calcium_upper_limit = computed(() => {
			    return 2500;
			});
		//マグネシウム
		const magnesium_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 70;
		    if (user_age.value <= 5) return 100;
		    if (user_age.value <= 7) return 130;
		    if (user_age.value <= 9) return 170;
		    if (user_age.value <= 11) return 210;
		    if (user_age.value <= 14) return 290;
		    if (user_age.value <= 17) return 360;
		    if (user_age.value <= 29) return 340;
		    if (user_age.value <= 49) return 380;
		    if (user_age.value <= 64) return 370;
		    if (user_age.value <= 74) return 350;
		    return 330;
		  } else {
		    if (user_age.value <= 2) return 70;
		    if (user_age.value <= 5) return 100;
		    if (user_age.value <= 7) return 130;
		    if (user_age.value <= 9) return 160;
		    if (user_age.value <= 11) return 220;
		    if (user_age.value <= 14) return 290;
		    if (user_age.value <= 17) return 310;
		    if (user_age.value <= 29) return 280;
		    if (user_age.value <= 49) return 290;
		    if (user_age.value <= 64) return 290;
		    if (user_age.value <= 74) return 280;
		    return 270;
		  }
		});
		//リン、17歳以下は耐容上限がないので表示するとき分岐する
		const phosphorus_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 600;
		    if (user_age.value <= 5) return 700;
		    if (user_age.value <= 7) return 900;
		    if (user_age.value <= 9) return 1000;
		    if (user_age.value <= 11) return 1100;
		    if (user_age.value <= 14) return 1200;
		    if (user_age.value <= 17) return 1200;
		    return 1000;
		  } else {
		    if (user_age.value <= 2) return 500;
		    if (user_age.value <= 5) return 700;
		    if (user_age.value <= 7) return 800;
		    if (user_age.value <= 9) return 900;
		    if (user_age.value <= 11) return 1000;
		    if (user_age.value <= 14) return 1100;
		    if (user_age.value <= 17) return 1000;
		    return 800;
		  }
		});
		const phosphorus_upper_limit = computed(() => {
			    return 3000;
			});
		//鉄
		const iron_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 4;
		    if (user_age.value <= 5) return 5;
		    if (user_age.value <= 7) return 6;
		    if (user_age.value <= 9) return 7.5;
		    if (user_age.value <= 11) return 9.5;
		    if (user_age.value <= 14) return 9;
		    if (user_age.value <= 17) return 9;
		    if (user_age.value <= 29) return 7;
		    if (user_age.value <= 49) return 7.5;
		    if (user_age.value <= 64) return 7;
		    if (user_age.value <= 74) return 7;
		    return 6.5;
		  } else {
		    if (user_age.value <= 2) return 4;
		    if (user_age.value <= 5) return 5;
		    if (user_age.value <= 7) return 6;
		    if (user_age.value <= 9) return 8;
		    if (user_age.value <= 11) return 9;
		    if (user_age.value <= 14) return 8;
		    if (user_age.value <= 17) return 6.5;
		    if (user_age.value <= 29) return 6;
		    if (user_age.value <= 49) return 6;
		    if (user_age.value <= 64) return 6;
		    if (user_age.value <= 74) return 6;
		    return 5.5;
		  }
		});
		//亜鉛、17歳以下は許容上限がないので表示するとき分岐する
		const zinc_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 3.5;
		    if (user_age.value <= 5) return 4;
		    if (user_age.value <= 7) return 5;
		    if (user_age.value <= 9) return 5.5;
		    if (user_age.value <= 11) return 8;
		    if (user_age.value <= 14) return 8.5;
		    if (user_age.value <= 17) return 10;
		    if (user_age.value <= 29) return 9;
		    if (user_age.value <= 49) return 9.5;
		    if (user_age.value <= 64) return 9.5;
		    if (user_age.value <= 74) return 9;
		    return 9;
		  } else {
			if (user_age.value <= 2) return 3;
			if (user_age.value <= 5) return 3.5;
			if (user_age.value <= 7) return 4.5;
			if (user_age.value <= 9) return 5.5;
			if (user_age.value <= 11) return 7.5;
			if (user_age.value <= 14) return 8.5;
			if (user_age.value <= 17) return 8;
			if (user_age.value <= 29) return 7.5;
			if (user_age.value <= 49) return 8;
			if (user_age.value <= 64) return 8;
			if (user_age.value <= 74) return 7.5;
			return 7;
		  }
		});
		const zinc_upper_limit = computed(() => {
			if (user_gender.value === '男性') {
			    if (user_age.value <= 29) return 40;
			    if (user_age.value <= 49) return 45;
			    if (user_age.value <= 64) return 45;
			    if (user_age.value <= 74) return 45;
			    return 40;
			  } else {
				return 35;
			  }
			});
		//銅、17歳以下は耐容上限がないため表示するとき分岐
		const copper_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 0.3;
		    if (user_age.value <= 5) return 0.4;
		    if (user_age.value <= 7) return 0.4;
		    if (user_age.value <= 9) return 0.5;
		    if (user_age.value <= 11) return 0.6;
		    if (user_age.value <= 14) return 0.8;
		    if (user_age.value <= 17) return 0.9;
		    if (user_age.value <= 29) return 0.8;
		    if (user_age.value <= 49) return 0.9;
		    if (user_age.value <= 64) return 0.9;
		    if (user_age.value <= 74) return 0.8;
		    return 0.8;
		  } else {
			if (user_age.value <= 2) return 0.3;
			if (user_age.value <= 5) return 0.3;
			if (user_age.value <= 7) return 0.4;
			if (user_age.value <= 9) return 0.5;
			if (user_age.value <= 11) return 0.6;
			if (user_age.value <= 14) return 0.8;
			return 0.7;
		  }
		});
		const copper_upper_limit = computed(() => {
			    return 7;
			});
		//マンガン、17歳以下は耐容上限がないため表示するとき分岐
		const manganese_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 1.5;
		    if (user_age.value <= 5) return 2;
		    if (user_age.value <= 7) return 2;
		    if (user_age.value <= 9) return 2.5;
		    if (user_age.value <= 11) return 3;
		    return 3.5;
		  } else {
			if (user_age.value <= 2) return 1.5;
			if (user_age.value <= 5) return 2;
			if (user_age.value <= 7) return 2;
			if (user_age.value <= 9) return 2.5;
			return 3;
		  }
		});
		const manganese_upper_limit = computed(() => {
			    return 11;
			});
		//ヨウ素
		const iodine_standard = computed(() => {
		    if (user_age.value <= 2) return 50;
		    if (user_age.value <= 5) return 60;
		    if (user_age.value <= 7) return 75;
		    if (user_age.value <= 9) return 90;
		    if (user_age.value <= 11) return 110;
			return 140;
		});
		const iodine_upper_limit = computed(() => {
			    if (user_age.value <= 2) return 600;
			    if (user_age.value <= 5) return 900;
			    if (user_age.value <= 7) return 1200;
			    if (user_age.value <= 9) return 1500;
			    if (user_age.value <= 11) return 2000;
			    if (user_age.value <= 14) return 2500;
			    return 3000;
			});
		//セレン
		const selenium_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 10;
		    if (user_age.value <= 5) return 15;
		    if (user_age.value <= 7) return 15;
		    if (user_age.value <= 9) return 20;
		    if (user_age.value <= 11) return 25;
		    if (user_age.value <= 14) return 30;
		    if (user_age.value <= 17) return 35;
		    if (user_age.value <= 29) return 30;
		    if (user_age.value <= 49) return 35;
		    return 30;
		  } else {
		    if (user_age.value <= 2) return 10;
		    if (user_age.value <= 5) return 10;
		    if (user_age.value <= 7) return 15;
		    if (user_age.value <= 9) return 20;
		    if (user_age.value <= 11) return 25;
		    if (user_age.value <= 14) return 30;
		    return 25;
		  }
		});
		const selenium_upper_limit = computed(() => {
			if (user_gender.value === '男性') {
				if (user_age.value <= 2) return 100;
			    if (user_age.value <= 5) return 100;
			    if (user_age.value <= 7) return 150;
			    if (user_age.value <= 9) return 200;
			    if (user_age.value <= 11) return 250;
			    if (user_age.value <= 14) return 350;
			    if (user_age.value <= 17) return 400;
			    if (user_age.value <= 29) return 400;
			    if (user_age.value <= 49) return 450;
			    if (user_age.value <= 64) return 450;
			    if (user_age.value <= 74) return 450;
			    return 400;
			  } else {
				if (user_age.value <= 2) return 100;
			    if (user_age.value <= 5) return 100;
			    if (user_age.value <= 7) return 150;
			    if (user_age.value <= 9) return 200;
			    if (user_age.value <= 11) return 250;
			    if (user_age.value <= 14) return 300;
			    return 350;
			  }
			});
		//クロム、17歳以下は目安量も許容上限もないので表示するとき分岐する
		const chrome_standard = computed(() => {
		    return 10;
		});
		const chrome_upper_limit = computed(() => {
			    return 500;
			});
		//モリブデン、17歳以下は耐容上限がないため表示するとき分岐
		const molybdenum_standard = computed(() => {
		  if (user_gender.value === '男性') {
		    if (user_age.value <= 2) return 10;
		    if (user_age.value <= 5) return 10;
		    if (user_age.value <= 7) return 15;
		    if (user_age.value <= 9) return 20;
		    if (user_age.value <= 11) return 20;
		    if (user_age.value <= 14) return 25;
		    if (user_age.value <= 17) return 30;
		    if (user_age.value <= 29) return 30;
		    if (user_age.value <= 49) return 30;
		    if (user_age.value <= 64) return 30;
		    if (user_age.value <= 74) return 30;
		    return 25;
		  } else {
			    if (user_age.value <= 2) return 10;
			    if (user_age.value <= 5) return 10;
			    if (user_age.value <= 7) return 15;
			    if (user_age.value <= 9) return 15;
		    return 25;
		  }
		});
		const molybdenum_upper_limit = computed(() => {
			if (user_gender.value === '男性') {
			    return 600;
			  } else {
			    return 500;
			  }
			});














		
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
        watch(selectedFoods, updateNutrition, { deep: true });
        	        

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
          onInputWeight,
          user_age,   
          user_gender,     
          user_height,      
          user_weight,    
          user_activity_level,

		  total_protein,
		  total_energy,
		  total_lipid,
		  total_food_fiber,
		  total_carbohydrate,
		  total_natrium,
		  total_potassium,
		  total_calcium,
		  total_magnesium,
		  total_phosphorus,
		  total_iron,
		  total_zinc,
		  total_copper,
		  total_manganese,
		  total_iodine,
		  total_selenium,
		  total_chrome,
		  total_molybdenum,
		  total_vitamin_a,
		  total_vitamin_d,
		  total_vitamin_e,
		  total_vitamin_k,
		  total_vitamin_b1,
		  total_vitamin_b2,
		  total_niacin,
		  total_vitamin_b6,
		  total_vitamin_b12,
		  total_folic_acid,
		  total_pantothenic_acid,
		  total_biotin,
		  total_vitamin_c,
		  total_sodium_content,

		  //各栄養素基準値（パーソナルデータから計算後）
          bmr,
          tdee,
		  protein_low_standard,
		  protein_high_standard,
		  lipid_low_standard,
		  lipid_high_standard,
		  carbohydrate_low_standard,
		  carbohydrate_high_standard,
		  fiber_standard,
		  vitamin_a_standard,
		  vitamin_a_upper_limit,
		  vitamin_d_standard,
		  vitamin_d_upper_limit,
		  vitamin_e_standard,
		  vitamin_e_upper_limit,
		  vitamin_k_standard,
		  vitamin_b1_standard,
		  vitamin_b2_standard,
		  niacin_standard,
		  niacin_upper_limit,
		  vitamin_b6_standard,
		  vitamin_b6_upper_limit,
		  vitamin_b12_standard,
		  folic_acid_standard,
		  folic_acid_upper_limit,
		  pantothenic_acid_standard,
		  biotin_standard,
		  vitamin_c_standard,
		  sodium_content_standard,
		  natrium_standard,
		  potassium_standard,
		  calcium_standard,
		  calcium_upper_limit,
		  magnesium_standard,
		  phosphorus_standard,
		  phosphorus_upper_limit,
		  iron_standard,
		  zinc_standard,
		  zinc_upper_limit,
		  copper_standard,
		  copper_upper_limit,
		  manganese_standard,
		  manganese_upper_limit,
		  iodine_standard,
		  iodine_upper_limit,
		  selenium_standard,
		  selenium_upper_limit,
		  chrome_standard,
		  chrome_upper_limit,
		  molybdenum_standard,
		  molybdenum_upper_limit,
        };
      }
    }).use(createVuetify()).mount('#app');
        </script>
    </body>
</html>
