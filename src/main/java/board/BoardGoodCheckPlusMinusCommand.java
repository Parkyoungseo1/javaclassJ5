package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardGoodCheckPlusMinusCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int goodCnt = request.getParameter("goodCnt")==null ? 0 : Integer.parseInt(request.getParameter("goodCnt"));
		
		BoardDAO dao = new BoardDAO();
		
		// 좋아요수 증가/감소 처리
		dao.setBoardGoodCheckPlusMinus(idx, goodCnt);
		
		//response.getWriter().write("1");
	}

}
