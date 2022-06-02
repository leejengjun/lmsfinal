package com.spring.lmsfinal.duHyeon.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.duHyeon.service.InterAchievementService;
import com.spring.lmsfinal.duHyeon.service.InterNoticeService;

@Controller
public class AchievementController {
	
	
	@Autowired
	private InterAchievementService service;
	
	@Autowired
	private InterNoticeService noticeService;
	
	
	@RequestMapping(value="/attendanceList.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_attendaceList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String subjectid = request.getParameter("subjectid");
		
		// subjectid = "11001";
		// System.out.println("achiev controller 36 번째줄 수정바람");
		
		String attendweek = request.getParameter("attendweek");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subjectid", subjectid);
		paraMap.put("attendweek", attendweek);
		
	//	System.out.println(subjectid);
	//	System.out.println(attendweek);
		
		if(attendweek == null) {
			attendweek ="1";
		}
		Map<String, String> smgMap = noticeService.getSMG(paraMap);

		smgMap.put("attendweek", attendweek);
		
		List<Map<String, String>> attList = service.getattList(smgMap);
		
		if(attList.isEmpty()) {
			// 비어있으면 그냥 학생만 따로뽑아서 넣어준뒤 받자
			attList = service.getstudentList(smgMap);
		}
		mav.addObject("subjectid", subjectid);
		mav.addObject("attList", attList);
		mav.addObject("attendweek",attendweek);
		mav.setViewName("duHyeon/achievement/attendanceList.tiles3");
		
		return mav;
	}
	
	
	@RequestMapping(value="/checkattend.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView checkattend(ModelAndView mav, HttpServletRequest request) {
		
		String subjectid = request.getParameter("subjectid");
		String attendweek = request.getParameter("attendweek");

		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subjectid", subjectid);
		
		// 수강중인 학생의 수 가져오기
		int n = service.getTotalStCount(paraMap);
		
		// System.out.println("확인용 n: " + n);
		
		for(int i = 1; i <= n; i++) {
			String courseno = request.getParameter("courseno"+i);
			String stdid = request.getParameter("stdid"+i);
			String attendance = request.getParameter("attendance"+i);
			
			String absent="";
			String tardy="";
			String attend="";
			
			if("absent".equals(attendance)) {
				absent="1";
				attend="0";
				tardy="0";
			}
			else if("tardy".equals(attendance)) {
				absent="0";
				attend="0";
				tardy="1";
			}
			else if("attend".equals(attendance)) {
				absent="0";
				attend="1";
				tardy="0";
			}
			
			paraMap.put("courseno", courseno);
			paraMap.put("stdid", stdid);
			paraMap.put("attendweek", attendweek);
			paraMap.put("absent", absent);
			paraMap.put("attend", attend);
			paraMap.put("tardy", tardy);
			

			int m = service.checkattend(paraMap);
			
			if( m != 1) {
				break;
			}
		//	System.out.println("m : "+ m);
		}
		paraMap.put("subjectid", subjectid);
		
		Map<String, String> smgMap = noticeService.getSMG(paraMap);
		if(attendweek == null) {
			attendweek ="1";
		}
		smgMap.put("attendweek", attendweek);
		
		List<Map<String, String>> attList = service.getattList(smgMap);
		
		if(attList.isEmpty()) {
			// 비어있으면 그냥 학생만 따로뽑아서 넣어준뒤 받자
			
			attList = service.getstudentList(smgMap);
			
		}
		
		mav.addObject("attList", attList);
		mav.addObject("attendweek",attendweek);
		mav.addObject("subjectid", subjectid);
		mav.setViewName("duHyeon/achievement/attendanceList.tiles3");
		
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateAtt.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView updateAtt(ModelAndView mav, HttpServletRequest request) {
	
		String courseno = request.getParameter("courseno");
		String stdid = request.getParameter("stdid");
		String attendance = request.getParameter("attendance");
		String subjectid= request.getParameter("subjectid");
		String attendweek = request.getParameter("attendweek");
		String absent="";
		String tardy="";
		String attend="";
		
		if("absent".equals(attendance)) {
			absent="1";
			attend="0";
			tardy="0";
		}
		else if("tardy".equals(attendance)) {
			absent="0";
			attend="0";
			tardy="1";
		}
		else if("attend".equals(attendance)) {
			absent="0";
			attend="1";
			tardy="0";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("courseno", courseno);
		paraMap.put("stdid", stdid);
		paraMap.put("attendance", attendance);
		paraMap.put("absent", absent);
		paraMap.put("tardy", tardy);
		paraMap.put("attendance", attend);
		paraMap.put("attendweek", attendweek);
		
		int n = service.updateAtt(paraMap);
		// 업데이트 하고 다시 리스트를 줄거임
		
		if(n == 1) {
			paraMap.put("subjectid", subjectid);
			
			Map<String, String> smgMap = noticeService.getSMG(paraMap);
			if(attendweek == null) {
				attendweek ="1";
			}
			smgMap.put("attendweek", attendweek);
			
			List<Map<String, String>> attList = service.getattList(smgMap);
			
			if(attList.isEmpty()) {
				// 비어있으면 그냥 학생만 따로뽑아서 넣어준뒤 받자
				
				attList = service.getstudentList(smgMap);
				
			}
			
			mav.addObject("attList", attList);
			mav.addObject("attendweek",attendweek);
			mav.setViewName("duHyeon/achievement/attendanceList.tiles3");
		}
		return mav;
	}
	
	
	@RequestMapping(value="/gradeResultList.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_requestgradeResultList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		String subjectid= request.getParameter("subjectid");
		
//		subjectid = "11001";
//		System.out.println("/gradeResultList.lmsfinal 222 라인 확인용  임의 subjectid 대입");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subjectid", subjectid);
		
		Map<String, String> smgMap = noticeService.getSMG(paraMap);
		

		
		// full join해서 어떤 강의를 듣고있는 모든 학생에 대한 테이블을 받아온다.
		List<Map<String, String>> graderesultList = service.getGradeResultList(smgMap);

		
		
			
		mav.addObject("graderesultList",graderesultList);
		mav.setViewName("duHyeon/achievement/creditList.tiles3");
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/detailcredit_json.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String detailcredit_json(HttpServletRequest request) {
		
		String courseno = request.getParameter("courseno");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("courseno", courseno);
		
		// 출결상태를 알아오는 메소드이다.
		List<Map<String, String>> attendCnt = service.getAttendCnt(paraMap);
/*		
		for(String a : attendCnt) {
			System.out.println(a);
		}
		확인용 잘나왔음
*/		
		
		int absent = 0;
		int attendance = 0;
		int tardy = 0;
		
		for(Map<String, String> map : attendCnt) {
			
			attendance += Integer.parseInt(map.get("attendance"));
			tardy += Integer.parseInt(map.get("tardy"));
			absent += Integer.parseInt(map.get("absent"));
			
			
			
		}

		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("attendance", String.valueOf(attendance));
		jsonObj.put("tardy", String.valueOf(tardy));
		jsonObj.put("absent", String.valueOf(absent));
		
		
		return jsonObj.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/compute_json.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String compute_json(HttpServletRequest request) {
		
		String subjectid = request.getParameter("subjectid");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subjectid", subjectid);
		
		// 정적 비율을 받아오기 위한 메소드
		Map<String, String> attendCnt = service.getCompute(paraMap);


		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("lpattendper", attendCnt.get("lpattendper"));
		jsonObj.put("lphomewkper", attendCnt.get("lphomewkper"));
		jsonObj.put("lpexamper", attendCnt.get("lpexamper"));

		return jsonObj.toString();
	}
	
	
	@RequestMapping(value="/detailcredit.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_detailcredit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	
		String courseno = request.getParameter("courseno");
		
		Map<String, String> paraMap = new HashMap<>();
		
		// 수강코드를 이용해서 subjectid를 구해올 것이다.
		paraMap.put("courseno", courseno);
		
		Map<String, String> smgMap = service.getSMG(paraMap);
		
		smgMap.put("courseno", courseno);
		
		// full join해서 어떤 강의를 듣고있는 한 학생에 대해서 가져온다.
		Map<String, String> graderesultOne = service.getGradeResult(smgMap);
		
		

		
		
		mav.addObject("graderesultOne",graderesultOne);
		mav.setViewName("duHyeon/achievement/detailcredit.tiles3");
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/updatecredit.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView updatecredit(ModelAndView mav, HttpServletRequest request) {
	
		String courseno = request.getParameter("courseno");
		String midscore = request.getParameter("midscore");
		String finalscore = request.getParameter("finalscore");
		String attscore = request.getParameter("attscore");
		String taskscore = request.getParameter("taskscore");
		String grade = request.getParameter("grade");
		String subjectid = request.getParameter("subjectid");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("courseno", courseno);
		paraMap.put("midscore", midscore);
		paraMap.put("finalscore", finalscore);
		paraMap.put("attscore", attscore);
		paraMap.put("taskscore", taskscore);
		paraMap.put("grade", grade);
		
		
		
		// 테이블에 대한 존재여부 update insert 정해야함
		// 먼저 인서트를 해보고 n값을 봐보자 
		int n = service.updatecredit(paraMap);
		
		if(n == 0) {
			// 없으니께 인서트로 들어가부러
			n = service.insertcredit(paraMap);
			n = 1;
		}
		
		// System.out.println("achie 339 번째줄 확인 : "+n);
		
		// full join해서 어떤 강의를 듣고있는 한 학생에 대해서 가져온다.
		// Map<String, String> graderesultOne = service.getGradeResult(smgMap);
		
		mav.setViewName("redirect:/gradeResultList.lmsfinal?subjectid="+subjectid);
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/testresult_json.lmsfinal", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String testresult_json(HttpServletRequest request) {
		
		String subjectid = request.getParameter("subjectid");
		String stdid = request.getParameter("stdid");
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("stdid", stdid);
		paraMap.put("subjectid", subjectid);
		
		// 테스트 라운드 리스트의 시험이름과 testclfc로 학생시험점수 테이블과 조인한뒤 점수를 input 태그에 넣어 줄 것임
		List<Map<String, String>> testList = service.getTestclfcAndScore(paraMap);
		

		
		JSONArray jsonArr = new JSONArray();
		
		for(Map<String, String> map : testList) {
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("examtitle", map.get("examtitle"));
			jsonObj.put("score", map.get("score"));
			
			jsonArr.put(jsonObj);
			
		}
		
		return jsonArr.toString();
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/checkmodal.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String checkmodal(HttpServletRequest request) {
		
		String testclfc = request.getParameter("testclfc");
		String stdid = request.getParameter("stdid");
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("stdid", stdid);
		paraMap.put("testclfc", testclfc);
		Map<String, String> testscore = service.getTestScore(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		String score = testscore.get("score");
		jsonObj.put("score", score);
		
		return jsonObj.toString();
	}
	
	
	
	
}
