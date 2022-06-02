package com.spring.lmsfinal.duHyeon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.duHyeon.model.InterNoticeDAO;
import com.spring.lmsfinal.duHyeon.model.InterTestDAO;
import com.spring.lmsfinal.duHyeon.model.SubjectNoticeVO;

@Service
public class NoticeService implements InterNoticeService {

	
	@Autowired
	private InterNoticeDAO dao;

	
	// Subjectid Majorid Gyowonid얻어오기
	@Override
	public Map<String, String> getSMG(Map<String, String> paraMap) {
		
		Map<String, String> smgMap = dao.getSMG(paraMap);
		return smgMap;
	}

	// 파라맵을 이용해서 데이터 베이스에 인서트 해줄 것
	@Override
	public int addNotice(SubjectNoticeVO subjectnoticevo) {
		
		int n = dao.addNotice(subjectnoticevo);
		return n;
	}

	// VO를 이용해서 데이터 베이스에 인서트 해줄 것
	@Override
	public int addNoticeWithFile(SubjectNoticeVO subjectnoticevo) {
		
		int n = dao.NoticeWithFile(subjectnoticevo);
		
		return n;
	}

	
	// 과목코드로 검색해서 공지사항의 총 개수를 구해옴
	@Override
	public int getTotalNoticeCount(Map<String, String> paraMap) {
		
		int n = dao.getTotalNoticeCount(paraMap);
		
		return n;
	}

	// 공지사항 리스트를 받아와주는 메소드
	@Override
	public List<SubjectNoticeVO> noticeList(Map<String, String> paraMap) {
		
		List<SubjectNoticeVO> noticeList = dao.noticeList(paraMap);
		
		return noticeList;
	}

	
	// noticeno을 이용하여 하나의 noticevo를 받아온다.
	@Override
	public SubjectNoticeVO getdetailnotice(Map<String, String> paraMap) {
		
		SubjectNoticeVO noticevo = dao.getdetailnotice(paraMap);
		
		return noticevo;
	}

	// noticeno이용해서 smg받아오기
	@Override
	public Map<String, String> getSMGThroughNotice(Map<String, String> paraMap) {
		Map<String, String> smgMap = dao.getSMGThroughNotice(paraMap);
		return smgMap;
	}

	// 글수정하기 근데 이제 파일이 없는
	@Override
	public int modifyNotice(SubjectNoticeVO subjectnoticevo) {
		int n = dao.modifyNotice(subjectnoticevo);
		return n;
	}
	// 글수정하기 근데이제 파일을 곁들인
	@Override
	public int modifyNoticeWithFile(SubjectNoticeVO subjectnoticevo) {
		int n = dao.modifyNoticeWithFile(subjectnoticevo);
		return n;
	}
}
