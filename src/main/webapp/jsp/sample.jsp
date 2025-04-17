              <v-list v-if="paginatedFoods.length">
                <v-list-item v-for="food in paginatedFoods" :key="food.id">
                  <v-list-item-title>{{ food.id }} - {{ food.foodName }}</v-list-item-title>
                  <v-list-item-subtitle>{{ food.other }}</v-list-item-subtitle>
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
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
                            <v-list v-if="paginatedNutrientFoods.length">
                <v-list-item v-for="food in paginatedNutrientFoods" :key="food.id">
                  <v-list-item-title>{{ food.id }} - {{ food.foodName }}</v-list-item-title>
                  <v-list-item-subtitle>{{ food[selectedNutrient] }}（{{ getNutrientTitle(selectedNutrient) }}）</v-list-item-subtitle>
                </v-list-item>
              </v-list>
              <div v-else-if="selectedNutrient"><p>該当する食品が見つかりませんでした。</p></div>

              <v-pagination
                v-if="nutrientFoods.length > itemsPerPage"
                v-model="currentNutrientPage"
                :length="totalNutrientPages"
                :total-visible="7"
                class="mt-4"
              ></v-pagination>