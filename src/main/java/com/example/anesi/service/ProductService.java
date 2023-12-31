package com.example.anesi.service;

import java.util.HashMap;
import java.util.List;

import com.example.anesi.model.Cart;
import com.example.anesi.model.Category;
import com.example.anesi.model.Order;
import com.example.anesi.model.Product;
import com.example.anesi.model.Review;
import com.example.anesi.model.Scrapbook;

public interface ProductService {
	//카테고리 대분류 검색
	List<Category> searchCategoryList();
	
	static List<Product> selectCartProductList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<Product> selectCartProductList(HashMap<String, Object> map);
	
	//카테고리 소분류 검색
	List<Category> searchCategoryList2(HashMap<String, Object> map);
	// 상품 카테고리 
		List<Category> searchCategory(HashMap<String, Object> map);
	// 상품 상세 정보 검색
	Product searchProductList(HashMap<String, Object> map);;
	// 상품 옵션 검색
	List<Product> searchOption(HashMap<String, Object> map);
	// 상품 썸네일 이미지 
	List<Scrapbook> searchThumbnailImg(HashMap<String, Object> map);
	// 상품 콘텐츠 이미지 
	List<Scrapbook>searchProductImg(HashMap<String, Object> map);
	//상품 검색창 
	List<Product> searchProduct(HashMap<String, Object> map);
	// 상품 상세 이미지
	List<Scrapbook>searchcontentImg2(HashMap<String, Object> map);
	//상품 장바구니
	List<Product>selectCartList(HashMap<String, Object> map);
	// 상품등록
	int addProduct(HashMap<String, Object> map);
	// 상품등록후 검색
	Product insertSearchProduct(HashMap<String, Object> map);
	
	// 옵션등록
	int addOption(HashMap<String, Object> map);
	// 회원 장바구니 삭제
	int deleteCartlist (HashMap<String, Object> map);
	
	List<Product> searchBarProductList (HashMap<String, Object> map);
	//회원 장바구니 모두삭제
	int deleteAllCartItems (HashMap<String, Object> map);
	//최근본상품 출력
	List<Product> selectLatest (HashMap<String, Object> map);
	//카테고리 상품 출력
	List<Product> selectCateList (HashMap<String, Object> map);
	//카테고리 상품 출력selectCateList
	public List<Product> selectCate(String categoryName);
	// 회원 장바구니 등록(상세페이지)
	int addCart(HashMap<String, Object> map);
	// 장바구니 중복체크
	List<Cart>searchCartCheck(HashMap<String, Object> map);
	// 카테고리 선택 상품
	HashMap<String, Object>searchProduct2(HashMap<String, Object> map); 
}

