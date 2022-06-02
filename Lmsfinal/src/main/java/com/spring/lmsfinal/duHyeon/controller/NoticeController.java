package com.spring.lmsfinal.duHyeon.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.common.MyUtil;
import com.spring.lmsfinal.duHyeon.common.FileManager;
import com.spring.lmsfinal.duHyeon.model.SubjectNoticeVO;
import com.spring.lmsfinal.duHyeon.service.InterNoticeService;
import com.spring.lmsfinal.yejinsim.model.GyowonVO;


@Controller
public class NoticeController {
	// 공지사항을 위한 컨트롤러 생성
	
	@Autowired
	private InterNoticeService service;
	
	
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
	// === 공지사항을 입력하기 위한 메소드 
	@RequestMapping(value="/addnotice.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_addnotice(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String subjectid = request.getParameter("subjectid");
		

		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("subjectid", subjectid);
		
		if("".equals(subjectid) || subjectid == null ) {
			
			mav.addObject("message", "비정상적인 경로입니다.");
			mav.addObject("loc",request.getContextPath()+"/index.lmsfinal");
			
			mav.setViewName("msg");
			
		}
		else {
			// Subjectid Majorid Gyowonid얻어오기
			Map<String, String> smgMap = service.getSMG(paraMap);
			// System.out.println("아직 미완성 단계이기 때문에 미리 과목코드를 넣어놨습니다 NoticeCOntroller 31번째 줄 \n");
			
			
			HttpSession session = request.getSession();
			
			GyowonVO loginuser = (GyowonVO)(session.getAttribute("loginuser")); // 현재로그인 유저의 아이디
			
			String userid = loginuser.getGyowonid();
			
			if(!smgMap.get("gyowonid").equals(userid)) {
				// 만약 로그인 한 유저가 다른 교원의 강의 코드를 가지고 장난치는 경우
			
				mav.addObject("message", "해당 강의에 대한 권한이 없습니다.");
				mav.addObject("loc",request.getContextPath()+"/mylecture.lmsfinal");

				mav.setViewName("msg");
				/*
				System.out.println("로그인 유저 아이디 : " + userid);
				System.out.println("해당 강의를 관리하는 유저 아이디 :" + smgMap.get("gyowonid"));
				*/
				return mav;

			}
			
			
			mav.addObject("smgMap", smgMap);
		
			
			mav.setViewName("duHyeon/notice/addnotice.tiles3");
		}
		
	    return mav;
	}
	
	
	// === 공지사항을 입력하기 위한 메소드 
	@RequestMapping(value="/addNoticeEnd.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView addnoticeEnd( ModelAndView mav, SubjectNoticeVO subjectnoticevo, MultipartHttpServletRequest mrequest) {


		MultipartFile attach = subjectnoticevo.getAttach();
		
		if(!attach.isEmpty()) {
			
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			String path = root+"resources"+File.separator+"files";
			
			String newFileName = "";
			
			byte[] bytes = null;
			
			long fileSize = 0;
			
			try{
				bytes = attach.getBytes();
				
				String originalFilename = attach.getOriginalFilename();
				
				newFileName = fileManager.doFileUpload(bytes,originalFilename, path);
				
				subjectnoticevo.setSnfilename(newFileName);
				
				subjectnoticevo.setSnorgfilename(originalFilename);
				
				fileSize = attach.getSize();
				subjectnoticevo.setSnfilesize(String.valueOf(fileSize));
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			
		}
		
		
		int n = 0;
		if(attach.isEmpty()) {
			n = service.addNotice(subjectnoticevo);
			// System.out.println("확인용 파일없는 n : " + n);
		}
		else {
			n = service.addNoticeWithFile(subjectnoticevo);
			// System.out.println("확인용 파일있는 n : " + n);
		}
		
		
		if(n==1) {
			mav.setViewName("redirect:/noticeList_gyo.lmsfinal?subjectid="+subjectnoticevo.getSubjectid());
			//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
	
	
	    return mav;
	}
	
	
	@RequestMapping(value = "/noticeList_gyo.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView noticeList(ModelAndView mav, HttpServletRequest request) {
		
		String subjectid = request.getParameter("subjectid");
		// System.out.println(subjectid);
		List<SubjectNoticeVO> noticeList = null;
		HttpSession session = request.getSession();
		
		
		
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(  subjectid != null && session.getAttribute("loginuser") != null) {
			
			
			try {
				
				GyowonVO gyowon = ((GyowonVO)session.getAttribute("loginuser"));
				
				String gyowonid = gyowon.getGyowonid();
				mav.addObject("gyowonid", gyowonid);
				mav.setViewName("duHyeon/notice/noticeList.tiles3");
				
			} catch(ClassCastException e) {
				mav.setViewName("duHyeon/notice/noticeList.tiles2");
			}
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("subjectid", subjectid);
			mav.addObject("subjectid", subjectid);
			

			
			// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
			// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
			int totalCount = 0;        // 총 게시물 건수
			int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
			int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
			int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
			
			int startRno = 0; // 시작 행번호
			int endRno = 0;   // 끝 행번호
			
			// 총 게시물 건수(totalCount)
			totalCount = service.getTotalNoticeCount(paraMap);
			
			// System.out.println("~~~~~ 확인용 183번 라인 totalCount : " + totalCount);
			
			totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
			
			if(str_currentShowPageNo == null) {
				// 게시판에 보여지는 초기화면
				currentShowPageNo = 1;
			}
			else {
				try {
					currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
					if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
						currentShowPageNo = 1;
					}
				} catch(NumberFormatException e) {
					currentShowPageNo = 1;
				}
			}
			
			
			startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
			endRno = startRno + sizePerPage - 1;
			paraMap.put("subjectid", subjectid);
			paraMap.put("startRno", String.valueOf(startRno));
			paraMap.put("endRno", String.valueOf(endRno));
			
			noticeList = service.noticeList(paraMap);
			// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
			
			// ===  페이지바 만들기 === //
			int blockSize = 10;
			
			int loop = 1;
			
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			// *** !! 공식이다. !! *** //
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = "noticeList.lmsfinal";
			
			// === [맨처음][이전] 만들기 === //
			if(pageNo != 1) {
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo=1'>[맨처음]</a></li>";
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == currentShowPageNo) {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
				}
				else {
					pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
				}
				
				loop++;
				pageNo++;
				
			}// end of while-----------------------
			
			// === [다음][마지막] 만들기 === //
			if( pageNo <= totalPage ) {
				pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?subjectid="+subjectid+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
			}
			
			pageBar += "</ul>";
			
			mav.addObject("pageBar", pageBar);
			
	//		String gobackURL = MyUtil.getCurrentURL(request);
		
	//		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
			
			// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
			///////////////////////////////////////////////////////////////
			
			
			
			
			mav.addObject("noticeList", noticeList);
			

		}
		else {
			 mav.addObject("loc","javascript:history.back()");
			 mav.addObject("message","확인되지 않은 경로입니다.");
			 mav.setViewName("msg");
		}
		
		return mav;
	}
	
	
	// 공지사항의 자세한 것을 보여주기 위함이다.
	@RequestMapping(value="/detailnotice.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView detailnotice(ModelAndView mav, HttpServletRequest request) {
		
		String subnoticeno = request.getParameter("subnoticeno");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("subnoticeno", subnoticeno);
		
		// noticeno을 이용하여 하나의 noticevo를 받아온다.
		SubjectNoticeVO noticevo = service.getdetailnotice(paraMap);
		
		// subnoticeno 을 가지고 
		
		
		mav.addObject("noticevo", noticevo);
		mav.setViewName("duHyeon/notice/detailnotice.tiles3");
		
		return mav;
	}
	
	// 공지사항의 자세한 것을 보여주기 위함이다.
	@RequestMapping(value="/modifynotice.lmsfinal", method = {RequestMethod.GET})
	public ModelAndView requiredLoginGyowon_modifynotice(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String subnoticeno = request.getParameter("subnoticeno");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("subnoticeno", subnoticeno);
		
		// noticeno을 이용하여 하나의 noticevo를 받아온다.
		SubjectNoticeVO noticevo = service.getdetailnotice(paraMap);
		
		// subnoticeno 을 가지고 
		Map<String, String> smgMap = service.getSMGThroughNotice(paraMap);
		
		mav.addObject("smgMap", smgMap);
		mav.addObject("noticevo", noticevo);
		mav.setViewName("duHyeon/notice/modifynotice.tiles3");
		
		return mav;
	}
	

	
	
	// 공지사항의 자세한 것을 보여주기 위함이다.
	@RequestMapping(value="/modifynoticeEnd.lmsfinal", method = {RequestMethod.POST})
	public ModelAndView modifynoticeEnd(ModelAndView mav, SubjectNoticeVO subjectnoticevo, MultipartHttpServletRequest mrequest) {
		
		
		
		MultipartFile attach = subjectnoticevo.getAttach();
		
		if(!attach.isEmpty()) {// 비어있지않다면
			
			HttpSession session = mrequest.getSession();
			
			String root = session.getServletContext().getRealPath("/");
			
			String path = root+"resources"+File.separator+"files";
			
			String newFileName = "";
			
			byte[] bytes = null;
			
			long fileSize = 0;
			
			try{
				bytes = attach.getBytes();
				
				String originalFilename = attach.getOriginalFilename();
				
				newFileName = fileManager.doFileUpload(bytes,originalFilename, path);
				
				subjectnoticevo.setSnfilename(newFileName);
				
				subjectnoticevo.setSnorgfilename(originalFilename);
				
				fileSize = attach.getSize();
				
				subjectnoticevo.setSnfilesize(String.valueOf(fileSize));
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}// if(!attach.isEmpth())----------------------------------
		else {
			subjectnoticevo.setSnfilename("");
			subjectnoticevo.setSnorgfilename("");
			subjectnoticevo.setSnfilesize("");
			
		}
		
		
		int  n = service.modifyNoticeWithFile(subjectnoticevo);
		
		/*
		 * int n = 0; if(attach.isEmpty()) { n = service.modifyNotice(subjectnoticevo);
		 * System.out.println("확인용 파일없는 n : " + n); } else { n =
		 * service.modifyNoticeWithFile(subjectnoticevo);
		 * System.out.println("확인용 파일있는 n : " + n); }
		 */
		
		
		if(n==1) {
			mav.setViewName("redirect:/detailnotice.lmsfinal?subnoticeno="+subjectnoticevo.getSubnoticeno());
			//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("msg");
			mav.addObject("loc", "");
			mav.addObject("message","수정에 실패하였습니다.");
		}
	
	
	    return mav;
		
		
	}

	
	@RequestMapping(value="/download_attch.lmsfinal", method = {RequestMethod.GET})
	public void download(HttpServletRequest request, HttpServletResponse response) {
		
		String subnoticeno = request.getParameter("subnoticeno");
      
      Map<String, String> paraMap = new HashMap<>();
      paraMap.put("subnoticeno", subnoticeno);
      
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = null;
       // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
      
      try {
         Integer.parseInt(subnoticeno);
         SubjectNoticeVO noticevo = service.getdetailnotice(paraMap);
         
         if(noticevo == null || (noticevo != null && noticevo.getSnfilename() == null ) ) {
            out = response.getWriter();
            out.println("<script type='text/javascript'>alert('존재하지 않는 글번호 이거나 첨부파일이 없으므로 파일다운로드가 불가합니다.'); history.back();</script>");
            return; // 종료
         }
         else {
            
            String fileName = noticevo.getSnfilename();
            // 20220429141939883981362180900.jpg  이것인 바로 WAS(톰캣) 디스크에 저장된 파일명이다. 
            
            String orgFilename = noticevo.getSnorgfilename();

        
            HttpSession session = request.getSession();
            String root = session.getServletContext().getRealPath("/");
            String path = root+"resources"+File.separator+"files";
            boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
            flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
            
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
      
    }
	
	
}
