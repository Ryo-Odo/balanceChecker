package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.User;

@WebServlet(name = "guestLogin", urlPatterns = { "/guest-login" })
public class GuestLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession oldSession = request.getSession(false);
		if (oldSession != null) {
			oldSession.invalidate();
		}

		HttpSession session = request.getSession(true);
		session.setAttribute("user", new User("guest", null, "ゲスト"));
		session.setAttribute("guest", Boolean.TRUE);
		response.sendRedirect(request.getContextPath() + "/home");
	}
}
