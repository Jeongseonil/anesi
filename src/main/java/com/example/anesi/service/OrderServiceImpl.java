package com.example.anesi.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.anesi.mapper.AdminMapper;
import com.example.anesi.mapper.OrderMapper;
import com.example.anesi.model.NonUserOrder;
import com.example.anesi.model.Order;
import com.example.anesi.model.ProductOption;
import com.example.anesi.model.UsedOrder;
import com.example.anesi.model.UserAddress;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	OrderMapper orderMapper;
	
	@Autowired
	AdminMapper adminMapper;
	
	//쿠폰 리스트
	@Override
	public List<Order> searchCouponListt(HashMap<String, Object> map) {
		return orderMapper.selectCouponList(map);
	}
	// 주소 입력
	@Override
	public Object addAddr(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		Object no = 1;
		if (!map.get("userNo").equals("")) {
			orderMapper.insertAddr(map);
			no = map.get("ADDR_NO");
		} else {
			orderMapper.insertNonAddr(map);
			no = map.get("ADDR_NO");
		}
		return no;
	}
	// 주소 검색
	@Override
	public List<UserAddress> searchAddrList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectAddrList(map);
	}
	// 입력 주소 검색
	@Override
	public UserAddress searchAddr(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectAddr(map);
	}
	@Override
	public ProductOption searchOptionInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectOptionInfo(map);
	}
	//주문 입력
	@Override
	public int addOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub		
		int no = 1;
		if (!map.get("userNo").equals("")) {
			no = orderMapper.insertOrder(map);
			map.put("alarmType",2);
			adminMapper.insertAlarm(map);
		} else {
			no = orderMapper.insertNonOrder(map);
		}
		return no;
	}
	@Override
	public int removeCoupon(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.deleteCoupon(map);
	}
	@Override
	public int editAddr(HashMap<String, Object> map) {
		orderMapper.updateAddr1(map);
		orderMapper.updateAddr2(map);
		return 1;
	}
	// 당일 주문량 조회
	@Override
	public int searchOrderCnt(HashMap<String, Object> map) {
		int no = 1;
		if (!map.get("userNo").equals("")) {
			no = orderMapper.selectOrderCnt(map);
		} else {
			no = orderMapper.selectNonOrderCnt(map);
		}
		return no;
	}
	
	// 재고 업데이트
	@Override
	public int editOptionStock(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.updateOptionStock(map);
	}
	// 비회원 주문 조회
	@Override
	public List<NonUserOrder> searchNonUserOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectNonUserOrder(map);
	}
	@Override
	public int editNonUserOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		orderMapper.updateNonUserOrder(map);
		orderMapper.updateNonUserOrderAddr(map);
		return 0;
	}
	@Override
	public int searchNonUserOrderCheck(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectNonUserOrderCheck(map);
	}
	// 중고 상품 정보
	@Override
	public UsedOrder searchUsedOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.selectUsedOrder(map);
	}
	@Override
	public int addUsedOrder(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.insertUsedOrder(map);
	}
	@Override
	public int removeAddress(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return orderMapper.deleteAddress(map);
	}
		
	
	
	
}
