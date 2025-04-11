package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;
import service.UserRegisterService;
import validation.Validation;

/**
 * Servlet implementation class RegisterController
 */
@WebServlet(name = "register", urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/jsp/register.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		
		Validation validation = new Validation();
		
		validation.isBlank("ユーザーID", loginId);
		validation.isBlank("パスワード", password);
		validation.isBlank("お名前", name);
		validation.length("ユーザーID", loginId, 1, 8);
		validation.length("パスワード", password, 2, 10);
		validation.length("お名前", name, 1, 10);
		
		if(validation.hasErrorMsg()) {
			request.setAttribute("errorMsg", validation.getErrorMsgList());
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/register.jsp");
			rd.forward(request, response);
		}
		
		User user = new User(loginId, password, name);
		UserRegisterService registarService = new UserRegisterService();
		
		//登録しようとしているユーザーがすでに存在しているか、UserRegisterServiceのmethodを使用して変数へ格納、いなかったらtrue
		boolean result = registarService.userEntryConfirm(user);
		
		if(result == true) {
			request.setAttribute("user", user);
			RequestDispatcher rd = request.getRequestDispatcher("jsp/registerConfirm.jsp");
			rd.forward(request, response);
		} else {
			validation.addErrorMsg("入力いただいたID「" + loginId + "」は既に使われています");
			request.setAttribute("errorMsg", validation.getErrorMsgList());
			RequestDispatcher rd = request.getRequestDispatcher("/jsp/register.jsp");
			rd.forward(request, response);			
		}
			
	}

}
