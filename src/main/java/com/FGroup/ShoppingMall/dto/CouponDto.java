package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CouponDto {

	private int c_no;
	private String c_name;
	private int c_discount;
	private int c_price;
	private Date c_regDate;
	private Date c_startDate;
	private Date c_endDate;
	private String c_m_id;
	private int c_p_no;

}
