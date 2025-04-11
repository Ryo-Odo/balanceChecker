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
import service.UserDeleteSarvice;

/**
 * Servlet implementation class DeleteController
 */
@WebServlet(name = "delete", urlPatterns = { "/delete" })
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/jsp/deleteConfirm.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginId = request.getParameter("deleteLoginId");
		
		User user = new User(loginId, null, null);
		
		UserDeleteSarvice deleteService = new UserDeleteSarvice();
		boolean result = deleteService.userDeleteDo(user);
		
		if (result == true) {
			HttpSession session = request.getSession();
			session.invalidate();
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/deleteDone.jsp");
			rd.forward(request, response);
		} else {
			request.setAttribute("deleteError", "登録情報の削除の失敗しました");
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/deleteConfirm.jsp");
			rd.forward(request, response);
		}
	}

}
