package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MemberUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/member/");
		int maxSize = 1024 * 1024 * 2;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		// 회원 사진 업로드 되었는지 여부 처리? 업로드된 파일이 있으면 서버에 저장된 이름을, 없으면 기존파일명을 fsName변수에 저장한다.
		String photo = multipartRequest.getFilesystemName("fName");
		String fName = multipartRequest.getParameter("photo");
		if(photo == null) photo = fName;
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String sNickName = (String) session.getAttribute("sNickName");
		
		String nickName = multipartRequest.getParameter("nickName")==null? "" : multipartRequest.getParameter("nickName");
		String name = multipartRequest.getParameter("name")==null? "" : multipartRequest.getParameter("name");
		String gender = multipartRequest.getParameter("gender")==null? "" : multipartRequest.getParameter("gender");
		String birthday = multipartRequest.getParameter("birthday")==null? "" : multipartRequest.getParameter("birthday");
		String tel = multipartRequest.getParameter("tel")==null? "" : multipartRequest.getParameter("tel");
		String address = multipartRequest.getParameter("address")==null? "" : multipartRequest.getParameter("address");
		String email = multipartRequest.getParameter("email")==null? "" : multipartRequest.getParameter("email");
		//String photo = multipartRequest.getParameter("photo")==null? "noimage.jpg" : multipartRequest.getParameter("photo");
		String content = multipartRequest.getParameter("content")==null? "" : multipartRequest.getParameter("content");
		String userInfor = multipartRequest.getParameter("userInfor")==null? "" : multipartRequest.getParameter("userInfor");
		
		// DB에 저장시킨자료중 not null 데이터는 Back End 체크시켜준다.
		// 닉네임 중복체크....
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberNickCheck(nickName);
		
		// 세션의 닉네임과 앞에서 넘어온 닉네임을 비교해서 같지 않으면 사용자가 닉네임을 수정한 것이다.
		if(!nickName.equals(sNickName)) {
			if(vo.getNickName() != null) {
				request.setAttribute("msg", "이미 사용중인 닉네임 입니다.");
				request.setAttribute("url", "MemberJoin.mem");
				return;
			}
		}
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장처리한다.
		vo = new MemberVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setPhoto(photo);
		vo.setContent(content);
		vo.setUserInfor(userInfor);
		System.out.println("vo : " + vo);
		int res = dao.setMemberUpdateOk(vo);
		
		if(res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			request.setAttribute("message", "회원 정보가 수정되었습니다.");
			request.setAttribute("url", "MemberMain.mem");
		}
		else {
			request.setAttribute("message", "회원정보 수정 실패~~");
			request.setAttribute("url", "MemberUpdate.mem");
		}
	}

}
