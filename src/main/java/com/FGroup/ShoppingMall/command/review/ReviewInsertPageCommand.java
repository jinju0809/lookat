package com.FGroup.ShoppingMall.command.review;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.OrderDao;
import com.FGroup.ShoppingMall.dto.OrderDto;
import com.FGroup.ShoppingMall.dto.ProductDto;

public class ReviewInsertPageCommand implements ReviewCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String stm_no = request.getParameter("rv_m_no");
		System.out.println(stm_no);
		int rv_m_no = 0;
		if (stm_no != null) {
			rv_m_no = Integer.parseInt(stm_no);
		}
		// 중복제거
		List<OrderDto> orderList = orderDao.OrderLists(rv_m_no, 1, 999);
		// 전체
		List<OrderDto> list = orderDao.OrderList(rv_m_no, 1, 999);

		model.addAttribute("list", list);
		model.addAttribute("orderList", orderList);
		List<ProductDto> prodList = new ArrayList<ProductDto>();
		for (OrderDto orderDto : list) {
			prodList.add(orderDao.OrderProduct(orderDto.getO_p_no()));
		}
		model.addAttribute("prodList", prodList);

	}

}
