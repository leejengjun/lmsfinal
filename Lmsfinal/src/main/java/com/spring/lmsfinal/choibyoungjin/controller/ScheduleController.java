package com.spring.lmsfinal.choibyoungjin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.choibyoungjin.model.*;
import com.spring.lmsfinal.choibyoungjin.service.InterScheduleService;
import com.spring.lmsfinal.common.MyUtil;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;

@Controller
public class ScheduleController {

	@Autowired
	private InterScheduleService service;
	
	// === 일정관리 시작 페이지 ===
	@RequestMapping(value="/schedule/scheduleManagement.lmsfinal")
	public ModelAndView requiredLogin_showSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		mav.setViewName("choibyoungjin/schedule/scheduleManagement.tiles2");

		return mav;
	}
	
	// === 공유 캘린더에 공유캘린더 소분류 추가하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/addComCalendar.lmsfinal",method = {RequestMethod.POST})
	public String addComCalendar(HttpServletRequest request) throws Throwable {
		
		String com_smcatgoname = request.getParameter("com_smcatgoname");
		String fk_userid = request.getParameter("fk_userid");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("com_smcatgoname",com_smcatgoname);
		paraMap.put("fk_userid",fk_userid);
		
		int n = service.addComCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}
	
	
	// === 내 캘린더에 내캘린더 소분류 추가하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/addMyCalendar.lmsfinal",method = {RequestMethod.POST})
	public String addMyCalendar(HttpServletRequest request) throws Throwable {
		
		String my_smcatgoname = request.getParameter("my_smcatgoname");
		String fk_userid = request.getParameter("fk_userid");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("my_smcatgoname",my_smcatgoname);
		paraMap.put("fk_userid",fk_userid);
		
		int n = service.addMyCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}
	
	
	// === 공유 캘린더에서 공유캘린더 소분류  보여주기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/showCompanyCalendar.lmsfinal",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8")  
	public String showCompanyCalendar() {
		
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showCompanyCalendar();
		
		JSONArray jsonArr = new JSONArray();
		
		if(calendar_small_category_VO_CompanyList != null) {
			for(Calendar_small_category_VO smcatevo : calendar_small_category_VO_CompanyList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}

	
	// === 내 캘린더에서 내캘린더 소분류  보여주기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/showMyCalendar.lmsfinal",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String showMyCalendar(HttpServletRequest request) {
		
		String fk_userid = request.getParameter("fk_userid");
		
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showMyCalendar(fk_userid);
		
		JSONArray jsonArr = new JSONArray();
		
		if(calendar_small_category_VO_CompanyList != null) {
			for(Calendar_small_category_VO smcatevo : calendar_small_category_VO_CompanyList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}

	
	// === 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다) ===
	@RequestMapping(value="/schedule/insertSchedule.lmsfinal",method = {RequestMethod.POST})
	public ModelAndView insertSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		// form 에서 받아온 날짜
		String chooseDate = request.getParameter("chooseDate");
		
		mav.addObject("chooseDate", chooseDate);
		mav.setViewName("choibyoungjin/schedule/insertSchedule.tiles2");
		
		return mav;
	}
	
	
	// === 일정 등록시 내캘린더,공유캘린더 선택에 따른 서브캘린더 종류를 알아오기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/selectSmallCategory.lmsfinal",method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8") 
	public String selectSmallCategory(HttpServletRequest request) {
		
		String fk_lgcatgono = request.getParameter("fk_lgcatgono"); // 캘린더 대분류 번호
		String fk_userid = request.getParameter("fk_userid");       // 사용자아이디
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("fk_userid", fk_userid);
		
		List<Calendar_small_category_VO> small_category_VOList = service.selectSmallCategory(paraMap);
			
		JSONArray jsArr = new JSONArray();
		if(small_category_VOList != null) {
			for(Calendar_small_category_VO scvo : small_category_VOList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", scvo.getSmcatgono());
				jsObj.put("smcatgoname", scvo.getSmcatgoname());
				
				jsArr.put(jsObj);
			}
		}
		
		return jsArr.toString();
	}
	
	
	// === 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/insertSchedule/searchJoinUserList.lmsfinal", produces="text/plain;charset=UTF-8")
	public String searchJoinUserList(HttpServletRequest request) {
		
		String joinUserName = request.getParameter("joinUserName");
		
		// 사원 명단 불러오기
		List<StudentVO> joinUserList = service.searchJoinUserList(joinUserName);

		JSONArray jsonArr = new JSONArray();
		if(joinUserList != null && joinUserList.size() > 0) {
			for(StudentVO mvo : joinUserList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("stdid", mvo.getStdid());
				jsObj.put("stdname", mvo.getStdname());
				
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
		
	}
	

	// === 일정 등록하기 ===
	@RequestMapping(value="/schedule/registerSchedule_end.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView registerSchedule_end(ModelAndView mav, HttpServletRequest request) throws Throwable {
		
		String startdate= request.getParameter("startdate");
   	//  System.out.println("확인용 startdate => " + startdate);
	//  확인용 startdate => 20211125140000
   	    
		String enddate = request.getParameter("enddate");
		String subject = request.getParameter("subject");
		String fk_lgcatgono= request.getParameter("fk_lgcatgono");
		String fk_smcatgono = request.getParameter("fk_smcatgono");
		String color = request.getParameter("color");
		String place = request.getParameter("place");
		String joinuser = request.getParameter("joinuser");
		
     //	System.out.println("확인용 joinuser => " + joinuser);
	 // 확인용 joinUser_es =>
	 // 또는 
	 // 확인용 joinUser_es => 이순신(leess),아이유1(iyou1),설현(seolh) 	
		
		String content = request.getParameter("content");
		String fk_userid = request.getParameter("fk_userid");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("subject", subject);
		paraMap.put("fk_lgcatgono",fk_lgcatgono);
		paraMap.put("fk_smcatgono", fk_smcatgono);
		paraMap.put("color", color);
		paraMap.put("place", place);
		
		paraMap.put("joinuser", joinuser);
		
		paraMap.put("content", content);
		paraMap.put("fk_userid", fk_userid);
		
		int n = service.registerSchedule_end(paraMap);

		if(n == 0) {
			mav.addObject("message", "일정 등록에 실패하였습니다.");
		}
		else {
			mav.addObject("message", "일정 등록에 성공하였습니다.");
		}
		
		mav.addObject("loc", request.getContextPath()+"/schedule/scheduleManagement.lmsfinal");
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	// === 모든 캘린더(공유캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@ResponseBody
	@RequestMapping(value="/schedule/selectSchedule.lmsfinal", produces="text/plain;charset=UTF-8")
	public String selectSchedule(HttpServletRequest request) {
		
		// 등록된 일정 가져오기
		
		String fk_userid = request.getParameter("fk_userid");
				
		List<Calendar_schedule_VO> scheduleList = service.selectSchedule(fk_userid);
		
		JSONArray jsArr = new JSONArray();
		
		if(scheduleList != null && scheduleList.size() > 0) {
			
			for(Calendar_schedule_VO svo : scheduleList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("subject", svo.getSubject());
				jsObj.put("startdate", svo.getStartdate());
				jsObj.put("enddate", svo.getEnddate());
				jsObj.put("color", svo.getColor());
				jsObj.put("scheduleno", svo.getScheduleno());
				jsObj.put("fk_lgcatgono", svo.getFk_lgcatgono());
				jsObj.put("fk_smcatgono", svo.getFk_smcatgono());
				jsObj.put("fk_userid", svo.getFk_userid());
				jsObj.put("joinuser", svo.getJoinuser());
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		
		}
		
		return jsArr.toString();
	}

	
	// === 일정상세보기 ===
	@RequestMapping(value="/schedule/detailSchedule.lmsfinal")
	public ModelAndView detailSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno = request.getParameter("scheduleno");
		
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_schedule = request.getParameter("listgobackURL_schedule");
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);

		
		// 일정상세보기에서 일정수정하기로 넘어갔을 때 필요함
		String gobackURL_detailSchedule = MyUtil.getCurrentURL(request);
		mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
		
		try {
			Integer.parseInt(scheduleno);
			Map<String,String> map = service.detailSchedule(scheduleno);
			mav.addObject("map", map);
			mav.setViewName("choibyoungjin/schedule/detailSchedule.tiles2");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/scheduleManagement.lmsfinal");
		}
		
		return mav;
	}

	
	// === 일정삭제하기 ===
	@ResponseBody
	@RequestMapping(value="/schedule/deleteSchedule.lmsfinal", method = {RequestMethod.POST})
	public String deleteSchedule(HttpServletRequest request) throws Throwable {
		
		String scheduleno = request.getParameter("scheduleno");
				
		int n = service.deleteSchedule(scheduleno);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}

	
	// === 일정 수정하기 ===
	@RequestMapping(value="/schedule/editSchedule.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno= request.getParameter("scheduleno");
   		
		try {			
			Integer.parseInt(scheduleno);
			String gobackURL_detailSchedule = request.getParameter("gobackURL_detailSchedule");
			
			HttpSession session = request.getSession();
			StudentVO loginuser = (StudentVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.detailSchedule(scheduleno);
			
			if( !loginuser.getUserid().equals( map.get("FK_USERID") ) ) {
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
				mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
				
				mav.setViewName("choibyoungjin/schedule/editSchedule.tiles2");
			}
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/scheduleManagement.lmsfinal");
		}
		
		return mav;
		
	}
	
	// === 일정 수정하기 교수용 ===
	@RequestMapping(value="/schedule/editSchedule_gyowon.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView editSchedule_gyowon(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno= request.getParameter("scheduleno");
   		
		try {			
			Integer.parseInt(scheduleno);
			String gobackURL_detailSchedule = request.getParameter("gobackURL_detailSchedule");
			
			HttpSession session = request.getSession();
			GyowonVO loginuser = (GyowonVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.detailSchedule(scheduleno);
			
			if( !loginuser.getUserid().equals( map.get("FK_USERID") ) ) {
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
				mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
				
				mav.setViewName("choibyoungjin/schedule/editSchedule_gyowon.tiles2");
			}
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/scheduleManagement.lmsfinal");
		}
		
		return mav;
		
	}
	
	// === 일정 수정 완료하기 ===
	@RequestMapping(value="/schedule/editSchedule_end.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView editSchedule_end(Calendar_schedule_VO svo, HttpServletRequest request, ModelAndView mav) {
		
		try {
			 int n = service.editSchedule_end(svo);
			 
			 if(n==1) {
				 mav.addObject("message", "일정을 수정하였습니다.");
				 mav.addObject("loc", request.getContextPath()+"/schedule/scheduleManagement.lmsfinal");
			 }
			 else {
				 mav.addObject("message", "일정 수정에 실패하였습니다.");
				 mav.addObject("loc", "javascript:history.back()");
			 }
			 
			 mav.setViewName("msg");
		} catch (Throwable e) {	
			e.printStackTrace();
			mav.setViewName("redirect:/schedule/scheduleManagement.lmsfinal");
		}
			
		return mav;
	}

	
	// === (공유캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기  === 	
	@ResponseBody
	@RequestMapping(value="/schedule/deleteSubCalendar.lmsfinal", method = {RequestMethod.POST})
	public String deleteSubCalendar(HttpServletRequest request) throws Throwable {
		
		String smcatgono = request.getParameter("smcatgono");
				
		int n = service.deleteSubCalendar(smcatgono);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}


	// === (공유캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기 === 
	@ResponseBody
	@RequestMapping(value="/schedule/editCalendar.lmsfinal", method = {RequestMethod.POST})
	public String editComCalendar(HttpServletRequest request) throws Throwable {
		
		String smcatgono = request.getParameter("smcatgono");
		String smcatgoname = request.getParameter("smcatgoname");
		String userid = request.getParameter("userid");
		String caltype = request.getParameter("caltype");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("smcatgono", smcatgono);
		paraMap.put("smcatgoname", smcatgoname);
		paraMap.put("userid", userid);
		paraMap.put("caltype", caltype);
		
		int n = service.editCalendar(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}

	
	// === 검색 기능 === //
	@RequestMapping(value="/schedule/searchSchedule.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		List<Map<String,String>> scheduleList = null;
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String fk_userid = request.getParameter("fk_userid");  // 로그인한 사용자id
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_sizePerPage = request.getParameter("sizePerPage");
	
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");
		
		if(searchType==null || (!"subject".equals(searchType) && !"content".equals(searchType)  && !"joinuser".equals(searchType))) {  
			searchType="";
		}
		
		if(searchWord==null || "".equals(searchWord) || searchWord.trim().isEmpty()) {  
			searchWord="";
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
			
		if(str_sizePerPage == null || "".equals(str_sizePerPage) || 
		   !("10".equals(str_sizePerPage) || "15".equals(str_sizePerPage) || "20".equals(str_sizePerPage))) {
				str_sizePerPage ="10";
		}
		
		if(fk_lgcatgono == null ) {
			fk_lgcatgono="";
		}
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("str_sizePerPage", str_sizePerPage);

		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		
		int totalCount=0;          // 총 게시물 건수		
		int currentShowPageNo=0;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage=0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		int sizePerPage = Integer.parseInt(str_sizePerPage);  // 한 페이지당 보여줄 행의 개수
		int startRno=0;            // 시작 행번호
	    int endRno=0;              // 끝 행번호 
	    
	    // 총 일정 검색 건수(totalCount)
	    totalCount = service.getTotalCount(paraMap);
	//  System.out.println("~~~ 확인용 총 일정 검색 건수 totalCount : " + totalCount);
      
	    totalPage = (int)Math.ceil((double)totalCount/sizePerPage); 

		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo=1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	      
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    	   
	    scheduleList = service.scheduleListSearchWithPaging(paraMap);
	    // 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
		
		mav.addObject("paraMap", paraMap);
		// 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		
		// === 페이지바 만들기 === //
		int blockSize= 5;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	   
		String pageBar = "<ul style='list-style:none;'>";
		
		String url = "searchSchedule.lmsfinal";
		
		// === [맨처음][이전] 만들기 ===
		if(pageNo!=1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while(!(loop>blockSize || pageNo>totalPage)) {
			
			if(pageNo==currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
		}// end of while--------------------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_userid="+fk_userid+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		pageBar += "</ul>";
		
		mav.addObject("pageBar",pageBar);
		
		String listgobackURL_schedule = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~ 확인용 검색 listgobackURL_schedule : " + listgobackURL_schedule);
		
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		mav.addObject("scheduleList", scheduleList);
		mav.setViewName("choibyoungjin/schedule/searchSchedule.tiles2");

		return mav;
	}

}
