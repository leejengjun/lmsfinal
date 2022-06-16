package com.spring.lmsfinal.wonhyejin.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.lmsfinal.common.AES256;
import com.spring.lmsfinal.common.MyUtil;
import com.spring.lmsfinal.common.Sha256;
import com.spring.lmsfinal.wonhyejin.model.StudentVO;
import com.spring.lmsfinal.wonhyejin.service.InterStudentService;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;


@Component
@Controller
public class StudentController {

   @Autowired
   private InterStudentService service;

   @Autowired
   private AES256 aes;


// == 학생 등록 폼 == //
   @RequestMapping(value = "/stdRegister.lmsfinal", method = { RequestMethod.GET })
   public ModelAndView stdRegister(ModelAndView mav) {

      mav.setViewName("wonhyejin/studentRegister.tiles2");
   
      return mav;
   }
   
   
   
	// 전체 학과 목록 보여주기
	@ResponseBody
	@RequestMapping(value="/stdDeptlist.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String stdDeptlist(HttpServletRequest request) {
		List<StudentVO> stdDeptlist = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
	
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		stdDeptlist = service.stdDeptlistSearch(paraMap);
		

		JsonArray jsonArr = new JsonArray();  // []
		
		if( stdDeptlist != null ) {
			for(StudentVO studentvo : stdDeptlist) {
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("majorid", studentvo.getMajorid());
				jsonObj.addProperty("deptname", studentvo.getDeptname());
				
				jsonArr.add(jsonObj);
			}// end of for---------------------
		}
		
		return new Gson().toJson(jsonArr);  //  위에 Gson gson = new Gson(); 를 삭제
	}
	
	
	
	//  전체 교원번호 목록 보여주기 
		@ResponseBody
		@RequestMapping(value="/stdGyowonlist.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
		public String stdGyowonlist(HttpServletRequest request) {
			List<StudentVO> stdGyowonlist = null;
			
			String searchType_1 = request.getParameter("searchType_1");
			String searchWord_1 = request.getParameter("searchWord_1");
			
			if(searchType_1 == null) {
				searchType_1 = "";
			}
			
			if(searchWord_1 == null) {
				searchWord_1 = "";
			}
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType_1", searchType_1);
			paraMap.put("searchWord_1", searchWord_1);
			
			stdGyowonlist = service.stdGyowonlistSearch(paraMap);
			

			JsonArray jsonArr = new JsonArray();  // []
			
			if( stdGyowonlist != null ) {
				for(StudentVO studentvo : stdGyowonlist) {
					JsonObject jsonObj = new JsonObject();
					jsonObj.addProperty("gyowonid", studentvo.getGyowonid());
					jsonObj.addProperty("majorid", studentvo.getMajorid());
					jsonObj.addProperty("gyoname", studentvo.getGyoname());
					jsonObj.addProperty("deptname", studentvo.getDeptname());
					
					jsonArr.add(jsonObj);
				}// end of for---------------------
			}
			
			return new Gson().toJson(jsonArr);
		}
	

// == 학생 등록 하기 == //
	   @RequestMapping(value = "/stdRegisterEnd.lmsfinal", method = { RequestMethod.POST })
	   public ModelAndView stdRegisterEnd(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
  
		      String stdid = request.getParameter("stdid"); // 학번
		      String stdpwd = request.getParameter("stdpwd"); // 비밀번호
		      String stdname = request.getParameter("stdname"); // 이름
		      String stdjumin = request.getParameter("stdjumin"); // 주민등록번호
		      String stdbirthday = request.getParameter("stdbirthday"); // 생년월일
		      String stdemail = request.getParameter("stdemail"); // 이메일
		      String stdmobile = request.getParameter("stdmobile"); // 연락처
		      String stdmajorid = request.getParameter("stdmajorid"); // 학과코드
		      String gyowonid = request.getParameter("gyowonid"); //교원번호
		      String enttype = request.getParameter("enttype"); // 입학전형
		      String entstate = request.getParameter("entstate"); // 입학구분
		      String entday = request.getParameter("entday"); // 입학일자
		      String stdstateid = request.getParameter("stdstateid"); // 학적상태코드
		      
		     
		
		      Map<String, String> paraMap = new HashMap<>();
		
		      paraMap.put("stdid", stdid);
		      paraMap.put("stdpwd", Sha256.encrypt(stdpwd));
		      paraMap.put("stdname", stdname);
		      paraMap.put("stdjumin", stdjumin);
		      paraMap.put("stdbirthday", stdbirthday);
		      try {
		         paraMap.put("stdemail", aes.encrypt(stdemail));
		
		      } catch (UnsupportedEncodingException | GeneralSecurityException e1) {
		
		         e1.printStackTrace();
		      }
		      paraMap.put("stdmobile", stdmobile);
		      paraMap.put("stdmajorid", stdmajorid);
		      paraMap.put("gyowonid", gyowonid);
		      paraMap.put("enttype", enttype);
		      paraMap.put("entstate", entstate);
		      paraMap.put("entday", entday);
		      paraMap.put("stdstateid", stdstateid);
		
		      //System.out.println("확인1 paraMap:" + paraMap);
		
		      String message = "";
		      String loc = "";
		
		      try {
		
		         int n = service.stdRegisterEnd(paraMap);
		         //System.out.println("확인2 n:" + n);
		
		         if (n == 1) {
		            message = "학생등록 성공";
		            loc = request.getContextPath() + "/stdRegister.lmsfinal";
		
		            mav.addObject("message", message);
		            mav.addObject("loc", loc);
		            mav.setViewName("msg");
		
		         }
		
		      } catch (Exception e) {
		
		         e.printStackTrace();
		      }
		
		      return mav;
		
		   }

// == 학번 중복 확인 하기 == //

	   @ResponseBody
	   @RequestMapping(value = "/stdidDuplicateCheck.lmsfinal", method = { RequestMethod.POST })
	   public int stdidDuplicateCheck(String stdid) {
	
	      int result = service.stdidDuplicateCheck(stdid);
	      // System.out.println("확인 result:" + result);
	      return result;
	
	   }
	
// == 이메일 중복 확인 하기 == //
	
	   @ResponseBody
	   @RequestMapping(value = "/stdemailDuplicateCheck.lmsfinal", method = { RequestMethod.POST })
	   public int stdemailDuplicateCheck(String stdemail) {
	
	      int result = service.stdemailDuplicateCheck(stdemail);
	      // System.out.println("확인 result:" + result);
	      return result;
	
	   }

   
// == 학생리스트 확인 하기 == //

   @RequestMapping(value="/studentList.lmsfinal", method={RequestMethod.GET}) 
        public ModelAndView studentList(ModelAndView mav, HttpServletRequest request) {
     
           String searchType_1 = request.getParameter("searchType_1");
           String searchWord_1 = request.getParameter("searchWord_1");
           String str_currentShowPageNo = request.getParameter("currentShowPageNo");
           String deptname = request.getParameter("deptname");
           String stdstateid = request.getParameter("stdstateid");
          
           if(searchType_1 == null || (!"stdname".equals(searchType_1) && !"stdid".equals(searchType_1) && !"stdmajorid".equals(searchType_1) && !"deptname".equals(searchType_1)) ) {  
              searchType_1 = "";
           
              }
          
           if(searchWord_1 == null || "".equals(searchWord_1) || searchWord_1.trim().isEmpty() ) {
                 searchWord_1 = "";    
               
              }
             
           if(stdstateid == null || "".equals(stdstateid) || stdstateid.trim().isEmpty() ) {
              stdstateid = "";   
                
              }
              
              Map<String, String> paraMap = new HashMap<>();
              paraMap.put("searchType_1",searchType_1);  
              paraMap.put("searchWord_1",searchWord_1);
              paraMap.put("deptname",deptname);
              paraMap.put("stdstateid",stdstateid);
           
              int totalCount = 0; // 총게시물 건수
              int sizePerPage = 7;  //한 페이지당 보여줄 게시물 건수    
              int currentShowPageNo = 1; 
              int totalPage = 0;  // 총 페이지 수 
              
              int startRno = 0; // 시작 행번호
              int endRno = 0;   // 끝 행번호
         
              totalCount = service.getTotalPage(paraMap);
             // System.out.println("~~~~~~~~~ 확인용 totalCount: " + totalCount); 
              totalPage = (int) Math.ceil((double)totalCount/sizePerPage); 
               
               if(str_currentShowPageNo == null) {    
                  currentShowPageNo = 1;
                 
                } 
               else {
                   try { 
                     currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
                       if( currentShowPageNo < 1 || currentShowPageNo > totalPage ) {
                          currentShowPageNo = 1;
                       }
                   } catch(NumberFormatException e) {
                      currentShowPageNo = 1;
                  }
                }
               
              startRno = ((currentShowPageNo -1) * sizePerPage) + 1;
              endRno = startRno + sizePerPage -1;
               
               paraMap.put("startRno", String.valueOf(startRno));  
               paraMap.put("endRno", String.valueOf(endRno));
               
               
              List<StudentVO> studentList = service.selectPagingStudent(paraMap);  
              
               if( !"".equals(searchType_1) && !"".equals(searchWord_1)) {
                  mav.addObject("paraMap", paraMap);
                
               }
              
               if( !"".equals(stdstateid)) {
                  mav.addObject("paraMap", paraMap);
                
               }
      
             //페이지바 
              int blockSize = 2;
           
              int loop = 1;
              
              int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
            
              
             String pageBar = "<ul style='list-style: none;'>";
             String url = "studentList.lmsfinal";
             
             // [맨처음][이전] //
            
            if(pageNo != 1) {
                
               if(searchType_1 != "") {
                
                pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&stdstateid="+stdstateid+"&currentShowPageNo=1'>[맨처음]</a></li>";
                pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&stdstateid="+stdstateid+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	               
                 }
              
                 else if(stdstateid != null) {
                    
                  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?stdstateid="+stdstateid+"&currentShowPageNo=1'>[맨처음]</a></li>";
                  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?stdstateid="+stdstateid+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";   
	                
                 }
                 
            }  
                
             while( !(loop > blockSize || pageNo > totalPage) ) {
              
              if(pageNo == currentShowPageNo) {
                    
	                  if(searchType_1 != "") {
	                   
	                       pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
		                    
	                  }
	                  else if(stdstateid != null) {
	                   
	                       pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";   
		                    
	                  }
              }
               else {
               
                   if(searchType_1 != "") {
                      
                      pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&stdstateid="+stdstateid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
                    
                   }
                   else if(stdstateid != null) {
                      
                      pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?stdstateid="+stdstateid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
                  
                   }
               }     
                
                loop++;
                pageNo++;
                
             }// end of while-----------------------
             
             
             // [다음][마지막] //
           if( pageNo <= totalPage ) {
                
                if(searchType_1 != "") {
                   
                   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&stdstateid="+stdstateid+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
                   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&stdstateid="+stdstateid+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
                  
                }
                else if(stdstateid != null) {
                   
                   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?stdstateid="+stdstateid+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
                   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?stdstateid="+stdstateid+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
                 
                }
                
            }
            
             pageBar += "</ul>";
             
              mav.addObject("pageBar", pageBar);
           
         
             String gobackURL = MyUtil.getCurrentURL(request);
              //System.out.println("~~~~~ 확인용 gobackURL : " + gobackURL);
             
             mav.addObject("gobackURL", gobackURL.replaceAll("&"," "));  
             
             
             mav.addObject("studentList", studentList);
             mav.setViewName("wonhyejin/studentList.tiles2");
          
             return mav;
      }         
       
            
               
// 학생 1명을 보여주는 페이지 요청 ==//

   @RequestMapping(value="/studentOneDetail.lmsfinal") 
	     public ModelAndView studentOneDetail(ModelAndView mav, HttpServletRequest request) {
	    
	       String stdname = request.getParameter("stdname");
	       
	      StudentVO studentvo = service.studentOneDetail(stdname);
	      
	      request.setAttribute("studentvo", studentvo);
	      //System.out.println("~~확인용 studentvo.getStdemail()"+studentvo.getStdemail());
	      
	      String stdemail = "";
	      try {
	         stdemail = aes.decrypt(studentvo.getStdemail());
	      } catch (NoSuchAlgorithmException e) {
	         
	         e.printStackTrace();
	      } catch (UnsupportedEncodingException e) {
	         
	         e.printStackTrace();
	      } catch (GeneralSecurityException e) {
	      
	         e.printStackTrace();
	      }
	
	      String goBackURL = request.getParameter("goBackURL");
	      //System.out.println("~~~ 확인용 goBackURL => " + goBackURL);
	
	      
	      request.setAttribute("goBackURL", goBackURL);
	      
	      mav.addObject("stdemail", stdemail);
	      mav.setViewName("wonhyejin/studentOneDetail.tiles2");
	      return mav;
	  
	   }  

    
 // 학적상태 변경_휴학승인 
    @ResponseBody
    @RequestMapping(value="/stuLeaveUpdate.lmsfinal", method = {RequestMethod.POST }) 
    public String stuLeaveUpdate(HttpServletRequest request ) {
    
	       String stdid = request.getParameter("stdid");
	       String stdstateid = request.getParameter("stdstateid");
	       
	       Map<String, String> paraMap = new HashMap<>();
	       
	       paraMap.put("stdid",stdid);
	       paraMap.put("stdstateid",stdstateid);
	       
	       int n = service.stuLeaveUpdate(paraMap);     
	       
	       if(n==1) {
	          
	           service.stuLeaveAprUpdate(stdid); 
	      }
	      else {
	      }   
	       JSONObject jsonobj = new JSONObject();
	       
	       jsonobj.put("n", n);
	       
	       return jsonobj.toString();
	       
	    }
    
    
 // 학적상태 변경_휴학거절
    @ResponseBody
    @RequestMapping(value="/stuLeaveDelete.lmsfinal", method = {RequestMethod.POST }) 
    public String stuLeaveDelete(HttpServletRequest request) {
    
	       String stdid = request.getParameter("stdid");
	       String stdstateid = request.getParameter("stdstateid");
	       
	       Map<String, String> paraMap = new HashMap<>();
	       
	       paraMap.put("stdid",stdid);
	       paraMap.put("stdstateid",stdstateid);
	       
	       int n = service.stuLeaveDelete(paraMap);
	       
	       if(n==1) {
	          
	          service.stuLeaveAprDelete(stdid); 
	      }
	      else {
	      }
	       
	       JSONObject jsonobj = new JSONObject();
	       
	       jsonobj.put("n", n);
	       
	       return jsonobj.toString();
	       
	    }
	    
    

    
 // 학적상태 변경_복학승인 
    @ResponseBody
    @RequestMapping(value="/stuReturnUpdate.lmsfinal", method = {RequestMethod.POST }) 
    public String stuReturnUpdate(HttpServletRequest request ) {
    
	       String stdid = request.getParameter("stdid");
	       String stdstateid = request.getParameter("stdstateid");
	       
	       Map<String, String> paraMap = new HashMap<>();
	       
	       paraMap.put("stdid",stdid);
	       paraMap.put("stdstateid",stdstateid);
	       
	       int n = service.stuReturnUpdate(paraMap);
	    
	       if(n==1) {
	          
	           service.stuReturnAprUpdate(stdid); 
	      }
	      else {
	      }
	      
	       JSONObject jsonobj = new JSONObject();
	       
	       jsonobj.put("n", n);
	       
	       return jsonobj.toString();
	       
	    }
    
    
 // 학적상태 변경_복학거절
    @ResponseBody
    @RequestMapping(value="/stuReturnDelete.lmsfinal", method = {RequestMethod.POST }) 
    public String stuReturnDelete(HttpServletRequest request) {
    
	       String stdid = request.getParameter("stdid");
	       String stdstateid = request.getParameter("stdstateid");
	       
	       Map<String, String> paraMap = new HashMap<>();
	       
	       paraMap.put("stdid",stdid);
	       paraMap.put("stdstateid",stdstateid);
	       
	       int n = service.stuReturnDelete(paraMap);
	       
	       if(n==1) {
	          
	          service.stuReturnAprDelete(stdid); 
	      }
	      else {
	      }
	       
	       JSONObject jsonobj = new JSONObject();
	       
	       jsonobj.put("n", n);
	       
	       return jsonobj.toString();
	       
	    }
	    
}     
