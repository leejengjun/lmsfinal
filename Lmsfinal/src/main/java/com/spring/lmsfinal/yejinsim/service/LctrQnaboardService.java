package com.spring.lmsfinal.yejinsim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.yejinsim.model.InterLctrQnaboardDAO;
import com.spring.lmsfinal.yejinsim.model.LctrQnaboardVO;

@Service
public class LctrQnaboardService implements InterLctrQnaboardService {

	@Autowired
	private InterLctrQnaboardDAO dao;

	// 파일첨부가 없는 질문게시판 글쓰기
	@Override
	public int addlctrQna(LctrQnaboardVO lqnaboardvo) {
		// === #144. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여 
	      //           tbl_board 테이블에 insert 를 해주어야 한다.
	      //           원글쓰기 이라면 tbl_board 테이블의 groupno 컬럼의 값은 
	      //           groupno 컬럼의 최대값(max)+1 로 해서 insert 해야하고,
	      //           답변글쓰기 이라면 넘겨받은 값(boardvo)을 그대로 insert 해주어야 한다.
		
		// === #147. 원글쓰기인지, 답변글쓰기인지 구분하기 시작 === 
/*
		if("".equals(qnaboardvo.getFk_qseq() )) {
	    	// 원글쓰기인 경우 
	    	// groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해야 한다.
	    	int qgroupno = dao.getQgroupnoMax() + 1;
	    	qnaboardvo.setQgroupno(String.valueOf(qgroupno));
	    }
	*/   	
		// === 원글쓰기인지, 답변글쓰기인지 구분하기 끝 === // 
		
		
		int n = dao.addlctrQna(lqnaboardvo);
		
		return n;
	}
}
