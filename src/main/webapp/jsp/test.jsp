<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div id="app">
        <v-app>
            <v-main class="pa-4">
                <h2>食品リスト</h2>
                <v-data-table
                    :headers="headers"
                    :items="foods"
                    class="elevation-1"
                    item-value="food_name"
                >
                    <template v-slot:[`item.foodName`]="{ item }">
                        <td>{{ item.foodName }}</td> <!-- 食品名 -->
                    </template>
                    <template v-slot:[`item.energy`]="{ item }">
                        <td>{{ item.energy }} kcal</td> <!-- エネルギー -->
                    </template>
                </v-data-table>
            </v-main>
        </v-app>
    </div>
    <script src="/balanceChecker/js/test.js"></script>