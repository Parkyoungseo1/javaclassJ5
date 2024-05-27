package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import common.Pagination;

public class BoardListCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자는 모든글 보여주고, 관리자외에는 숨긴글과 차단글(신고글)은 보여주지않게한다. 단, 자신이 작성한글은 볼수 있게한다.
		// 이것을 view에서(boardList.jsp)에서 처리하면 한페이지분량이 맞지않기에 sql문에서 처리해서 넘겨주도록 한다.
		// contentsShow변수 : 관리자는 'adminOK'로, 일반사용자는 자신의 아이디로 부여한다. (즉, recordShow='adminOK'는 모든글보기, 일반 아이디는 숨긴글(openSW='NO')과 차단글(complaint='OK')은 보여주지않기(즉, 자신만 보기)
		HttpSession session = request.getSession();
		int level = (int) session.getAttribute("sLevel");
		String contentsShow = "";
		if(level == 0) contentsShow = "adminOK";
		else contentsShow = (String) session.getAttribute("sMid");
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		
		//Pagination.pageChange(request, pag, pageSize, contentsShow, "board", "");
	}

}
