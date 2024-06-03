package board;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardInputOkCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/member");
		int maxSize = 1024 * 1024 * 30;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		String file = "";
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		int price = request.getParameter("price")==null ? 0 : Integer.parseInt(request.getParameter("price"));
		String openSw = request.getParameter("openSw")==null ? "" : request.getParameter("openSw");
		String part = request.getParameter("part")==null ? "거래분류" : request.getParameter("part");
		
		BoardVO vo = new BoardVO();
		
		vo.setMid(mid);
		vo.setNickName(nickName);
		title = title.replace("<", "&lt;").replace(">", "&gt;");
		vo.setTitle(title);
		vo.setContent(content);
		vo.setPrice(price);
		vo.setOpenSw(openSw);
		vo.setPart(part);
		
		BoardDAO dao = new BoardDAO();
		
		int res = dao.setBoardInput(vo);
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 등록되었습니다.");
			request.setAttribute("url", "BoardList.bo");
		}
		else {
			request.setAttribute("message", "게시글 등록실패~");
			request.setAttribute("url", "BoardInput.bo");
		}
	}

}
