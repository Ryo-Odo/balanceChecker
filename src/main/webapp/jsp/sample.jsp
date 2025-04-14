<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <div id="app">
    <v-app>
      <v-container>
        <v-text-field
          v-model="searchQuery"
          label="食品名またはその他を検索"
          prepend-inner-icon="mdi-magnify"
          clearable
        ></v-text-field>

        <v-list v-if="filteredFoods.length">
          <v-list-item
            v-for="food in filteredFoods"
            :key="food.id"
          >
            <v-list-item-content>
              <v-list-item-title>{{ food.foodName }}</v-list-item-title>
              <v-list-item-subtitle>{{ food.other }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <div v-else>
          <p>該当する食品が見つかりませんでした。</p>
        </div>
      </v-container>
    </v-app>
  </div>
  <script src="/balanceChecker/js/sample.js"></script>