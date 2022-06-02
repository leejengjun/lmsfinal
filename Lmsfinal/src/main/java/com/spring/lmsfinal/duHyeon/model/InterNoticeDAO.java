package com.spring.lmsfinal.duHyeon.model;

import java.util.List;
import java.util.Map;

public interface InterNoticeDAO {

	
	// Subjectid Majorid Gyowonid얻어오기
	Map<String, String> getSMG(Map<String, String> paraMap);

	
	// VO를 이용해서 데이터 베이스에 인서트 해줄 것
	int addNotice(SubjectNoticeVO subjectnoticevo);

	// VO를 이용해서 데이터 베이스에 인서트 해줄 것
	int NoticeWithFile(SubjectNoticeVO subjectnoticevo);

	// 과목코드로 검색해서 공지사항의 총 개수를 구해옴
	int getTotalNoticeCount(Map<String, String> paraMap);

	// 공지사항 리스트를 받아와주는 메소드
	List<SubjectNoticeVO> noticeList(Map<String, String> paraMap);

	// noticeno을 이용하여 하나의 noticevo를 받아온다.
	SubjectNoticeVO getdetailnotice(Map<String, String> paraMap);

	// noticeno이용해서 smg받아오기
	Map<String, String> getSMGThroughNotice(Map<String, String> paraMap);

	// 글수정하기 근데 이제 파일이 없는
	int modifyNotice(SubjectNoticeVO subjectnoticevo);

	// 글수정하기 근데이제 파일을 곁들인
	int modifyNoticeWithFile(SubjectNoticeVO subjectnoticevo);
	
	
	

}
