package com.spring.lmsfinal.leejeongjun.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.common.AES256;
import com.spring.lmsfinal.common.FileManager;
import com.spring.lmsfinal.leejeongjun.model.Leave_armyVO;
import com.spring.lmsfinal.leejeongjun.model.Leave_schoolVO;
import com.spring.lmsfinal.leejeongjun.model.Return_schoolVO;
import com.spring.lmsfinal.leejeongjun.model.TestinsertVO;
import com.spring.lmsfinal.leejeongjun.service.InterLjjService;

@Controller
public class LjjController {

	@Autowired
	private InterLjjService service;
	
	@Autowired
    private AES256 aes;
	
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
//////////////강의평가 파트 시작 //////////////////////////////////////////////////////	
	// === 강의평가 페이지 보여주기 === //
	@RequestMapping(value = "/lecture_evaluation.lmsfinal")
	public ModelAndView lecture_evaluation(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		Calendar cal = Calendar.getInstance();
		int curyear = cal.get(cal.YEAR);
		int curmonth = cal.get(cal.MONTH)+1;
		int curdate = cal.get(cal.DATE);
	//	System.out.println("확인용 현재년도 => "+curyear);
	//	System.out.println("확인용 현재년도 => "+curmonth);
	//	System.out.println("확인용 현재년도 => "+curdate);
		
		// 강의평가 기간여부 확인
		// 임의로 설정한 강의평가 기간은 1학기는 5월 1일 - 5월 24일까지이다.
		if(curmonth == 5) {
			if(curdate >= 1 && curdate <= 24) {
				// 이 분기안에 들어와야 강의평가가 가능하다.
				HttpSession session = request.getSession();
				StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
			//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
				String get_stdid = Integer.toString(stdid.getStdid());
				
				// 학생의 학번을 이용하여 수강테이블에서 해당학생이 이수한 학기 리스트 가져오기
				List<Map<String, String>> appsemesterList = service.appsemesterList(get_stdid);
			//	System.out.println("확인용~~~ appsemesterList => "+appsemesterList);
				
				mav.addObject("appsemesterList", appsemesterList);
				
				mav.setViewName("leejeongjun/lectEvaluation.tiles2");
			}
			else {
				// 강의평가 기간이 아닌경우
				String message = "강의평가 기간이 아닙니다! 학기일정을 확인하세요.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
		}
		else {
			// 강의평가 기간이 아닌경우
			String message = "강의평가 기간이 아닙니다! 학기일정을 확인하세요.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
		}
		
		
		
		return mav;
	}
	
	// 해당학기에 강의평가해야할 과목리스트 가져오기
	@ResponseBody
	@RequestMapping(value="/inputSemestershow.lmsfinal", produces="text/plain;charset=UTF-8")
	public String inputSemestershow(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO) session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+Integer.toString(stdid.getStdid()));
		
		String inputSemester = request.getParameter("inputSemester");
	//	System.out.println("확인용 inputSemester "+inputSemester);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("inputSemester", inputSemester);
		paraMap.put("stdid", Integer.toString(stdid.getStdid()));
		
		// 해당 학기에 수강한 과목들 조회하기
		List<Map<String, String>> inputSemesterList = service.inputSemesterList(paraMap);
	//	System.out.println("확인용 ~~~~~~~ inputSemesterList "+inputSemesterList);
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : inputSemesterList) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("courseno", map.get("courseno"));
			jsonObj.addProperty("appsemester", map.get("appsemester"));
			jsonObj.addProperty("classname", map.get("classname"));
			jsonObj.addProperty("subjectid", map.get("subjectid"));
			jsonObj.addProperty("gyoname", map.get("gyoname"));
			jsonObj.addProperty("evaluwhether", map.get("evaluwhether"));
			
			jsonArr.add(jsonObj);
		}// end of for------------------------------
		
		return new Gson().toJson(jsonArr);
	}
	
	// 강의평가 문항 보여주기
	@ResponseBody
	@RequestMapping(value="/goLectureEvaluation.lmsfinal", produces="text/plain;charset=UTF-8")
	public String goLectureEvaluation(HttpServletRequest request) {
		
		String choice_courseno = request.getParameter("choice_courseno");
	//	System.out.println("~~~~확인용 choice_courseno "+choice_courseno);
		
		// 선택한 과목의 수강코드로 해당 강의평가 문항 가져오기
		List<Map<String, String>> lectureEvaluationQuestions = service.choice_LectureEvaluationQuestions(choice_courseno); 
	//	System.out.println("~~~~확인용 lectureEvaluationQuestions => "+lectureEvaluationQuestions);
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : lectureEvaluationQuestions) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("evalucode", map.get("evalucode"));
			jsonObj.addProperty("courseno", map.get("courseno"));
			jsonObj.addProperty("classname", map.get("classname"));
			jsonObj.addProperty("gyoname", map.get("gyoname"));
			
			jsonArr.add(jsonObj);
		}// end of for------------------------------
		
		return new Gson().toJson(jsonArr);
	}
	
	// 강의평가 완료하기
	@RequestMapping(value="/lectureEvaluationEnd.lmsfinal")
	public ModelAndView lectureEvaluationEnd(ModelAndView mav, HttpServletRequest request) {
		
		String courseno = request.getParameter("courseno");
		String evalucode = request.getParameter("evalucode");
		String firstans = request.getParameter("firstans");
		String secondans = request.getParameter("secondans");
		String thirdans = request.getParameter("thirdans");
		String fourans = request.getParameter("fourans");
		String fiveans = request.getParameter("fiveans");
		String sixans = request.getParameter("sixans");
		String sevenans = request.getParameter("sevenans");
		String eightans = request.getParameter("eightans");
		String etcans = request.getParameter("etcans");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("courseno", courseno);
		paraMap.put("evalucode", evalucode);
		paraMap.put("firstans", firstans);
		paraMap.put("secondans", secondans);
		paraMap.put("thirdans", thirdans);
		paraMap.put("fourans", fourans);
		paraMap.put("fiveans", fiveans);
		paraMap.put("sixans", sixans);
		paraMap.put("sevenans", sevenans);
		paraMap.put("eightans", eightans);
		paraMap.put("etcans", etcans);
		
		// 강의평가 체크한 값들을 강의평가 완료 테이블에 update 하기 //
		int n = service.addlectureEvaluation(paraMap);
		
		if(!(n == 1)) {
			// 강의평가 실패했을 경우
			String message = "강의평가가 제대로 이루어지지 않았습니다. 정상적인 경로로 접근하세요.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			return mav;
		}
		else {
			// 강의평가가 제대로 완료가 되었다면 
			// 강의평가한 과목의 courseno와 evalucode을 가지고 
			// 수강 테이블에 있는 해당 과목의 강의평가유무를 1로 업데이트해야함(평가완료)
			// 강의평가유무 업데이트하기
			service.updateLectureEvaluation(paraMap);
		}
		
		mav.setViewName("redirect:/lecture_evaluation.lmsfinal");
		
		return mav;
	}
//////////////강의평가 파트 끝 //////////////////////////////////////////////////////	
	
	
/////////////휴복학 파트 시작///////////////////////////////////////////////////////
	
	// 휴학신청 페이지 이동
	@RequestMapping(value = "/Application_for_leave_of_absence.lmsfinal")
	public ModelAndView Application_for_leave_of_absence(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		
		String get_stdid = Integer.toString(stdid.getStdid());
		
		Map<String, String> studentInfo = service.selectOneStudent(get_stdid);
	//	System.out.println("~~~확인용 studentInfo => "+studentInfo);
		
		// 휴학테이블에서 학번과 조건값을 이용해서 '승인전'의 개수를 얻어오기(휴학 중복신청 막기위해서)
		String approve = "승인전";
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("stdid", get_stdid);
		paraMap.put("approve", approve);
		
		Map<String, String> count_approve = service.countApprove(paraMap); 
	//	System.out.println("확인용 count_approve "+count_approve);
		String cnt_approve = String.valueOf(count_approve.get("APPROVE")) ;
	//	System.out.println("확인용 cnt_approve "+(cnt_approve == "0") );
	
		
		if( !"0".equals(cnt_approve) ) {
		//	System.out.println("휴학신청했어!");
			//이미 휴학신청을 한 경우!
			String message = "이미 휴학신청을 하셨습니다. 휴학신청내역을 확인하세요.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			return mav;
		}
		
		String STDEMAIL = null;
		try {
			STDEMAIL = aes.decrypt((studentInfo.get("STDEMAIL")));
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
	//	System.out.println("확인용 STDEMAIL => "+STDEMAIL);
	
		mav.addObject("studentInfo", studentInfo);
		mav.addObject("STDEMAIL", STDEMAIL);
		mav.setViewName("leejeongjun/leave_of_absence.tiles2");
	
		return mav;
	}
	
	
	// 휴학신청하기(트랜잭션처리)
	@RequestMapping(value="/insert_leaveAdd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView insert_leaveAdd(MultipartHttpServletRequest mrequest, ModelAndView mav, Leave_schoolVO leaveschoolvo, Leave_armyVO leavearmyvo) {
	
		String stdstateid = "6";	// 휴학신청 후 학생 테이블의 학적상태를 '휴학신청' 상태로 변경해주기 위해서 필요한 변수
		
		MultipartFile attach = leavearmyvo.getAttach();
	//	System.out.println("~~확인용 attach =>"+ leavearmyvo.getAttach());
		if(!attach.isEmpty()) {
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
		//	System.out.println("~~~~ 확인용 webapp 의 절대경로 => " + root);
			// ~~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
		
			String path = root+"resources"+File.separator+"files";
			
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
			
			long fileSize = 0;
			// 첨부파일의 크기
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
			//	System.out.println("~~~ 확인용 originalFilename => "+originalFilename);
				// ~~~ 확인용 originalFilename => manP51.jpg
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
				
			//	System.out.println(">>> 확인용 newFileName => "+ newFileName);
				// >>> 확인용 newFileName => 202204291230481336311367859300.pdf
				
				/*
					3. 	leavearmyvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기	
				*/
				leavearmyvo.setFileName(newFileName);
				// WAS(톰캣)에 저장될 파일명(202204291230481336311367859300.pdf)
				
				leavearmyvo.setOrgFilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				leavearmyvo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int n= 0;
		
		if(attach.isEmpty()) {
			// 파일첨부가 없는 일반휴학신청이라면
			try {
				n = service.leaveAdd(leaveschoolvo, stdstateid);
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
		else {
			// 파일첨부가 있는 군휴학신청이라면
			try {
				n = service.leaveArmyAdd(leavearmyvo, stdstateid);
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(n==1) {
			mav.setViewName("redirect:/leave_result.lmsfinal");
		}
		else {
			// 휴학신청이 제대로 안 되었을 경우!
			
		}
		return mav;
	}
	
	
	// 휴학신청결과조회 페이지 이동
	@RequestMapping(value = "/leave_result.lmsfinal")
	public ModelAndView leave_result(HttpServletRequest request, ModelAndView mav) {
	
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		
		String get_stdid = Integer.toString(stdid.getStdid());
		
		// 로그인한 학생의 휴학내역을 다 뽑아오기
		List<Map<String, String>> leave_list = service.leave_List(get_stdid);
	//	System.out.println("확인용 leave_list => "+leave_list);
		
		mav.addObject("leave_list", leave_list);
		mav.setViewName("leejeongjun/leave_result.tiles2");
		
		return mav;
	}
	
	
	// 첨부파일 다운로드 하기
	@RequestMapping(value="/download_add.lmsfinal")
	public void download(HttpServletRequest request, HttpServletResponse response) {
		
		String leaveno =request.getParameter("leaveno");
		// 첨부파일이 있는 휴학코드번호
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("leaveno", leaveno);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체
		
		try {
			Integer.parseInt(leaveno);
			Leave_armyVO leavearmyvo = service.getViewleave(paraMap);
			
			if(leavearmyvo == null || (leavearmyvo != null && leavearmyvo.getFileName() == null)) {	// 유저가 장난친경우	
				out = response.getWriter();
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 휴학신청코드 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return;
			}
			else { // 정상적인 접근
				// 정상적으로 다운로드를 할 경우
				
				String fileName = leavearmyvo.getFileName();
				
				String orgfilename = leavearmyvo.getOrgFilename();
				
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				
				String path = root+"resources"+File.separator+"files";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
					운영체제가 Windows 이라면 File.separator 는  "\" 이고,
					운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
				*/
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//	System.out.println("~~~~ 확인용 path 의 절대경로 => " + root);
				
				boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
				flag = fileManager.doFileDownload(fileName, orgfilename, path, response);
				// file 다운로드 성공시 flag 는 true,
				// file 다운로드 실패시 flag 는 false 를 가진다.
				
				if(!flag) {
					// 다운로드가 실패할 경우 메시지를 띄워준다.
					out = response.getWriter();
					// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
					
					out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");					
				}
			}
			
		} catch(NumberFormatException | IOException e) {
			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
		            
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}// end of public void download(HttpServletRequest request, HttpServletResponse response) {------------------
	
	
	// 휴학신청 취소하기(트랜잭션처리)
	@RequestMapping(value="/cancel_leave.lmsfinal")
	public ModelAndView cancel_leave(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String stdstateid = "1";	// 휴학신청 취소 후 학생 테이블의 학적상태를 '재학' 상태로 변경해주기 위해서 필요한 변수
		
		String leaveno = request.getParameter("leaveno");
	//	System.out.println("삭제할 휴학번호는 => "+leaveno);
		String filename = request.getParameter("filename");
	//	System.out.println("삭제할 파일이름 => "+filename);
		
		HttpSession session = request.getSession();
		
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
		//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
			
		String get_stdid = Integer.toString(stdid.getStdid());
		
		String root = session.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator+"files";
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("leaveno", leaveno);
		paraMap.put("path", path);
		paraMap.put("filename", filename);
		paraMap.put("stdstateid", stdstateid);
		paraMap.put("stdid", get_stdid);
		
		// 휴학신청 취소하기(트랜잭션 처리하기)
		int n;
		try {
			n = service.delLeave(paraMap);
			
			if(n==1) {
				mav.addObject("message", "휴학신청 취소 성공!!!");
				mav.addObject("loc", request.getContextPath()+"/leave_result.lmsfinal"); // 휴학신청내역결과 페이지로 이동
			}
			else {
				mav.addObject("message", "휴학신청 취소 실패!!!");
				mav.addObject("loc", "javascript:history.back()");
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	// 휴학신청수정하기(파일첨부 유무에 따라 분기)
	@RequestMapping(value="/edit_leave.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView edit_leave(MultipartHttpServletRequest mrequest, ModelAndView mav, Leave_schoolVO leaveschoolvo, Leave_armyVO leavearmyvo) {
		
		MultipartFile attach = leavearmyvo.getAttach();
	
	//	System.out.println("~~확인용 attach =>"+ leavearmyvo.getAttach());
		if( !attach.isEmpty()) {
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
		//	System.out.println("~~~~ 확인용 webapp 의 절대경로 => " + root);
			// ~~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
		
			String path = root+"resources"+File.separator+"files";
			
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
			
			long fileSize = 0;
			// 첨부파일의 크기
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
			//	System.out.println("~~~ 확인용 originalFilename => "+originalFilename);
				// ~~~ 확인용 originalFilename => manP51.jpg
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
				
			//	System.out.println(">>> 확인용 newFileName => "+ newFileName);
				// >>> 확인용 newFileName => 202204291230481336311367859300.pdf
				
				/*
					3. leavearmyvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기	
				*/
				leavearmyvo.setFileName(newFileName);
				// WAS(톰캣)에 저장될 파일명(202204291230481336311367859300.pdf)
				
				leavearmyvo.setOrgFilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				leavearmyvo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int n= 0;
		
		if(attach.isEmpty()) {
			// 파일첨부가 없는 일반휴학신청이라면
			n = service.edit_leave(leaveschoolvo);
		}
		else {
			// 파일첨부가 있는 군휴학신청이라면
			n = service.edit_leaveArmy(leavearmyvo);
		}
		
		if(n==1) {
			mav.setViewName("redirect:/leave_result.lmsfinal");
		}
		else {
			// 휴학신청이 제대로 안 되었을 경우!
			
		}
		return mav;
	}
	
	
	// 복학신청 페이지 이동
	@RequestMapping(value = "/Application_for_returnSchool.lmsfinal")
	public ModelAndView Application_for_returnSchool(HttpServletRequest request, ModelAndView mav) {
		
		/////////////////// 학생 정보 담기 시작////////////////////////////////////////
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		
		String get_stdid = Integer.toString(stdid.getStdid());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("stdid", get_stdid);
		
		// 로그인한 학생의 학적정보 가져오기
		Map<String, String> studentInfo = service.selectOneStudent(get_stdid);
	//	System.out.println("~~~확인용 studentInfo => "+studentInfo);
		
		String STDEMAIL = null;
		try {
			STDEMAIL = aes.decrypt((studentInfo.get("STDEMAIL")));
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
	//	System.out.println("확인용 STDEMAIL => "+STDEMAIL);
	
		mav.addObject("studentInfo", studentInfo);
		mav.addObject("STDEMAIL", STDEMAIL);
		/////////////////// 학생 정보 담기 끝////////////////////////////////////////
		
		////////////// 현재날짜 기준으로 가장 가까운 복학학기 계산하기 ////////////////////
		Calendar cal = Calendar.getInstance();
		int curyear = cal.get(cal.YEAR);
		int curmonth = cal.get(cal.MONTH)+1;
		String comesem = "";
		
		if(curmonth >= 9 || curmonth < 3) {
			if(curmonth >= 1 && curmonth < 3) {
				comesem = (curyear) + " / 1학기";
			}
			else {
				comesem = (curyear+1) + " / 1학기";
			}
		}
		if(curmonth >= 3 && curmonth < 9) {
			comesem = curyear + " / 2학기";
		}
		
	//	System.out.println("복학예정학기는 "+comesem);
		mav.addObject("comesem", comesem);
		//////////////현재날짜 기준으로 가장 가까운 복학학기 계산하기 끝////////////////////
	
		///////////// 계산한 복학학기와 학번을 가지고 휴학테이블에가서 해당 휴학내역이 있으면 가져오기////
		paraMap.put("comesem", comesem);
		Map<String, String> choice_std_leave_return = service.getleaveReturn(paraMap); 
	//	System.out.println("확인용 choice_std_leave_return=> "+choice_std_leave_return);
		
		mav.addObject("choice_std_leave_return", choice_std_leave_return);
		mav.setViewName("leejeongjun/return_school.tiles2");
			
		return mav;
	}

	
	// 복학신청하기(파일첨부x 트랜잭션처리)
	@ResponseBody
	@RequestMapping(value="/addReturnSchool.lmsfinal", produces="text/plain;charset=UTF-8")
	public String addReturnSchool(HttpServletRequest request) {
		
		String stdstateid = "7";	// 복학신청 후 학생 테이블의 학적상태를 '복학신청' 상태로 변경해주기 위해서 필요한 변수
		
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		
		String get_stdid = Integer.toString(stdid.getStdid());
		
		JsonObject jsonObj = new JsonObject();
		
		// 이미 복학신청한 내역이 있는지 검사하기
		int check_return = service.checkReturn(get_stdid);
		
		if(check_return == 1) {	// 이미 복학 신청하였다면
			boolean check_return_school = false;
			jsonObj.addProperty("check_return_school", check_return_school);
			return jsonObj.toString();
		}
		else {	// 복학신청하기
			String returntype = request.getParameter("returntype");
		//	System.out.println("~~~~확인용 returntype "+returntype);
			// ~~~~확인용 returntype 일반복학
			String returnsemester = request.getParameter("returnsemester");
		//	System.out.println("~~~~확인용 returnsemester "+returnsemester);
			// ~~~~확인용 returnsemester 2022 / 2학기
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("stdid", get_stdid);
			paraMap.put("returntype", returntype);
			paraMap.put("returnsemester", returnsemester);
			paraMap.put("stdstateid", stdstateid);
			
			// 복학신청하기(트랜잭션처리)
			int n = 0;
			try {
				n = service.addReturnSchool(paraMap);

				jsonObj.addProperty("result_addReturn", n);
				System.out.println("jsonObj 값은?"+jsonObj);
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return jsonObj.toString();
		}
	}
	
	
	// 복학신청내역 보여주기
	@ResponseBody
	@RequestMapping(value="/showReturnSchool.lmsfinal", produces="text/plain;charset=UTF-8")
	public String addandshowReturnSchool(HttpServletRequest request) {
		
		String returntype = request.getParameter("returntype");
	//	System.out.println("~~~확인용 returntype"+returntype);
		
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		
		String get_stdid = Integer.toString(stdid.getStdid());
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("stdid", get_stdid);
		paraMap.put("returntype", returntype);
		
		JsonArray jsonArr = new JsonArray();
		
		if("일반복학".equals(returntype)) {
			// 복학신청내역 가져오기(파일첨부x)
			List<Map<String, String>> return_list = service.returnList(paraMap); 
			System.out.println("~~~~확인용 return_list => "+return_list);
			
			for(Map<String, String> map : return_list) {
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("returnsemester", map.get("returnsemester"));
				jsonObj.addProperty("regdate", map.get("regdate"));
				jsonObj.addProperty("returntype", map.get("returntype"));
				jsonObj.addProperty("approve", map.get("approve"));
				jsonObj.addProperty("returnseq", map.get("returnseq"));
				jsonObj.addProperty("filename", map.get("filename"));
		
				jsonArr.add(jsonObj);
			}// end of for------------------------------
		}
		else if("군복학".equals(returntype)) {
			// 복학신청내역 가져오기(파일첨부x)
			List<Map<String, String>> return_listAttach = service.returnListAttach(paraMap); 
			System.out.println("~~~~확인용 return_list => "+return_listAttach);
			
			for(Map<String, String> map : return_listAttach) {
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("returnsemester", map.get("returnsemester"));
				jsonObj.addProperty("regdate", map.get("regdate"));
				jsonObj.addProperty("returntype", map.get("returntype"));
				jsonObj.addProperty("approve", map.get("approve"));
				jsonObj.addProperty("returnseq", map.get("returnseq"));
				jsonObj.addProperty("orgfilename", map.get("orgfilename"));
				jsonObj.addProperty("filename", map.get("filename"));
				
				jsonArr.add(jsonObj);
			}// end of for------------------------------
		}
		
		return new Gson().toJson(jsonArr);
	}
	
	
	// 복학신청 취소하기(트랜잭션처리)
	@RequestMapping(value="/cancel_return.lmsfinal")
	public ModelAndView cancel_return(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String stdstateid = "2";	// 복학신청 취소 후 학생 테이블의 학적상태를 '휴학' 상태로 변경해주기 위해서 필요한 변수
		
		String returnseq = request.getParameter("returnseq");
	//	System.out.println("삭제할 복학신청번호는 => "+returnseq);
		String filename = request.getParameter("filename");
	//	System.out.println("삭제할 파일이름 => "+filename);
		
		HttpSession session = request.getSession();
		
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
		//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
			
		String get_stdid = Integer.toString(stdid.getStdid());
		String root = session.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator+"returnfiles";
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("returnseq", returnseq);
		paraMap.put("path", path);
		paraMap.put("filename", filename);
		paraMap.put("stdid", get_stdid);
		paraMap.put("stdstateid", stdstateid);
		
		// 복학신청 취소하기(트랜잭션처리)
		int n=0;
		try {
			n = service.delreturn(paraMap);	
			if(n==1) {
				mav.addObject("message", "복학신청 취소 성공!!!");
				mav.addObject("loc", request.getContextPath()+"/Application_for_returnSchool.lmsfinal"); // 복학신청및결과조회 페이지로 이동
			}
			else {
				mav.addObject("message", "복학신청 취소 실패!!!");
				mav.addObject("loc", "javascript:history.back()");
			}
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	// 복학신청하기(파일첨부o 트랜잭션처리)
	@RequestMapping(value="/addreturn_attach.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView addreturn_army(MultipartHttpServletRequest mrequest, ModelAndView mav, Return_schoolVO returnschoolvo) {
		
		String stdstateid = "7";	// 복학신청 후 학생 테이블의 학적상태를 '복학신청' 상태로 변경해주기 위해서 필요한 변수
		
		HttpSession session = mrequest.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		
		String get_stdid = Integer.toString(stdid.getStdid());
		
		
		// 이미 복학신청한 내역이 있는지 검사하기
		int check_return = service.checkReturn(get_stdid);
		
		if(check_return == 1) {	// 이미 복학 신청하였다면
			mav.addObject("message", "이미 복학신청 하셨습니다. 승인을 기다려주세요.");
			mav.addObject("loc", mrequest.getContextPath()+"/Application_for_returnSchool.lmsfinal");
			mav.setViewName("msg");
			return mav;
		}
		
		MultipartFile attach = returnschoolvo.getAttach();
	
	//	System.out.println("~~확인용 attach =>"+ returnschoolvo.getAttach());
		if( !attach.isEmpty()) {
			
			
			String root = session.getServletContext().getRealPath("/");
		//	System.out.println("~~~~ 확인용 webapp 의 절대경로 => " + root);
			// ~~~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
		
			String path = root+"resources"+File.separator+"returnfiles";
			
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
			
			long fileSize = 0;
			// 첨부파일의 크기
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
			//	System.out.println("~~~ 확인용 originalFilename => "+originalFilename);
				// ~~~ 확인용 originalFilename => manP51.jpg
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
				
			//	System.out.println(">>> 확인용 newFileName => "+ newFileName);
				// >>> 확인용 newFileName => 202204291230481336311367859300.pdf
				
				/*
					3. returnschoolvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기	
				*/
				returnschoolvo.setFileName(newFileName);
				// WAS(톰캣)에 저장될 파일명(202204291230481336311367859300.pdf)
				
				returnschoolvo.setOrgFilename(originalFilename);
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				
				fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
				returnschoolvo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int n;
		try {
			n = service.add_returnAttach(returnschoolvo, stdstateid);
			if(n==1) {
				mav.setViewName("redirect:/Application_for_returnSchool.lmsfinal");
			}
			else {
				// 군복학신청이 제대로 안 되었을 경우!
				mav.addObject("message", "복학신청 취소 실패!!!");
				mav.addObject("loc", "javascript:history.back()");
			}
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
	// 첨부파일 다운로드 하기
	@RequestMapping(value="/download_return.lmsfinal")
	public void download_return(HttpServletRequest request, HttpServletResponse response) {
		
		String returnseq =request.getParameter("returnseq");
		// 첨부파일이 있는 복학코드번호
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("returnseq", returnseq);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체
		
		try {
			Integer.parseInt(returnseq);
			Return_schoolVO returnschoolvo = service.getViewreturn(paraMap);
			
			if(returnschoolvo == null || (returnschoolvo != null && returnschoolvo.getFileName() == null)) {	// 유저가 장난친경우	
				out = response.getWriter();
				
				out.println("<script type='text/javascript'>alert('존재하지 않는 복학신청코드 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
				return;
			}
			else { // 정상적인 접근
				// 정상적으로 다운로드를 할 경우
				
				String fileName = returnschoolvo.getFileName();
				
				String orgfilename = returnschoolvo.getOrgFilename();
				
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				
				String path = root+"resources"+File.separator+"returnfiles";
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
					운영체제가 Windows 이라면 File.separator 는  "\" 이고,
					운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
				*/
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//	System.out.println("~~~~ 확인용 path 의 절대경로 => " + root);
				
				boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
				flag = fileManager.doFileDownload(fileName, orgfilename, path, response);
				// file 다운로드 성공시 flag 는 true,
				// file 다운로드 실패시 flag 는 false 를 가진다.
				
				if(!flag) {
					// 다운로드가 실패할 경우 메시지를 띄워준다.
					out = response.getWriter();
					// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
					
					out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");					
				}
			}
			
		} catch(NumberFormatException | IOException e) {
			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
		            
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}// end of public void download(HttpServletRequest request, HttpServletResponse response) {------------------
		
/////////////휴복학 파트 끝///////////////////////////////////////////////////////	


/////////////장학금 파트 시작///////////////////////////////////////////////////////	
	// 로그인한 학생의 장학금지급내역 페이지 보여주기
	@RequestMapping(value = "/stdscholarship.lmsfinal")
	public ModelAndView stdscholarship(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		/////////////////// 학생 정보 담기 시작////////////////////////////////////////
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		String get_stdid = Integer.toString(stdid.getStdid());
		
		// 로그인한 학생의 학적정보 가져오기
		Map<String, String> studentInfo = service.selectOneStudent(get_stdid);
	//	System.out.println("~~~확인용 studentInfo => "+studentInfo);
		
		String STDEMAIL = null;
		try {
			STDEMAIL = aes.decrypt((studentInfo.get("STDEMAIL")));
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
	//	System.out.println("확인용 STDEMAIL => "+STDEMAIL);
	
		mav.addObject("studentInfo", studentInfo);
		mav.addObject("STDEMAIL", STDEMAIL);
		/////////////////// 학생 정보 담기 끝////////////////////////////////////////
		
		////////////////// 로그인한 학생의 학번을 이용하여 장학내역 조회하기 시작 ///////////////////
		List<Map<String, String>> stdscholarshipList = service.stdscholarship_List(get_stdid);
		
		mav.addObject("stdscholarshipList", stdscholarshipList);
		////////////////// 로그인한 학생의 학번을 이용하여 장학내역 조회하기 끝 ///////////////////
		mav.setViewName("leejeongjun/stdscholarship.tiles2");
		return mav;
	}
	
	// 장학지급내역 엑셀파일로 다운 받기
	@RequestMapping(value = "/excel/downloadExcelFile.lmsfinal")
	public String downloadExcelFile(HttpServletRequest request, Model model) {
		
		/////////////////// 학생 정보 담기 시작////////////////////////////////////////
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		String get_stdid = Integer.toString(stdid.getStdid());
		
		// 로그인한 학생의 학번을 이용하여 장학내역 조회하기
		List<Map<String, String>> stdscholarshipList = service.stdscholarship_List(get_stdid);
		
		// === 조회결과물인 empList 를 가지고 엑셀 시트 생성하기 ===
		// 시트를 생성하고, 행을 생성하고, 셀을 생성하고, 셀안에 내용을 넣어주면 된다.
		
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		
		// 시트 생성
		SXSSFSheet sheet = workbook.createSheet("장학금지급내역");
		
		// 시트열 너비 설정
		sheet.setColumnWidth(0, 1500);
		sheet.setColumnWidth(1, 4000);
		sheet.setColumnWidth(2, 4000);
		sheet.setColumnWidth(3, 4000);
		sheet.setColumnWidth(4, 4000);
		
		// 행의 위치를 나타내는 변수
		int rowLocation = 0;
		
		////////////////////////////////////////////////////////////////////////////////////////
		// CellStyle 정렬하기(Alignment)
		// CellStyle 객체를 생성하여 Alignment 세팅하는 메소드를 호출해서 인자값을 넣어준다.
		// 아래는 HorizontalAlignment(가로)와 VerticalAlignment(세로)를 모두 가운데 정렬 시켰다.
		
		CellStyle mergeRowStyle = workbook.createCellStyle();
		mergeRowStyle.setAlignment(HorizontalAlignment.CENTER);
		mergeRowStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		// import org.apache.poi.ss.usermodel.VerticalAlignment 으로 해야함.

		CellStyle headerStyle = workbook.createCellStyle();
		headerStyle.setAlignment(HorizontalAlignment.CENTER);
		headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
	      
		
		// CellStyle 배경색(ForegroundColor)만들기
        // setFillForegroundColor 메소드에 IndexedColors Enum인자를 사용한다.
        // setFillPattern은 해당 색을 어떤 패턴으로 입힐지를 정한다.
		mergeRowStyle.setFillForegroundColor(IndexedColors.PINK.getIndex());	// IndexedColors.DARK_BLUE.getIndex() 는 색상(남색)의 인덱스값을 리턴시켜준다.
		mergeRowStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		headerStyle.setFillForegroundColor(IndexedColors.LIGHT_ORANGE.getIndex());	// IndexedColors.LIGHT_YELLOW.getIndex() 는 연한노랑의 인덱스값을 리턴시켜준다.
		headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		
		// CellStyle 천단위 쉼표, 금액
        CellStyle moneyStyle = workbook.createCellStyle();
        moneyStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
        
		
		// Cell 폰트(Font) 설정하기
        // 폰트 적용을 위해 POI 라이브러리의 Font 객체를 생성해준다.
        // 해당 객체의 세터를 사용해 폰트를 설정해준다. 대표적으로 글씨체, 크기, 색상, 굵기만 설정한다.
        // 이후 CellStyle의 setFont 메소드를 사용해 인자로 폰트를 넣어준다.
		Font mergeRowFont = workbook.createFont();	// import org.apache.poi.ss.usermodel.Font; 으로 한다.
		mergeRowFont.setFontName("맑은고딕");
		mergeRowFont.setFontHeight((short)500);
		mergeRowFont.setColor(IndexedColors.WHITE.getIndex());
		mergeRowFont.setBold(true);
		
		mergeRowStyle.setFont(mergeRowFont);
		
		
		// CellStyle 테두리 Border
        // 테두리는 각 셀마다 상하좌우 모두 설정해준다.
        // setBorderTop, Bottom, Left, Right 메소드와 인자로 POI라이브러리의 BorderStyle 인자를 넣어서 적용한다.
		headerStyle.setBorderTop(BorderStyle.THICK);
		headerStyle.setBorderBottom(BorderStyle.THICK);
		headerStyle.setBorderLeft(BorderStyle.THIN);
		headerStyle.setBorderRight(BorderStyle.THIN);
		
		// Cell Merge 셀 병합시키기
        /* 셀병합은 시트의 addMergeRegion 메소드에 CellRangeAddress 객체를 인자로 하여 병합시킨다.
           CellRangeAddress 생성자의 인자로(시작 행, 끝 행, 시작 열, 끝 열) 순서대로 넣어서 병합시킬 범위를 정한다. 배열처럼 시작은 0부터이다.  
        */
        // 병합할 행 만들기
		Row mergeRow = sheet.createRow(rowLocation);	// 엑셀에서 행의 시작은 0부터 시작한다.
		
		// 병합할 행에 "우리회사 사원정보" 로 셀을 만들어 셀에 스타일을 주기
		for(int i=0; i<5; i++) {
			Cell cell = mergeRow.createCell(i);
			cell.setCellStyle(mergeRowStyle);
			cell.setCellValue(get_stdid+"의 장학지급내역");
		}// end of for---------------------
		
		
		// 셀 병합하기
		sheet.addMergedRegion(new CellRangeAddress(rowLocation, rowLocation, 0, 4)); // 시작 행, 끝 행, 시작 열, 끝 열 
        ////////////////////////////////////////////////////////////////////////////////////////////////
		
		// 헤더 행 생성
        Row headerRow = sheet.createRow(++rowLocation); // 엑셀에서 행의 시작은 0 부터 시작한다.
                                                        // ++rowLocation는 전위연산자임. 
        
        // 해당 행의 첫번째 열 셀 생성
        Cell headerCell = headerRow.createCell(0);	// 엑셀에서 열의 시작은 0 부터 시작한다.
        headerCell.setCellValue("순번");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 두번째 열 셀 생성
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("지급학기");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 세번째 열 셀 생성
        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("분류명");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 네번째 열 셀 생성
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("장학명");
        headerCell.setCellStyle(headerStyle);
        
        // 해당 행의 다섯번째 열 셀 생성
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("장학금액");
        headerCell.setCellStyle(headerStyle);
        
		
     // ==== HR사원정보 내용에 해당하는 행 및 셀 생성하기 ==== //
        Row bodyRow = null;
        Cell bodyCell = null;
        
        for(int i=0; i<stdscholarshipList.size(); i++) {
        	
        	Map<String, String> stdscholarshipMap = stdscholarshipList.get(i);	// 사원 1명에 대한 정보
        	
        	// 행생성
        	bodyRow = sheet.createRow(i + (rowLocation+1));
        	
        	// 데이터 순번 표시
        	bodyCell = bodyRow.createCell(0);
        	bodyCell.setCellValue(1+i);
        	
        	// 데이터 지급학기 표시
        	bodyCell = bodyRow.createCell(1);
        	bodyCell.setCellValue(stdscholarshipMap.get("paysemester"));
        	
        	// 데이터 분류명 표시
        	bodyCell = bodyRow.createCell(2);
        	bodyCell.setCellValue(stdscholarshipMap.get("sortname"));
        	
        	// 데이터 장학명 표시
        	bodyCell = bodyRow.createCell(3);
        	bodyCell.setCellValue(stdscholarshipMap.get("scholarshipnm"));
        	
        	// 데이터 장학금액 표시
        	bodyCell = bodyRow.createCell(4);
        	bodyCell.setCellValue(Integer.parseInt(stdscholarshipMap.get("scholarshipamt")));
        	bodyCell.setCellStyle(moneyStyle); // 천단위 쉼표, 금액
        	
        }// end of for-------------------------
		
        model.addAttribute("locale", Locale.KOREA);
        model.addAttribute("workbook", workbook);
        model.addAttribute("workbookName", "장학지급내역");	// 다운받을 엑셀파일의 이름
		
        return "excelDownloadView";
		//   "excelDownloadView" 은 
		//  /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서
		//  뷰리졸버 0 순위로 기술된 bean 의 id 값이다.    
		
	}
	
/////////////장학금 파트 끝///////////////////////////////////////////////////////	

	@RequestMapping(value = "/testinsert.lmsfinal")
	public ModelAndView testinsert(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, TestinsertVO testinsertvo) {
		
		int n = service.testinsert(testinsertvo);
		System.out.println("확인용 testinsertvo의 courseno 는" + testinsertvo.getCourseno());
		return mav;
	}
	
	@RequestMapping(value = "/testinsert2.lmsfinal")
	public ModelAndView testinsert(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String courseno = "";
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("courseno", courseno);
		
		int n = service.testinsert2(paraMap);
		System.out.println("확인용 courseno "+paraMap.get("courseno"));
		return mav;
	}
	
/////////////성적조회 파트 시작///////////////////////////////////////////////////////
	// 성적조회 페이지 이동
	@RequestMapping(value = "/result_grade.lmsfinal")
	public ModelAndView result_grade(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		String get_stdid = Integer.toString(stdid.getStdid());
		
		// 학생의 학번을 이용하여 수강테이블에서 해당학생이 이수한 학기 리스트 가져오기
		List<Map<String, String>> appsemesterList = service.appsemesterList(get_stdid);
		System.out.println("확인용~~~ appsemesterList => "+appsemesterList);
		
		mav.addObject("appsemesterList", appsemesterList);
		mav.setViewName("leejeongjun/result_grade.tiles2");
		return mav;
	}
	
	
	// 해당학기에 수강한 과목의 성적 가져오기
	@ResponseBody
	@RequestMapping(value="/getGrade.lmsfinal", produces="text/plain;charset=UTF-8")
	public String getGrade(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		StudentVO stdid = (StudentVO)  session.getAttribute("loginuser");
	//	System.out.println("~~확인용 로그인한 학생 학번은? => "+ Integer.toString(stdid.getStdid()));
		String get_stdid = Integer.toString(stdid.getStdid());
		
		String latest_semester = request.getParameter("latest_semester");
		System.out.println("~~~~확인용 latest_semester "+latest_semester);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("get_stdid", get_stdid);
		paraMap.put("latest_semester", latest_semester);
		
		// 학번과 선택학기에 해당하는 성적리스트 가져오기
		List<Map<String, String>> getGradeList = service.getGradeList(paraMap); 
		System.out.println("~~~~확인용 getGradeList => "+getGradeList);
		
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : getGradeList) { 
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("courseno", map.get("courseno"));
			jsonObj.addProperty("classname", map.get("classname"));
			jsonObj.addProperty("appsemester", map.get("appsemester"));
			jsonObj.addProperty("credit", map.get("credit"));
			jsonObj.addProperty("courseclfc", map.get("courseclfc"));
			jsonObj.addProperty("grade", map.get("grade"));
			jsonObj.addProperty("evaluwhether", map.get("evaluwhether"));
			
			jsonArr.add(jsonObj);
		}// end of for------------------------------
		
		return new Gson().toJson(jsonArr); 
	}

/////////////성적조회 파트 끝///////////////////////////////////////////////////////
	
}
