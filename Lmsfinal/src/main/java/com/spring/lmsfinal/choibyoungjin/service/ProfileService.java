package com.spring.lmsfinal.choibyoungjin.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.lmsfinal.choibyoungjin.model.InterProfileDAO;
import com.spring.lmsfinal.choibyoungjin.model.StudentVO;
import com.spring.lmsfinal.choibyoungjin.model.TestVO;
import com.spring.lmsfinal.common.AES256;

@Service
public class ProfileService implements InterProfileService {

	@Autowired
	private InterProfileDAO dao;

	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private AES256 aes;
	
	@Override
	public List<TestVO> test_select() {
		List<TestVO> testvoList = dao.test_select();		
		return testvoList;
	}

	@Override
	public List<StudentVO> profile_select() {
		
		List<StudentVO> studentList = dao.profile_select();
		return studentList;
	}

	@Override
	public StudentVO profile_select_one(Map<String, Object> paraMap) {
		StudentVO studentvo = dao.profile_select_one(paraMap);
		
		String stdemail = "";

		try {
			stdemail = aes.decrypt(studentvo.getStdemail());
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		studentvo.setStdemail(stdemail);
		
		return studentvo;
	}

	@Override
	public int profileEdit(StudentVO studentvo) {
		int n = dao.profileEdit(studentvo);
		System.out.println(n);
		return n;
	}

	
	
}
