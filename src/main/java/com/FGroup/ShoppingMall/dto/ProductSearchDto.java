package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductSearchDto {

	private String p_Category;
	private String search;
	private String search_type;
	private int p_Price1;
	private int p_Price2;
	private String order_by;
	private int p_No;
	private String p_Name;
	private String p_Size;
	private double p_Price;
	private String p_Color;
	private int p_Amount;
	private Date p_Regdate;
	private String p_Image;

	private int page;
	private int beginRecord;
	private int endRecord;

}
