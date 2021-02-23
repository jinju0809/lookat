package com.FGroup.ShoppingMall.dao;

import com.FGroup.ShoppingMall.dto.MemberDto;

public interface MemberDao {

	public MemberDto memberView(int no);
	public MemberDto login(String m_id, String m_pw);
	public MemberDto idCheck(String m_id);
	public MemberDto emailCheck(String m_id, String m_email);
	public MemberDto findId(String m_name, String m_email);
	public MemberDto findPassword(String m_id, String m_name, String m_email);
	public void register(String m_id, String m_pw, String m_name, String m_phone, String m_email);
	public int changePassword(String m_id, String m_pw);
	public int memberUpdate(int m_no, String m_name, String m_addr1, String m_addr2, String m_addr3, String m_phone, String m_email);
	public int memberDelete(int m_no);

}