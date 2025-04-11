package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;
import service.UserEditService;

/**
 * Servlet implementation class EditConfirmController
 */
@WebServlet(name = "editConfirm", urlPatterns = { "/editConfirm" })
public class EditConfirmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditConfirmController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("editPassword");
		String name = request.getParameter("editName");
		
		User user = new User(loginId, password, name);
		
		UserEditService editService = new UserEditService();
		boolean result = editService.userEditDo(user);
		
		if (result == true) {
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/editDone.jsp");
			rd.forward(request, response);
		} else {
			request.setAttribute("editError", "メンバー情報の更新に失敗しました");
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/edit.jsp");
			rd.forward(request, response);
		}

	}

}
