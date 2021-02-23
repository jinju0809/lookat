package com.FGroup.ShoppingMall.dao;

import java.util.List;
import java.util.Map;

import com.FGroup.ShoppingMall.dto.ReviewDto;

public interface ReviewDao {

	public List<ReviewDto> reviewList(int beginRecord, int endRecord); // 메소드의 이름이 mapper의 쿼리문 id가 됩니다.

	public int reviewInsert(String rv_title, int rv_m_no, String rv_content, String rv_filename, int rv_p_no);
	// public List<ProductDto> productCategory(String p_Category);

	public ReviewDto reviewView(int rv_no);

	public List<Integer> reviewNo(int rv_no);

	public int reviewDelete(int rv_no);

	public int reviewUpdate(String rv_title, String rv_content, int rv_no, String rv_filename);

	public int totalRecord();

	public int reviewHit(int rv_no);

	public int getTotalQueryRecord(Map<String, String> map);

	public List<ReviewDto> queryReviewList(Map<String, String> map);

}
