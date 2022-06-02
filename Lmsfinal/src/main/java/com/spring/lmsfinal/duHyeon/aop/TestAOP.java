package com.spring.lmsfinal.duHyeon.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;


@Aspect		// 공통관심사 클래스로 등록
@Component	// bean 으로 등록
public class TestAOP {
	
	
	
	@Pointcut("execution(public * com.spring..*Controller.requiredLoginGyowon_*(..) )")
	public void requiredLoginGyowon() {}
	
	@Before("requiredLoginGyowon()")
	public void loginCheckGyowon(JoinPoint joinpoint) {
		
		// 로그인 유무를 확인하기 위해서는 request를 통해 session 을 얻어와야 한다. 
		HttpServletRequest request = (HttpServletRequest) joinpoint.getArgs()[0];  // 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다.  
		HttpServletResponse response = (HttpServletResponse) joinpoint.getArgs()[1]; // 주업무 메소드의 두번째 파라미터를 얻어오는 것이다.  
		
		HttpSession session = request.getSession();
		
		String message = "";
		String loc = request.getContextPath()+"/index.lmsfinal";
		
		
		
		
		if(session.getAttribute("loginuser") == null) {
			message = "먼저 로그인 하세요";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// >>> 로그인 성공후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< //
			// === 현재 페이지의 주소(URL) 알아오기 === //
			//String url = MyUtil.getCurrentURL(request);
			//session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다.
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
		else{
			if(session.getAttribute("loginuser").getClass().getName() != "com.spring.lmsfinal.yejinsim.model.GyowonVO") {
				message = "권한이 없습니다.";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				// >>> 로그인 성공후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< //
				// === 현재 페이지의 주소(URL) 알아오기 === //
				//String url = MyUtil.getCurrentURL(request);
				//session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다.
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
				try {
					dispatcher.forward(request, response);
				} catch (ServletException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}// end of loginCheckGyowon(JoinPoint joinpoint)-----------------------------------------------
	
	

}
