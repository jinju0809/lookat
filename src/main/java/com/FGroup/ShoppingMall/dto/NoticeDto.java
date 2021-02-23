package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class NoticeDto {

	private int n_no;
	private String n_title;
	private int n_m_no;
	private String n_content;
	private Date n_date;
	private int n_hit;
	private String n_filename;
	private String m_name;

}
