package com.spring.lmsfinal.duHyeon.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO implements InterNoticeDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	
	// Subjectid Majorid Gyowonid얻어오기
	@Override
	public Map<String, String> getSMG(Map<String, String> paraMap) {
		
		Map<String, String> smgMap = sqlsession.selectOne("duHyeon.getSMGThroughSubjectid",paraMap);
		return smgMap;
	}


	// 파라맵을 이용해서 데이터 베이스에 인서트 해줄 것
	@Override
	public int addNotice(SubjectNoticeVO subjectnoticevo) {
		
		int n = sqlsession.insert("duHyeon.addNotice", subjectnoticevo);
		return n;
	}


	// VO를 이용해서 데이터 베이스에 인서트 해줄 것
	@Override
	public int NoticeWithFile(SubjectNoticeVO subjectnoticevo) {
		
		int n = sqlsession.insert("duHyeon.addNoticeWithFile", subjectnoticevo);
		return n;
	}


	// 과목코드로 검색해서 공지사항의 총 개수를 구해옴
	@Override
	public int getTotalNoticeCount(Map<String, String> paraMap) {
		
		int n = sqlsession.selectOne("duHyeon.getTotalNoticeCount", paraMap);
		
		return n;
	}


	// 공지사항 리스트를 받아와주는 메소드
	@Override
	public List<SubjectNoticeVO> noticeList(Map<String, String> paraMap) {
		
		List<SubjectNoticeVO> noticeList = sqlsession.selectList("duHyeon.noticeList", paraMap);
		
		return noticeList;
		
	}


	// noticeno을 이용하여 하나의 noticevo를 받아온다.
	@Override
	public SubjectNoticeVO getdetailnotice(Map<String, String> paraMap) {
		
		SubjectNoticeVO noticevo = sqlsession.selectOne("duHyeon.getNoticeOne", paraMap);
		return noticevo;
	}

	// noticeno이용해서 smg받아오기
	@Override
	public Map<String, String> getSMGThroughNotice(Map<String, String> paraMap) {
		Map<String, String> smgMap = sqlsession.selectOne("duHyeon.getSMGThroughNoticeNo", paraMap);
 		return smgMap;
	}

	// 글수정하기 근데 이제 파일이 없는
	@Override
	public int modifyNotice(SubjectNoticeVO subjectnoticevo) {
		int n = sqlsession.update("duHyeon.modifyNotice", subjectnoticevo);
		return n;
	}

	// 글수정하기 근데이제 파일을 곁들인
	@Override
	public int modifyNoticeWithFile(SubjectNoticeVO subjectnoticevo) {
		int n = sqlsession.update("duHyeon.modifyNoticeWithFile", subjectnoticevo);
		return n;
	}
	
	

}
