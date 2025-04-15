package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.FoodNameDTO;

public class FoodNameDAO extends BaseDAO{
	
	public List<FoodNameDTO> searchFoods(String keyword) {
		//検索されたfoods_dbを取得してList<FoodDTO>として返すメソッド
		
	    List<FoodNameDTO> list = new ArrayList<>();
	    //DTOList作成
	    
	    Connection conn = getonConnection();
	    //DBへ接続
	    
	    try {
	    	PreparedStatement ps = conn.prepareStatement("SELECT * FROM food_name WHERE food_name ILIKE ?");
	    	//SQL文セット
	    	
	    	ps.setString(1, "%" + keyword + "%");
	    	
	    	
	    	ResultSet rs = ps.executeQuery();
	    	//rsに実行結果を格納
	    	System.out.println("3.FoodNameDAO内、searchFoodsメソッドのrs");
	    	System.out.println(rs);
	    	
	    	while (rs.next()) {
	    		FoodNameDTO foodNameDTO = new FoodNameDTO(
	    		        rs.getInt("id"),
	    		        rs.getInt("food_group"),
	    		        rs.getString("food_name"),
	    		        rs.getString("other")
	    		    );
	    		//SQL実行結果を順次取り出し、それを元にDTO作成
	    		list.add(foodNameDTO);
	    		//作成したリストに追加
	    		System.out.println(foodNameDTO.getFoodName());
	    	}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return list;
	}
}
