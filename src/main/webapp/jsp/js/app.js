const { createApp, ref, computed } = Vue;
const vuetify = Vuetify.createVuetify();

createApp({
  setup() {
    const foods = ref([]);
    const search = ref('');
    const selectedFoods = ref([]);

    const filteredFoods = computed(() =>
      foods.value.filter(food =>
        food.foodName.includes(search.value)
      )
    );

    const totalNutrition = computed(() => {
      const keys = Object.keys(foods.value[0] || {}).filter(k => typeof foods.value[0][k] === 'number');
      const total = {};
      keys.forEach(k => {
        total[k] = selectedFoods.value.reduce((sum, f) => sum + f[k], 0);
      });
      return total;
    });

    const toggleFood = (food) => {
      const idx = selectedFoods.value.indexOf(food);
      if (idx === -1) selectedFoods.value.push(food);
      else selectedFoods.value.splice(idx, 1);
    };

    fetch('FoodServlet')
      .then(res => res.json())
      .then(data => foods.value = data);

    return { search, filteredFoods, selectedFoods, toggleFood, totalNutrition };
  },
  template: `
    <v-app>
      <v-container>
        <v-text-field v-model="search" label="食品名で検索" clearable></v-text-field>
        <v-list>
          <v-list-item v-for="food in filteredFoods" :key="food.id" @click="toggleFood(food)">
            {{ food.foodName }}
          </v-list-item>
        </v-list>
        <h3>選択された食品の合計栄養素</h3>
        <v-table>
          <tr v-for="(value, key) in totalNutrition" :key="key">
            <td>{{ key }}</td>
            <td>{{ value.toFixed(2) }}</td>
          </tr>
        </v-table>
      </v-container>
    </v-app>
  `
}).use(vuetify).mount('#app');
