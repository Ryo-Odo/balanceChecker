package service;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import dao.FoodDAO;
import dao.FoodNameDAO;
import domain.Food;
import domain.FoodName;
import domain.FoodNutrien;
import dto.FoodDTO;
import dto.FoodNameDTO;

public class FoodGetService {
	
	public List<FoodNutrien> getSearchFoodNutrien(String nutrient) {
		//foods_dbから検索された食品情報を返すメソッド
		
		FoodDAO foodDAO = new FoodDAO();
		//DAOインスタンス作成
		List<FoodDTO> foodDTOList = foodDAO.searchNutrien(nutrient);
		//List<FoodDTO>型のデータを返すFoodDAOのsearchNutrienメソッド
		
		List<FoodNutrien> foodNutrienList = new ArrayList<>();
		//最終的に返すFoodNutrien型のリストを初期化
		
		for (FoodDTO dto : foodDTOList ) {
			FoodNutrien food = new FoodNutrien();
			try {
				food = convertToFoodNutrienDomain(dto, nutrient);
			} catch (NoSuchMethodException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
			//List<FoodDTO>を順次取り出し、convertToDomaiメソッドでFood型に変換
			
			foodNutrienList.add(food);
			//作成したLISTに追加
		}		
		return foodNutrienList;
	}
	
	
	
	
	public List<FoodName> getSearchFoods(String keyword) {
		//foods_dbから検索された食品情報を返すメソッド
		
		FoodNameDAO foodNameDAO = new FoodNameDAO();
		//DAOインスタンス作成
		List<FoodNameDTO> foodNameDTOList = foodNameDAO.searchFoods(keyword);
		//List<FoodDTO>型のデータを返すFoodDAOのfindAllメソッド
		
		List<FoodName> foodNameList = new ArrayList<>();
		
		//初期化
		
		for (FoodNameDTO dto : foodNameDTOList ) {
			FoodName foodName = convertToFoodNameDomain(dto);
			//List<FoodNameDTO>を順次取り出し、convertToFoodNameDomainメソッドでFoodName型に変換
			
			foodNameList.add(foodName);
			//作成したLISTに追加
		}		
		return foodNameList;
	}
	
	public List<Food> getAllFoods() {
		//foods_dbからデータをすべてList<Food>として返すメソッド
		FoodDAO foodDAO = new FoodDAO();
		//DAOインスタンス作成
		List<FoodDTO> foodDTOList = foodDAO.findAll();
		//List<FoodDTO>型のデータを返すFoodDAOのfindAllメソッド
		
		List<Food> foodList = new ArrayList<>();
		//初期化
		
		for (FoodDTO dto : foodDTOList ) {
			Food food = convertToFoodDomain(dto);
			//List<FoodDTO>を順次取り出し、convertToDomaiメソッドでFood型に変換
			
			foodList.add(food);
			//作成したLISTに追加
		}		
		return foodList;
	}
	
	public FoodNutrien convertToFoodNutrienDomain(FoodDTO dto, String nutrien) throws NoSuchMethodException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
	    FoodNutrien food = new FoodNutrien();
	    try {
	        String methodName = "get" + nutrien.substring(0, 1).toUpperCase() + nutrien.substring(1);
	        Method method = FoodDTO.class.getMethod(methodName);
	        Double setValue = (Double) method.invoke(dto);

	        food.setId(dto.getId());
	        food.setFood_group(dto.getFood_group());
	        food.setFoodName(dto.getFoodName());
	        food.setMoisture(dto.getMoisture());
	        food.setOther(dto.getOther());
	        food.setNutrien(setValue);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return food;
	}

	
	public FoodName convertToFoodNameDomain(FoodNameDTO dto) {
		FoodName foodName = new FoodName();
		//初期化
		
		foodName.setId(dto.getId());
		foodName.setFood_group(dto.getFood_group());
		foodName.setFoodName(dto.getFoodName());
		foodName.setOther(dto.getOther());	
		return foodName;

	}
	
	public Food convertToFoodDomain(FoodDTO dto) {
		Food food = new Food();
		//初期化
		
		food.setId(dto.getId());
		food.setFood_group(dto.getFood_group());
		food.setFoodName(dto.getFoodName());
		food.setOther(dto.getOther());
		food.setEnergy(dto.getEnergy());
		food.setMoisture(dto.getMoisture());
		food.setProtein(dto.getProtein());
		food.setLipid(dto.getLipid());
		food.setFood_fiber(dto.getFood_fiber());
		food.setCarbohydrate(dto.getCarbohydrate());
		food.setNatrium(dto.getNatrium());
		food.setPotassium(dto.getPotassium());
		food.setCalcium(dto.getCalcium());
		food.setMagnesium(dto.getMagnesium());
		food.setPhosphorus(dto.getPhosphorus());
		food.setIron(dto.getIron());
		food.setZinc(dto.getZinc());
		food.setCopper(dto.getCopper());
		food.setManganese(dto.getManganese());
		food.setIodine(dto.getIodine());
		food.setSelenium(dto.getSelenium());
		food.setChrome(dto.getChrome());
		food.setMolybdenum(dto.getMolybdenum());
		food.setVitamin_a(dto.getVitamin_a());
		food.setVitamin_d(dto.getVitamin_d());
		food.setVitamin_e(dto.getVitamin_e());
		food.setVitamin_k(dto.getVitamin_k());
		food.setVitamin_b1(dto.getVitamin_b1());
		food.setVitamin_b2(dto.getVitamin_b2());
		food.setNiacin(dto.getNiacin());
		food.setVitamin_b6(dto.getVitamin_b6());
		food.setVitamin_b12(dto.getVitamin_b12());
		food.setFolic_acid(dto.getFolic_acid());
		food.setPantothenic_acid(dto.getPantothenic_acid());
		food.setBiotin(dto.getBiotin());
		food.setVitamin_c(dto.getVitamin_c());
		food.setSodium_content(dto.getSodium_content());
		
		return food;

	}

}
