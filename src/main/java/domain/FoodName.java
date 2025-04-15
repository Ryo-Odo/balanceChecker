package domain;

public class FoodName {
    private int id;
    private int food_group;
    private String foodName;
    private String other;    
    
//	public FoodName(int id, int food_group, String foodName, String other) {
//		this.id = id;
//		this.food_group = food_group;
//		this.foodName = foodName;
//		this.other = other;
//		}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getFood_group() {
		return food_group;
	}


	public void setFood_group(int food_group) {
		this.food_group = food_group;
	}


	public String getFoodName() {
		return foodName;
	}


	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}


	public String getOther() {
		return other;
	}


	public void setOther(String other) {
		this.other = other;
	}
}
