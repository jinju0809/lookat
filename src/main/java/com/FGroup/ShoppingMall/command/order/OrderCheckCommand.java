package com.FGroup.ShoppingMall.command.order;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.OrderDao;

public class OrderCheckCommand implements OrderCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);
		List<String> orderStatus = orderDao.orderStatus(m_no);
		int a = 0, b = 0, c = 0, d = 0;
		if (orderStatus != null) { //
			for (String status : orderStatus) {
				if (status.equals("배송준비중")) {
					b = b + 1;
				} else if (status.equals("배송중")) {
					c = c + 1;
				} else if (status.equals("배송완료")) {
					d = d + 1;
				} else {
					a = a + 1;
				}
			}
			model.addAttribute("a", a);
			model.addAttribute("b", b);
			model.addAttribute("c", c);
			model.addAttribute("d", d);
		}

	}

}
