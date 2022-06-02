package com.spring.lmsfinal.yejinsim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.yejinsim.model.GyowonVO;
import com.spring.lmsfinal.yejinsim.model.InterGyowonDAO;
import com.spring.lmsfinal.yejinsim.model.LectureplanVO;

@Service
public class GyowonService implements InterGyowonService {

	@Autowired
	private InterGyowonDAO dao;

	// 교원정보 조회하기
	@Override
	public GyowonVO gyowoninfoSearch(String gyowonid) {
		GyowonVO gyowonvo = dao.gyowoninfoSearch(gyowonid); // 글 1개를 조회하기
		return gyowonvo;
	}

	// 이메일 중복검사
	@Override
	public String emailDuplicateCheck(String gyoemail) {
		String isExist = dao.emailDuplicateCheck(gyoemail);
		return isExist;
	}

	// 교원정보 수정하기 
	@Override
	public int editgyowoninfo(GyowonVO gyowonvo) {
		int n = dao.editgyowoninfo(gyowonvo);
		return n;
	}
}
