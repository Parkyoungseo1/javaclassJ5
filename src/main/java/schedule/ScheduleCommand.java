package schedule;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ScheduleCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 오늘날짜 처리(저장)
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		// 화면에 보여줄 해당 '년/월'을 셋팅
		int yy = request.getParameter("yy")==null ? toYear : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null ? toMonth : Integer.parseInt(request.getParameter("mm"));
		
		// 이전월 클릭시 1월(0)은 음수가 넘어오기에, 년도를 -1로 빼주고, 월은 12월(11)로 셋팅해준다.
		// 다음월 클릭시 12월(11)은 13월(12)이 넘어오기에, 년도를 +1로 빼주고, 월은 1월(0)로 셋팅해준다.
		if(mm < 0) {
			yy--;
			mm = 11;
		}
		if(mm > 11) {
			yy++;
			mm = 0;
		}
		
		// 선택한 해당 '년/월'의 1일을 기준으로 날짜를 세팅해준다.(처음(첫) 날짜 셋팅 : '년/월/1'로 셋팅한다.)
		calToday.set(yy, mm, 1);
		
		// 앞에서 셋팅된 해당 '년/월/1'의 요일에 해당하는 값을 숫자로 가져온다.(일:1, 월:2, 화:3, 수:4,~~) : 날짜를 표시할 시작테이블의 1일이 들어갈 첫 열을 찾기위함
		int startWeek = calToday.get(Calendar.DAY_OF_WEEK);
		
		// 해당 '년/월'의 마지막 일자를 가져온다.
		int lastDay = calToday.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 화면에 보여줄 달력의 해당 내역(년/월/요일숫자/마지막일자)을 저장소에 담아서 넘겨준다.
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		// 오늘 날짜를 저장소에 담아서 전송한다.
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		
		// 현재달을 기준으로 전월/다음월 을 구하여 저장소에 담아서 넘겨준다.
		
		// 앞에서 셋팅한 '년/월'의 앞쪽셀은 이전달 마지막일수를...
		int prevYear = yy;
		int prevMonth = mm - 1;
		int nextYear = yy;
		int nextMonth = mm + 1;
		
		if(prevMonth == -1) {
			prevYear--;
			prevMonth = 11;
		}
		if(nextMonth == 12) {
			nextYear++;
			nextMonth = 0;
		}
		
		// 현재월의 이전월에 해당하는 마지막 날짜를 구한다.
		calToday.set(prevYear, prevMonth, 1);
		int prevLastDay = calToday.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 다음월의 1일에 해당하는 요일을 숫자로 구한다.
		calToday.set(nextYear, nextMonth, 1);
		int nextStartWeek = calToday.get(Calendar.DAY_OF_WEEK);
		
		// 현재달의 '전월/다음월'의 변수를 저장해서 넘겨준다.
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("prevLastDay", prevLastDay);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
		// DB에 저장된 일정 정보들을 가져와서 저장소에 담아준다.
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");

		// 2024-5 ==>> 2024-05
		String ym = "";
		if((mm+1) < 10) ym = yy + "-0" + (mm+1);
		else ym = yy + "-" + (mm+1);
		
		ScheduleDAO dao = new ScheduleDAO();
		
		ArrayList<ScheduleVO> vos = dao.getScheduleList(mid, ym, 0);	// 0:partCnt, 1은 내역(list)
		
		request.setAttribute("vos", vos);
	}

}
