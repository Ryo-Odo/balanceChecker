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