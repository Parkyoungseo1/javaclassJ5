package admin.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.AdminDAO;
import admin.AdminInterface;

public class MemberLevelSelectCheckCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idxSelectArray = request.getParameter("idxSelectArray")==null ? "" : request.getParameter("idxSelectArray");
		int levelSelect = request.getParameter("levelSelect")==null ? 999 : Integer.parseInt(request.getParameter("levelSelect"));
		
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		AdminDAO dao = new AdminDAO();
		
		String str = "0";
		for(String idxSelect : idxSelectArrays) {
			dao.setMemberLevelChange(Integer.parseInt(idxSelect), levelSelect);
			str = "1";
		}
		
		response.getWriter().write(str);
	}

}
