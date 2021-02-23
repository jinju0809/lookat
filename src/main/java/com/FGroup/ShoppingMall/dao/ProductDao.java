package com.FGroup.ShoppingMall.dao;

import java.util.List;

import com.FGroup.ShoppingMall.dto.ProductDto;
import com.FGroup.ShoppingMall.dto.ProductSearchDto;
import com.FGroup.ShoppingMall.dto.ReviewDto;

public interface ProductDao {

	public List<ProductDto> productList(); // 메소드의 이름이 mapper의 쿼리문 id가 됩니다.

	public List<ProductDto> productCategory(String p_Category);

	public List<ProductDto> productView(int no);

	// 상품보기 --임시
	public List<ProductDto> productViews(String p_Name, String p_Color);

	public ProductDto productInfo(int p_No);

	public List<ProductDto> searchPage(String search);

	public List<ProductSearchDto> productSearch(ProductSearchDto productSearchDto);

	public int searchCount(ProductSearchDto productSearchDto);

	public List<ReviewDto> productReview(int beginRecord, int endRecord);

}
