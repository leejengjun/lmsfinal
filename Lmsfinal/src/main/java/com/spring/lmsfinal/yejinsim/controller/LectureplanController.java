package com.spring.lmsfinal.yejinsim.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.lmsfinal.yejinsim.model.LectureplanVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;
import com.spring.lmsfinal.yejinsim.service.InterLectureplanService;

@Controller
public class LectureplanController {

	@Autowired
	private InterLectureplanService service;
	
	
	/// === 강의계획서 입력 폼페이지 요청 === /// 
	@RequestMapping(value="/addlectureplan.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView addlectureplan(ModelAndView mav, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		String gyowonid = String.valueOf(session.getAttribute("userid")) ;
		String subjectid = request.getParameter("subjectid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("gyowonid", gyowonid);
		paraMap.put("subjectid", subjectid);
		
		List<MylectureVO> lctrinfoList = null;
		
		lctrinfoList = service.lctrListSearch(paraMap);
		
		mav.addObject("lctrinfoList", lctrinfoList);
		mav.addObject("subjectid", subjectid);
		
		mav.setViewName("yejinsim/addlectureplan.tiles2");
		// /WEB-INF/views/tiles2/yejinsim/writelectureplan.jsp  --> 페이지 만들어야 한다.
		
		return mav;	
	}
	
	
	// === 강의계획서 작성 완료 요청 === //
	@RequestMapping(value="/addlctrplanEnd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView addlctrplanEnd(ModelAndView mav, LectureplanVO lectureplanvo, HttpServletRequest request) { 
		
		/*
		 * 
		    form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
		    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
		        자동적으로 BoardVO boardvo 에 set 되어진다.
		 */		
		HttpSession session = request.getSession();
		String subjectid = request.getParameter("subjectid");
		
		int n = service.addlectureplan(lectureplanvo);
		
		String seq_lectureplan = lectureplanvo.getSeq_lectureplan();
		
		mav.addObject("seq_lectureplan", seq_lectureplan);		
		mav.setViewName("yejinsim/addlectureplandetail.tiles2");
		
		return mav;
		
	}
	
	
	
	// 주차별 강의계획서 정보 입력하기
	@RequestMapping(value = "/addlectureplandetailEnd.lmsfinal", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8") 
	public ModelAndView addlectureplandetail(ModelAndView mav,HttpServletRequest request, HttpServletResponse response, LectureplanVO lectureplanvo) {
		
		HttpSession session = request.getSession();
		
		String userid = String.valueOf(session.getAttribute("userid"));		
		
		String subjectid = request.getParameter("subjectid");
		String gyowonid = request.getParameter("gyowonid");
		String seq_lectureplan = request.getParameter("seq_lectureplan");
	//	System.out.println("seq_lectureplan 확인용3 " + seq_lectureplan);
        
		String majorid = service.getmajorid(subjectid);			
		
		
		String jsonData = request.getParameter("jsonData");
   
	    jsonData = jsonData.substring(1, jsonData.length()-2);	   
	   
	    String[] arr_jsonData = jsonData.split("\\},");
	 
	    int rowLength = arr_jsonData.length;    
	   
	    for(int i=0; i<rowLength; i++) {
	          arr_jsonData[i] += "}";
	        }
	       
	    List<Map<String, Object>> resendList = new ArrayList<Map<String, Object>>();
	    Map<String, Object> paraMap = new HashMap<String, Object>();
	    
        for(String json : arr_jsonData) {
         
          JsonObject jsonObj = new Gson().fromJson(json, JsonObject.class);
          
           Map<String, Object> resendMap = new HashMap<String, Object>();
           
           
           resendMap.put("subjectid", subjectid);
           resendMap.put("gyowonid", gyowonid);
           resendMap.put("majorid", majorid);
           resendMap.put("seq_lectureplan", seq_lectureplan);
           resendMap.put("lectureweek", jsonObj.get("lectureweek").getAsInt());
           resendMap.put("lptopic", jsonObj.get("lptopic").getAsString());
           resendMap.put("lpteaching", jsonObj.get("lpteaching").getAsString());
           resendMap.put("lpmaterial", jsonObj.get("lpmaterial").getAsString());
           resendMap.put("lphomewk", jsonObj.get("lphomewk").getAsString());   	          
          
           resendList.add(resendMap);
        //   System.out.println("resendMap 확인용: "+resendMap);
       }
	       paraMap.put("resendList", resendList);	       
	   //    System.out.println("resendList 확인용: "+resendList);
	       
	       int n = service.addlctrplandetail(paraMap);
	 //      System.out.println("확인용 n1" + n);
	//     System.out.println("확인용 rowLength2" + rowLength);
	      
	       
	       if(n != rowLength) {
	    	   mav.addObject("message", "계획서 입력이 불가합니다.");
			   mav.addObject("loc", "javascript:history.back()");
			   mav.setViewName("msg");
			   
	       }
	       else {
	    	   int m = service.changeapplystate(subjectid);
	    	  
	    	   if(m == 1) {
	    		  // System.out.println("여기 들어오고 계시죠 그럼 메시지로 들어가세요 빨랑.."); // 이 문구가 출력되고 db에도 정상적으로 들어오나 아래의 절차가 진행되지 않음. 어떤 오류메세지도 없이 반응이 없음. 
	    		  mav.addObject("message", "계획서 입력 성공!!");
				  mav.addObject("loc", request.getContextPath()+"/applylecture.lmsfinal");
				  //request.getContextPath()+"/addlectureplan.lmsfinal?subjectid="+subjectid
				  //mav.setViewName("redirect:yejinsim/applylecture.tiles2");
				   
	          }
	    	   else if(m != 1) {
	    		   mav.addObject("message", "계획서 입력이 불가합니다.");
				   mav.addObject("loc", "javascript:history.back()");
	    	   }
	       }
	       mav.setViewName("msg");
	       return mav;
	}
	
	

	/// === 강의계획서 보기 === /// 
	@RequestMapping(value="/viewlectureplan.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView viewlectureplan(ModelAndView mav, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		String gyowonid = String.valueOf(session.getAttribute("userid")) ;
		String subjectid = request.getParameter("subjectid");
		String seq_lectureplan = request.getParameter("seq_lectureplan");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("gyowonid", gyowonid);
		paraMap.put("subjectid", subjectid);		
		paraMap.put("seq_lectureplan", seq_lectureplan);
		
		LectureplanVO lctrplanvo = null;
		
		lctrplanvo = service.lctrplanSearch(paraMap);
		
		
		mav.addObject("lctrplanvo", lctrplanvo);
		
		mav.setViewName("yejinsim/viewlectureplan.tiles2");
		// /WEB-INF/views/tiles2/yejinsim/viewlectureplan.jsp  --> 페이지 만들어야 한다.
		
		return mav;	
	}
	
		
		// 주차별 강의계획서 보기	
		@ResponseBody
		@RequestMapping(value="/lctrplandetailSearch.lmsfinal", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
		public String lctrevaluresultSearch(HttpServletRequest request){
			
		//	HttpSession session = request.getSession();	
		//	String userid = String.valueOf(session.getAttribute("userid"));
			
			String subjectid = request.getParameter("subjectid");
		//	System.out.println("확인해보세"+ subjectid);
			List<LectureplanVO> lctrplandetailList = service.lctrplandetailSearch(subjectid);
				
			JSONArray jsonArray = new JSONArray(); // []
			
			if(lctrplandetailList != null) {
				for(LectureplanVO lctrplandvo: lctrplandetailList) {
					JSONObject jsonObject = new JSONObject();
							
					jsonObject.put("lectureweek", lctrplandvo.getLectureweek());
					jsonObject.put("lptopic", lctrplandvo.getLptopic());
					jsonObject.put("lpteaching", lctrplandvo.getLpteaching());
					jsonObject.put("lpmaterial", lctrplandvo.getLpmaterial());
					jsonObject.put("lphomewk", lctrplandvo.getLphomewk());
			
					jsonArray.put(jsonObject);
				}// end of for-----------------
			}
			
			return jsonArray.toString();
		}
		
		
		/// === 강의실 안에서 강의계획서 보기 === /// 
		@RequestMapping(value="/viewlectureplaninlectureroom.lmsfinal", method = {RequestMethod.GET})
		public ModelAndView viewlectureplaninlectureroom(ModelAndView mav, HttpServletRequest request){
			
			HttpSession session = request.getSession();
			
			String gyowonid = String.valueOf(session.getAttribute("userid")) ;
			String subjectid = request.getParameter("subjectid");
			String seq_lectureplan = request.getParameter("seq_lectureplan");
			List<MylectureVO> mylectureList = (List<MylectureVO>) session.getAttribute("mylectureList");
		      
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("gyowonid", gyowonid);
			paraMap.put("subjectid", subjectid);		
			paraMap.put("seq_lectureplan", seq_lectureplan);
			
			LectureplanVO lctrplanvo = null;
			
			lctrplanvo = service.lctrplanSearch(paraMap);
			
			
			mav.addObject("lctrplanvo", lctrplanvo);
			mav.addObject("mylectureList", mylectureList);
		      
			mav.setViewName("yejinsim/viewlectureplan.tiles3");
			// /WEB-INF/views/tiles2/yejinsim/viewlectureplan.jsp  --> 페이지 만들어야 한다.
			
			return mav;	
		}
		
		// 강의계획서 수정하기 폼페이지 요청
		@RequestMapping(value="/editlectureplan.lmsfinal", method = {RequestMethod.GET})
		public ModelAndView editlectureplan(ModelAndView mav, HttpServletRequest request, LectureplanVO lectureplanvo){
			
			HttpSession session = request.getSession();
			String gyowonid = String.valueOf(session.getAttribute("userid")) ;
			String subjectid = request.getParameter("subjectid");
			String seq_lectureplan = request.getParameter("seq_lectureplan");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("subjectid", subjectid);		
			paraMap.put("seq_lectureplan", seq_lectureplan);
			paraMap.put("gyowonid", gyowonid);
			
			LectureplanVO lctrplanvo = null;
			
			lctrplanvo = service.lctrplanSearch(paraMap);
			
			mav.addObject("lctrplanvo", lctrplanvo);
			
			
			mav.setViewName("yejinsim/editlectureplan.tiles2");
			// /WEB-INF/views/tiles2/yejinsim/writelectureplan.jsp  --> 페이지 만들어야 한다.
			
			return mav;	
		}
		
		// 강의계획서 수정 완료하기  //
		@RequestMapping(value="/editlctrplanEnd.lmsfinal")
		public ModelAndView editlctrplanEnd(ModelAndView mav, LectureplanVO lctrplanvo, HttpServletRequest request) {
			
			String subjectid = request.getParameter("subjectid");
			String seq_lectureplan = request.getParameter("seq_lectureplan");
			
			int n = service.editlctrplan(lctrplanvo);
			
			
			System.out.println(n);
			
			if(n==0) {
				mav.addObject("message", "계획서 수정이 불가합니다.");
				mav.addObject("loc", "javascript:history.back()");
			}
			else {
				mav.addObject("message", "계획서 수정 성공!!");
				mav.addObject("loc", request.getContextPath()+"/viewlectureplan.lmsfinal?subjectid="+subjectid);
			}
			
			mav.setViewName("msg");
			
			return mav;
		}		
		
		
		// 주차별 강의계획서 수정 폼페이지 요청
		@RequestMapping(value="/editlectureplandetail.lmsfinal", method = {RequestMethod.GET})
		public ModelAndView editlectureplandetail(ModelAndView mav, HttpServletRequest request, LectureplanVO lectureplanvo){
			
			HttpSession session = request.getSession();
			String gyowonid = String.valueOf(session.getAttribute("userid")) ;
			String subjectid = request.getParameter("subjectid");
			String seq_lectureplan = request.getParameter("seq_lectureplan");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("subjectid", subjectid);		
			paraMap.put("seq_lectureplan", seq_lectureplan);
			paraMap.put("gyowonid", gyowonid);
			
			LectureplanVO lctrplanvo = null;
			
			lctrplanvo = service.lctrplanSearch(paraMap);
			
			mav.addObject("lctrplanvo", lctrplanvo);
			
			
			mav.setViewName("yejinsim/editlectureplandetail.tiles2");
			// /WEB-INF/views/tiles2/yejinsim/writelectureplan.jsp  --> 페이지 만들어야 한다.
			
			return mav;	
		}
		
				
		// 주차별 강의계획서 수정 완료하기  //
		@RequestMapping(value="/editlectureplandetailEnd.lmsfinal", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8") 
		public ModelAndView editlectureplandetailEnd(ModelAndView mav, LectureplanVO lctrplanvo, HttpServletRequest request) throws Exception {
			
			HttpSession session = request.getSession();
			
			String userid = String.valueOf(session.getAttribute("userid"));		
			
			String subjectid = request.getParameter("subjectid");
			String gyowonid = request.getParameter("gyowonid");
			String seq_lectureplan = request.getParameter("seq_lectureplan");
			System.out.println("seq_lectureplan 확인용3 " + seq_lectureplan);
	        
			String majorid = service.getmajorid(subjectid);			
			
			String jsonData = request.getParameter("jsonData");
		
			System.out.println("jsonData는??" + jsonData);
			
		    Map<String, Object> paraMap = new HashMap<String, Object>();
	   
		    jsonData = jsonData.substring(1, jsonData.length()-2);
		   
		   
		    String[] arr_jsonData = jsonData.split("\\},");
		 
		    int rowLength = arr_jsonData.length;    
		   
		    for(int i=0; i<rowLength; i++) {
		          arr_jsonData[i] += "}";
		        }
		       
		    List<Map<String, Object>> resendList = new ArrayList<Map<String, Object>>();
		         	      
		       for(String json : arr_jsonData) {
		          System.out.println("json 확인용 " + json);
		          
		          JsonObject jsonObj = new Gson().fromJson(json, JsonObject.class);
		          
		           Map<String, Object> resendMap = new HashMap<String, Object>();
		           
		           resendMap.put("seq_lectureplan", seq_lectureplan);
		        //   System.out.println("확인좀요..."+ jsonObj.get("lectureweek").getAsInt());
		           resendMap.put("subjectid", subjectid);
		           resendMap.put("majorid", majorid);
		           resendMap.put("gyowonid", gyowonid);
		           resendMap.put("lectureweek", jsonObj.get("lectureweek").getAsInt());
		           resendMap.put("lptopic", jsonObj.get("lptopic").getAsString());
		           resendMap.put("lpteaching", jsonObj.get("lpteaching").getAsString());
		           resendMap.put("lpmaterial", jsonObj.get("lpmaterial").getAsString());
		           resendMap.put("lphomewk", jsonObj.get("lphomewk").getAsString());		          
		          
		           resendList.add(resendMap);
		           System.out.println("resendMap 확인용: "+resendMap);
		       }
		       paraMap.put("resendList", resendList);	
		       
		       System.out.println("resendList 확인용: "+resendList);
		       
		       int n = service.editlctrplandetail(paraMap); // 이놈은 여기서 오류남... 
		      System.out.println("확인용!!! n1:" + n);
		      System.out.println("확인용 rowLength2!!:" + rowLength);
		       
		       
		       if(n != rowLength) {
		    	   mav.addObject("message", "주차별 강의계획서 수정이 불가합니다.");
			       mav.addObject("loc", "javascript:history.back()");
		       }
		       else {
	    		   System.out.println("여기 들어오고 계시죠 ??? 그럼 메시지로 들어가세요 빨랑..");
	    		   mav.addObject("message", "주차별 강의계획서 수정 성공!");
		           mav.addObject("loc", request.getContextPath()+"/applylecture.lmsfinal");
		       }
		       
		       mav.setViewName("msg");
		       
			 return mav; 
		}
		

		
		
		
}
