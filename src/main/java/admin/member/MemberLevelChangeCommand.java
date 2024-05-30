package admin.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class MemberLevelChangeCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int level = request.getParameter("level")==null ? 999 : Integer.parseInt(request.getParameter("level"));
		
		AdminDAO dao = new AdminDAO();
		
		int res = dao.setMemberLevelChange(idx, level);
		
		response.getWriter().write(res + "");
	}

}
