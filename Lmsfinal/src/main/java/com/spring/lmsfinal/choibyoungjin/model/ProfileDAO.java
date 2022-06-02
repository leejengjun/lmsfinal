package com.spring.lmsfinal.choibyoungjin.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProfileDAO implements InterProfileDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	@Override
	public List<TestVO> test_select() {
		List<TestVO> testvoList = sqlsession.selectList("profileCBJ.test_select");
		return testvoList;
	}

	@Override
	public List<StudentVO> profile_select() {
		List<StudentVO> studentList = sqlsession.selectList("profileCBJ.profile_select");
		return studentList;
	}

	@Override
	public StudentVO profile_select_one(Map<String, Object> paraMap) {
		StudentVO studentvo = sqlsession.selectOne("profileCBJ.profile_select_one", paraMap);
		return studentvo;
	}

	@Override
	public int profileEdit(StudentVO studentvo) {
		int n = sqlsession.update("profileCBJ.profileEdit", studentvo);
		System.out.println(n);
		return n;
	}

	

}
