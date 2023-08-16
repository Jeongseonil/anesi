package com.example.anesi.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.anesi.model.Order;
import com.example.anesi.model.Product;
import com.example.anesi.model.Review;

@Mapper
public interface ReviewMapper {
		// 상품 별점 검색
		Product selectCsatAvg(HashMap<String, Object> map);
		// 리뷰
		List<Review>selectReview(HashMap<String, Object> map);
		// 리뷰 페이지 카운트
		int selectCnt(HashMap<String, Object> map);
		// 리뷰 개수 검색
		List<Review>selectReviewCnt(HashMap<String, Object> map);
		// 상품 구매 확인(리뷰)
		List<Order> selectReviewUser(HashMap<String, Object> map);
		// 리뷰 등록
		int insertReview(HashMap<String, Object> map);
}
