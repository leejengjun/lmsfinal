package com.spring.lmsfinal.yejinsim.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.spring.lmsfinal.yejinsim.model.LectureroomVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;
import com.spring.lmsfinal.yejinsim.service.InterLectureroomService;

@Controller
public class LectureroomController {

	@Autowired
	private InterLectureroomService service;
	
	
	// 강의코드에 따라 강의실 배정 정보 보여주기 (ajax)
	@ResponseBody
	@RequestMapping(value="/timetableListSearch.lmsfinal", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String timetableListSearch(HttpServletRequest request) {
	
		String subjectid = request.getParameter("subjectid");
		
		List<LectureroomVO> timetableList  = service.timetableListSearch(subjectid);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(timetableList != null) {
			for(LectureroomVO ttlctrrvo : timetableList) {
				JSONObject jsonObj = new JSONObject();
				
				
				jsonObj.put("totalperson", ttlctrrvo.getSeq_lctrid());				
				jsonObj.put("dayid", ttlctrrvo.getDayid());
				jsonObj.put("lctrid", ttlctrrvo.getLctrid());
				
				jsonArr.put(jsonObj);
			}// end of for-----------------
		}
		
		return jsonArr.toString();	
	}

	
	@RequestMapping(value="/assignlectureroom.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public ModelAndView assignlectureroom(ModelAndView mav,HttpServletRequest request, LectureroomVO lectureroomvo) {
		// 강의신청목록에서 강의실 배정 버튼을 누르면 그 행의 studentid를 추출해서 가져온다.
		String subjectid = request.getParameter("subjectid");
	//	System.out.println("확인용 subjectid:" + subjectid);
		String credit = request.getParameter("credit");
	//	System.out.println("확인용 credit:" + credit);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("subjectid", subjectid);
		paraMap.put("credit", credit);
		
		List<LectureroomVO> buildingList = null;
		
	 	// == 건물 목록 보여주기 == //
		buildingList = service.buildingListSearch(paraMap);	

		mav.addObject("buildingList", buildingList);
		
		mav.setViewName("yejinsim/assignlectureroom.tiles2");
		// /WEB-INF/views/assignlectureroom.jsp  --> 페이지 만들어야 한다.

		return mav;		
	}
	
	
	// 건물번호에 따라 강의실 목록 보여주기 (Ajax)
	@ResponseBody
	@RequestMapping(value="/lectureroomSearch.lmsfinal", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String lectureroomSearch(HttpServletRequest request) {
	
		String buildno = request.getParameter("buildno");
		
		List<LectureroomVO> lectureroomList  = service.lectureroomSearch(buildno);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(lectureroomList != null) {
			for(LectureroomVO lctrrvo : lectureroomList) {
				JSONObject jsonObj = new JSONObject();
				
				
				jsonObj.put("seq_lctrid", lctrrvo.getSeq_lctrid());				
				jsonObj.put("lctrid", lctrrvo.getLctrid());
				jsonObj.put("maxperson", lctrrvo.getMaxperson());
				
				jsonArr.put(jsonObj);
			}// end of for-----------------
		}
		
		return jsonArr.toString();	
	}
	
	
	// 강의실에 따라서 시간표 배열 가져오기(Ajax)
	@ResponseBody
	@RequestMapping(value="/lctrtimetableSearch.lmsfinal", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String lctrtimetableSearch(HttpServletRequest request) {
//	public void lctrtimetableSearch(@RequestParam("seq_lctrassign") String seq_lctrassign) { 
			
	//	System.out.println(seq_lctrassign); 
		String seq_lctrid = request.getParameter("seq_lctrid");
		
		List<LectureroomVO> lctrroomtimetable  = service.lctrroomtimetableSearch(seq_lctrid);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(lctrroomtimetable != null) {
			for(LectureroomVO lctrrvo : lctrroomtimetable) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("periodid", lctrrvo.getPeriodid());
				jsonObj.put("dayid", lctrrvo.getDayid());
				jsonObj.put("seq_lctrassign", lctrrvo.getSeq_lctrassign());	
				jsonObj.put("emptystate", lctrrvo.getEmptystate());
		            

				jsonArr.put(jsonObj);
			}// end of for-----------------
		}
		
		return jsonArr.toString();	
	}
	
	
	// 강의실, 강의정원 배정하기
	@ResponseBody
	@RequestMapping(value="/assignlectureroom.lmsfinal", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")	
	public ModelAndView assignlectureroom(HttpServletRequest request, ModelAndView mav) throws Exception {


		String subjectid = request.getParameter("subjectid");
		String totalperson = request.getParameter("totalperson");

	//	System.out.println("컨틀롤러 확인 subjectid :"+ subjectid);
	//	System.out.println("컨틀롤러 확인 totalperson :"+ totalperson);
	
		
	//	List<String> seq_lctraasignList = service.seq_lctraasignList();
		String str_Seq_lctraasign = request.getParameter("str_Seq_lctraasign");
	//	System.out.println("~~~확인용 str_Seq_lctraasign =>" +str_Seq_lctraasign);
		
		Map<String, Object> paraMap = new HashMap<>();
		
		if(str_Seq_lctraasign != null && !"".equals(str_Seq_lctraasign)) {
			String[] arr_Seq_lctraasign = str_Seq_lctraasign.split("\\,");	
			paraMap.put("arr_Seq_lctraasign", arr_Seq_lctraasign);
			
			//request.setAttribute("str_DeptId", str_DeptId);
			// 뷰단에서 체크되어진 값을 유지시키기위한 것이다.
		}
		
	 	paraMap.put("totalperson",totalperson);
	 	paraMap.put("subjectid",subjectid);
	
	 	// 강의실 배정하기
	 	int n = service.assignlectureroom(paraMap);
	 //	System.out.println("n controller단 :" + n);
	    
	    // 강의 정원 정하기 
	 	int m = service.assignlectureperson(paraMap);
	 	
	    if(n==3) {
	    	if(m!=1) {
	    		mav.addObject("message", "강의실 배정은 성공했으나 강의정원 배정이 불가합니다.");
				mav.addObject("loc", "javascript:history.back()");
	    	}
	    	else {
	    		mav.addObject("message", "강의실, 강의정원 배정 성공!!");
	    		mav.addObject("loc", request.getContextPath()+"/addlectureplan.lmsfinal?subjectid="+subjectid);
	    	}
	    }
		else {
			mav.addObject("message", "강의실 배정이 불가합니다.");
			mav.addObject("loc", "javascript:history.back()");
		}

	    mav.setViewName("msg");
	    
	    return mav; 
	    }
	
	
}
