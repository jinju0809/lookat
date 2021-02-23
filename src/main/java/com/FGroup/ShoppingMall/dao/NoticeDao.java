package com.FGroup.ShoppingMall.dao;

import java.util.List;
import java.util.Map;

import com.FGroup.ShoppingMall.dto.NoticeDto;

public interface NoticeDao {

	public List<NoticeDto> noticeList(int beginRecord, int endRecord); // 메소드의 이름이 mapper의 쿼리문 id가 됩니다.

	public int noticeInsert(String n_title, int n_m_no, String n_content, String n_filename);
	// public List<ProductDto> productCategory(String p_Category);

	public NoticeDto noticeView(int n_no);

	public List<Integer> noticeNo(int n_no);

	public int noticeDelete(int n_no);

	public int noticeUpdate(String n_title, String n_content, int n_no, String n_filename);

	public int totalRecord();

	public int noticeHit(int n_no);

	public int getTotalQueryRecord(Map<String, String> map);

	public List<NoticeDto> queryNoticeList(Map<String, String> map);

}
