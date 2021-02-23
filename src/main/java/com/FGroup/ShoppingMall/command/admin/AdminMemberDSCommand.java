package com.FGroup.ShoppingMall.command.admin;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.AdminDao;

public class AdminMemberDSCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		return null;
	}

	public String excutee(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		String sto_idx = (String) map.get("o_idx");
		String o_delivery = (String) map.get("o_delivery");
		System.out.println(sto_idx + o_delivery);

		int o_idx = Integer.parseInt(sto_idx);
		AdminDao adminDao = sqlSession.getMapper(AdminDao.class);
		int statusResult = adminDao.memberDeliveryStatus(o_delivery, o_idx);
		System.out.println(statusResult);
		return Integer.toString(statusResult);
		
	}

}
