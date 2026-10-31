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
		
		HttpSession session = request.getSession(false);
		User currentUser = session == null ? null : (User) session.getAttribute("user");
		User user = session == null ? null : (User) session.getAttribute("pendingEdit");
		if (currentUser == null || user == null || !currentUser.getLoginId().equals(user.getLoginId())) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		UserEditService editService = new UserEditService();
		boolean result = editService.userEditDo(user);
		
		if (result == true) {
			session.removeAttribute("pendingEdit");
			currentUser.setName(user.getName());
			currentUser.setPassword(null);
			response.sendRedirect(request.getContextPath() + "/home");
		} else {
			request.setAttribute("editError", "メンバー情報の更新に失敗しました");
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/edit.jsp");
			rd.forward(request, response);
		}

	}

}
