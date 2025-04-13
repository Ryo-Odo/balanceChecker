package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.User;
import service.UserLoginService;

/**
 * Servlet implementation class LoginController
 */
@WebServlet(name = "login", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/jsp/login.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//reqestは「ブラウザからのリクエスト情報」、responseは「ブラウザへ送り返す情報」
		request.setCharacterEncoding("UTF-8");
		
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		//リクエストの情報getして変数へ入れる
		
		UserLoginService loginService =new UserLoginService();
		//自作した「UserLoginService」のインスタンスを作成
		
		User user = loginService.loginCheck(loginId, password);
		//自作した「User」クラスのインスタンスに入れる、ログインチェックで合っているか確認
		
		
		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			
//			FoodGetService getSelvice= new FoodGetService();
//			//Foodのロジッククラスを初期化
//			
//			List<Food> foodList = getSelvice.getAllFoods();
//			//foods_dbから全ての情報を取得し、Food型のListを作成
//			
//		    response.setContentType("application/json; charset=UTF-8");
//		    //
//		    
//		    PrintWriter out = response.getWriter();
//
//		    Gson gson = new Gson();
//		    String json = gson.toJson(foodList); // ← FoodでもGsonでそのままJSON化できる
//		    out.print(json);
//		    out.flush();
			
				
//			RequestDispatcher rd = request.getRequestDispatcher("jsp/home.jsp");
//			rd.forward(request, response);
		    response.sendRedirect(request.getContextPath() + "/home"); // URL変更して遷移
		} else {
			request.setAttribute("loginError", "ログインIDまたはパスワードが間違っています。");
			RequestDispatcher rd = request.getRequestDispatcher("jsp/login.jsp");
			rd.forward(request, response);
		}
		
		
	}

}
