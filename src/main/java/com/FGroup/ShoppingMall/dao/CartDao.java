package com.FGroup.ShoppingMall.dao;

import java.util.List;

import com.FGroup.ShoppingMall.dto.CartDto;
import com.FGroup.ShoppingMall.dto.ProductDto;

public interface CartDao {

	public int cartInsert(int m_no, int p_No, int o_amount);
	public int totalRecord(int m_no);
	public List<CartDto> cartList(int m_no, int beginRecord, int endRecord); // 페이징 + 카트목록
	public ProductDto cartProduct(int p_no);
	public int cartDelete(int p_no, int m_no);
	public int cartDuplicate(int p_no, int m_no); // 같은 제품 중복 방지..
	public List<Integer> memberCart(int m_no); // 그냥 카트 목록 - 세션용
	public int cartCount(int m_no);
	public int cartUpdate(int m_no, int p_no, int crt_amount);
	
}
