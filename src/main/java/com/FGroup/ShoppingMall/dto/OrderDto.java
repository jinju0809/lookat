package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDto {

	private int o_no;
	private int o_m_no;
	private int o_p_no;
	private String o_amount;
	private Date o_regDate;
	private String o_name;
	private String o_addr1;
	private String o_addr2;
	private String o_addr3;
	private String o_cellphone;
	private String o_payment;
	private String o_note;
	private String o_price;
	
	private String o_point;
	private int o_idx;
	private String o_delivery;
}
