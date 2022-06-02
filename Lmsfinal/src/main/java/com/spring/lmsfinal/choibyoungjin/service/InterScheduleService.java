package com.spring.lmsfinal.choibyoungjin.service;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.choibyoungjin.model.*;

public interface InterScheduleService {

	// 공유 캘린더에 일정 추가하기
	int addComCalendar(Map<String, String> paraMap) throws Throwable;

	// 내 캘린더에 일정 추가하기
	int addMyCalendar(Map<String, String> paraMap) throws Throwable;

	// 공유 캘린더에서 사내캘린더 소분류  보여주기 
	List<Calendar_small_category_VO> showCompanyCalendar();

	// 내 캘린더에서 내캘린더 소분류  보여주기
	List<Calendar_small_category_VO> showMyCalendar(String fk_userid);

	// 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 
	List<Calendar_small_category_VO> selectSmallCategory(Map<String, String> paraMap);

	// 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 
	List<StudentVO> searchJoinUserList(String joinUserName);

	// 일정 등록하기
	int registerSchedule_end(Map<String, String> paraMap) throws Throwable;

	// 등록된 일정 가져오기
	List<Calendar_schedule_VO> selectSchedule(String fk_userid);

	// 일정 상세 보기 
	Map<String, String> detailSchedule(String scheduleno);

	// 일정삭제하기 
	int deleteSchedule(String scheduleno) throws Throwable;

	// 일정수정하기
	int editSchedule_end(Calendar_schedule_VO svo) throws Throwable;

	// (사내캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기 
	int deleteSubCalendar(String smcatgono) throws Throwable;

	// (사내캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기 
	int editCalendar(Map<String, String> paraMap) throws Throwable;

	// 총 일정 검색 건수(totalCount)
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
	List<Map<String, String>> scheduleListSearchWithPaging(Map<String, String> paraMap);

	
}
