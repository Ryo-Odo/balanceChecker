// search.js
function searchFoods(foods, query) {
  return foods.filter(food =>
    food.foodName.toLowerCase().includes(query.toLowerCase())
  );
}