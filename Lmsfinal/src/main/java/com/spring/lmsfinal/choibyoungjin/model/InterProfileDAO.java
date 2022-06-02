package com.spring.lmsfinal.choibyoungjin.model;

import java.util.List;
import java.util.Map;

public interface InterProfileDAO {

	List<TestVO> test_select();

	List<StudentVO> profile_select();

	StudentVO profile_select_one(Map<String, Object> paraMap);

	int profileEdit(StudentVO studentvo);

}
