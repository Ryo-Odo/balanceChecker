<!-- 栄養素別検索モーダル -->
      <v-dialog v-model="dialogNutrition" max-width="800" hide-overlay>
        <v-card>
          <v-card-title class="text-h6">
            栄養素別検索
          </v-card-title>

          <v-card-text>
            <!-- 栄養素入力フィールド -->
            <v-text-field
              v-model="selectedNutrientInput"
              label="栄養素を入力"
              prepend-inner-icon="mdi-magnify"
              clearable
              @input="onNutritionInput"
            ></v-text-field>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn text @click="dialogNutrition = false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>