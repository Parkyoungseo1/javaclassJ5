package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.mem")
public class MemberController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberInterface command = null;
		String viewPage = "/WEB-INF/member";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(com.equals("/MemberLogin")) {
			viewPage += "/memberLogin.jsp";
		}
		else if(com.equals("/MemberLoginOk")) {
			command = new MemberLoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberLogout")) {
			command = new MemberLogoutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberJoin")) {
			viewPage += "/memberJoin.jsp";
		}
		else if(com.equals("/MemberJoinOk")) {
			command = new MemberJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberIdCheck")) {
			command = new MemberIdCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MemberNickCheck")) {
			command = new MemberNickCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(level > 4) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberMain")) {
			command = new MemberMainCommand();
			command.execute(request, response);
			viewPage += "/memberMain.jsp";
		}
		else if(com.equals("/MemberList")) {
			command = new MemberListCommand();
			command.execute(request, response);
			viewPage += "/memberList.jsp";
		}
	
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
