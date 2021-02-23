package com.FGroup.ShoppingMall.command.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.AdminDao;
import com.FGroup.ShoppingMall.dto.OrderDto;

public class AdminMemberDeliveryCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		AdminDao adminDao = sqlSession.getMapper(AdminDao.class);
		List<OrderDto> memberOrderList = new ArrayList<OrderDto>();
		memberOrderList = adminDao.memberOrderList();
		model.addAttribute("memberOrderList", memberOrderList);
		return null;

	}

}
