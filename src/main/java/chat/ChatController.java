package chat;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.chat")
public class ChatController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ChatInterface command = null;
		String viewPage = "/WEB-INF/chat";

		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(com.equals("/Chat")) {
			System.out.println("ㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇㅎㅇ");
			String mid = String.valueOf(session.getAttribute("sMid"));
			
			// 세션에 아이디 정보가 없다. 즉 로그인을 하지 않은 상태일때는 예외처리가 필요함. if 조건 필요
			
			viewPage += "/ChatWindow.jsp?chatId="+mid;
		}
	
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}