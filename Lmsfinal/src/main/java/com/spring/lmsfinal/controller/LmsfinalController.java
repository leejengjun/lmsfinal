package com.spring.lmsfinal.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.common.AES256;
import com.spring.lmsfinal.common.GoogleMail;
import com.spring.lmsfinal.common.Sha256;
import com.spring.lmsfinal.service.InterLmsfinalService;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;

@Component

@Controller
public class LmsfinalController {
	
	@Autowired
	private InterLmsfinalService service;
	
	@Autowired
    private AES256 aes;
	
	@RequestMapping(value="/test/test_insert.lmsfinal")	// ctxPath는 com.spring.board에서 마지막 board가 된다!
	public String test_insert(HttpServletRequest request) {
		
		int n = service.test_insert(); // 서비스 단에 요청함!
		
		String message = "";
		
		if(n==1) {
			message = "데이터 입력 성공!!";
		}
		else {
			message = "데이터 입력 실패!!";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("n", n);
		
		return "test/test_insert"; // 뷰단 표시
	//	/WEB-INF/views/test/test_insert.jsp 페이지를 만들어야 한다.
	}// end of public String test_insert(HttpServletRequest request)--------------------
	

	/////////  ===== ***** 1. 메인 홈페이지 요청(로그인 전) ***** ===== /////////
	@RequestMapping(value="/index.lmsfinal")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("main/index.tiles1");
		// /WEB-INF/views/tiles1/main/index.jsp  파일을 생성한다.
		
		return mav;
	}
	
	
	/////////  ===== ***** 3.로그인 안 한 상태에서 사이드바에 있는 로그인 버튼을 눌렀을 경우 로그인폼 페이지 요청 ***** ===== /////////
	@RequestMapping(value="/jeongKyeongEun/privacy_policy.lmsfinal")   // 폼 페이지가 떠야하니까 method get방식만
	public String privacy_policy(ModelAndView mav) {
		
	//	mav.setViewName("/jeongKyeongEun/privacy_policy");
		// /WEB-INF/views/main/loginform.jsp  파일을 생성한다. 
		
		return "/jeongKyeongEun/privacy_policy";
	}
	
	
	
	/////////  ===== ***** 2. 메인에서 로그인 하지 않고 공지사항 또는 메뉴를 누른 경우 공통 메인페이지로 감 ***** ===== /////////
	@RequestMapping(value="/home.lmsfinal", method= {RequestMethod.GET})   // 폼 페이지가 떠야하니까 method get방식만
	public ModelAndView home(ModelAndView mav) {
		
		List<String> imgfilenameList = service.getImgfilenameList();  // 리턴타입은 복수개,  빨간줄이 뜨면 create. interBoardService.java 로 간다.
		
		mav.addObject("imgfilenameList", imgfilenameList);
		
		mav.setViewName("main/afterlogin.tiles2");
		// /WEB-INF/views/tiles1/main/loginform.jsp  파일을 생성한다. 
		
		return mav;
	}


	/////////  ===== ***** 3.로그인 안 한 상태에서 사이드바에 있는 로그인 버튼을 눌렀을 경우 로그인폼 페이지 요청 ***** ===== /////////
	@RequestMapping(value="/login.lmsfinal", method= {RequestMethod.GET})   // 폼 페이지가 떠야하니까 method get방식만
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("main/loginform.tiles1");
		// /WEB-INF/views/main/loginform.jsp  파일을 생성한다. 
		
		return mav;
	}
	
	
	/////////  ===== ***** 4. 로그인 처리하기  ***** ===== /////////
	  @RequestMapping(value="/loginEnd.lmsfinal", method= {RequestMethod.POST})
	  public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) { // HttpServletRequest request 가 당연히 필요! loginform.jsp에서 name 받아옴
         
    	  
     	 List<String> imgfilenameList = service.getImgfilenameList();  // 리턴타입은 복수개,  빨간줄이 뜨면 create. interBoardService.java 로 간다.
   		
   		 mav.addObject("imgfilenameList", imgfilenameList);
    	  
         try {
            String userid = request.getParameter("userid");
            String pwd = request.getParameter("pwd");
      //    System.out.println("확인용 userid => "+userid);
            
            
            int userid_leng = userid.length();
      //    System.out.println("확인용 userid_leng => "+userid_leng);
            
            StudentVO loginuser_student = null;
            GyowonVO loginuser_gyowon = null;
            AdminVO loginuser_admin = null;
            boolean flag = false;   // 로그인 확인하는 플래그!
            
            /////////////// 분기 시작 ///////////////////////////
            
            if(userid_leng == 9) {
               // 아이디 유효성 검사(학생 또는 교원은 아이디가 숫자로 구성되어 있기 때문에 분기 이동 후 검사한다!)
               Integer.parseInt(userid);
               
               // 학생이 로그인 한 것이라면
         //    System.out.println("학생이 로그인했다!");
               
               Map<String, String> paraMap = new HashMap<>(); // DB에 있는것을 Map에 넣자
               paraMap.put("userid", userid);
               paraMap.put("pwd", Sha256.encrypt(pwd)); // 암호를 다시한번 암호화. 이거를 paraMap에 집어넣어서 service에 보낸다.
               
               loginuser_student = service.getLoginStudent(paraMap);
               if(loginuser_student == null) {
                  // 학생 아이디와 비밀번호가 일치하지 않으면
                  flag = false;
               }
               else {
                  // 학생 아이디와 비밀번호가 일치하면
                  flag = true;
               }
               
               if(!flag) { // 로그인 실패시 로그인 실패하면 flag 값은 false 이다!
                  String message = "아이디 또는 암호가 틀립니다.";
                  String loc = "javascript:history.back()";
                  
                  mav.addObject("message", message);
                  mav.addObject("loc", loc);
                  
                  mav.setViewName("msg");
                  // /WEB-INF/views/msg.jsp 페이지를 만들어야한다.
               }
               
               else {   // 아이디와 암호가 존재하는 경우
                  
                  HttpSession session = request.getSession();
                  
                  session.setAttribute("loginuser", loginuser_student);
                  // session(세션)에 로그인 되어진 사용자 정보인 loginuser_student 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
                  
                  session.setAttribute("userid", userid);
                  // 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우 
                      // "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
                      // 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
                      // 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
                  
                  String goBackURL = (String)session.getAttribute("goBackURL");  // 세션에 가본다.
                  
                  if(goBackURL != null) {
                     mav.setViewName("main/index.tiles1");
                     session.removeAttribute("goBackURL");  // 세션에서 반드시 제거해주어야 한다!!!! 다 썼기 때문에
                  }
                  else {
                     mav.setViewName("main/afterlogin.tiles2");  // 올바르게 되어지면 시작페이지로 이동
                     //   /WEB-INF/views/tiles2/main/afterlogin.jsp  --> 페이지를 만들어야 한다.
                  }
               
               }
               
            }
            else if(userid_leng == 5) {
               // 아이디 유효성 검사(학생 또는 교원은 아이디가 숫자로 구성되어 있기 때문에 분기 이동 후 검사한다!)
               Integer.parseInt(userid);
               
               // 교수가 로그인 한 것이라면
               Map<String, String> paraMap = new HashMap<>(); // DB에 있는것을 Map에 넣자
               paraMap.put("userid", userid);
               paraMap.put("pwd", Sha256.encrypt(pwd)); // 암호를 다시한번 암호화. 이거를 paraMap에 집어넣어서 service에 보낸다.
               
               loginuser_gyowon = service.getLoginGyowon(paraMap);
               if(loginuser_gyowon == null) {
                  // 교원 아이디와 비밀번호가 일치하지 않으면
                  flag = false;
               }
               else {
                  // 교원 아이디와 비밀번호가 일치하면
                  flag = true;
               }
               
               if(!flag) { // 로그인 실패시 로그인 실패하면 flag 값은 false 이다!
                  String message = "아이디 또는 암호가 틀립니다.";
                  String loc = "javascript:history.back()";
                  
                  mav.addObject("message", message);
                  mav.addObject("loc", loc);
                  
                  mav.setViewName("msg");
                  // /WEB-INF/views/msg.jsp 페이지를 만들어야한다.
               }
               else {   // 아이디와 암호가 존재하는 경우
                  
                  HttpSession session = request.getSession();
                  
                  session.setAttribute("loginuser", loginuser_gyowon);
                  // session(세션)에 로그인 되어진 사용자 정보인 loginuser_gyowon 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
                  session.setAttribute("userid", userid);
                   // 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우 
                      // "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
                      // 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
                      // 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
                  
                  String goBackURL = (String)session.getAttribute("goBackURL");  // 세션에 가본다.
                  
                  if(goBackURL != null) {
                     mav.setViewName("main/index.tiles1");
                     session.removeAttribute("goBackURL");  // 세션에서 반드시 제거해주어야 한다!!!! 다 썼기 때문에
                  }
                  else {
                     mav.setViewName("main/afterlogin.tiles2");  // 올바르게 되어지면 시작페이지로 이동
                     //   /WEB-INF/views/tiles2/main/afterlogin.jsp  --> 페이지를 만들어야 한다.
                  }
               
               }
               
            } 
            else if(userid_leng == 6) {
               // 관리자가 로그인 한 것이라면
      //       System.out.println("관리자 아이디이다!");
               Map<String, String> paraMap = new HashMap<>(); // DB에 있는것을 Map에 넣자
               paraMap.put("userid", userid);
               paraMap.put("pwd", Sha256.encrypt(pwd)); // 암호를 다시한번 암호화. 이거를 paraMap에 집어넣어서 service에 보낸다.
               loginuser_admin = service.getLoginAdmin(paraMap);
               if(loginuser_admin == null) {
                  // 교원 아이디와 비밀번호가 일치하지 않으면
                  flag = false;
               }
               else {
                  // 교원 아이디와 비밀번호가 일치하면
                  flag = true;
               }
               
               if(!flag) { // 로그인 실패시 로그인 실패하면 flag 값은 false 이다!
                  String message = "아이디 또는 암호가 틀립니다.";
                  String loc = "javascript:history.back()";
                  
                  mav.addObject("message", message);
                  mav.addObject("loc", loc);
                  
                  mav.setViewName("msg");
                  // /WEB-INF/views/msg.jsp 페이지를 만들어야한다.
               }
               
               else {   // 아이디와 암호가 존재하는 경우
                  
                  HttpSession session = request.getSession();
                  
                  session.setAttribute("loginuser", loginuser_admin);
                  // session(세션)에 로그인 되어진 사용자 정보인 loginuser_admin 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
                  
                   // 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우 
                      // "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
                      // 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
                      // 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
                  
                  String goBackURL = (String)session.getAttribute("goBackURL");  // 세션에 가본다.
                  
                  if(goBackURL != null) {
                     mav.setViewName("main/index.tiles1");
                     session.removeAttribute("goBackURL");  // 세션에서 반드시 제거해주어야 한다!!!! 다 썼기 때문에
                  }
                  else {
                	  
                     mav.setViewName("main/afterlogin.tiles2");  // 올바르게 되어지면 시작페이지로 이동
                     //   /WEB-INF/views/tiles2/main/afterlogin.jsp  --> 페이지를 만들어야 한다.
                  }
               
               }
            }
            else {
               //학생 교수 관리자가 아닌 그 외의 로그인 시도일때
               String message = "비정상적인 계정으로 로그인 시도 헀습니다.";
               String loc = "javascript:history.back()";
               
               mav.addObject("message", message);
               mav.addObject("loc", loc);
               
               mav.setViewName("msg");
               // /WEB-INF/views/msg.jsp 페이지를 만들어야한다.
            }
            //////////// 분기 끝 ///////////////////////////////////////////
   
            
         
         } catch(NumberFormatException e) {
            String message = "학생과 교원 아이디 형태는 '숫자'입니다. 다시 입력하세요.";
            String loc = "javascript:history.back()";
            
            mav.addObject("message", message);
            mav.addObject("loc", loc);
            
            mav.setViewName("msg");
         }
         
         return mav;
      }
     	   
   
   // ===  5.로그아웃 처리하기 === //
   @RequestMapping(value="/logout.lmsfinal")
   public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
   
      // 로그아웃시 시작페이지로 돌아가는 것이다. 추후엔 그 페이지에 머물 것
      HttpSession session = request.getSession();
      session.invalidate();
      
      String message = "로그아웃 되었습니다.";
      String loc = request.getContextPath()+"/index.lmsfinal";
      
      mav.addObject("message", message);
      mav.addObject("loc", loc);
      mav.setViewName("msg");
      // 접두어 접미어
      // /WEB-INF/views/msg.jsp
      
      return mav;

   }
	
	
	/////////  ===== ***** 6.아이디 찾기 페이지 요청 ***** ===== /////////
	@RequestMapping(value="/idfindpage.lmsfinal", method= {RequestMethod.GET})   // 폼 페이지가 떠야하니까 method get방식만
	public ModelAndView idfindpage(ModelAndView mav) {
		
		mav.setViewName("main/idfind.tiles1");  // 아이디 찾기 폼이 있는 페이지로 이동
		// /WEB-INF/views/tiles1/main/idfind.jsp  파일을 생성한다. 
		
		return mav;
	}

	/////////  ===== ***** 7. 아이디 찾기 ***** ===== /////////
	@RequestMapping(value="/idfind.lmsfinal")
	public ModelAndView idfind(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
	  
		String method = request.getMethod();   
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String userType = request.getParameter("userType");
   //   System.out.println("확인용 mobile : " + mobile);  // null 나와용
   //   System.out.println("확인용 email : " + email); 
   //   System.out.println("확인용 userType : " + userType); 
	  
	  
		
		if("POST".equalsIgnoreCase(method)) { // POST 방식일 때만!
	
			 
		     Map<String, String> paraMap = new HashMap<>(); // mobile과 email보내기
		     
		     paraMap.put("name", name);
		     
		     try {
		         String secret_email =  aes.encrypt(email);
		//       System.out.println("확인용 secret_email : " + secret_email);
		         
		         paraMap.put("email", aes.encrypt(email));
		         
		      } catch (UnsupportedEncodingException | GeneralSecurityException e) {
		         e.printStackTrace();
		      }  // 암호화 해야함
		
		     paraMap.put("userType", userType);
		     
		     String findUserid = service.getFindUserid(paraMap);
	//	     System.out.println("확인용 findUserid : " +findUserid);
		     // 확인용 findUserid : 202200001
		     
		     if(findUserid != null) {
		        request.setAttribute("userid", findUserid);
		     }
		     else {   // ID가 존재하지 않은 경우
		        request.setAttribute("userid", "존재하지 않는 회원 아이디이거나 회원구분을 잘못 선택하셨습니다.");
		     }
		     
		  ////////////////////////////////////////////////////////////////
	     
		}// end of if("POST".equalsIgnoreCase(method))------------
		
		request.setAttribute("name", name);
		request.setAttribute("email", email);
		request.setAttribute("method", method);	   // GET 방식이라면 찾아온 아이디를 화면에 표시하지 않는다.(idFind.jsp 파일 참고)
		//super.setRedirect(false);
		
	  mav.setViewName("main/idfind.tiles1");
	  
	  return mav;
	}
	   
	   
	 
	/////////  ===== ***** 8.비밀번호 찾기 페이지 요청 ***** ===== /////////
	@RequestMapping(value="/pwdFindpage.lmsfinal", method= {RequestMethod.GET})   // 폼 페이지가 떠야하니까 method get방식만
	public ModelAndView pwdFindpage(ModelAndView mav) {
		
		mav.setViewName("main/pwdFind.tiles1");  // 비밀번호 찾기 폼이 있는 페이지로 이동
		// /WEB-INF/views/tiles1/main/idfind.jsp  파일을 생성한다. 
		
		return mav;
	}
	
	
	
	   /////////  ===== ***** 9.비밀번호 찾기 ***** ===== /////////
	   @RequestMapping(value="/pwdFind.lmsfinal")
	   public ModelAndView pwdFind(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {

           try {
        	   String userid = request.getParameter("userid");
        	   Integer.parseInt(userid); // 아이디 유효성 검사(학생 또는 교원은 아이디가 숫자로 구성되어 있기 때문에 분기 이동 후 검사한다!)
        	   
			   String method = request.getMethod();   
			   boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도 
	           String isUserExist = "";
	           
			   if("POST".equalsIgnoreCase(method)) { // POST 방식일 때만!
			   
			       userid = request.getParameter("userid");
			       String email = request.getParameter("email");
			       String userType = request.getParameter("userType");
			 //    System.out.println("확인용 userid : " + userid); 
		     //    System.out.println("확인용 email : " + email); 
		     //    System.out.println("확인용 userType : " + userType); 
		
			       //////////////////////////////////////////////////////////////////////////////////// 완료    
			       Map<String, String> paraMap = new HashMap<>(); // userid와 email보내기
			       paraMap.put("userid", userid);
			       try {
			            String secret_email =  aes.encrypt(email);
	//		            System.out.println("확인용 secret_email : " + secret_email);
			            
			            paraMap.put("email", aes.encrypt(email));
			            
			         } catch (UnsupportedEncodingException | GeneralSecurityException e) {
			            e.printStackTrace();
			         }  // 암호화 해야함
			       paraMap.put("userType", userType);
			       
			       isUserExist = service.getFindPwd(paraMap);  // id 를 select 해서 id복호화 된 pwd 가 나올것??
	   //          System.out.println("확인용 isUserExist : " +isUserExist);
	              // 확인용 isUserExist : 10005
	                     
	                
	                
	   //           System.out.println("확인용 sendMailSuccess 1 : " + sendMailSuccess);
	           //   확인용 sendMailSuccess 1 : false
	
			       if(isUserExist != null) {
			    	  request.setAttribute("isUserExist", isUserExist);
			         // 회원으로 존재하는 경우
			         //인증키를 랜덤하게 생성하도록 한다.
			    	  
			  //   System.out.println("확인용 userType :" +userType);
		              Random rnd = new Random();
		              
		              String certificationCode = "";  
		              //인증키는 영문소문자 5글자 +숫자 7글자
		            
		              char randchar = ' ';
		              for(int i=0; i<5; i++) {
		                
		                 randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');  
		                 certificationCode  += randchar;
		              } //end of for----------------
		              
		              int randnum = 0;
		              for(int i=0; i<7; i++) {
		                 randnum = rnd.nextInt(9 - 0 + 1) + 0;
		                 certificationCode += randnum;
		                 
		              }//end of for---------
		            
		               //랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다.
		              GoogleMail mail =  new GoogleMail();
		              
		              try {
		                 mail.sendmail(email, certificationCode);
		                 sendMailSuccess = true;   //메일전송이 성공했음을 기록함
		                 
		                 //세션 불러오기
		                 HttpSession session = request.getSession();
		                 session.setAttribute("certificationCode",certificationCode);   
		                 //발금한 인증코드를 세션에 저장시킴
		              	 } catch(Exception e) {
		                    //메일전송이 실패한 경우
		                    e.printStackTrace();
		                    sendMailSuccess = false;   //메일전송이 실패했음을 기록함
		                 }
		              
		//            System.out.println("확인용 sendMailSuccess 1 : " + sendMailSuccess);
		              //      확인용 sendMailSuccess 1 : true   
			       
		       }// if(isUserExist != null) -------------------
				
			       request.setAttribute("method", method);
			       request.setAttribute("sendMailSuccess", sendMailSuccess);
			       request.setAttribute("isUserExist", isUserExist);
			       request.setAttribute("userid", userid);
			       request.setAttribute("email", email);
	
			              
			  //    System.out.println("확인용 sendMailSuccess: " +sendMailSuccess);
			 ////////////////////////////////////////////////////////////////////////////////////////////
			   }// end of if("POST".equalsIgnoreCase(method))------------
					mav.setViewName("main/pwdFind.tiles1");  // 비밀번호 인증코드를 입력하는 페이지로 이동
			   //  /WEB-INF/views/tiles1/main/pwdAuthentication.jsp  파일을 생성한다. 
		      
	       
           } catch(NumberFormatException e) {
               String message = "학생과 교원 아이디 형태는 '숫자'입니다. 다시 입력하세요.";
               String loc = "javascript:history.back()";
               
               mav.addObject("message", message);
               mav.addObject("loc", loc);
               
               mav.setViewName("msg");
            }
            
            return mav;
         }
	   
	   /////////  ===== ***** 10.비밀번호 찾기 인증키보내기 ***** ===== /////////
	   @RequestMapping(value="/verifyCertification.lmsfinal")
	   public ModelAndView verifyCertification(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
	      
	      String userCertificationCode = request.getParameter("userCertificationCode");  //유저 인증키
	      String userid = request.getParameter("userid");
	      
	      HttpSession session = request.getSession();  // 랜덤하게 발송되어진 인증키
	      String certificationCode =(String)session.getAttribute("certificationCode");   //세션에 저장된 인증코드 가져오기
	       
	      String message = "";
	      String loc = "";
	        
	      if(certificationCode.equals(userCertificationCode) ) {   //유저가 보내준 인증키하고 내가 보내준인증키하고 같냐 같지않냐
	          message = "인증이 완료되었습니다.";  // 유저가 보내준 인증코드와 메일 받은 인증코드가 같다면  새로운 비밀번호 만들기
	          loc = request.getContextPath()+"/pwdUpdate.lmsfinal?userid="+userid;  // 변경할 유저 아이디   // 이렇게 갈때는 POST 로 못가나?
	       
	          mav.addObject("message", message);
			  mav.addObject("loc", loc);
			
			  mav.setViewName("msg");
			  // /WEB-INF/views/msg.jsp 페이지를 만들어야한다.
	      
	      }
	       else {
	          message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
	          loc = request.getContextPath()+"/pwdFind.lmsfinal";
	       
	          mav.addObject("message", message);
			  mav.addObject("loc", loc);
				
			  mav.setViewName("msg");
			  // /WEB-INF/views/msg.jsp 페이지를 만들어야한다.
	       }
	      ////////////////////////////////////////////////////////////////////////////////////////////
	      
	      return mav;
	   }
	   
	     
	   
	/////////  ===== ***** 11.비밀번호 찾기 페이지 요청 ***** ===== /////////
	@RequestMapping(value="/pwdUpdatepage.lmsfinal", method= {RequestMethod.GET})   // 폼 페이지가 떠야하니까 method get방식만
	public ModelAndView pwdUpdatepage(ModelAndView mav) {
		
		mav.setViewName("main/pwdUpdate.tiles1");  // 비밀번호 찾기 폼이 있는 페이지로 이동
		// /WEB-INF/views/tiles1/main/idfind.jsp  파일을 생성한다. 
		
		return mav;
	}
	   
    /////////  ===== ***** 12.비밀번호 변경 페이지 요청 ***** ===== /////////
	@RequestMapping(value="/pwdUpdate.lmsfinal")   // 폼 페이지가 떠야하니까 method get방식만
	public ModelAndView pwdUpdate(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();   
		String userid = request.getParameter("userid");
		
//		System.out.println("확인용 method : " + method);
		
		String userType = "";
		
		// 아이디를 가지고 와서 아이디의 첫자리가 1이라면 교원, 2라면 학생으로 구분하기
		
		if("POST".equalsIgnoreCase(method)) { 
			
			if(userid.length() == 5) {
				userType = "gyo";
			}
			
			else if(userid.length() == 9) {
				userType = "std";
			}
			
			String pwd = request.getParameter("pwd");
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("pwd", Sha256.encrypt(pwd));
			paraMap.put("userid", userid);
			paraMap.put("userType", userType);
			
			int n = service.getPwdUpdate(paraMap);
			
			request.setAttribute("n", n);
			
		}
		
		else if("GET".equalsIgnoreCase(method)) {
            //학생 교수 관리자가 아닌 그 외의 로그인 시도일때
            String message = "비정상적인 경로로 비밀번호 변경을 시도 헀습니다.";
            String loc = "javascript:history.back()";
            
            mav.addObject("message", message);
            mav.addObject("loc", loc);
            
            mav.setViewName("msg");
            // /WEB-INF/views/msg.jsp 페이지를 만들어야한다.
         }
		
		request.setAttribute("userid", userid);
		request.setAttribute("method", method);
		
		mav.setViewName("main/pwdUpdate.tiles1");  // 비밀번호 변경 폼이 있는 페이지로 이동
		// /WEB-INF/views/tiles1/main/idfind.jsp  파일을 생성한다. 
		
		return mav;
	}
	   

	   
	}