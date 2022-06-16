package com.spring.lmsfinal.wonhyejin.model;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.yejinsim.model.MylectureVO;

public interface InterGyowonDAO {

// 학과찾기
	List<GyowonVO> gyoDeptlistSearch(Map<String, String> paraMap);
	
//교원회원등록
	int gyowonRegisterEnd(Map<String, String> paraMap);
	
// 교원번호중복 검사 
	int gyowonIdDuplicateCheck(String gyowonid);

//이메일 중복 확인 
	int gyoemailDuplicateCheck(String gyoemail);
 
//교수강의 개설 승인(업데이트 신청상태변경_승인)
	int gyoOpenedUpdate(Map<String, String> paraMap);
	
 //교수강의 개설 승인(업데이트 신청상태변경_삭제)
	int gyoOpenedDelete(Map<String, String> paraMap);

//교수 리스트 보기 
	int getGTotalPage(Map<String, String> paraMap);

//교수 리스트 보기 
	List<GyowonVO> selectPagingGyowon(Map<String, String> paraMap);

//교수1명보기 
	GyowonVO gyowonOneDetail(String gyoname);

//교수강의 개설 승인	 (페이징처리함)
	int getGOpenTotalPage(Map<String, String> paraMap);
	
//교수강의 개설 승인	 (페이징처리함)
	List<MylectureVO> selectPagingGyowonOpen(Map<String, String> paraMap);

	
}
