package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import domain.FoodName;
import service.FoodGetService;

/**
 * Servlet implementation class FoodSearchApiController
 */
@WebServlet(name = "api/foodSearch", urlPatterns = { "/api/foodSearch" })
public class FoodSearchApiController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodSearchApiController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			return;
		}
		
		request.setCharacterEncoding("UTF-8");

		
		BufferedReader reader = request.getReader();
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
		    sb.append(line);
		}
		String requestBody = sb.toString();

		JsonObject jsonObject = JsonParser.parseString(requestBody).getAsJsonObject();
		
		String keyword = jsonObject.get("keyword").getAsString();
		
		FoodGetService getService = new FoodGetService();
		System.out.println("1.入力されたキーワード：" + keyword);
		List<FoodName> foodList = getService.getSearchFoods(keyword);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();

		Gson gson = new Gson();
		String json = gson.toJson(foodList);
		
		System.out.println(json);
		out.print(json);
		out.flush();
	}

}
