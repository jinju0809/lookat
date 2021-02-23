package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductDto {

	private int idx;
	private int p_No;
	private String p_Name;
	private String p_Size;
	private int p_Price;
	private String p_Color;
	private int p_Amount;
	private Date p_Regdate;
	private String p_Category;
	private String p_Image;
	private String p_Fabric;
	private String p_Information;

}
