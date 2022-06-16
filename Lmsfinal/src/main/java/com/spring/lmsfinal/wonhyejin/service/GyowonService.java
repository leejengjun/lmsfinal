package com.spring.lmsfinal.wonhyejin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.common.AES256;
import com.spring.lmsfinal.wonhyejin.model.GyowonVO;
import com.spring.lmsfinal.wonhyejin.model.InterGyowonDAO;
import com.spring.lmsfinal.wonhyejin.model.StudentVO;
import com.spring.lmsfinal.yejinsim.model.MylectureVO;



@Service
public class GyowonService implements InterGyowonService {

	
	@Autowired
	private InterGyowonDAO dao;

	 @Autowired
	  private AES256 aes;

// 학과찾기
	 
	@Override
	public List<GyowonVO> gyoDeptlistSearch(Map<String, String> paraMap) {
		List<GyowonVO> gyoDeptlist = dao.gyoDeptlistSearch(paraMap);
		return gyoDeptlist;
	}

		
//교원회원 등록
	@Override
	public int gyowonRegisterEnd(Map<String, String> paraMap) {
		int n = dao.gyowonRegisterEnd(paraMap);
		return n;
	}
	
//교원번호 중복 확인 
	@Override
	public int gyowonIdDuplicateCheck(String gyowonid) {
		int result = dao.gyowonIdDuplicateCheck(gyowonid);
		return result;
	}

//이메일 중복 확인 하기 
	@Override
	public int gyoemailDuplicateCheck(String gyoemail) {
		int result = dao.gyoemailDuplicateCheck(gyoemail);
		return result;
	}


//교수리스트 보기
	@Override
	public int getGTotalPage(Map<String, String> paraMap) {
		int n = dao.getGTotalPage(paraMap);
		return n;
	}
	
//교수리스트 보기
	@Override
	public List<GyowonVO> selectPagingGyowon(Map<String, String> paraMap) {
		List<GyowonVO> gyowonList = dao.selectPagingGyowon(paraMap);
		return gyowonList;
	}
	
// 교수한명 리스트보기 
	@Override
	public GyowonVO gyowonOneDetail(String gyoname) {
		GyowonVO gyowonvo = dao.gyowonOneDetail(gyoname);
		return gyowonvo;
	}


//교수강의 개설 승인(업데이트 신청상태변경_등록)
	@Override
	public int gyoOpenedUpdate(Map<String, String> paraMap) {
		int n = dao.gyoOpenedUpdate(paraMap);
		return n;
	}

//교수강의 개설 승인(업데이트 신청상태변경_삭제)
	@Override
	public int gyoOpenedDelete(Map<String, String> paraMap) {
		int n = dao.gyoOpenedDelete(paraMap);
		return n;
	}
	
//교수강의 개설 승인	 (페이징처리함)
	@Override
	public int getGOpenTotalPage(Map<String, String> paraMap) {
		int n = dao.getGOpenTotalPage(paraMap);
		return n;
	}

//교수강의 개설 승인	 (페이징처리함)
	@Override
	public List<MylectureVO> selectPagingGyowonOpen(Map<String, String> paraMap) {
		List<MylectureVO> gyoOpenedList = dao.selectPagingGyowonOpen(paraMap);
		return gyoOpenedList;
	}

	


}
