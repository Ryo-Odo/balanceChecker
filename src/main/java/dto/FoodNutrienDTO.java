package dto;

public class FoodNutrienDTO {
    private int id;
    private int food_group;
    private String foodName;
    private double nutrien;
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

	
	public double getNutrien() {
		return nutrien;
	}


	public void setNutrien(double nutrien) {
		this.nutrien = nutrien;
	}


	public String getOther() {
		return other;
	}


	public void setOther(String other) {
		this.other = other;
	}
}
