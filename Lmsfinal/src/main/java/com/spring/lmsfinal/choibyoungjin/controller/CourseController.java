package com.spring.lmsfinal.choibyoungjin.controller;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.choibyoungjin.model.*;
import com.spring.lmsfinal.choibyoungjin.service.InterCourseService;
import com.spring.lmsfinal.choibyoungjin.service.InterProfileService;

@Component
@Controller
public class CourseController {

	@Autowired
	private InterCourseService service;
	
	// 개설과목 불러오기
	@RequestMapping(value="/course_application.lmsfinal")
	public ModelAndView subjectInfoView(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		
		List<String> deptList = service.deptList();		
		List<String> dayList = service.dayList();
		List<String> gradeList = service.gradeList();
		List<String> classList = service.classList();
		
		String deptname = request.getParameter("deptname");
		String dayname = request.getParameter("dayname");
		String grade = request.getParameter("grade");
		String classname = request.getParameter("classname");
		String gyoname = request.getParameter("gyoname");
		String stdid = request.getParameter("stdid");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		
		if(deptname == null || "".equals(deptname) || deptname.trim().isEmpty()) {
			deptname = "";
		}
		
		if(dayname == null || "".equals(dayname) || dayname.trim().isEmpty()) {
			dayname = "";
		}
		
		if(grade == null || "".equals(grade) || grade.trim().isEmpty()) {
			grade = "";
		}
		
		if(classname == null || "".equals(classname) || classname.trim().isEmpty()) {
			classname = "";
		}
		
		if(gyoname == null || "".equals(gyoname) || gyoname.trim().isEmpty()) {
			gyoname = "";
		}
		Map<String, Object> paraMap = new HashMap<>();
		
		if(deptname != null && !"".equals(deptname)) {
			paraMap.put("deptname", deptname);
			
			request.setAttribute("deptname", deptname);
			// 뷰단에서 선택한 deptname 유지시키기 위한 것이다.
		}
		
		if(dayname != null && !"".equals(dayname)) {
			paraMap.put("dayname", dayname);
			
			request.setAttribute("dayname", dayname);
			// 뷰단에서 선택한 dayname 유지시키기 위한 것이다.
		}
		
		if(grade != null && !"".equals(grade)) {
			paraMap.put("grade", grade);
			
			request.setAttribute("grade", grade);
			// 뷰단에서 선택한 grade 유지시키기 위한 것이다.
		}
		
		if(classname != null && !"".equals(classname)) {
			paraMap.put("classname", classname);
			
			request.setAttribute("classname", classname);
			// 뷰단에서 선택한 classname 유지시키기 위한 것이다.
		}
		
		if(gyoname != null && !"".equals(gyoname)) {
			paraMap.put("gyoname", gyoname);
			
			request.setAttribute("gyoname", gyoname);
			// 뷰단에서 선택한 gyowonname 유지시키기 위한 것이다.
		}
		
		paraMap.put("stdid", stdid);
		int totalCount = 0; 		// 총 게시물 건수
		int sizePerPage = 10; 		// 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; 	// 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;			// 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0; 	// 시작 행번호
		int endRno = 0; 	// 끝 행번호
		
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
	//	System.out.println("~~~~~ 확인용 totalCount : " + totalCount);
				
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
		
		paraMap.put("totalPage", totalPage);
		paraMap.put("totalCount", totalCount);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		List<Map<String, String>> subjectList = service.subjectList(paraMap);

		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "course_application.lmsfinal";
		
		// === [맨처음][이전]만들기 === //
		if(pageNo != 1) {																		
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&dayname="+dayname+"&grade="+grade+"&classname="+classname+"&gyoname="+gyoname+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&dayname="+dayname+"&grade="+grade+"&classname="+classname+"&gyoname="+gyoname+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</a></li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&dayname="+dayname+"&grade="+grade+"&classname="+classname+"&gyoname="+gyoname+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
			
		}// end of while--------------------------------------------------
		
		
		// === [다음][맨마지막]만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&dayname="+dayname+"&grade="+grade+"&classname="+classname+"&gyoname="+gyoname+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?deptname="+deptname+"&dayname="+dayname+"&grade="+grade+"&classname="+classname+"&gyoname="+gyoname+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
				
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = com.spring.lmsfinal.common.MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		
		List<Map<String, String>> courseList = service.courseList(paraMap);
				
		request.setAttribute("deptList", deptList);
		request.setAttribute("dayList", dayList);
		request.setAttribute("gradeList", gradeList);
		request.setAttribute("classList", classList);
		request.setAttribute("subjectList", subjectList);
		request.setAttribute("courseList", courseList);
		
		mav.addObject("subjectList", subjectList);
		mav.setViewName("choibyoungjin/subjectList.tiles2");
		
		return mav;		
	}
	
	
	
	
	// 수강등록
	@RequestMapping(value="/course_submit.lmsfinal")
	public ModelAndView course_submit(ModelAndView mav, HttpServletRequest request) {			
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) { // GET 방식이라면 
			mav.setViewName("choibyoungjin/subjectList.tiles2"); 
		}
		
		else { // POST 방식이라면
			try {
				String stdid = request.getParameter("stdid");
				String subjectid = request.getParameter("subjectid");
				String majorid = request.getParameter("majorid");
				String gyowonid = request.getParameter("gyowonid");
				String completesemester = request.getParameter("completesemester");
				String courseno = request.getParameter("courseno");
				String message = "";
				
				String course_no = "";
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("stdid", stdid);
				paraMap.put("subjectid", subjectid);
				paraMap.put("majorid", majorid);
				paraMap.put("gyowonid", gyowonid);
				paraMap.put("completesemester", completesemester);
				paraMap.put("courseno", courseno);
				paraMap.put("course_no", course_no);
				
				
				int n = service.course_submit(paraMap);
				int m = 0;
				int o = 0;
				if(n==1) {
					message = "과목 신청 성공!!";
					m = service.applyperson_plus(paraMap);
				//	System.out.println(paraMap.get("course_no"));
					o = service.insertevalue(paraMap);
				}
				else {
					message = "과목 신청 실패!!";
				}
				
				request.setAttribute("message", message);
				request.setAttribute("n", n);
				request.setAttribute("m", m);
			} catch (Exception e) {
				String message = "이미 신청된 과목입니다!!";
				String loc = request.getContextPath()+"/course_application.lmsfinal";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
				return mav;
			}
			mav.setViewName("redirect:/course_application.lmsfinal");
		}
		return mav;
	}
	
	
	// 수강신청목록
	@RequestMapping(value="/mycourseList.lmsfinal")
	public String courseList(HttpServletRequest request, HttpServletResponse response) {

		List<String> creditcount = service.creditcount();
				
		String stdid = request.getParameter("stdid");
		String creditsum = request.getParameter("creditsum");
		
		Map<String, Object> paraMap = new HashMap<>();

		paraMap.put("creditsum", creditsum);
		paraMap.put("stdid", stdid);
		
		List<Map<String, String>> courseList = service.courseList(paraMap);
				
		request.setAttribute("creditsum", creditsum);
		request.setAttribute("creditcount", creditcount);
		request.setAttribute("courseList", courseList);
		
		return "choibyoungjin/courseList.tiles2";
	}
	
	
	// 등록된 수강 삭제
	@RequestMapping(value="/course_delete.lmsfinal")
	public String course_delete(HttpServletRequest request) {			
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) { // GET 방식이라면 
			return "choibyoungjin/subjectList.tiles2"; 
		}
		
		else { // POST 방식이라면
			String courseno = request.getParameter("courseno");
			String subjectid = request.getParameter("subjectid");
			String message = "";
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("courseno", courseno);
			paraMap.put("subjectid", subjectid);
			
			int n = service.course_delete(paraMap);
			int m = 0;
			if(n==1) {
				message = "과목 삭제 성공!!";
				m = service.applyperson_minus(paraMap);
			}
			else {
				message = "과목 삭제 실패!!";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("n", n);
			request.setAttribute("m", m);
			
			return "redirect:/course_application.lmsfinal";
		}
	}

}
