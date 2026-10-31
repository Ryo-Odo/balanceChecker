package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "authenticationFilter", urlPatterns = { "/*" })
public class AuthenticationFilter implements Filter {

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		String path = request.getRequestURI().substring(request.getContextPath().length());

		if (isPublicPath(path)) {
			chain.doFilter(request, response);
			return;
		}

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			if (path.startsWith("/api/")) {
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			} else {
				response.sendRedirect(request.getContextPath() + "/login");
			}
			return;
		}

		boolean guest = Boolean.TRUE.equals(session.getAttribute("guest"));
		if (guest && isAccountManagementPath(path)) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		chain.doFilter(request, response);
	}

	private boolean isPublicPath(String path) {
		return path.equals("/login")
				|| path.equals("/guest-login")
				|| path.equals("/register")
				|| path.equals("/registerConfirm")
				|| path.startsWith("/css/")
				|| path.startsWith("/js/")
				|| path.startsWith("/images/")
				|| path.startsWith("/screenshots/")
				|| path.equals("/favicon.ico");
	}

	private boolean isAccountManagementPath(String path) {
		return path.equals("/edit") || path.equals("/editConfirm") || path.equals("/delete");
	}
}
