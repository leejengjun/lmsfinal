package com.spring.lmsfinal.yejinsim.service;

import com.spring.lmsfinal.yejinsim.model.GyowonVO;

public interface InterGyowonService {

	// 교원정보 조회하기
	GyowonVO gyowoninfoSearch(String gyowonid);

	// 이메일 중복검사
	String emailDuplicateCheck(String gyoemail);

	// 교원정보 수정하기 
	int editgyowoninfo(GyowonVO gyowonvo);

}
