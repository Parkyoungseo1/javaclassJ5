package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminContentCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		
		int mCount = dao.getNewMemberListCount();
		int rCount = dao.getMemberReportListCount();
		int bCount = dao.getMemberBoardNewListCount();
		
		request.setAttribute("mCount", mCount);
		request.setAttribute("rCount", rCount);
		request.setAttribute("bCount", bCount);
	}

}
