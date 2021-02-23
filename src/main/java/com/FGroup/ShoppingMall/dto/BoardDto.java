package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardDto {

	private int n_no;
	private int n_m_no;
	private String n_title;
	private String n_content;
	private int n_hit;
	private String n_filename;
	private Date n_date;
	
}
