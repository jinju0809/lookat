package com.FGroup.ShoppingMall.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDto {

	private int crt_no;
	private int crt_m_no;
	private int crt_p_no;
	private int crt_amount;

}
