package com.spring.lmsfinal.yejinsim.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.spring.lmsfinal.common.FileManager;
import com.spring.lmsfinal.yejinsim.model.LctrQnaboardVO;
import com.spring.lmsfinal.yejinsim.service.InterLctrQnaboardService;

@Controller
public class QnaboardController {

	@Autowired
	private InterLctrQnaboardService service;
	
	// === 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
	@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;

	
	// === 질답게시판  페이지 요청 === //
	@RequestMapping(value="/lctrQnalist.lmsfinal")
	public ModelAndView lctrQnalist(ModelAndView mav, HttpServletRequest request) {
	
		String subjectid = request.getParameter("subjectid");
		
		mav.addObject("subjectid", subjectid);
		mav.setViewName("yejinsim/lctrQnalist.tiles2");
		
		return mav;	
	}
	
	// === 질답게시판 글쓰기 폼페이지 요청 === //
	@RequestMapping(value="/addlctrQna.lmsfinal")
	public ModelAndView addlctrQna(ModelAndView mav, HttpServletRequest request) {
	
		String subjectid = request.getParameter("subjectid");
		
		// === #142. 답변글쓰기가 추가된 경우 시작 === 
		String fk_qseq = request.getParameter("fk_qseq");
		String qgroupno = request.getParameter("qgroupno");
		String qdepthno = request.getParameter("qdepthno");
		String qsubject = "[답변] " + request.getParameter("qsubject");
		
		mav.addObject("fk_qseq", fk_qseq);
		mav.addObject("qgroupno", qgroupno);
		mav.addObject("qdepthno", qdepthno);
		mav.addObject("qsubject", qsubject);
		// === 답변글쓰기가 추가된 경우 끝 === 
		
		mav.addObject("subjectid", subjectid);
		
		mav.setViewName("yejinsim/addlctrQna.tiles2");
	//  /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.
		
		return mav;	
	}
	
	
	// === 게시판 글쓰기 완료 요청 === //
	@RequestMapping(value="/addlctrQnaEnd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView addlctrQnaEnd(Map<String,String> paraMap, ModelAndView mav, LctrQnaboardVO lqnaboardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기  및 파일 첨부하기
		
		MultipartFile attach = lqnaboardvo.getAttach();
		
		if( !attach.isEmpty()) {
			// attach(첨부파일)가 비어있지 않으면(즉, 첨부파일이 있는 경우라면)
			/*
            1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
            >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
                          우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
                           조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
            */
			//WAS의 webapp의 절대경로를 알아와야 한다. 
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			
			//System.out.println("~~~확인용 webapp의 절대경로 => " + root);
			// ~~~확인용 webapp의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
			
			String path = root+"resources"+File.separator+"files";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		            운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		            운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
			 */
			// path가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			//System.out.println("~~~확인용 path => " + path);
			// ~~~확인용 path => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
			
			/*
			2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
			 */
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명 
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 곳 
			
			long qfilesize = 0;
			// 첨부파일의 크기
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것
				String originalFilename = attach.getOriginalFilename();
				// attach.getOriginalFilename()이 첨부파일의 파일명(예: 강아지.png)이다.
				//System.out.println("확인용 originalFilename =>" + originalFilename);
				// 확인용 originalFilename =>Electrolux냉장고_사용설명서.pdf

				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
	            
				//System.out.println(">>> 확인용 newFileName => "+newFileName);
				//>>> 확인용 newFileName => 2022042912303212763092267800.pdf
				
			/*
			3. BoardVO boardvo 에 fileName 값과 orgFileName 값과 fileSize 값을 넣어주기
			 */
				lqnaboardvo.setQfilename(newFileName);
				// WAS(톰캣)에 저장된 파일명(2020120809271535243254235235234.png)
				lqnaboardvo.setQorgfile(originalFilename);
				// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
	            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
				qfilesize = attach.getSize(); //첨부파일의 크기(단위는 byte임)
				lqnaboardvo.setQfilesize(String.valueOf(qfilesize));
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===
		
		
	//	int n = service.add(boardvo);  // <== 파일첨부가 없는 글쓰기 
	//  === #156. 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 === // 
		//  먼저 위의  int n = service.add(boardvo); 부분을 주석처리 하고서 아래와 같이 한다.
		
		int n = 0;
		
		if( attach.isEmpty()) {
			//파일첨부가 없는경우 
			n = service.addlctrQna(lqnaboardvo);
		}
		else {
			//파일첨부가 있는경우 
			//n = service.addlctrQna_withFile(qnaboardvo);
		}
		
		if(n==1) {
			mav.setViewName("redirect:/addlctrQna.lmsfinal");
			//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
		}
		else {
			mav.setViewName("add_error");
			//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
		}
		
		
		
		
		return mav;
	}	
}
