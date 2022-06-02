package com.spring.lmsfinal.yejinsim.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LctrQnaboardDAO implements InterLctrQnaboardDAO {

	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB finalorauser3 에 연결

	// 질문게시판 글쓰기
	@Override
	public int addlctrQna(LctrQnaboardVO lqnaboardvo) {
		int n = sqlsession.insert("yejinsim.addlctrQna",lqnaboardvo);	
		return n;
	}

}
