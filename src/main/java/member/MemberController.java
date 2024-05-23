package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.mem")
public class MemberController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		String viewPage = "/WEB-INF/member";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		if(com.equals("/MemberLogin")) {
			viewPage += "/memberLogin.jsp";
		}
		else if(com.equals("/MemberLoginOk")) {
			command = new MemberLoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
	
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
