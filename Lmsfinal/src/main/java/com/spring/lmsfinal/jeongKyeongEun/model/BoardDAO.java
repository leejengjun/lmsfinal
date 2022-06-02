package com.spring.lmsfinal.jeongKyeongEun.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements InterBoardDAO {

	@Resource
	private SqlSessionTemplate sqlsession;   // 로컬 DB 에 연결

	@Override
	public int test_insert() {
		int n = sqlsession.insert("jeongKyeongEun.test_insert");
		return n;
	}

	// 글쓰기(파일 첨부가 없는 글쓰기)
	@Override
	public int add(NoticeVO noticevo) {
		int n = sqlsession.insert("jeongKyeongEun.add", noticevo);
		return n;
	}

	@Override
	public int add_withFile(NoticeVO noticevo) {
		int n = sqlsession.insert("jeongKyeongEun.add_withFile", noticevo);
		return n;
	}

	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을 때로 나뉜다.
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = sqlsession.selectOne("jeongKyeongEun.getTotalCount", paraMap);
		return n;
	}

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<NoticeVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<NoticeVO> boardList = sqlsession.selectList("jeongKyeongEun.boardListSearchWithPaging", paraMap);
		return boardList;
	}

	// 검색어 입력시 자동글 완성하기 4
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = sqlsession.selectList("jeongKyeongEun.wordSearchShow", paraMap);
		return wordList;
	}

	// 글 한개 조회하기
	@Override
	public NoticeVO getView(Map<String, String> paraMap) {
		NoticeVO noticevo = sqlsession.selectOne("jeongKyeongEun.getView", paraMap);
		return noticevo;
	}

	// 글 조회수 1 증가하기
	@Override
	public void setAddReadCount(int noticeno) {
		sqlsession.update("jeongKyeongEun.setAddRedaCount", noticeno);
	}

	// 글 한 개 수정하기
	@Override
	public int edit(NoticeVO noticevo) {
		int n = sqlsession.update("jeongKyeongEun.edit", noticevo);
		return n;
	}

	// 글 한 개 삭제하기
	@Override
	public int del(Map<String, String> paraMap) {
		int n = sqlsession.delete("jeongKyeongEun.del", paraMap);
		return n;
	}
	
}
