package com.spring.lmsfinal.yejinsim.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class GyowonDAO implements InterGyowonDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession; // 원격 DB finalorauser3 에 연결

	// 교원정보 조회하기
	@Override
	public GyowonVO gyowoninfoSearch(String gyowonid) {
		GyowonVO gyowonvo = sqlsession.selectOne("yejinsim.gyowoninfoSearch",gyowonid);
		return gyowonvo;
	}

	// 이메일 중복검사
	@Override
	public String emailDuplicateCheck(String gyoemail) {
		String isExist = sqlsession.selectOne("yejinsim.emailDuplicateCheck", gyoemail);
		return isExist;
	}

	// 교원정보 수정하기 
	@Override
	public int editgyowoninfo(GyowonVO gyowonvo) {
		int n = sqlsession.update("yejinsim.editgyowoninfo", gyowonvo);
		return n;
	}
	
	
}
