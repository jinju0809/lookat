package com.FGroup.ShoppingMall.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MemberDto {

	private int m_no;
	private String m_id;
	private String m_pw;
	private String m_pw2;
	private String c_pw;
	private String c_pw2;
	private String m_name;
	private String m_addr1;
	private String m_addr2;
	private String m_addr3;
	private String m_phone;
	private String m_email;
	private int m_coupon;
	private int m_point;
	private String m_grade;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date m_regdate;

	private String authKey;
	private String userKey;
	private boolean check1;
	private boolean check2;

}
