package com.spring.lmsfinal.jeongKyeongEun.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.common.FileManager;
import com.spring.lmsfinal.jeongKyeongEun.model.InterBoardDAO;
import com.spring.lmsfinal.jeongKyeongEun.model.NoticeVO;

@Service
public class BoardService implements InterBoardService {
	
	@Autowired
	private InterBoardDAO dao;
	
	// === #187. Spring Scheduler(스프링 스케줄러7) === //
    // === Spring Scheduler(스프링스케줄러)를 사용한 email 발송하기 === //
    @Autowired  // Type에 따라 알아서 Bean을 주입해준다.
	private FileManager fileManager;

	@Override
	public int test_insert() {
		int n = dao.test_insert();
		return n;
	}

	// ==== 글쓰기(파일 첨부가 없는 글쓰기)
	@Override
	public int add(NoticeVO noticevo) {
		int n = dao.add(noticevo);
		return n;
	}

	@Override
	public int add_withFile(NoticeVO noticevo) {
		int n = dao.add_withFile(noticevo); // 첨부파일이 있는 경우
		return n;
	}

	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을 때로 나뉜다.
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int n = dao.getTotalCount(paraMap);
		return n;
	}

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
	@Override
	public List<NoticeVO> boardListSearchWithPaging(Map<String, String> paraMap) {
		List<NoticeVO> boardList = dao.boardListSearchWithPaging(paraMap);
		return boardList;
	}

	// 검색어 입력시 자동글 완성하기 4
	@Override
	public List<String> wordSearchShow(Map<String, String> paraMap) {
		List<String> wordList = dao.wordSearchShow(paraMap);
		return wordList;
	}

	// 글 조회수 증가와 함께 글 한개 조회를 해주는 것
	@Override
	public NoticeVO getView(Map<String, String> paraMap) {
		
		NoticeVO noticevo = dao.getView(paraMap); // DB에 paraMap을 줘서 요청한다. 글 1개 조회하기

		dao.setAddReadCount(noticevo.getNoticeno());  // 글조회수 1 증가하기
		noticevo = dao.getView(paraMap);
		
		return noticevo;
	}

	// 글 조회수 증가는 없고 단순히 글 한개만을 조회를 해주는 것
	@Override
	public NoticeVO getViewWithNoAddCount(Map<String, String> paraMap) {
		NoticeVO noticevo = dao.getView(paraMap);  // 글 1개 조회하기
		return noticevo;
	}

	// 글 한 개 수정하기
	@Override
	public int edit(NoticeVO noticevo) {
		int n = dao.edit(noticevo);
		return n;
	}

	// 글 한 개 삭제하기
	@Override
	public int del(Map<String, String> paraMap) {
		int n = dao.del(paraMap);
		
		// === #165. 파일첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제해주어야 한다. === //
		if(n==1) {
			String path = paraMap.get("path");
			String nfileName = paraMap.get("nfileName");
			
			if( nfileName != null && !"".equals(nfileName) ) {
				try {
					fileManager.doFileDelete(nfileName, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		////////////////////////////////////////////////////////////////////
		
		return n;
	}

}
