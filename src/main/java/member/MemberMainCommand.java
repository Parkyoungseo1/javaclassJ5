package member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import guest.GuestDAO;
//import guest.GuestVO;

public class MemberMainCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String mid = (String) session.getAttribute("sMid");
		
		MemberDAO mDao = new MemberDAO();
		MemberVO mVo = mDao.getMemberIdCheck(mid);

//		GuestDAO gDao = new GuestDAO();
//		ArrayList<GuestVO> gVos = gDao.getMemberGuestSearch(mid, mVo.getName(), mVo.getNickName());
		
		request.setAttribute("mVo", mVo);
//		request.setAttribute("guestCnt", gVos.size());
	}

}
