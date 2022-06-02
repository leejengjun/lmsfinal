package com.spring.lmsfinal.yejinsim.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.common.AES256;
import com.spring.lmsfinal.common.Sha256;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;
import com.spring.lmsfinal.yejinsim.model.LectureplanVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;
import com.spring.lmsfinal.yejinsim.service.InterGyowonService;

@Controller
public class GyowonController {

	@Autowired
	private InterGyowonService service;
	
	@Autowired
	private AES256 aes;

	// === 교원 개인정보 조회 페이지 요청 
	@RequestMapping(value="/gyowoninfo.lmsfinal")
	public ModelAndView gyowoninfo(ModelAndView mav, HttpServletRequest request){
		
		HttpSession session = request.getSession();	
		String gyowonid = String.valueOf(session.getAttribute("userid"));
	//	System.out.println("gyowonid확인1:"+gyowonid);
		GyowonVO gyowonvo = null;		
		
		gyowonvo = service.gyowoninfoSearch(gyowonid);
		
		String gyoemail = "";
		
		try {
			gyoemail = aes.decrypt(gyowonvo.getGyoemail());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		gyowonvo.setGyoemail(gyoemail);
		
		mav.addObject("gyowonvo", gyowonvo);
		// 이메일 어떻게 복호화하지
		
		mav.setViewName("yejinsim/gyowoninfo.tiles2");
		
		return mav;	
	}
	
	// === 교원 개인정보 수정 폼페이지 불러오기
	@RequestMapping(value="/editgyowoninfo.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView editgyowoninfo(ModelAndView mav, HttpServletRequest request){
		
		HttpSession session = request.getSession();	
		String gyowonid = String.valueOf(session.getAttribute("userid"));
	//	System.out.println("gyowonid확인1:"+gyowonid);
		
		GyowonVO gyowonvo = null;
		
		gyowonvo = service.gyowoninfoSearch(gyowonid);
		System.out.println(gyowonvo);
		
		String gyoemail = "";
		
		try {
			gyoemail = aes.decrypt(gyowonvo.getGyoemail());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		gyowonvo.setGyoemail(gyoemail);
		
		mav.addObject("gyowonvo", gyowonvo);	
			
		mav.setViewName("yejinsim/editgyowoninfo.tiles2");
		// /WEB-INF/views/tiles2/yejinsim/editgyowoninfo.jsp  --> 페이지 만들어야 한다.
		
		return mav;	
	}
	
	
	@RequestMapping(value="/emailDuplicateCheck.lmsfinal", method = {RequestMethod.POST})
	public String emailDuplicateCheck(ModelAndView mav, HttpServletRequest request){
		
		String gyoemail = request.getParameter("gyoemail");
		//	System.out.println(">>>확인용 email =>"+email);
		
		
		String isExist = service.emailDuplicateCheck(gyoemail);
		
		JSONObject json = new JSONObject();
    	
		json.put("isExist", isExist);            
        
		return json.toString();	
	}
	
		
	// 수정하기
	@RequestMapping(value="/editgyowoninfoEnd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView editEnd(ModelAndView mav, GyowonVO gyowonvo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();	
		String gyowonid = String.valueOf(session.getAttribute("userid"));
		
		String gyopwd = request.getParameter("gyopwd");
		gyopwd = Sha256.encrypt(gyopwd);
		gyowonvo.setGyopwd(gyopwd);
		String gyoemail = request.getParameter("gyoemail");
		try {
			gyoemail = aes.encrypt(gyoemail);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		gyowonvo.setGyoemail(gyoemail);
		/*
		     글 수정을 하려면 원본글의 글암호와 수정시 입력해준 암호가 일치할때만
		     글 수정이 가능하도록 해야 한다.    
		*/
		int n = service.editgyowoninfo(gyowonvo);
		// n 이 1 이라면 정상적으로 변경됨.
		// n 이 0 이라면 글수정에 필요한 글암호가 틀린경우임.
		
		if(n==0) {
			mav.addObject("message", "암호가 일치하지 않아 글 수정이 불가합니다.");
			mav.addObject("loc", "javascript:history.back()");
		}
		else {
			mav.addObject("message", "글 수정 성공!!");
			mav.addObject("loc", request.getContextPath()+"/gyowoninfo.lmsfinal?gyowonid="+gyowonvo.getGyowonid());
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
}
