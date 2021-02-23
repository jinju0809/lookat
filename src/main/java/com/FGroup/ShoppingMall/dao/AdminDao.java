package com.FGroup.ShoppingMall.dao;

import java.util.List;

import com.FGroup.ShoppingMall.dto.MemberDto;
import com.FGroup.ShoppingMall.dto.OrderDto;

public interface AdminDao {

	public List<MemberDto> memberList(String member_type, String search_member);
	public int memberMGUpdate(int m_no, String m_name, String m_addr1, String m_addr2, String m_addr3, String m_phone, String m_email, String m_grade);

	public List<OrderDto> memberOrderList();
	public List<OrderDto> memberOrderPage(String m_no);

	public int memberDeliveryStatus(String o_delivery, int o_idx);

}
