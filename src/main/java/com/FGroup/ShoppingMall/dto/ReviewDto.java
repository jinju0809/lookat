package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReviewDto {

	private int rv_no;
	private String rv_title;
	private int rv_m_no;
	private String rv_content;
	private Date rv_regDate;
	private int rv_hit;
	private String rv_filename;
	private String m_name;
	private int rv_p_no;
	private String p_Image;
	private String p_Name;
	private double p_Price;
	private String p_Color;

}
