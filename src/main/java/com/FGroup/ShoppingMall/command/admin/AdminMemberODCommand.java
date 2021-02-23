package com.FGroup.ShoppingMall.command.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.AdminDao;
import com.FGroup.ShoppingMall.dto.OrderDto;

public class AdminMemberODCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		AdminDao adminDao = sqlSession.getMapper(AdminDao.class);
		String m_no = request.getParameter("m_no");
		List<OrderDto> orderList = new ArrayList<OrderDto>();
		orderList = adminDao.memberOrderPage(m_no);
		for (OrderDto orderdto : orderList) {

		}
		model.addAttribute("orderList", orderList);

		return null;
	}

}
