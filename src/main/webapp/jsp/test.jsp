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
          getNutrientTitle
        };
      }
    }).use(createVuetify()).mount('#app');
  </script>