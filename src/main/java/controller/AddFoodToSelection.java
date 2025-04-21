package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import domain.Food;
import service.FoodGetService;

/**
 * Servlet implementation class AddFoodToSelection
 */
@WebServlet(name = "api/addFoodToSelection", urlPatterns = { "/api/addFoodToSelection" })
public class AddFoodToSelection extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFoodToSelection() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");

	    BufferedReader reader = request.getReader();
	    StringBuilder sb = new StringBuilder();
	    String line;
	    while ((line = reader.readLine()) != null) {
	        sb.append(line);
	    }

	    try {
	        JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
	        JsonElement foodIdElement = json.get("food_id");

	        if (foodIdElement == null || foodIdElement.isJsonNull()) {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            response.getWriter().write("Missing 'food_id'");
	            return;
	        }

	        String food_id = foodIdElement.getAsString();
	        System.out.println("選択された食品ID: " + food_id);
	        
			FoodGetService getService = new FoodGetService();
			
			Food food = getService.getFood(food_id);

			response.setContentType("application/json; charset=UTF-8");
			

			Gson gson = new Gson();
			String food_json = gson.toJson(food);

	        response.setStatus(HttpServletResponse.SC_OK);
	        
	        PrintWriter out = response.getWriter();
			out.print(food_json);
			out.flush();

	    } catch (Exception e) {
	        e.printStackTrace(); // コンソールでスタックトレース表示
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("サーバー内部エラー");
	    }

	    
	}
}

