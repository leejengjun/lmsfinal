package com.spring.lmsfinal.choibyoungjin.controller;

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
import com.spring.lmsfinal.choibyoungjin.service.InterProfileService;

@Component
@Controller
public class ProfileController {

	@Autowired
	private InterProfileService service;
	
	
	@RequestMapping(value="/test_select.lmsfinal")
	public String test_select(HttpServletRequest request) {		
		List<TestVO> testvoList = service.test_select();
		request.setAttribute("testvoList", testvoList);
		
		return "choibyoungjin/test_select"; 
	}
		
	
	// 전체학생목록 불러오기
	@RequestMapping(value="/profile_form_vo.lmsfinal") // GET방식 및  POST방식 둘 모두 허락하는 것임.  
	public String profile_form_vo(HttpServletRequest request) {
		
		List<StudentVO> studentList = service.profile_select();
		
		request.setAttribute("studentList", studentList);
		
		return "choibyoungjin/profile_form_vo.tiles2";
	}
	
	
	// 한명의 학생정보 불러오기
	@RequestMapping(value="/profile.lmsfinal")
	public ModelAndView profile(ModelAndView mav, HttpServletRequest request) {		
		
		Map<String, Object> paraMap = new HashMap<>();
		
		mav.addObject("paraMap", paraMap);
		
		HttpSession session = request.getSession();
		StudentVO loginuser = (StudentVO) session.getAttribute("loginuser");
		
		int stdid = 0;
		if(loginuser != null) {
			stdid = loginuser.getStdid();
		}
		paraMap.put("stdid", stdid);
		
		StudentVO studentvo = service.profile_select_one(paraMap);
		
		mav.addObject("studentvo", studentvo);
		
		mav.setViewName("choibyoungjin/profile.tiles2");
				
		return mav;		
	}
	
	
	// 글 수정페이지 요청
	@RequestMapping(value="/profileEdit.lmsfinal")
	public ModelAndView profileEdit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String stdid = request.getParameter("stdid");
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("stdid", stdid);
		
		StudentVO studentvo = service.profile_select_one(paraMap); // 이미 만들어둔 글 하나만 가져오는 것

		HttpSession session = request.getSession();
		StudentVO loginuser = (StudentVO)session.getAttribute("loginuser");									
		
		mav.addObject("studentvo", studentvo);
		mav.setViewName("choibyoungjin/profileEdit.tiles2");
		
		return mav;
	}

	// 수정페이지 완료하기
	@RequestMapping(value="/profileEditEnd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView profileEditEnd(ModelAndView mav, StudentVO studentvo, HttpServletRequest request) {
		
		int n = service.profileEdit(studentvo);
		System.out.println(n);
		if(n==0) {
			mav.addObject("message", "글 수정이 실패했습니다.");
			mav.addObject("loc", "javascript:history.back()");
		}
		else {
			mav.addObject("message", "글 수정 성공!!");
			mav.addObject("loc", request.getContextPath()+"/profile.lmsfinal?stdid="+studentvo.getStdid());		
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	
}
