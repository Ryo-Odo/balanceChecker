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

import validation.Validation;
/**
 * Servlet implementation class EditController
 */
@WebServlet(name = "edit", urlPatterns = { "/edit" })
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/jsp/edit.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute("pendingEdit");
		}
		
		String editPassword = request.getParameter("editPassword");
		String editName = request.getParameter("editName");
		
		Validation validation = new Validation();
		validation.isBlank("パスワード", editPassword);
		validation.isBlank("お名前", editName);
		validation.length("パスワード", editPassword, 8, 64);
		validation.length("お名前", editName, 1, 10);
		
		if (validation.hasErrorMsg()) {
			request.setAttribute("errorMsg", validation.getErrorMsgList());
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/edit.jsp");
			rd.forward(request, response);
		} else {
			User currentUser = session == null ? null : (User) session.getAttribute("user");
			if (currentUser == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}
			User pendingEdit = new User(currentUser.getLoginId(), editPassword, editName);
			session.setAttribute("pendingEdit", pendingEdit);
			request.setAttribute("editName", editName);
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/editConfirm.jsp");
			rd.forward(request, response);
		}
	}

}
