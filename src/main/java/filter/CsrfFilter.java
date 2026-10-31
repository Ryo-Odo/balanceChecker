package filter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "csrfFilter", urlPatterns = { "/*" })
public class CsrfFilter implements Filter {
	private static final String SESSION_ATTRIBUTE = "csrfToken";
	private static final String REQUEST_PARAMETER = "_csrf";
	private static final String REQUEST_HEADER = "X-CSRF-Token";
	private static final SecureRandom RANDOM = new SecureRandom();

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		HttpSession session = request.getSession(true);
		String expectedToken = (String) session.getAttribute(SESSION_ATTRIBUTE);

		if (expectedToken == null) {
			expectedToken = createToken();
			session.setAttribute(SESSION_ATTRIBUTE, expectedToken);
		}

		if ("POST".equalsIgnoreCase(request.getMethod())) {
			String actualToken = request.getHeader(REQUEST_HEADER);
			if (actualToken == null || actualToken.isBlank()) {
				actualToken = request.getParameter(REQUEST_PARAMETER);
			}
			if (!constantTimeEquals(expectedToken, actualToken)) {
				response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token.");
				return;
			}
		}

		chain.doFilter(request, response);
	}

	private String createToken() {
		byte[] bytes = new byte[32];
		RANDOM.nextBytes(bytes);
		return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
	}

	private boolean constantTimeEquals(String expected, String actual) {
		if (actual == null) {
			return false;
		}
		return MessageDigest.isEqual(expected.getBytes(StandardCharsets.UTF_8),
				actual.getBytes(StandardCharsets.UTF_8));
	}
}
