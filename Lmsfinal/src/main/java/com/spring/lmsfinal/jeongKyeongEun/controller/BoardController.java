package com.spring.lmsfinal.jeongKyeongEun.controller;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.lmsfinal.common.FileManager;
import com.spring.lmsfinal.jeongKyeongEun.model.NoticeVO;
import com.spring.lmsfinal.jeongKyeongEun.service.InterBoardService;
import com.spring.lmsfinal.wonhyejin.model.AdminVO;

@Component

@Controller
public class BoardController {
	
	@Autowired
	private InterBoardService service;
	
	// === #155 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
    @Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
    private FileManager fileManager;
	
	@RequestMapping(value="/jeongKyeongEun/test_insert.lmsfinal")	// ctxPath는 com.spring.board에서 마지막 board가 된다!
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
		
		return "jeongKyeongEun/test_insert"; // 뷰단 표시
	//	/WEB-INF/views/test/test_insert.jsp 페이지를 만들어야 한다.
	}// end of public String test_insert(HttpServletRequest request)--------------------
	
	
	
	
	   
	   // === 공지사항 글쓰기 폼페이지 요청 === //
	   @RequestMapping(value="/noticeWritePage.lmsfinal")
	   public ModelAndView noticeWritePage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	      
	      String nsubject = request.getParameter("nsubject");
	      
	      mav.addObject("nsubject", nsubject);  // 이것도 필요한가?
	      
	      // 답변 글쓰기가 없으므로 여기까지만 작성
	      
	      mav.setViewName("jeongKyeongEun/notice/noticeWrite.tiles2");
	   //   /WEB-INF/views/tiles2/jeongKyeongEun/notice/noticeWrite.jsp   파일을 생성한다.
	      
	      return mav;
	   }
	      
	   
	   
	   // === 공지사항 글쓰기 완료 요청 === //
	   @RequestMapping(value="/noticeWriteEnd.lmsfinal", method= {RequestMethod.POST})
	   
	   public ModelAndView noticeWriteEnd(Map<String,String> paraMap, ModelAndView mav, NoticeVO noticevo, MultipartHttpServletRequest mrequest) {
	      
	      /*
	         === #151 파일첨부가 된 글쓰기 이므로  
	                   먼저 위의  public ModelAndView pointPlus_addEnd(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo) { 을 
	                   주석처리 한 이후에 아래와 같이 한다.
	            MultipartHttpServletRequest mrequest 를 사용하기 위해서는 
	                  먼저 /Board/src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml 에서     
	            #21 파일업로드 및 파일다운로드에 필요한 의존객체 설정하기 를 해두어야 한다.  
	      */
	      /*
	            웹페이지에 요청 form이 enctype="multipart/form-data" 으로 되어있어서 Multipart 요청(파일처리 요청)이 들어올때 
	            컨트롤러에서는 HttpServletRequest 대신 MultipartHttpServletRequest 인터페이스를 사용해야 한다.
	           MultipartHttpServletRequest 인터페이스는 HttpServletRequest 인터페이스와  MultipartRequest 인터페이스를 상속받고있다.
	            즉, 웹 요청 정보를 얻기 위한 getParameter()와 같은 메소드와 Multipart(파일처리) 관련 메소드를 모두 사용가능하다.     
	      */
	      
	      // === 사용자가 쓴 글에 파일이 첨부되어 있는 것인지, 아니면 파일첨부가 안된것인지 구분을 지어주어야 한다. === 
	        // === !!! 첨부파일이 있는 경우 작업 시작 !!! ===
	      MultipartFile attach = noticevo.getAttach();
	      
	      if( !attach.isEmpty() ) {
	         
	         // attach(첨부파일)가 비어 있지 않으면 (즉, 첨부파일이 있는 경우라면)
	         
	         /*
	              1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
	              >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	                       우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
	                                   조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
	             */
	         // WAS 의 webapp 의 절대경로를 알아와야 한다.
	         HttpSession session = mrequest.getSession();
	         String root = session.getServletContext().getRealPath("/");
	         
	         //   System.out.println("~~ 확인용 webapp 의 절대경로 => " +root);
	         // ~~ 확인용 webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\
	         String path = root+"resources"+ File.separator +"files";
	         /* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
	                     운영체제가 Windows 이라면 File.separator 는  "\" 이고,
	                     운영체제가 UNIX, Linux 이라면  File.separator 는 "/" 이다. 
	        */
	         
	         // path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	      //   System.out.println("~~ 확인용 path 의 절대경로 => " +path);
	         // ~~ 확인용 path 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
	            
	         /*
	             2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
	       */
	         String newFileName = "";
	         // WAS(톰캣)의 디스크에 저장될 파일명
	         
	         byte[] bytes = null;
	         // 첨부파일의 내용물을 담는 것
	         
	         int fileSize = 0;
	         // 첨부파일의 크기
	         
	         try {
	            bytes = attach.getBytes();
	            // 첨부파일의 내용물을 읽어오는 것
	            
	            String originalFilename = attach.getOriginalFilename();
	             // attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
	            //   System.out.println("~~~~ 확인용 originalFilename => " + originalFilename);
	            // ~~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf
	               
	            newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
	            // 첨부되어진 파일을 업로드 하도록 하는 것이다. 
	            
	          //   System.out.println(">>> 확인용  newFileName => " + newFileName);
	            // >>> 확인용  newFileName => 20220429123020735292855609700.jpg
	            
	      /*
	          3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기
	       */
	            noticevo.setNfilename(newFileName);
	            // WAS(톰캣)에 저장될 파일명(2022042912181535243254235235234.png)
	             
	            noticevo.setNorgfile(originalFilename);
	            // 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
	               // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
	            
	            fileSize = (int) attach.getSize();  // 첨부파일의 크기(다누이는 byte임)
	            noticevo.setNfilesize(fileSize);
	            
	             
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	         
	      }
	      // === !!! 첨부파일이 있는 경우 작업 끝 !!! ===
	      
	      
	      //   int n = service.add(noticevo);  // <== 파일 첨부가 없는 글쓰기  boardvo 에 넣음
	      
	      //  === #156. 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 === // 
	       //  먼저 위의  int n = service.add(noticevo); 부분을 주석처리 하고서 아래와 같이 한다.
	         
	         int n = 0;
	          
	         if( attach.isEmpty() ) {
	            // 첨부파일이 없는 경우라면
	            n = service.add(noticevo);
	         }
	         
	         else {
	            // 첨부파일이 있는 경우라면 
	            n = service.add_withFile(noticevo);
	         }
	         
	         System.out.println("확인용 n : " +n);
	         
	         if(n==1) {
	            mav.setViewName("redirect:/noticeList.lmsfinal"); 
	            //  /WEB-INF/views/tiles2/jeongKyeongEun/notice/noticeList.jsp 파일을 생성한다.
	         }
	         else {
	            String message = "공지사항 글쓰기에 실패했습니다.";
	            String loc = "javascript:history.back()";
	            
	            mav.addObject("message", message);
	               mav.addObject("loc", loc);
	               
	               mav.setViewName("msg");
	         }
	         
	         
	         return mav;
	      
	   }
	   
	   
	   
	   
	   
	   /////////  ===== ***** 공지사항 목록 페이지 요청 ***** ===== /////////
	   @RequestMapping(value="/noticeList.lmsfinal")   // 폼 페이지가 떠야하니까 method get방식만
	   public ModelAndView noticeList(ModelAndView mav, HttpServletRequest request) {
	      
	//    getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
	      
	      List<NoticeVO> boardList = null;
	      
	      //////////////////////////////////////////////////////
	      // === #69 글조회수(readCount)증가 (DML문 update)는
	      //          반드시 목록보기에 와서 해당 글제목을 클릭했을 경우에만 증가되고,
	      //          웹브라우저에서 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다.
	      //          이것을 하기 위해서는 session 을 사용하여 처리하면 된다.
	      HttpSession session = request.getSession();
	      session.setAttribute("readCountPermission", "yes");  // 정상적으로 들어왔다면
	      /*
	      session 에  "readCountPermission" 키값으로 저장된 value값은 "yes" 이다.
	      session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면 
	      반드시 웹브라우저에서 주소창에 "/list.action" 이라고 입력해야만 얻어올 수 있다. 
	      */
	      //////////////////////////////////////////////////////
	      
	      
	      // == #114 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 == //
	      /* 페이징 처리를 통한 글목록 보여주기는 
	            예를 들어 3페이지의 내용을 보고자 한다라면 검색을 할 경우는 아래와 같이
	         list.action?searchType=subject&searchWord=안녕&currentShowPageNo=3 와 같이 해주어야 한다.
	            또는 
	            검색이 없는 전체를 볼때는 아래와 같이 
	         list.action 또는 
	         list.action?searchType=&searchWord=&currentShowPageNo=3 또는 
	          list.action?searchType=subject&searchWord=&currentShowPageNo=3 와 같이 해주어야 한다.
	        */
	      String searchType = request.getParameter("searchType");
	      String searchWord = request.getParameter("searchWord");  // 넘어온 값이 무엇입니깡
	      String str_currentShowPageNo = request.getParameter("currentShowPageNo");
	      
	      if(searchType == null || ( !"nsubject".equals(searchType) )) {
	         searchType = "";
	      }
	      
	      if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
	         searchWord = "";
	      }
	      
	      Map<String, String> paraMap = new HashMap<>();
	      paraMap.put("searchType", searchType);
	      paraMap.put("searchWord", searchWord);
	      
	      // 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
	      // 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다.
	      int totalCount = 0;        // 총 게시물 건수
	      int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수
	      int currentShowPageNo = 0;  // 현재 보여주는 페이지번호로서, 초기치로는 1페이지를 준다.
	      int totalPage = 0;          // 총 페이지 수(웹 브라우저 상에서 보여줄 총 페이지 개수, 페이지바)
	      
	      int startRno = 0; // 시작 행번호
	      int endRno = 0;   // 끝 행번호
	      
	      // 총 게시물 건수(totalCount)
	      totalCount = service.getTotalCount(paraMap);
	      System.out.println("확인용 totalCount : " + totalCount);
	      // 확인용 totalCount : 4
	      // 2가 나와야 되는데 그러면??
	      
	      // 만약에 총 게시물 건수(totalCount)가 127개 라면
	      // 총 페이지 수(totalPage)가 13개가 되어야 한다.
	      
	      totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
	      // (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13
	      // (double)120/10 ==> 12.7 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
	      
	      if(str_currentShowPageNo == null) {
	         // 게시판에 보여지는 초기화면
	         currentShowPageNo = 1;
	      }
	      else {
	         try {
	            currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
	            if( currentShowPageNo < 1 || currentShowPageNo > totalPage ) {
	               currentShowPageNo = 1;
	            }
	         } catch (NumberFormatException e) {
	            currentShowPageNo = 1;
	         }
	      }
	      // **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
	         /*
	              currentShowPageNo      startRno     endRno
	             --------------------------------------------
	                  1 page        ===>    1           10
	                  2 page        ===>    11          20
	                  3 page        ===>    21          30
	                  4 page        ===>    31          40
	                  ......                ...         ...
	          */
	      
	      startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	      endRno = startRno + sizePerPage - 1;
	      
	      paraMap.put("startRno", String.valueOf(startRno));
	      paraMap.put("endRno", String.valueOf(endRno));
	      
	      boardList = service.boardListSearchWithPaging(paraMap);
	      // 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	      
	      // 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것이다.
	      if(!"".equals(searchType) && !"".equals(searchWord)) {
	         mav.addObject("paraMap", paraMap);  // 이 값이 뷰단에 간다. 맵을 넘겨주면
	      }
	      
	      // === #121. 페이지바 만들기 === //
	      int blockSize = 10;
	      // blockSize 는 1개 블럭(토막)당 보여지는 페이지 번호의 개수이다.
	      /*
	                   1  2  3  4  5  6  7  8  9  10 [다음][마지막]  -- 1개블럭
	      [맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
	      [맨처음][이전]  21 22 23
	      */
	      
	      int loop = 1;
	      /*
	           loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	       */
	      
	      int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	         // *** !! 공식이다. !! *** //
	         
	      
	      String pageBar = "<ul style='list-style: none;'>";
	      String url = "noticeList.lmsfinal";
	      
	      // === [맨처음][이전] 만들기 === //
	      if(pageNo != 1) {
	         pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]<a/></li>";
	         pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]<a/></li>";
	      }
	      
	      
	      while( !(loop > blockSize || pageNo > totalPage) ) {  // !() 는 탈출조건
	      
	         if(pageNo == currentShowPageNo) {
	         pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
	         }
	         else {
	         pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"<a/></li>";
	         }
	         loop++;
	         pageNo++;
	      }// end of while ---------------------------
	      
	      
	      // === [다음][마지막] 만들기 === //
	      if(pageNo <= totalPage) {
	         pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]<a/></li>";
	         pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]<a/></li>";
	      }
	      
	      pageBar += "<ul/>";
	      
	      mav.addObject("pageBar", pageBar);
	      
	      // === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	        //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
	        //           현재 페이지 주소를 뷰단으로 넘겨준다.
	      String gobackURL = com.spring.lmsfinal.common.MyUtil.getCurrentURL(request);
	   //   System.out.println("확인용 gobackURL : " +gobackURL);
	       
	      mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
	      
	      
	      // ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ==== //
	      ///////////////////////////////////////////////////////////////////
	      
	      mav.addObject("boardList", boardList);
	      mav.setViewName("jeongKyeongEun/notice/noticeList.tiles2");  // 뷰단 페이지에서 문서가 로딩될때 request 영역에 나온다.
	      // /WEB-INF/views/tiles2/jeongKyeongEun/notice/noticeList.jsp  파일을 생성한다. 
	      
	      return mav;
	   }
	   
	   
	   // === #108 검색어 입력시 자동글 완성하기 3 === // ajax 임
	      @ResponseBody                                                // 한글 포함시
	      @RequestMapping(value="/wordSearchShow.lmsfinal", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8" )
	      public String wordSearchShow(HttpServletRequest request) {
	         
	         String searchType = request.getParameter("searchType");
	         String searchWord = request.getParameter("searchWord");
	         
	         Map<String, String> paraMap = new HashMap<>();
	         paraMap.put("searchType", searchType);
	         paraMap.put("searchWord", searchWord);
	         
	         List<String> wordList = service.wordSearchShow(paraMap);
	         
	         JSONArray jsonArr = new JSONArray();  // []
	         
	         if(wordList != null) {
	            for(String word : wordList) {
	               JSONObject jsonObj = new JSONObject();
	               jsonObj.put("word", word);
	               
	               jsonArr.put(jsonObj);
	               
	            }// end of for-----------------------------
	         }
	         
	         return jsonArr.toString(); // 리턴타입은 문자열
	      }
	   
	
	
	// === #62. 글 한개보여주는 페이지 요청 === //
	@RequestMapping(value="/noticeView.lmsfinal")
	public ModelAndView noticeView(ModelAndView mav, HttpServletRequest request) {
		
	//	getCurrentURL(request);
		
		// 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		// 조회하고자 하는 글번호 받아오기
		String noticeno = request.getParameter("noticeno");
	//	System.out.println("확인용 noticeno : " +noticeno);
		// 확인용 noticeno : 3
		
		// 글 목록에서 검색되어진 글 내용일 경우 이전글 제목, 다음글 제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다.
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		// === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
        //           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
        //           현재 페이지 주소를 뷰단으로 넘겨준다.										&는 데이터 구분자!! 그 앞까지 읽어옴
		String gobackURL = request.getParameter("gobackURL"); // /list.action?searchType=&searchWord=&currentShowPageNo=2
	//	System.out.println("확인용 gobackURL : "+gobackURL);
		if( gobackURL != null && gobackURL.contains(" ") ) { //.contains(" ") 에서 () 안에 문자가 포함되어 있습니깡??
			gobackURL = gobackURL.replaceAll(" ", "&");
		}
		mav.addObject("gobackURL", gobackURL);
		
		// === 125 작업의 끝 === // 
		/////////////////////////////////////////////////////////////////////
		
		try {
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("noticeno", noticeno);
			
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			mav.addObject("paraMap", paraMap);  // view.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위해서임.
			
			HttpSession session = request.getSession();
//			AdminVO loginuser = (AdminVO)session.getAttribute("loginuser");
		
//			String login_userid = null;
//			if(loginuser != null) {
//				login_userid = loginuser.getUserid();  // 로그인 되어진 사용자의 아이디 값
				// login_userid 는 로그인 되어진 사용자의 userid 이다.
//			}
//			paraMap.put("login_userid", login_userid);
    //		System.out.println("글 한개 보여주기 확인용 login_userid : " +login_userid);
			// 확인용 login_userid : admin1
			
			// === #68. !!! 중요 !!! 
            //     글1개를 보여주는 페이지 요청은 select 와 함께 
            //     DML문(지금은 글조회수 증가인 update문)이 포함되어져 있다.
            //     이럴경우 웹브라우저에서 페이지 새로고침(F5)을 했을때 DML문이 실행되어
            //     매번 글조회수 증가가 발생한다.
            //     그래서 우리는 웹브라우저에서 페이지 새로고침(F5)을 했을때는
            //     단순히 select만 해주고 DML문(지금은 글조회수 증가인 update문)은 
            //     실행하지 않도록 해주어야 한다. !!! === //
			
			// 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다. 
			NoticeVO noticevo = null;
			if( "yes".equals(session.getAttribute("readCountPermission")) ) { // 올바르게 목록보기를 거쳐온 경우
				// 글 목록보기를 클릭한 다음에 특정 글을 조회해온 경우이다.
				
				noticevo = service.getView(paraMap);   // getView()가 글 한개를 가져오는 것
				// 글 조회수 증가와 함께 글 한개 조회를 해주는 것
				
				session.removeAttribute("readCountPermission"); // 글 한개 보여주고 session은 없애준다. 다시 가져오려면 글 목록보기 과정을 거쳐야한다.
				// 중요함!!! session에 저장된 readCountPermission 을 반드시 삭제해줘야한다.
			}
			else {
				// 웹브라우저에서 새로고침(F5)을 클릭한 경우
				
				noticevo = service.getViewWithNoAddCount(paraMap);   // getView()가 글 한개를 가져오는 것
				// 글 조회수 증가는 없고 단순히 글 한개만을 조회를 해주는 것
			}
			
			mav.addObject("noticevo", noticevo);
			
		
		} catch(NumberFormatException e) {
			
		}
		
		mav.setViewName("jeongKyeongEun/notice/noticeView.tiles2"); // 뷰단 페이지에서 문서가 로딩될때 request 영역에 나온다.
		// /WEB-INF/views/tiles2/jeongKyeongEun/notice/noticeView.jsp
		return mav;
		
	}
		
	@RequestMapping(value="/noticeView2.lmsfinal")
	public ModelAndView noticeView2(ModelAndView mav, HttpServletRequest request) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		// 조회하고자 하는 글번호 받아오기
		String noticeno = request.getParameter("noticeno");
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String gobackURL = request.getParameter("gobackURL");  // & 없이 공백만 나옴
	/*	
		System.out.println("~~~~ view2 의 searchType : " + searchType);
        System.out.println("~~~~ view2 의 searchWord : " + searchWord);
        System.out.println("~~~~ view2 의 gobackURL : " + gobackURL);
	*/      
		HttpSession session = request.getSession();			 // 여기를 거쳐서 감
		session.setAttribute("readCountPermission", "yes");  // 이걸 준 다음에
		
		try {
	         searchWord = URLEncoder.encode(searchWord, "UTF-8"); // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.  
	         gobackURL = URLEncoder.encode(gobackURL, "UTF-8");   // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.
	      /*   
	         System.out.println("~~~~ view2 의 URLEncoder.encode(searchWord, \"UTF-8\") : " + searchWord);
	         System.out.println("~~~~ view2 의 URLEncoder.encode(gobackURL, \"UTF-8\") : " + gobackURL);
	         
	         System.out.println(URLDecoder.decode(searchWord, "UTF-8")); // URL인코딩 되어진 한글을 원래 한글모양으로 되돌려 주는 것임. 
	         System.out.println(URLDecoder.decode(gobackURL, "UTF-8"));  // URL인코딩 되어진 한글을 원래 한글모양으로 되돌려 주는 것임. 
	      */   
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      } 
		
																												// 공백이 넘어감
		mav.setViewName("redirect:/noticeView.lmsfinal?noticeno="+noticeno+"&searchType="+searchType+"&searchWord="+searchWord+"&gobackURL="+gobackURL);
		// redirect ==> 거쳐간것을 여기로 바꾸어준다.   redirect 할때 한글이 깨져서 위에 수정해왔다.
		return mav;
	}
	
	
	// === #71 글 수정페이지 요청 === //
	@RequestMapping(value="/noticeEdit.lmsfinal")
	public ModelAndView noticeEdit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 글 수정해야 할 글번호 가져오기
		String noticeno = request.getParameter("noticeno");
		
		// 글 수정해야 할  글 한개 내용을 가져오기
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("noticeno", noticeno);
		
		////////////////////////////////
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		////////////////////////////////
		
		NoticeVO noticevo = service.getViewWithNoAddCount(paraMap);
		// 글조회수(readCount) 증가 없이 단순히 글 한개만 조회해주는 것이다.
		
		HttpSession session = request.getSession();
		AdminVO loginuser = (AdminVO)session.getAttribute("loginuser");
		
		if( loginuser.getUserid() == null ) {
			String message = "관리자만 수정이 가능합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		
		else {
			// 자신의 글을 수정할 경우
			// 가져온 1개 글을 수정할 폼이 있는 view 단으로 보내준다.
			mav.addObject("noticevo", noticevo);
			mav.setViewName("jeongKyeongEun/notice/noticeEdit.tiles2"); // 뷰단 페이지에서 문서가 로딩될때 request 영역에 나온다.
			// /WEB-INF/views/tiles2/jeongKyeongEun/notice/noticeEdit.jsp  파일을 생성한다. 
		}
		
		return mav;
	}
		
	
	
	// === #72 글 수정페이지 완료하기 === //
	@RequestMapping(value="/editEnd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView editEnd(ModelAndView mav, NoticeVO noticevo, HttpServletRequest request) {
		
		System.out.println("확인용 글번호: " +noticevo.getNoticeno());
		/*
		  	글 수정을 하려면 원본글의 글암호와 수정시 입력해준 암호가 일치할때만
		  	글 수정이 가능하도록 해야 한다.
		 */
		int n = service.edit(noticevo);
		// n 이 1 이라면 정상적으로 변경됨
		// n 이 0 이라면 글수정에 필요한 글 암호가 틀린경우임.
		System.out.println("확인용 n : " +n); // 0 이 나온다.
		if(n==0) {
			mav.addObject("message", "오류가 감지되어 글 수정이 불가합니다.");
			mav.addObject("loc", "javascript:history.back()");
		}
		else {
			mav.addObject("message", "글이 성공적으로 수정되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/noticeView.lmsfinal?noticeno="+noticevo.getNoticeno());  // 글번호는 boardvo 에 다 들어오고 있다.
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	
	// === #76 글 삭제페이지 요청하기 === //
	@RequestMapping(value="/noticeDel.lmsfinal")
	public ModelAndView noticeDel(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 글 삭제해야 할 글번호 가져오기
		String noticeno = request.getParameter("noticeno");
		
		// 글 삭제해야 할  글 한개 내용을 가져와서 로그인 한 사람이 쓴 글이라면 글 삭제가 가능하도록 하고
		// 다른 사람이 쓴 글은 삭제가 불가능하게 한다.
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("noticeno", noticeno);
		
		/////////////////////////////////
		paraMap.put("searchType", "");
		paraMap.put("searchWord", "");
		/////////////////////////////////
		
		NoticeVO noticevo = service.getViewWithNoAddCount(paraMap);
		// 글조회수(readCount) 증가 없이 단순히 글 한개만 조회해주는 것이다.
		
		HttpSession session = request.getSession();
		AdminVO loginuser = (AdminVO)session.getAttribute("loginuser");
		
		if( loginuser.getUserid() == null ) {
			String message = "관리자만 글 삭제가 가능합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);
			mav.setViewName("msg");
		}
		
		else {
			// 자신의 글을 삭제할 경우
			mav.addObject("noticeno", noticeno);
			mav.setViewName("jeongKyeongEun/notice/noticeDel.tiles2"); // 뷰단 페이지에서 문서가 로딩될때 request 영역에 나온다.
			// /WEB-INF/views/tiles2/jeongKyeongEun/notice/noticeEdit.jsp  파일을 생성한다. 
		
		}
		return mav;
	}
	
	
	
	// === #77. 글삭제 페이지 완료하기 === //
	@RequestMapping(value="/delEnd.lmsfinal", method= {RequestMethod.POST})
	public ModelAndView delEnd(ModelAndView mav, HttpServletRequest request) {
	
		String noticeno = request.getParameter("noticeno");  // seq 가 넘어온다.
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("noticeno", noticeno);
		
		////////////////////////////////////////////////////////////////////
		// === #164. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. === //
		paraMap.put("searchType", "");
		paraMap.put("searchWord", ""); // 이게 있어야 오류가 안 일어난다.

		NoticeVO noticevo = service.getViewWithNoAddCount(paraMap);
		String nfileName = noticevo.getNfilename();
		
		if( nfileName != null && !"".equals(nfileName) ) {
			HttpSession session = request.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root+"resources"+File.separator+"files";  // 경로 알아오기
			
			paraMap.put("path", path); // 삭제해야할 파일이 저장된 경로
			paraMap.put("nfileName", nfileName); // 삭제해야할 파일명
		}
		// === 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. 끝  === //
        /////////////////////////////////////////////////////////////////
		
		int n = service.del(paraMap);
		
		if(n==1) {
			mav.addObject("message", "글 삭제 성공!!");
			mav.addObject("loc", request.getContextPath()+"/noticeList.lmsfinal");
		}
		else {
			mav.addObject("message", "글 삭제 실패!!");
			mav.addObject("loc", "javascript:history.back()");
		}

		mav.setViewName("msg");
		
		return mav;
	}
	   
	   
	   
	   
	   // ==== #163 첨부파일 다운로드 받기 ==== //
	   @RequestMapping(value="/download.lmsfinal")
	   public void download(HttpServletRequest request, HttpServletResponse response) {
	      
	      String noticeno = request.getParameter("noticeno");
	      // 첨부파일이 있는 글번호
	      
	      Map<String, String> paraMap = new HashMap<>();
	      paraMap.put("searchType", "");
	      paraMap.put("searchWord", "");
	      paraMap.put("noticeno", noticeno);
	      
	      response.setContentType("text/html; charset=UTF-8");
	       PrintWriter out = null;
	       // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	      
	      try {
	         Integer.parseInt(noticeno);
	         NoticeVO noticevo = service.getViewWithNoAddCount(paraMap);
	         
	         if(noticevo == null || noticevo != null && noticevo.getNfilename() == null) {
	            out = response.getWriter();
	            // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	            
	            out.println("<script type='text/javascript'>alert('존재하지 않는 글번호이거나 첨부파일이 없으므로 파일 다운로드가 불가합니다.'); history.back();</script>");
	            return;  // 종료
	         }
	         else {
	            // 정상적으로 다운로드를 할 경우
	            
	            String nfilename = noticevo.getNfilename();
	            
	            String norgfile = noticevo.getNorgfile();
	            
	            // 첨부파일이 저장되어 있는 WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
	               // 이 경로는 우리가 파일첨부를 위해서 /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
	               // WAS 의 webapp 의 절대경로를 알아와야 한다.
	            
	            HttpSession session = request.getSession();
	            String root = session.getServletContext().getRealPath("/");
	            
	            String path = root+"resources"+ File.separator +"files";
	            
	            // **** file 다운로드 하기 **** //
	            boolean flag = false; // file 다운로드 성공, 실패를 알려주는 용도
	            flag = fileManager.doFileDownload(nfilename, norgfile, path, response);
	            // file 다운로드 성공시 flag는 true, 실패시 false 가 되어진다.
	            
	            if(!flag) {
	               // 다운로드가 실패할 경우 메시지를 띄워준다.
	               out = response.getWriter();
	               // out 은 웹브라우저에 기술하는 대상체라고 생각하자.
	               
	               out.println("<script type='text/javascript'>alert('파일 다운로드에 실패했습니다.'); history.back();</script>");
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
	
	/////////  ===== ***** faq 페이지 요청 ***** ===== /////////
	@RequestMapping(value="/faq.lmsfinal", method= {RequestMethod.GET})   // 폼 페이지가 떠야하니까 method get방식만
	public ModelAndView faq(ModelAndView mav) {
		
		mav.setViewName("jeongKyeongEun/faq.tiles2");  // faq 폼이 있는 페이지로 이동
		// /WEB-INF/views/tiles2/jeongKyeongEun/faq.jsp  파일을 생성한다. 
		return mav;
	}
	
	

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 생성 === //
	public void getCurrentURL(HttpServletRequest request) {
	HttpSession session = request.getSession();
	session.setAttribute("goBackURL", com.spring.lmsfinal.common.MyUtil.getCurrentURL(request));
	
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	
	
	
	
}
