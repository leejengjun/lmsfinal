package com.spring.lmsfinal.wonhyejin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.lmsfinal.yejinsim.model.MylectureVO;


@Repository
public class GyowonDAO implements InterGyowonDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

//교원회원등록
	@Override
	public int gyowonRegisterEnd(Map<String, String> paraMap) {
		int n = sqlsession.insert("wonhyejin.gyowonRegisterEnd",paraMap);
		return n;
	}

// 교원번호중복 검사 
	@Override
	public int gyowonIdDuplicateCheck(String gyowonid) {
		
		int result = sqlsession.selectOne("wonhyejin.gyowonIdDuplicateCheck", gyowonid);
		return result;
	}

//이메일 중복확인
	@Override
	public int gyoemailDuplicateCheck(String gyoemail) {
		int result = sqlsession.selectOne("wonhyejin.gyoemailDuplicateCheck", gyoemail);
		return result;
	}

//교수 리스트 보기 
		@Override
		public int getGTotalPage(Map<String, String> paraMap) {
			int n = sqlsession.selectOne("wonhyejin.getGTotalPage", paraMap);
			return n;
		}
		
//교수 리스트 보기 
	@Override
	public List<GyowonVO> selectPagingGyowon(Map<String, String> paraMap) {
		List<GyowonVO> gyowonList = sqlsession.selectList("wonhyejin.selectPagingGyowon", paraMap);
		return gyowonList;
	}	
	
//교수1명보기 
	@Override
	public GyowonVO gyowonOneDetail(String gyoname) {
		GyowonVO gyowonvo = sqlsession.selectOne("wonhyejin.gyowonOneDetail",gyoname);
		return gyowonvo;
	}
		

//교수강의 개설 승인(업데이트 신청상태변경_승인)
	@Override
	public int gyoOpenedUpdate(Map<String, String> paraMap) {
		int n = sqlsession.update("wonhyejin.gyoOpenedUpdate",paraMap);
		return n;
	}

//교수강의 개설 승인(업데이트 신청상태변경_삭제)
	@Override
	public int gyoOpenedDelete(Map<String, String> paraMap) {
		int n = sqlsession.update("wonhyejin.gyoOpenedDelete",paraMap);
		return n;
	}

// 교수강의 신청(페이징함)
	@Override
	public int getGOpenTotalPage(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("wonhyejin.getGOpenTotalPage", paraMap);
		return n;
	}

// 교수강의 신청(페이징함)
	@Override
	public List<MylectureVO> selectPagingGyowonOpen(Map<String, String> paraMap) {
		List<MylectureVO> gyoOpenedList = sqlsession.selectList("wonhyejin.selectPagingGyowonOpen", paraMap);
		return gyoOpenedList;
	}

	

}
