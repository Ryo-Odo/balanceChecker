package controller;

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

import domain.Food;
import service.FoodGetService;

/**
 * Servlet implementation class FoodApiController
 */
@WebServlet(name = "api/foods", urlPatterns = { "/api/foods" })
public class FoodApiController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodApiController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			return;
		}

		FoodGetService getService = new FoodGetService();
		List<Food> foodList = getService.getAllFoods();

		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();

		Gson gson = new Gson();
		String json = gson.toJson(foodList);
		
		out.print(json);
		out.flush();
	}

}
