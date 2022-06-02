package com.spring.lmsfinal.yejinsim.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.common.Sha256;
import com.spring.lmsfinal.duHyeon.model.SubjectNoticeVO;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;
import com.spring.lmsfinal.yejinsim.model.LectureroomVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;
import com.spring.lmsfinal.yejinsim.service.InterMylectureService;

@Controller
public class MylectureController {

	@Autowired
	private InterMylectureService service;
	

	
	/// === 내 강의 목록 페이지 === /// 
	@RequestMapping(value="/mylecture.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView mylecture(ModelAndView mav, HttpServletRequest request){
		
		
		HttpSession session = request.getSession();
		
		String userid = String.valueOf(session.getAttribute("userid")) ;
	
		int userid_leng = userid.length();
		
		List<MylectureVO> mylectureList = null;
		
		if(userid_leng == 9) {
			// 학생으로 로그인했을 때
			// == 페이징 처리를 안한 검색어 없는 교수의 내 강의 목록 보여주기 == //
			mylectureList = service.stumylectureListNoSearch(userid);
			
		}
		else if(userid_leng == 5) {
			// 교수로 로그인 했을 때 
			// == 페이징 처리를 안한 검색어 없는 교수의 내 강의 목록 보여주기 == //
			mylectureList = service.mylectureListNoSearch(userid);
			
		}				

		mav.addObject("mylectureList", mylectureList);
		
		mav.setViewName("yejinsim/mylecture.tiles2");
		// /WEB-INF/views/tiles2/yejinsim/mylecture.jsp  --> 페이지 만들어야 한다.

		
		return mav;	
	}
	
	// === 내 강의실 들어가기 페이지 === //
	@RequestMapping(value="/goLecturehome.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView goLecturepage(ModelAndView mav, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		String userid = String.valueOf(session.getAttribute("userid")) ;
		int userid_leng = userid.length();
	
		String subjectid = request.getParameter("subjectid");
	//	System.out.println("확인용1 subjectid => "+subjectid);
		
		String classname = service.getClassname(subjectid);	
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subjectid", subjectid);
		paraMap.put("userid", userid);
		
		List<MylectureVO> mylectureList = null;
		
		if(userid_leng == 9) {
			
			StudentVO loginuser_student = null;
			loginuser_student = service.keepLoginStudent(paraMap);
			
			session.setAttribute("loginuser", loginuser_student);
            // session(세션)에 로그인 되어진 사용자 정보인 loginuser_student 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.

			
			// 학생으로 로그인했을 때 수강하는 강의 정보 보여주기
			mylectureList = service.stugetlectureInfo(paraMap);
			session.setAttribute("mylectureList", mylectureList);
			mav.addObject("mylectureList", mylectureList);
			
			
		}
		else if(userid_leng == 5) {
			
			GyowonVO loginuser_gyowon = null;
			loginuser_gyowon = service.keepLoginGyowon(paraMap);
            	
			session.setAttribute("loginuser", loginuser_gyowon);
            
			// 교수로 로그인 했을 때 강의하는 강의 정보 보여주기
			mylectureList = service.getlectureInfo(paraMap);
			session.setAttribute("mylectureList", mylectureList);
			mav.addObject("mylectureList", mylectureList);
			
			
		}						
		else if(userid_leng == 6) {
			AdminVO loginuser_admin = null;
			loginuser_admin = service.keepLoginAdmin(paraMap);
            
			session.setAttribute("loginuser", loginuser_admin);
			
			// 관리자로 로그인 했을 때 강의하는 강의 정보 보여주기
			mylectureList = service.getlectureInfo(paraMap);
			session.setAttribute("mylectureList", mylectureList);
			mav.addObject("mylectureList", mylectureList);
			
		}
		
		List<SubjectNoticeVO> noticeList = null;
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
		if(  subjectid != null && session.getAttribute("loginuser") != null) {
			

			mav.addObject("subjectid", subjectid);
			
			
			// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
			int totalCount = 0;        // 총 게시물 건수
			int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
			int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작 행번호
			int endRno = 0;   // 끝 행번호
			
			// 총 게시물 건수(totalCount)
			totalCount = service.getTotalNoticeCount(paraMap);
			
			// System.out.println("~~~~~ 확인용 183번 라인 totalCount : " + totalCount);
			
			totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
			
			if(str_currentShowPageNo == null) {
				// 게시판에 보여지는 초기화면
				currentShowPageNo = 1;
			}
			else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
					if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				} catch(NumberFormatException e) {
					currentShowPageNo = 1;
				}
			}
			
			
			startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
			endRno = startRno + sizePerPage - 1;
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			noticeList = service.noticeList(paraMap);
			// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			// ===  페이지바 만들기 === //
			int blockSize = 10;
			
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			// *** !! 공식이다. !! *** //
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = "noticeList.lmsfinal";
			
			// === [맨처음][이전] 만들기 === //
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				}
				
				loop++;
				pageNo++;
				
			}// end of while-----------------------
			
			// === [다음][마지막] 만들기 === //
			if( pageNo <= totalPage ) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
	//		String gobackURL = MyUtil.getCurrentURL(request);
		
	//		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
			
			// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
			///////////////////////////////////////////////////////////////
			
			mav.addObject("userid", userid);
			mav.addObject("subjectid", subjectid);
			mav.addObject("classname", classname);
			mav.addObject("noticeList", noticeList);
			
			mav.setViewName("goLecturehome.tiles3");
		}
		else {
			 mav.addObject("loc","javascript:history.back()");
			 mav.addObject("message","확인되지 않은 경로입니다."); 
			 mav.setViewName("msg");
		}
		
		return mav;
	}
	

	// === #108. 검색어 입력시 자동글 완성하기 3 === //
		@ResponseBody
		@RequestMapping(value="/lectureSearchShow.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public String wordSearchShow(HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			String userid = String.valueOf(session.getAttribute("userid"));
			
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			paraMap.put("userid", userid);
			
			List<String> lectureList = service.lectureSearchShow(paraMap);
			
			JSONArray jsonArr = new JSONArray(); // []
			
			if(lectureList != null) {
				for(String word : lectureList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("word", word);
					
					jsonArr.put(jsonObj);
				}// end of for-----------------
			}
			
			return jsonArr.toString();
		}
		
	
		
	/// === 강의 신청 목록 보기 페이지 === /// 
	@RequestMapping(value="/applylecture.lmsfinal")
	public ModelAndView applylecture(ModelAndView mav, HttpServletRequest request){
		
		HttpSession session = request.getSession();
			
		String userid = String.valueOf(session.getAttribute("userid")) ;
	//    System.out.println("확인용1 userid => "+userid);
		
		List<MylectureVO> applylectureList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String semester = request.getParameter("semester");
		String grade = request.getParameter("grade");	
		String deptname = request.getParameter("deptname");
		
		//String opensemester = request.getParameter("opensemester");
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"classname".equals(searchType) && !"subjectid".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		if(deptname == null || "".equals(deptname) || deptname.trim().isEmpty() ) {
			deptname = "";
		}
		
		String opensemester = "";
		
		if(semester == null || "".equals(semester) || semester.trim().isEmpty() ){
			if (grade == null || "".equals(grade) || grade.trim().isEmpty() ) {  
				opensemester = "";//textBox값 초기화				
			}
			else if ("1".equals(grade)){ 
				opensemester = "1,2";                
			}
			else if ("2".equals(grade)){ 
				opensemester = "3,4";                       
			}
			else if ("3".equals(grade)){ 
				opensemester = "5,6";                    
			}
			else if ("4".equals(grade)){ 
				opensemester = "7,8";                    
			}
		}	
		else if("1".equals(semester)){ // 1,3,5,7
			if (grade == null || "".equals(grade) || grade.trim().isEmpty() ) {  
				opensemester = "1,3,5,7";//textBox값 초기화				
			}
			else if ("1".equals(grade)){ 
				opensemester = "1";                
			}
			else if ("2".equals(grade)){ 
				opensemester = "3";                       
			}
			else if ("3".equals(grade)){ 
				opensemester = "5";                    
			}
			else if ("4".equals(grade)){ 
				opensemester = "7";                    
			}
		}
	    else{ // 2,4,6,8
	    	if (grade == null || "".equals(grade) || grade.trim().isEmpty() ) {  
				opensemester = "2,4,6,8";//textBox값 초기화				
			}
			else if ("1".equals(grade)){ 
				opensemester = "2";                
			}
			else if ("2".equals(grade)){ 
				opensemester = "4";                       
			}
			else if ("3".equals(grade)){ 
				opensemester = "6";                    
			}
			else if ("4".equals(grade)){ 
				opensemester = "8";                    
			}
	    } 
		  

		Map<String, String> paraMap = new HashMap<>();

		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("semester", semester);
		paraMap.put("grade", grade);
		paraMap.put("opensemester", opensemester);
		paraMap.put("userid", userid);
		paraMap.put("deptname", deptname);
		
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		
		// 교수의 총 신청강의 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
	//	System.out.println("~~~~~ 확인용 totalCount : " + totalCount);
		
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		// (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
		
		if(str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;
		System.out.println("확인 startRno"+startRno);
		System.out.println("확인 endRno"+endRno);
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		applylectureList = service.applyListSearchWithPaging(paraMap);
		// 페이징 처리한 신청강의목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		if( !"".equals(semester)  ) {
			//mav.addObject("paraMap", paraMap);
			mav.addObject("semester", semester);
			mav.addObject("userid", userid);
		}
		if( !"".equals(grade)  ) {
			//mav.addObject("paraMap", paraMap);
			mav.addObject("grade", grade);
			mav.addObject("userid", userid);
		}
		if( !"".equals(deptname)  ) {
			//mav.addObject("paraMap", paraMap);
		 	mav.addObject("deptname", deptname);
			mav.addObject("userid", userid);
		}
		
		
		// === #121. 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		/*
			        1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  21 22 23
		*/
		
		int loop = 1;
		/*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	    */
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
	
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "applylecture.lmsfinal";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&grade="+grade+"&semester="+semester+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&grade="+grade+"&semester="+semester+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&grade="+grade+"&semester="+semester+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&grade="+grade+"&semester="+semester+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&grade="+grade+"&semester="+semester+"&searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		
	 	// == 페이징 처리를 안한 검색어 없는 내 강의 목록 보여주기 == //
		// applylectureList = service.applylectureListNoSearch(userid);
			
		mav.addObject("applylectureList", applylectureList);
		mav.addObject("userid", userid);
		
		
		mav.setViewName("yejinsim/applylecture.tiles2");
		// /WEB-INF/views/tiles2/yejinsim/applylecture.jsp  --> 페이지 만들어야 한다.
		
		return mav;	
	}
	
	
	
		
	
	/// === 강의 신청하기 폼 페이지 === /// 
	@RequestMapping(value="/addlecture.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView addlecture(ModelAndView mav, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		// '교수로' '로그인 안 했으면' 돌아가게 만드는 페이지 만들 것
		
		mav.setViewName("yejinsim/addlecture.tiles2");
		// /WEB-INF/views/tiles2/yejinsim/applylecture.jsp  --> 페이지 만들어야 한다.

		
		return mav;	
	}
	
	
	// === 검색어 입력시 자동글 완성하기  === //
	@ResponseBody
	@RequestMapping(value="/deptSearchShow.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String deptSearchShow(HttpServletRequest request) {
		
	//	String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("deptname");
		
		Map<String, String> paraMap = new HashMap<>();
	//	paraMap.put("searchType", searchType);
		paraMap.put("deptname", searchWord);
		
	//	request.setAttribute("searchType", searchType);
		// 뷰단에서 선택한 검색종류 유지시키기 위함? 안 필요할지도. 
		
		List<String> deptnameList = service.deptSearchShow(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(deptnameList != null) {
			for(String word : deptnameList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("word", word);
				
				jsonArr.put(jsonObj);
			}// end of for-----------------
		}
		
		return jsonArr.toString();
	}
	
	
	// 페이징처리 안 한 검색어 있는 전체 학과 목록 보여주기 (Ajax)
	@ResponseBody
	@RequestMapping(value="/deptlist.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String deptlist(HttpServletRequest request) {
		List<MylectureVO> deptList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
	//	System.out.println("확인용1 searchType => "+searchType);
	//	System.out.println("확인용1 searchWord => "+searchWord);
			
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		deptList = service.deptListSearch(paraMap);
		

		JsonArray jsonArr = new JsonArray();  // []
		
		if( deptList != null ) {
			for(MylectureVO mylecturevo : deptList) {
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("majorid", mylecturevo.getMajorid());
				jsonObj.addProperty("deptname", mylecturevo.getDeptname());
				
				
				jsonArr.add(jsonObj);
			}// end of for---------------------
		}
		
		
		return new Gson().toJson(jsonArr);
	}
	
	
	// 학과코드에 따라 강의코드 주기 (Ajax)
	@ResponseBody
	@RequestMapping(value="/subjectidShow.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String subjectidShow(HttpServletRequest request) {
	
		String majorid = request.getParameter("majorid");
	
		
        int subjectid = service.subjectidShow(majorid);
		
        JSONObject json = new JSONObject();
    	
        json.put("subjectid", subjectid);
        /*
		if(subjectid != null) {
			for(String word : subjectid) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("word", word);
				
				json.put(jsonObj);
			}// end of for-----------------
		}*/
		
		return json.toString();
	}
	
	// 강의신청 완료 요청
	@RequestMapping(value="/addlectureEnd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView addlectureEnd(ModelAndView mav, MylectureVO mylecturevo) {
	/*
	 * 
	    form 태그의 name 명과  MylectureVO 의 필드명이 같다라면 
	    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
	        자동적으로 MylectureVO MylectureVO 에 set 되어진다.
	 */
		int n = service.addlecture(mylecturevo);  
	//	System.out.println("확인용1 n:" + n);
		
		// 강의신청 완료 후 강의실 배정 페이지로 바로 넘어가기
		String subjectid = mylecturevo.getSubjectid();
		String credit = mylecturevo.getCredit();
		mav.setViewName("redirect:/assignlectureroom.lmsfinal?subjectid="+ subjectid+"&credit="+credit);
	//<%=ctxPath%>/assignlectureroom.lmsfinal?subjectid=${requestScope.mylecturevo.subjectid}'">??
	//mav.setViewName("redirect:/view.action?seq="+seq+"&searchType="+searchType+"&searchWord="+searchWord+"&gobackURL="+gobackURL);
	 	
		return mav;
}
	
	// 강의평가 조회 
	   @RequestMapping(value="/viewlectureevaluation.lmsfinal", method = {RequestMethod.GET})
	   public ModelAndView viewlectureevaluation(ModelAndView mav, HttpServletRequest request, MylectureVO mylecturevo){
	      
	      HttpSession session = request.getSession();   
	      String userid = String.valueOf(session.getAttribute("userid"));
	      List<MylectureVO> mylectureList = (List<MylectureVO>) session.getAttribute("mylectureList");
	      
	      String subjectid = request.getParameter("subjectid");
	      
	      mav.addObject("subjectid", subjectid);
	      mav.addObject("userid", userid);
	      mav.addObject("mylectureList", mylectureList);
	      mav.setViewName("/yejinsim/viewlectureevaluation.tiles3");
	      
	      return mav;   
	   }
	
	   
	// 강의평가 결과 조회 (Ajax)
	@ResponseBody
	@RequestMapping(value="/lctrevaluresultSearch.lmsfinal", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String lctrevaluresultSearch(HttpServletRequest request){
		
	//	HttpSession session = request.getSession();	
	//	String userid = String.valueOf(session.getAttribute("userid"));
		
		String subjectid = request.getParameter("subjectid");
		
		List<MylectureVO> lctrEvaluResult = service.lctrevaluresultSearch(subjectid);
			
		JSONArray jsonArr = new JSONArray(); // []
		
		if(lctrEvaluResult != null) {
			for(MylectureVO lctrevaluresvo: lctrEvaluResult) {
				JSONObject jsonObj = new JSONObject();
						
				jsonObj.put("firstans", lctrevaluresvo.getFirstans());
				jsonObj.put("secondans", lctrevaluresvo.getSecondans());
				jsonObj.put("thirdans", lctrevaluresvo.getThirdans());
				jsonObj.put("fourans", lctrevaluresvo.getFourans());
				jsonObj.put("fiveans", lctrevaluresvo.getFiveans());
				jsonObj.put("sixans", lctrevaluresvo.getSixans());
				jsonObj.put("sevenans", lctrevaluresvo.getSevenans());
				jsonObj.put("eightans", lctrevaluresvo.getEightans());
				jsonObj.put("etcans", lctrevaluresvo.getEtcans());
				
				jsonArr.put(jsonObj);
			}// end of for-----------------
		}
		
		return jsonArr.toString();
	}
	
	
	// 강의평가의 평균값 결과 조회 (Ajax)
		@ResponseBody
		@RequestMapping(value="/lctrevaluavgresultSearch.lmsfinal", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String lctrevaluavgresultSearch(HttpServletRequest request){
			
		//	HttpSession session = request.getSession();	
		//	String userid = String.valueOf(session.getAttribute("userid"));
			
			String subjectid = request.getParameter("subjectid");
			
			List<MylectureVO> avlctrEvaluavgResult = service.lctrevaluavgresultSearch(subjectid);
				
			JSONArray jsonArr = new JSONArray(); // []
			
			if(avlctrEvaluavgResult != null) {
				for(MylectureVO lctrevaluavgresvo: avlctrEvaluavgResult) {
					JSONObject jsonObject = new JSONObject();
					
					jsonObject.put("coursecount", lctrevaluavgresvo.getCourseno());
					jsonObject.put("firstansavg", lctrevaluavgresvo.getFirstans());
					jsonObject.put("secondansavg", lctrevaluavgresvo.getSecondans());
					jsonObject.put("thirdansavg", lctrevaluavgresvo.getThirdans());
					jsonObject.put("fouransavg", lctrevaluavgresvo.getFourans());
					jsonObject.put("fiveansavg", lctrevaluavgresvo.getFiveans());
					jsonObject.put("sixansavg", lctrevaluavgresvo.getSixans());
					jsonObject.put("sevenansavg", lctrevaluavgresvo.getSevenans());
					jsonObject.put("eightansavg", lctrevaluavgresvo.getEightans());
					jsonObject.put("etcansavg", lctrevaluavgresvo.getEtcans());
					
					jsonArr.put(jsonObject);
				}// end of for-----------------
			}
			
			return jsonArr.toString();
		}
		
}
           