package com.spring.lmsfinal.jeongKyeongEun.service;

import java.util.List;
import java.util.Map;

import com.spring.lmsfinal.jeongKyeongEun.model.NoticeVO;

public interface InterBoardService {

	int test_insert();

	// 글쓰기(파일 첨부가 없는 글쓰기)
	int add(NoticeVO noticevo);

	// 글쓰기(파일 첨부가 있는 글쓰기)
	int add_withFile(NoticeVO noticevo);

	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을 때로 나뉜다.
	int getTotalCount(Map<String, String> paraMap);

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	List<NoticeVO> boardListSearchWithPaging(Map<String, String> paraMap);

	// 검색어 입력시 자동글 완성하기 4
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 글 조회수 증가와 함께 글 한개 조회를 해주는 것
	NoticeVO getView(Map<String, String> paraMap);

	// 글 조회수 증가는 없고 단순히 글 한개만을 조회를 해주는 것
	NoticeVO getViewWithNoAddCount(Map<String, String> paraMap);

	// 글 한 개 수정하기
	int edit(NoticeVO noticevo);

	// 글 한 개 삭제하기
	int del(Map<String, String> paraMap);

}
