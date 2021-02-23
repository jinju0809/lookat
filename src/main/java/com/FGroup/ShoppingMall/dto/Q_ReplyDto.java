package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Q_ReplyDto {

	private int r_no;
	private String r_writer;
	private String r_content;
	private Date r_date;
	private int r_q_no;
	private Date r_editdate;
	private int r_m_no;
	private int r_delete;
	private int r_group;
	private int r_groupOrd;
	private int r_depth;

}
