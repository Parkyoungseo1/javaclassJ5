package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberLogoutCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String nickName = (String) session.getAttribute("sNickName");
		
		session.invalidate();
		
		request.setAttribute("message", nickName+"님 로그아웃 되셨습니다.");
		request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
	}

}
