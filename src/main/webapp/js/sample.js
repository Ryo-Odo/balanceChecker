    const { createApp, ref, watch, onMounted } = Vue;

    createApp({
      setup() {
        const searchQuery = ref('');
        const foods = ref([]);
        const filteredFoods = ref([]);
        let fuse = null;

        // データ取得とFuse初期化
        onMounted(async () => {
          const response = await axios.get('/api/foods'); // APIを実際のURLに置き換えてください
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