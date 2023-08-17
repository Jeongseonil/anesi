package com.example.anesi.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.anesi.mapper.AdminMapper;
import com.example.anesi.model.Product;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminMapper adminMapper;
	
	@Override
	public List<Product> adminProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.adminProductList(map);
	}
	
	
	
}