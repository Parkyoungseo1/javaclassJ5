package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardInterface command = null;
		String viewPage = "/WEB-INF/board";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증....처리.....
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(level > 4) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardList")) {
			command = new BoardListCommand();
			command.execute(request, response);
			viewPage += "/boardList.jsp";
		}
		else if(com.equals("/BoardInput")) {
			viewPage += "/boardInput.jsp";
		}
		else if(com.equals("/BoardInputOk")) {
			command = new BoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardContent")) {
			command = new BoardContentCommand();
			command.execute(request, response);
			viewPage += "/boardContent.jsp";
		}
		else if(com.equals("/BoardUpdate")) {
			command = new BoardUpdateCommand();
			command.execute(request, response);
			viewPage += "/boardUpdate.jsp";
		}
		else if(com.equals("/BoardUpdateOk")) {
			command = new BoardUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardDelete")) {
			command = new BoardDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardGoodCheck")) {
			command = new BoardGoodCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/BoardGoodCheck2")) {
			command = new BoardGoodCheck2Command();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/BoardGoodCheckPlusMinus")) {
			command = new BoardGoodCheckPlusMinusCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/BoardSearchList")) {
			command = new BoardSearchListCommand();
			command.execute(request, response);
			viewPage += "/boardSearchList.jsp";
		}
		else if(com.equals("/BoardReplyInput")) {
			command = new BoardReplyInputCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/BoardReplyDelete")) {
			command = new BoardReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);		
	}
}
