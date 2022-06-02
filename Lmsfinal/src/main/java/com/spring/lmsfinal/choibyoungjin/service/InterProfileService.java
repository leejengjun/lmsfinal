package com.spring.lmsfinal.choibyoungjin.service;

import java.util.*;

import com.spring.lmsfinal.choibyoungjin.model.*;

public interface InterProfileService {

	List<TestVO> test_select();

	List<StudentVO> profile_select();

	StudentVO profile_select_one(Map<String, Object> paraMap);

	int profileEdit(StudentVO studentvo);

}
