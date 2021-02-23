package com.FGroup.ShoppingMall.command.order;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;
import com.FGroup.ShoppingMall.dao.OrderDao;
import com.FGroup.ShoppingMall.dto.OrderDto;

public class OrderDeleteCommand implements OrderCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		String m_no = request.getParameter("m_no");
		String o_idx = request.getParameter("o_idx");

		CartDao cartDao = sqlSession.getMapper(CartDao.class);
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);

		List<OrderDto> list = orderDao.OrderView2(Integer.parseInt(o_idx));
		String point = null;
		for (OrderDto orderDto2 : list) {
			orderDao.OrderProductStockAdd(orderDto2.getO_p_no(), Integer.parseInt(orderDto2.getO_amount()));
			orderDao.OrderDelete2(Integer.parseInt(o_idx));
			point = orderDto2.getO_point();
		}
		orderDao.orderIdxDecrease();
		orderDao.OrderPointIncrease(Integer.parseInt(m_no), Integer.parseInt(point));
		// 재고늘림
		model.addAttribute("m_no", m_no);
		session.setAttribute("loginDto", orderDao.OrderMember(Integer.parseInt(m_no)));
		session.setAttribute("crt_count", cartDao.cartCount(Integer.parseInt(m_no)));

	}

}
