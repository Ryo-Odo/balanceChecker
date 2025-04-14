package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.FoodDTO;

public class FoodDAO extends BaseDAO{
	
	public List<FoodDTO> findAll() {
		//すべてのfoods_dbを取得してList<FoodDTO>として返すメソッド
		
	    List<FoodDTO> list = new ArrayList<>();
	    //DTOList作成
	    
	    Connection conn = getonConnection();
	    //DBへ接続
	    
	    try {
	    	PreparedStatement ps = conn.prepareStatement("SELECT * FROM foods");
	    	//SQL文セット
	    	
	    	ResultSet rs = ps.executeQuery();
	    	//rsに実行結果を格納
	    	
	    	while (rs.next()) {
	    		FoodDTO foodDTO = new FoodDTO(
	    		        rs.getInt("id"),
	    		        rs.getInt("food_group"),
	    		        rs.getString("food_name"),
	    		        rs.getString("other"),
	    		        rs.getDouble("energy"),
	    		        rs.getDouble("moisture"),
	    		        rs.getDouble("protein"),
	    		        rs.getDouble("lipid"),
	    		        rs.getDouble("food_fiber"),
	    		        rs.getDouble("carbohydrate"),
	    		        rs.getDouble("natrium"),
	    		        rs.getDouble("potassium"),
	    		        rs.getDouble("calcium"),
	    		        rs.getDouble("magnesium"),
	    		        rs.getDouble("phosphorus"),
	    		        rs.getDouble("iron"),
	    		        rs.getDouble("zinc"),
	    		        rs.getDouble("copper"),
	    		        rs.getDouble("manganese"),
	    		        rs.getDouble("iodine"),
	    		        rs.getDouble("selenium"),
	    		        rs.getDouble("chrome"),
	    		        rs.getDouble("molybdenum"),
	    		        rs.getDouble("vitamin_a"),
	    		        rs.getDouble("vitamin_d"),
	    		        rs.getDouble("vitamin_e"),
	    		        rs.getDouble("vitamin_k"),
	    		        rs.getDouble("vitamin_b1"),
	    		        rs.getDouble("vitamin_b2"),
	    		        rs.getDouble("niacin"),
	    		        rs.getDouble("vitamin_b6"),
	    		        rs.getDouble("vitamin_b12"),
	    		        rs.getDouble("folic_acid"),
	    		        rs.getDouble("pantothenic_acid"),
	    		        rs.getDouble("biotin"),
	    		        rs.getDouble("vitamin_c"),
	    		        rs.getDouble("sodium_content")
	    		    );
	    		//SQL実行結果を順次取り出し、それを元にDTO作成
	    		list.add(foodDTO);
	    		//作成したリストに追加
	    	}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return list;
	}
}
