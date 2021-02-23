package com.FGroup.ShoppingMall.dao;

import java.util.List;
import java.util.Map;

import com.FGroup.ShoppingMall.dto.QnaDto;

public interface QnaDao {

	public List<QnaDto> qnaList(int beginRecord, int endRecord); // 메소드의 이름이 mapper의 쿼리문 id가 됩니다.

	public int qnaInsert(int q_m_no, int q_p_no, String q_title, String q_content, String q_pw, String q_filename, String q_secret);
	// public List<ProductDto> productCategory(String p_Category);
	public QnaDto qnaView(int q_no);

	public List<Integer> qnaNo(int q_no);

	public int qnaDelete(int q_no);

	public int qnaUpdate(String q_title, String q_content, int q_no, String q_filename);

	public int totalRecord();

	public QnaDto qnaPassword(int q_no);

	public int qnaHit(int q_no);

	public int getTotalQueryRecord(Map<String, String> map);

	public List<QnaDto> queryQnaList(Map<String, String> map);

}
