package com.spring.lmsfinal.wonhyejin.controller;

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
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.lmsfinal.common.AES256;
import com.spring.lmsfinal.common.MyUtil;
import com.spring.lmsfinal.common.Sha256;
import com.spring.lmsfinal.wonhyejin.model.GyowonVO;
import com.spring.lmsfinal.wonhyejin.model.StudentVO;
import com.spring.lmsfinal.wonhyejin.service.InterGyowonService;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;


@Component
@Controller
public class GyowonController {

	@Autowired
	private InterGyowonService service;
	
	@Autowired
    private AES256 aes;
  
// == 교원 등록 폼 == //
			@RequestMapping(value = "/gyowonRegister.lmsfinal", method = {RequestMethod.GET })
			public ModelAndView gyowonRegister(ModelAndView mav) {

				mav.setViewName("wonhyejin/gyowonRegister.tiles2");
				/// WEB-INF/views/tiles2/wonhyejin/gyowonRegister.jsp

				return mav;
			}

// 전체 학과 목록 보여주기 
			@ResponseBody
			@RequestMapping(value="/gyoDeptlist.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
			public String gyoDeptlist(HttpServletRequest request) {
				List<GyowonVO> gyoDeptlist = null;
				
				String searchType1 = request.getParameter("searchType1");
				String searchWord1 = request.getParameter("searchWord1");
				
				if(searchType1 == null) {
					searchType1 = "";
				}
				
				if(searchWord1 == null) {
					searchWord1 = "";
				}
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("searchType1", searchType1);
				paraMap.put("searchWord1", searchWord1);
				
				gyoDeptlist = service.gyoDeptlistSearch(paraMap);
				

				JsonArray jsonArr = new JsonArray();  // []
				
				if( gyoDeptlist != null ) {
					for(GyowonVO gyowonvo : gyoDeptlist) {
						JsonObject jsonObj = new JsonObject();
						jsonObj.addProperty("majorid", gyowonvo.getMajorid());
						jsonObj.addProperty("deptname", gyowonvo.getDeptname());
						
						jsonArr.add(jsonObj);
					}// end of for---------------------
				}
				
				return new Gson().toJson(jsonArr);
			}
			
			
// == 교원 등록 하기 == //
			@RequestMapping(value="/gyowonRegisterEnd.lmsfinal", method= {RequestMethod.POST}) 
		    public ModelAndView gyowonRegisterEnd(ModelAndView mav, HttpServletRequest request) {
		  	  
				String gyowonid = request.getParameter("gyowonid") ;     //교원번호
		        String gyopwd   = request.getParameter("gyopwd");        //비밀번호
		        String gyoname = request.getParameter("gyoname");        //이름
		        String gyojumin = request.getParameter("gyojumin");        //주민등록번호
		        String gyobirthday = request.getParameter("gyobirthday");        //생년월일
		        String gyoemail = request.getParameter("gyoemail");      //이메일
		        String gyomobile = request.getParameter("gyomobile");      // 연락처
		        String gyomajorid = request.getParameter("gyomajorid");      //학과코드
		        String appointmentdt = request.getParameter("appointmentdt");      //임용일자
		        String workstatus = request.getParameter("workstatus");      //근로상태코드
		        
		        Map<String, String> paraMap = new HashMap<>();
		        
				  paraMap.put("gyowonid", gyowonid); 
				  paraMap.put("gyopwd", Sha256.encrypt(gyopwd));
				  paraMap.put("gyoname",gyoname); 
				  paraMap.put("gyojumin",gyojumin); 
				  paraMap.put("gyobirthday",gyobirthday); 
				  
				try {
					paraMap.put("gyoemail", aes.encrypt(gyoemail));

				} catch (UnsupportedEncodingException | GeneralSecurityException e1) {
				
					e1.printStackTrace();
				
				}
				  paraMap.put("gyomobile",gyomobile);
				  paraMap.put("gyomajorid",gyomajorid);
				  paraMap.put("appointmentdt",appointmentdt);
				  paraMap.put("workstatus",workstatus);
				
			     //System.out.println("확인1 paraMap:" + paraMap);
			
		           String message = "";
		           String loc = "";
		         
		           try {
		             
					  int n = service.gyowonRegisterEnd(paraMap);
					
		              if(n == 1) {
		            	 
		                 message = "교원등록 성공";
		                 loc = request.getContextPath()+"/gyowonRegister.lmsfinal"; 
		                 
		                 mav.addObject("message", message);
		       			 mav.addObject("loc", loc);
		       			 mav.setViewName("msg");
		                
		              }
		              
		           } catch(Exception e) {
		             
		               e.printStackTrace();
		           }
		      
				return mav;
		        
			}

// == 교원번호중복 확인 하기 == //
			 
			  @ResponseBody
		      @RequestMapping(value="/gyowonIdDuplicateCheck.lmsfinal", method={RequestMethod.POST}) 
			  public int gyowonIdDuplicateCheck(String gyowonid) {
			  
			  int result = service.gyowonIdDuplicateCheck(gyowonid);
			  //System.out.println("확인 result:" + result);
			  return result;
			  
		      }
			  
// == 이메일 중복 확인 하기 == //
				 
			  @ResponseBody
		      @RequestMapping(value="/gyoemailDuplicateCheck.lmsfinal", method={RequestMethod.POST}) 
			  public int gyoemailDuplicateCheck(String gyoemail) {
			  
			  int result = service.gyoemailDuplicateCheck(gyoemail);
			  //System.out.println("확인 result:" + result);
			  return result;
			  
		      }

			  
 // 교수정보조회
			  
	// == 교원리스트 확인 하기 == //

			@RequestMapping(value="/gyowonList.lmsfinal", method={RequestMethod.GET}) 
				  public ModelAndView gyowonList(ModelAndView mav, HttpServletRequest request) {
			  
					  String searchType_1 = request.getParameter("searchType_1");
					  String searchWord_1 = request.getParameter("searchWord_1");
					  String str_currentShowPageNo = request.getParameter("currentShowPageNo");
					  String deptname = request.getParameter("deptname");
					  
					  if(searchType_1 == null || (!"gyoname".equals(searchType_1)) && !"gyowonid".equals(searchType_1) && !"gyomajorid".equals(searchType_1) && !"deptname".equals(searchType_1)) {  
						  searchType_1 = "";
				    	 }
				    	 
				      if(searchWord_1 == null || "".equals(searchWord_1) || searchWord_1.trim().isEmpty() ) {
				    		 searchWord_1 = "";   
				    	 }
		
					  Map<String, String> paraMap = new HashMap<>();
					  paraMap.put("searchType_1",searchType_1);   
				      paraMap.put("searchWord_1",searchWord_1);
				      paraMap.put("deptname",deptname);
				     
				     
				         int totalCount = 0; // 총게시물 건수
				    	 int sizePerPage = 5;  //한 페이지당 보여줄 게시물 건수    
				    	 int currentShowPageNo = 1; 
				    	 int totalPage = 0;  // 총 페이지 수
				    	 
				    	 int startRno = 0; // 시작 행번호
				    	 int endRno = 0;   // 끝 행번호
					
				    	 totalCount = service.getGTotalPage(paraMap);
				    	 //System.out.println("~~~~~~~~~ 확인용 totalCount: " + totalCount);
				    	 
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
				     	 
				     	 
				     	List<GyowonVO> gyowonList = service.selectPagingGyowon(paraMap);    
				     
				     	 if( !"".equals(searchType_1) && !"".equals(searchWord_1)) {
				     		 mav.addObject("paraMap", paraMap);
				     	 }
				       
				     	 
				     	// 페이지바  //
				  		int blockSize = 3;
				  		
				  		int loop = 1;
				  	
				  		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
				  		 //System.out.println("확인용 pageNo=>" + pageNo);
				  		
				  		String pageBar = "<ul style='list-style: none;>";
				 		String url = "gyowonList.lmsfinal";
				 		
				 		// [맨처음][이전] //
				 		if(pageNo != 1) {
				 			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt; '><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&currentShowPageNo=1'>[맨처음]</a></li>";
				 			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
				 		}
				 		
				 		while( !(loop > blockSize || pageNo > totalPage) ) { 
				 			
				 			if(pageNo == currentShowPageNo) {
				 			   pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
				 			}
				 			else {
				 				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				 				
				 			}
				 			
				 			loop++;
				 			pageNo++;
				 			
				 		}// end of while-----------------------
				 		
				 		
				 		//  [다음][마지막] //
				 		if( pageNo <= totalPage ) {
				 			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				 			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
				 			 
				 		}
				 		
				 		pageBar += "</ul>";
				 		
				 		mav.addObject("pageBar", pageBar);
				 		
				   
				 		String gobackURL = MyUtil.getCurrentURL(request);
				 	 	
				 		mav.addObject("gobackURL", gobackURL.replaceAll("&"," ")); 
				 
				 		
				 		mav.addObject("gyowonList", gyowonList);
				 		mav.setViewName("wonhyejin/gyowonList.tiles2");
				 	
				 		return mav;
				 	}    	  
					    	  
				    	  
// 교원1명을 보여주는 페이지 요청 ==//
			    @RequestMapping(value="/gyowonOneDetail.lmsfinal") 
			     public ModelAndView gyowonOneDetail(ModelAndView mav, HttpServletRequest request) {
			  	  
			    	String gyoname = request.getParameter("gyoname");
					
			    	GyowonVO gyowonvo = service.gyowonOneDetail(gyoname);
					
					request.setAttribute("gyowonvo",  gyowonvo);
					
					String gyoemail = "";
					try {
						 gyoemail = aes.decrypt(gyowonvo.getGyoemail());
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
					
					mav.addObject("gyoemail", gyoemail);
					mav.setViewName("wonhyejin/gyowonOneDetail.tiles2");
					return mav;
			  
			  }  
			    


			    
//교원 강의개설 
          // == 교원강의 리스트 확인 하기 == //

				@RequestMapping(value="/gyoOpenedList.lmsfinal", method={RequestMethod.GET}) 
					  public ModelAndView gyoOpenedList(ModelAndView mav, HttpServletRequest request) {
				  
						  String searchType_1 = request.getParameter("searchType_1");
						  String searchWord_1 = request.getParameter("searchWord_1");
						  String str_currentShowPageNo = request.getParameter("currentShowPageNo");
						  String applystate = request.getParameter("applystate");
						  
				
						 if(searchType_1 == null || (!"deptname".equals(searchType_1) && !"opensemester".equals(searchType_1) && !"classname".equals(searchType_1) && !"applystate".equals(searchType_1)) ) {  
							  searchType_1 = "";
					    	 }
					    	 
				    	 if(searchWord_1 == null || "".equals(searchWord_1) || searchWord_1.trim().isEmpty() ) {
				    		 searchWord_1 = "";     
				    	 }
				    	 if(applystate == null || "".equals(applystate) || applystate.trim().isEmpty() ) {
				    		 applystate = "";   
				           
				         }
				
						  Map<String, String> paraMap = new HashMap<>();
						  paraMap.put("searchType_1",searchType_1);   
					      paraMap.put("searchWord_1",searchWord_1);
					      paraMap.put("applystate",applystate);
					     
					         int totalCount = 0; // 총게시물 건수
					    	 int sizePerPage = 4;  //한 페이지당 보여줄 게시물 건수    
					    	 int currentShowPageNo = 1; 
					    	 int totalPage = 0;  // 총 페이지 수
					    	 
					    	 int startRno = 0; // 시작 행번호
					    	 int endRno = 0;   // 끝 행번호
						
					    	 totalCount = service.getGOpenTotalPage(paraMap);
					    	 //System.out.println("~~~~~~~~~ 확인용 totalCount: " + totalCount); 
					    	 totalPage = (int) Math.ceil((double)totalCount/sizePerPage); 
					    	  //System.out.println("확인용 totalPage => "+totalPage);
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
					     	 
					     	 
					     	List<MylectureVO> applylectureList = service.selectPagingGyowonOpen(paraMap);   
					     	
					     	 if( !"".equals(searchType_1) && !"".equals(searchWord_1)) {
					     		 mav.addObject("paraMap", paraMap);
					     	 }
					     	 if( !"".equals(applystate)) {
				                 mav.addObject("paraMap", paraMap);
				                
				              }
					     	 
					     // 페이지바 //
					  		int blockSize = 4;
					  	
					  		int loop = 1;
					  		
					  		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
					  	
					  		String pageBar = "<ul style='list-style: none;'>";
					 		String url = "gyoOpenedList.lmsfinal";
					 		
					 	// [맨처음][이전] //
					 		  if(pageNo != 1) {
					                
					               if(searchType_1 != "") {
					                
					                pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&applystate="+applystate+"&currentShowPageNo=1'>[맨처음]</a></li>";
					                pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&applystate="+applystate+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
						             
					                 }
					              
					                 else if(applystate != null) {
					                    
					                  pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?applystate="+applystate+"&currentShowPageNo=1'>[맨처음]</a></li>";
					                  pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?applystate="+applystate+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";   
						             
					                 }
					            }  
					 		  
					 		  while( !(loop > blockSize || pageNo > totalPage) ) { 
					 			
					 			   if(pageNo == currentShowPageNo) {
					                    
					                   if(searchType_1 != "") {
					                   
					                        pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
						                 
					                   }
					                   else if(applystate != null) {
					                    
					                      pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 0px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";   
						               
					                  }
				              }
				               else {
				              
				                 if(searchType_1 != "") {
				                    
				                    pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&applystate="+applystate+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				                   
				                 }
				                 else if(applystate != null) {
				                    
				                    pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?applystate="+applystate+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				                  
				                 }
				             }     
				              
					 			loop++;
					 			pageNo++;
					 			
					 		}// end of while-----------------------
					 		
					 		
					 		//  [다음][마지막] //
					 		if( pageNo <= totalPage ) {
					 			 if(searchType_1 != "") {
					                   
					                   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&applystate="+applystate+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
					                   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType_1="+searchType_1+"&searchWord_1="+searchWord_1+"&applystate="+applystate+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
					                 
					                }
					                else if(applystate != null) {
					                   
					                   pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?applystate="+applystate+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
					                   pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?applystate="+applystate+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
					               
					                }
					 		}
					 		
					 		pageBar += "</ul>";
					 		
					 		mav.addObject("pageBar", pageBar);
					 	
					 		String gobackURL = MyUtil.getCurrentURL(request);
					 	 	//System.out.println("~~~~~ 확인용 gobackURL : " + gobackURL);
					 		
					 		mav.addObject("gobackURL", gobackURL.replaceAll("&"," ")); 
					 	
					 		mav.addObject("applylectureList", applylectureList);
					 		mav.setViewName("wonhyejin/gyoOpenedList.tiles2");
					 	
					 		return mav;
					 	}    	  

			 				
   /// === 교수 강의 개설 (버튼 클릭시 업데이트)   신청상태변경 등록완료 === /// 		  
			    @ResponseBody
			    @RequestMapping(value="/gyoOpenedUpdate.lmsfinal", method = {RequestMethod.POST }) 
			    public String gyoOpenedUpdate(HttpServletRequest request) {
			    
			    	String subjectid = request.getParameter("subjectid");
			    	String applystate = request.getParameter("applystate");
			    	
			    	Map<String, String> paraMap = new HashMap<>();
			    	
			    	paraMap.put("subjectid",subjectid);
			    	paraMap.put("applystate",applystate);
			    	
			    	int n = service.gyoOpenedUpdate(paraMap);
			    	
			    	JSONObject jsonobj = new JSONObject();
			    	
			    	jsonobj.put("n", n);
			    	
			    	return jsonobj.toString();
			    }
			   

			    
/// === 교수 강의 개설 (버튼 클릭시 업데이트)   신청상태변경 삭제 === /// 			    	  
		  
			    @ResponseBody
			    @RequestMapping(value="/gyoOpenedDelete.lmsfinal", method = {RequestMethod.POST }) 
			    public String gyoOpenedDelete(HttpServletRequest request) {
			    
			    	String subjectid = request.getParameter("subjectid");
			    	String applystate = request.getParameter("applystate");
			    	
			    	Map<String, String> paraMap = new HashMap<>();
			    	
			    	paraMap.put("subjectid",subjectid);
			    	paraMap.put("applystate",applystate);
			    	
			    	int n = service.gyoOpenedDelete(paraMap);
			    	
			    	JSONObject jsonobj = new JSONObject();
			    	
			    	jsonobj.put("n", n);
			    	
			    	return jsonobj.toString();
			    	
			    }
			    


			  
}
