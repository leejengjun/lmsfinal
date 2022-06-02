package com.spring.lmsfinal.duHyeon.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.duHyeon.model.StudentExamVO;
import com.spring.lmsfinal.duHyeon.model.SubjectNoticeVO;
import com.spring.lmsfinal.duHyeon.service.InterNoticeService;
import com.spring.lmsfinal.duHyeon.service.InterTestService;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;



@Component
@Controller
public class TestController {
	
	
	@Autowired
	private InterTestService service;
	
	
	@Autowired
	private InterNoticeService noticeService;
	
	
	
	@RequestMapping(value="/leeduhyeontest.lmsfinal")
	public ModelAndView requiredLoginGyowon_setExam(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		// Before Advice를 이용해서 교수가 로그인 했을때만 들어올수 있도록 할것임
		// HttpSession session = request.set
		
		
		HttpSession session = request.getSession();
		
		String subjectid = request.getParameter("subjectid");
		

		GyowonVO loginuser = (GyowonVO)(session.getAttribute("loginuser"));
		
		String userid = loginuser.getGyowonid();
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subjectid", subjectid);
		paraMap.put("gyowonid", userid);
		
//		System.out.println("확인용"+userid);
//		System.out.println(subjectid);
		MylectureVO mylecture = service.getSubjectOne(paraMap);
		
		mav.addObject("subjectid", subjectid);
		
		mav.addObject("mylecture", mylecture);
		
		
		mav.setViewName("duHyeon/test/testform.tiles3");
		
		return mav;
	}
	
	// 테스트 라운드를 인서트 해주기 위한 메소드
	@RequestMapping(value="/addTestRound.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView addTestRound(ModelAndView mav, HttpServletRequest request) {
		
		String examtitle = request.getParameter("examtitle");
		String startDate = request.getParameter("startdate");
		String endDate = request.getParameter("enddate");
		String disclosure = request.getParameter("disclosure");
		String questioncnt = request.getParameter("questioncnt");
		String majorid = request.getParameter("majorid");
		String gyowonid = request.getParameter("gyowonid");
		String subjectid = request.getParameter("subjectid");
		
		
		//  System.out.println("확인용"+examtitle+"\n"+startDate+"\n"+endDate+"\n"+disclosure+
		//  "\n"+questioncnt+"\n"+majorid+"\n"+gyowonid+"\n"+subjectid);
		 /*  중간고사					시험제목
			2022-05-09 00 00		시작시간
			2022-05-09 00 00		마감시간
			0						0은 공개
			15						문항수
			11						학과 코드
			10001					교원아이디
			11001					과목코드
		 */
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("examtitle", examtitle);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("disclosure", disclosure);
		paraMap.put("questioncnt", questioncnt);
		paraMap.put("majorid", majorid);
		paraMap.put("gyowonid", gyowonid);
		paraMap.put("subjectid", subjectid);
		
		int n = service.addTestRound(paraMap); // 폼에서 넘어온 정보로 TestRound 테이블에 인서트 해줄 메소드
		
		if(n == 1) {
			// System.out.println("성공");
			mav.addObject("message", "정상적으로 등록 되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/testroundList.lmsfinal?subjectid="+subjectid);
			
		}
		
		
		mav.setViewName("msg");
		// 과목코드없으면 안됨 수정필요
		// testroundlist를 보여줘야 함
		return mav;
	}
	
	
	// 테스트 라운드리스트를 보여주기 위한 메소드 근데 이제 before advice 를 곁들인
	@RequestMapping(value="/testroundList.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView testroundList(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		
		// Before Advice를 이용해서 교수가 로그인 했을때만 들어올수 있도록 할것임
		// HttpSession session = request.set
		HttpSession session = request.getSession();
		
		String subjectid = request.getParameter("subjectid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("subjectid", subjectid);
		List<Map<String, String>> testRoundList = null;
		
		
		
		if(session.getAttribute("loginuser") != null) {
			
			try {
				
				GyowonVO gyowon = ((GyowonVO)session.getAttribute("loginuser"));
				
				String gyowonid = gyowon.getGyowonid();
				mav.addObject("gyowonid", gyowonid);
				mav.setViewName("duHyeon/test/testroundList.tiles3");
				
			} catch(ClassCastException e) {
				
				try {
					StudentVO stdid = (StudentVO)(session.getAttribute("loginuser"));
					mav.addObject("stdid", String.valueOf(stdid.getStdid()));
					
					
					paraMap.put("stdid", String.valueOf(stdid.getStdid()));
					
					int m = service.isCourse(paraMap);
					
					if(m != 0) {
						mav.setViewName("duHyeon/test/testroundList.tiles2");
						// System.out.println("m 값 : "+ m);
						// 교원번호와 과목코드가 담긴 파라맵을 이용하여 testRound가 들어있는 List를 받아오기 위한 메소드
						
						
						
						mav.addObject("subjectid",subjectid);
					}
					else {
						mav.setViewName("msg");
						mav.addObject("message", "수강중인 강의가 아닙니다.");
						mav.addObject("loc","javascript:history.back()");
						
					}
					
					// stdid and subjectid 필요
				} catch(ClassCastException e1) {
					
				}
			}
			
		
			
		}
		else {
			mav.addObject("message", "로그인을 먼저 해주세요");
			mav.addObject("loc", "main/index.lmsfinal");
			mav.setViewName("msg");
		}
		testRoundList = service.getTestRoundList(paraMap);
		mav.addObject("subjectid",subjectid);
		mav.addObject("testRoundList", testRoundList);
		return mav;
	}
	
	
	// 테스트 라운드의 상세정보와 수정 및 문제 출제로 넘어갈 페이지
	@RequestMapping(value="/detailtestround.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_detailtestround(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		
		// Before Advice를 이용해서 교수가 로그인 했을때만 들어올수 있도록 할것임
		// HttpSession session = request.set
		HttpSession session = request.getSession();
		
		String testclfc = request.getParameter("testclfc"); // 시험라운드의 고유 번호 
		
		try {
			GyowonVO loginuser = (GyowonVO)(session.getAttribute("loginuser")); // 현재 로그인한 사람의 아이디 근데 교원만 들어와야하니 변수이름을 gyowonid로
			
			String gyowonid = loginuser.getGyowonid();
			
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("testclfc", testclfc);
			paraMap.put("gyowonid", gyowonid);
			
			// 교원번호와 시험라운드고유번호를 파라맵에 넣어 일치하는 테스트 라운드의 정보를 하나 뽑아옴
			Map<String, String> testRoundOne = service.getTestRoundOne(paraMap);
			
			mav.addObject("testRoundOne", testRoundOne);
			
			mav.setViewName("duHyeon/test/detailtestround.tiles3");
		} catch(ClassCastException e) {
			mav.addObject("loc", "javascript:history.back()");
			mav.setViewName("msg");
		}
		return mav;
	}
	
	
	// 테스트 라운드의 수정을 도와줄 페이지 날짜가 변경된다면 공지사항에 자동으로 올라가게끔 
	@RequestMapping(value="/modifytestround.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView modifytestround(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		
		SimpleDateFormat newdate = new SimpleDateFormat("yyyyMMddHHmmss");
		SimpleDateFormat storeddate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat comparedate = new SimpleDateFormat("yyyy년 MM월 dd일 HH시mm분");
		
		
		String examtitle = request.getParameter("examtitle");
		String startDate = request.getParameter("startdate");
		String endDate = request.getParameter("enddate");
		String disclosure = request.getParameter("disclosure");
		String questioncnt = request.getParameter("questioncnt");
		String majorid = request.getParameter("majorid");
		String gyowonid = request.getParameter("gyowonid");
		String subjectid = request.getParameter("subjectid");
		String testclfc = request.getParameter("testclfc");
		String storedStartDate = request.getParameter("storedStartDate")+":00";
		String storedEndDate = request.getParameter("storedStartDate")+":00"; //시간을 바꿨으면 공지사항에
		
		
		
		
		/*
		System.out.println("확인용"+examtitle+"\n"+startDate+"\n"+endDate+"\n"+disclosure+
				  "\n"+questioncnt+"\n"+majorid+"\n"+gyowonid+"\n"+subjectid+"\n"+testclfc+"\n"+storedStartDate+"\n"+storedEndDate);
		*/
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("examtitle", examtitle);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("disclosure", disclosure);
		paraMap.put("questioncnt", questioncnt);
		paraMap.put("majorid", majorid);
		paraMap.put("gyowonid", gyowonid);
		paraMap.put("subjectid", subjectid);
		paraMap.put("testclfc", testclfc);
		
		int n = service.modifyTestRound(paraMap); 
		
		/*
		 * System.out.println(startDate); System.out.println(endDate);
		 * 
		 * System.out.println(storedStartDate); System.out.println(storedEndDate);
		 */
		if(n == 1) {
			// 수정이 성공한 상황
		
			// update 해주고 만약 시작날과 수정날이 다르다면 공지사항에 올려주기위한 

			try {
				Date formatstartDate = newdate.parse(startDate);
				Date formatendDate = newdate.parse(endDate);
				
				Date formatSstartDate = storeddate.parse(storedStartDate);
				Date formatSendDate = storeddate.parse(storedEndDate);
				
				//System.out.println(comparedate.format(formatstartDate));
				
				
				
				
				
				
				
				if(!formatstartDate.equals(formatSstartDate) || !formatendDate.equals(formatSendDate)) {
					// 날짜가 수정되었다면 공지사항으로 올려줄 것이다.
					
					String snsubject = examtitle+" 시험 날짜변경에 대해 공지";
					String sncontent = examtitle+" 의 응시 날짜가 [" + comparedate.format(formatSstartDate)+
								  	   " ~ "+ comparedate.format(formatSendDate) +"] 에서 ["+
								  	   comparedate.format(formatstartDate) + " ~ " +
								  	   comparedate.format(formatendDate) + "]로 변경되었습니다. \n";
					
					SubjectNoticeVO subjectnoticevo = new SubjectNoticeVO("",  snsubject, sncontent,
																		  "", "1234", "", subjectid,
																		  majorid, gyowonid, "", "", "");
					
					
					noticeService.addNotice(subjectnoticevo);
					
				}
				
				
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			mav.addObject("message", "정상적으로 수정 되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/detailtestround.lmsfinal?testclfc="+testclfc);
			mav.setViewName("msg");
		}
		else {
			mav.addObject("message", "수정에 실패했습니다.");
			mav.addObject("loc", request.getContextPath()+"/testtroundList.lmsfinal?subjectid="+subjectid);
			mav.setViewName("msg");
		}
		
		
		return mav;
	}
	
	@RequestMapping(value="/questionList.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_getQuestionList(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		// Before Advice를 이용해서 교수가 로그인 했을때만 들어올수 있도록 할것임
		// HttpSession session = request.set
		
		
		
		String testclfc = request.getParameter("testclfc");
		System.out.println("questionlist"+testclfc);
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("testclfc",testclfc);
		
		// 과목코들를 가져와줄 메소드 구현
		
		Map<String, String> smgMap = service.getSMG(paraMap);
		
		// 특정 시험에대한 문제들을 가져올 메소드
		List<Map<String, String>> questionList = service.getQuestionList(paraMap);
		
		mav.addObject("testclfc", testclfc);
		mav.addObject("questionList", questionList);
		mav.addObject("subjectid", smgMap.get("subjectid"));
		
		mav.setViewName("duHyeon/test/questionList.tiles3");
		
		return mav;
	}
	
	
	@RequestMapping(value="/questionForm.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_questionForm(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		// Before Advice를 이용해서 교수가 로그인 했을때만 들어올수 있도록 할것임
		// HttpSession session = request.set
		
		String testclfc = request.getParameter("testclfc");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("testclfc",testclfc);
		System.out.println("questionform"+testclfc);
		
		// testclfc만으로 subjectid majorid gyowonid  받아오기
		Map<String, String> smgMap = service.getSMG(paraMap);

		// 먼저 seq.currval로 받아온뒤 동시에 insert처리를 해주려 했지만 
		// 찾아보니 안되는 거기 때문에 trasaction 처리로 바꿔줄 예정이다.
		
		mav.addObject("subjectid", smgMap.get("subjectid"));
		
		mav.addObject("smgMap", smgMap);
		
		mav.setViewName("duHyeon/test/questionform.tiles3");
		
		return mav;
	}
	
	
	@RequestMapping(value="/addQuestion.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView addQuestion(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
		
		
		
		String question = request.getParameter("question"); // tbl_question
		String correct = request.getParameter("correct"); // tbl_question
		
		String answer1 = request.getParameter("answer1"); // tbl_answer
		String answer2 = request.getParameter("answer2"); // tbl_answer
		String answer3 = request.getParameter("answer3"); // tbl_answer
		String answer4 = request.getParameter("answer4"); // tbl_answer
		
		String majorid = request.getParameter("majorid"); // 두개다
		String gyowonid = request.getParameter("gyowonid"); // 두개다
		String subjectid = request.getParameter("subjectid"); // 두개다
		String testclfc = request.getParameter("testclfc"); // 두개다
		
		/*
		System.out.println("확인용"+majorid+"\n"+gyowonid+"\n"+subjectid+"\n"+testclfc+"\n"+
							question+"\n"+answer1+"\n"+"\n"+answer2+"\n"+"\n"+answer3+"\n"+"\n"+answer4+"\n"
							+"\n"+correct+"\n");
		*/
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("question", question);
		paraMap.put("correct", correct);
		
		paraMap.put("majorid", majorid);
		paraMap.put("gyowonid", gyowonid);
		paraMap.put("subjectid", subjectid);
		paraMap.put("testclfc", testclfc);
		
		
		int n = service.addQuestion(paraMap);
		// System.out.println("확인용 n : " + n);
		// 확인용 n : 1
		
		if(n == 1) {
			// 성공했으니 이제 보기를 넣어줘야함 
			String currentseq = service.getCurrentSeq(paraMap);
			
			paraMap.put("questionseq", currentseq);
			
	

				paraMap.put("answer", answer1);
				int m = service.addAnswer(paraMap);
				paraMap.put("answer", answer2);
				m += service.addAnswer(paraMap);
				paraMap.put("answer", answer3);
				m += service.addAnswer(paraMap);
				paraMap.put("answer", answer4);
				m += service.addAnswer(paraMap);
				
				// System.out.println("확인용 m : " + m);
	
				if(m == 4) {
					// 보기까지 잘 들어간 경우
					String loc = "questionList.lmsfinal?testclfc="+testclfc+"&majorid="+majorid+"&subjectid="+subjectid;
					String message = "문제가 정상적으로 저장되었습니다.";
					
					mav.addObject("loc", loc);
					mav.addObject("message", message);
					
					mav.setViewName("msg");
				}
				else {
					// 실패한 경우 detail testround로 갈예정
 				}
			
		}
		else {
			
		}
		
		return mav;
	}
	
	@RequestMapping(value="/detailQuestion.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_detailQuestion(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
	
	
		String questionseq = request.getParameter("questionseq");
		
		// 문제번호를 받아서 문제와 문제에 달린 보기예제들을 받아옴
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("questionseq", questionseq);
		
		// 맵으로 해서 받아온다.
		Map<String, String> question = service.getQuestionOne(paraMap);
		
		mav.addObject("question", question); // 문제를 넘겨줌
		mav.addObject("testclfc", question.get("testclfc"));
		
		// 문제의 보기를 리스트로 받아올것
		List<Map<String, String>> answer = service.getAnswerList(paraMap);
		/*
		for(Map<String, String> a: answer) {
			System.out.println("answersseq "+ a.get("answersseq"));
			System.out.println("answer "+ a.get("answer")+"\n");
		}
		*/
		
		mav.addObject("answer", answer); // 보기 리스트를 넘겨줌
		
		mav.setViewName("duHyeon/test/detailquestion.tiles2");
		
		return mav;
	}
								
	@RequestMapping(value="/modifyQuestion.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView modifyQuestinon(HttpServletRequest request,HttpServletResponse response, ModelAndView mav) {
	
		String question = request.getParameter("question");
		String correct = request.getParameter("correct");
		String questionseq = request.getParameter("questionseq");
		
		///////////////////////////////////////
		String subjectid = request.getParameter("subjectid");
		String majorid = request.getParameter("majorid");
		String gyowonid = request.getParameter("gyowonid");
		String testclfc = request.getParameter("testclfc");
		
		///////////////////////////////////////
		// 먼저 qustion 테이블에 업데이트 부터 
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("question", question);
		paraMap.put("correct", correct);
		
		paraMap.put("gyowonid",gyowonid);
		paraMap.put("testclfc", testclfc);
		paraMap.put("majorid", majorid);
		paraMap.put("subjectid", subjectid);
		
		paraMap.put("questionseq",questionseq);
		
		// 문제 번호 수정하기
		int n = service.modifyQuestion(paraMap);
		
		//System.out.println("확인용 n : " + n);
		
		//////////////////////////////////////
		
		if( n == 1) { // question 테이블이 잘 수정됐다면
		
			String answer1 = request.getParameter("answer1");
			String answerseq1 = request.getParameter("answerseq1");
			
			String answer2 = request.getParameter("answer2");
			String answerseq2 = request.getParameter("answerseq2");
			
			String answer3 = request.getParameter("answer3");
			String answerseq3 = request.getParameter("answerseq3");
			
			String answer4 = request.getParameter("answer4");
			String answerseq4 = request.getParameter("answerseq4");
			
			
			paraMap.put("answer", answer1);
			paraMap.put("answerseq", answerseq1);
			int m = service.modifyAnswer(paraMap);
			
			paraMap.put("answer", answer2);
			paraMap.put("answerseq", answerseq2);
			m += service.modifyAnswer(paraMap);
			
			paraMap.put("answer", answer3);
			paraMap.put("answerseq", answerseq3);
			m += service.modifyAnswer(paraMap);
			
			paraMap.put("answer", answer4);
			paraMap.put("answerseq", answerseq4);
			m += service.modifyAnswer(paraMap);
			
			
			if(m == 4) {
				// 정상적으로 전부 수정됐을때
				//System.out.println("확인용  m : " + m);
				
				mav.addObject("message", "문제가 정상적으로 수정되었습니다.");
				mav.addObject("loc", request.getContextPath()+"/detailQuestion.lmsfinal?questionseq="+questionseq);
				
				mav.setViewName("msg");
			}
			
		}
		else {// 아니라면
			
		}
		
		
		
		
		return mav;
	}

	
	@RequestMapping(value="/takeTheExam.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView takeTheExam(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		
		String testclfc = request.getParameter("testclfc");  // 과목회차 

		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginuser") != null) {
		
			StudentVO std = (StudentVO)session.getAttribute("loginuser");
			
			Date now = new Date();
			String nowTime = sdformat.format(now);
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("testclfc", testclfc);
			
			Map<String,String> smgMap = service.getSMG(paraMap);
			
			smgMap.put("stdid", String.valueOf(std.getStdid()));
			smgMap.put("testclfc", testclfc);
			
			
			// 현재 학생이 수강하는 강의인지 아닌지 확인하기 위한 메소드 
			int n = service.isCourse(smgMap);
			// stdid and subjectid 필요
			// System.out.println("확인용 n : " + n);
			
			if(n != 0) {// 존재한다면
				Map<String, String> testround = service.getTestRoundOne(smgMap);// 현재 보려고 하는 시험이 응시 가능한지 아닌지 알아보기위해 먼저 받아오고
				
				
				try {
					Date date1 = sdformat.parse(testround.get("startdate"));
					Date currentTime = sdformat.parse(nowTime); 
					Date date2 = sdformat.parse(testround.get("enddate"));

					
					if(date1.before(currentTime) && date2.after(currentTime)) {
						// 응시가안 내에 들어왔을 때
						
						// 이미 응시를 한 시험인지 알아보기
						
						int m = service.isTakeTheExam(smgMap);
						
						if(m == 0) {
							mav.setViewName("duHyeon/test/takeTheExam.tiles2");
							mav.addObject("smgMap", smgMap);
							mav.addObject("stdid",std.getStdid());
							mav.addObject("testclfc",testclfc);
						}
						else {
							mav.setViewName("msg");
							mav.addObject("loc", request.getContextPath() + "/testroundList.lmsfinal?subjectid="+smgMap.get("subjectid"));
							mav.addObject("message", "응시한 시험입니다.");
						}
						
					
					}
					else {
						// 아닐때
						mav.addObject("message", "시험응시기간이 아닙니다.");
						mav.addObject("loc", request.getContextPath() + "/testroundList.lmsfinal?subjectid="+smgMap.get("subjectid"));
						mav.setViewName("msg");
					
					}
					
					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}// end of if(n == 1) ------------------------------------------
			else {// 수강중인 과목의 시험을 하지 않고 장난쳤을 때
				mav.addObject("message", "수강중인 과목만 시험에 응시할 수 있습니다.");
				mav.addObject("loc", "javascript:history.back()");
				
				mav.setViewName("msg");
			}
			
		}
		else { // 로그인을 하지 않았더라면
			
			mav.addObject("message", "로그인을 먼저 해주세요");
			mav.addObject("loc", request.getContextPath()+"/index.lmsfinal");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	
	
	// json으로 처리하기 위함
	@ResponseBody
	@RequestMapping(value="/takeTheExamJson.lmsfinal", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String takeTheExamJson( HttpServletRequest request, HttpServletResponse response, ModelAndView mav){
		
		
			String testclfc = request.getParameter("testclfc");  // 과목회차 

			SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
			
			Date now = new Date();
			String nowTime = sdformat.format(now);
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("testclfc", testclfc);
			
			Map<String,String> smgMap = service.getSMG(paraMap);
			
			Map<String, String> testround = service.getTestRoundOne(smgMap);// 현재 보려고 하는 시험이 응시 가능한지 아닌지 알아보기위해 먼저 받아오고
			
			try {
				Date date1 = sdformat.parse(testround.get("startdate"));
				Date currentTime = sdformat.parse(nowTime); 
				Date date2 = sdformat.parse(testround.get("enddate"));

				
				if(date1.before(currentTime) && date2.after(currentTime)) {
					String 	remainingTime = String.valueOf(date2.getTime()-currentTime.getTime());

					testround.put("remainingTime", remainingTime);
				//	System.out.println(remainingTime);
					List<Map<String, String>> questionList = service.getQuestionList(paraMap);
					
					JSONArray json_arr = new JSONArray();
					
					for(Map<String, String> question : questionList) { 
						
						JSONObject json = new JSONObject();
						
						json.put("question", question.get("question"));
						
						List<Map<String, String>> answersList = service.getAnswerList(question); 
						
						JSONObject json_answers = new JSONObject();
						
						for(int i=0; i<answersList.size(); i++) {
							
							json_answers.put(String.valueOf(i+1), answersList.get(i));
							
						}// end of for---------------------------
						
						json.put("answers", json_answers);
						
						json.put("correct", question.get("correct"));
						
						json_arr.put(json);
						
					}// end of for-------------------------------
					
					JSONObject json_Time = new JSONObject();
					
					json_Time.put("remainingTime", remainingTime);
					
					json_arr.put(json_Time);
					
					String str_json = json_arr.toString();
					
					
					return str_json;
				}
				else {
					
				
				//	System.out.println("시험보는 위치로 가야함 takeTheExam 635번쨰줄");
				}
				
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		
		return "";
		
		}
	
	@RequestMapping(value="/insertStudentExam.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView insertStudentExam(ModelAndView mav, StudentExamVO studentexamvo, HttpServletRequest request) {
		
		
		// 저장해주기
		int n = service.insertStudentExam(studentexamvo);
		
//		System.out.println("확인용 : n"+ n);
		
		if(n == 1) {
			mav.addObject("loc", request.getContextPath() + "/testroundList.lmsfinal?subjectid="+studentexamvo.getSubjectid());
			mav.addObject("message","정상적으로 제출이 완료되었습니다");
			mav.setViewName("msg");
		}
		
		return mav;

	}

}

