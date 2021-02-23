package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class QnaDto {

	private int q_no;
	private String q_title;
	private int q_m_no;
	private String q_content;
	private Date q_date;
	private int q_hit;
	private String q_filename;
	private String m_name;
	private int q_p_no;
	private String q_secret;
	private String q_pw;
	private String p_Image;
	private String p_Name;
	private double p_Price;
	private String p_Color;

}
