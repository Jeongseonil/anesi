package com.example.anesi.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.anesi.mapper.LoginMapper;
import com.example.anesi.mapper.UserMapper;



@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper userMapper;
	
	@Override
	public int userJoin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return userMapper.userJoin(map);
	}

	@Override
	public int userCnt(HashMap<String, Object> map) {
		System.out.println(map);
		return userMapper.userCnt(map);
	}

}
