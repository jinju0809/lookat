package com.FGroup.ShoppingMall.command.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.OrderDao;
import com.FGroup.ShoppingMall.dto.OrderDto;
import com.FGroup.ShoppingMall.dto.ProductDto;

public class OrderViewCommand implements OrderCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int o_idx = Integer.parseInt(request.getParameter("o_idx"));

		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);
		// model.addAttribute("orderDto", orderDao.OrderView(o_no));
		List<OrderDto> orderViewList = new ArrayList<OrderDto>();
		orderViewList = orderDao.OrderView2(o_idx);
		List<ProductDto> prodList = new ArrayList<ProductDto>();
		// 제품정보 가져오기
		int p_No = 0;
		for (OrderDto orderDto : orderViewList) {
			int o_no = orderDto.getO_no();
			p_No = orderDao.OrderProductNo(o_no);
			prodList.add(orderDao.OrderProduct(p_No));
		}

		model.addAttribute("orderViewList", orderViewList);
		model.addAttribute("prodList", prodList);

	}

}
