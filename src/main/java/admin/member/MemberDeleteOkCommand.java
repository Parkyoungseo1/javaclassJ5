package admin.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class MemberDeleteOkCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		AdminDAO dao = new AdminDAO();
		
		int res = dao.MemberDeleteOk(idx);
		
		String str = "";
		if(res != 0) str = "1";
		else str = "0";
		
		response.getWriter().write(str);
	}

}
