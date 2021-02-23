package com.FGroup.ShoppingMall.dao;

import java.util.List;

import com.FGroup.ShoppingMall.dto.CartDto;
import com.FGroup.ShoppingMall.dto.MemberDto;
import com.FGroup.ShoppingMall.dto.OrderDto;
import com.FGroup.ShoppingMall.dto.ProductDto;

public interface OrderDao {

	// 구매페이지
	public ProductDto OrderProduct(int p_No); // 메소드의 이름이 mapper의 쿼리문 id가 됩니다.
	public MemberDto OrderMember(int m_no); // 주문자정보 가져오기

	// 결제하기 누르면,
	public void OrderCart(int m_no, int p_No, int o_amount); // 주문자의 장바구니에 주문하기 버튼을 누른 제품이 들어감
	
	public int OrderInsert(OrderDto orderDto); // 결제완료하고 주문 인서트..(물품 1개)
	// product에서 수량 빼기, member에서 point 차감
	public int OrderProductStock(int o_p_No, int o_amount);
	public int OrderPoint(int o_m_no, int inputPoint);
	public int OrderPointIncrease(int o_m_no, int inputPoint);
	public int OrderCartDelete(int o_m_no, int o_p_No);
	
	public int OrderProductStockAdd(int o_p_No, int o_amount);

	// 주문현황
	public int totalRecord(int m_no);
	public List<OrderDto> OrderList(int o_m_no, int beginRecord, int endRecord);
	public List<OrderDto> OrderLists(int o_m_no, int beginRecord, int endRecord);

	// 주문상세
	public OrderDto OrderView(int o_no);
	public int OrderProductNo(int o_no);

	public List<OrderDto> OrderView2(int o_idx);

	// 주문취소
	public int OrderDelete(int o_no);
	public int OrderDelete2(int o_idx);
	
	// 카트에서 가져오기
	public CartDto OrderCarts(int m_no, int p_no);
	
	public List<Integer> orderAll(int m_no);

	public int orderIdxUpdate();
	public int orderIdxDecrease();

	public List<String> orderStatus(int m_no);

}
