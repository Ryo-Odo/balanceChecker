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

/**
 * Servlet implementation class HomeController
 */
@WebServlet(name = "home", urlPatterns = { "/home" })
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
			return;
		}

		// セッションからユーザー情報を取得
		User user = (User) session.getAttribute("user");
		request.setAttribute("user", user); // 必要に応じてリクエストスコープにもセット

		// home.jsp へフォワード
		RequestDispatcher rd = request.getRequestDispatcher("/jsp/home.jsp");
		rd.forward(request, response);
	}

}
