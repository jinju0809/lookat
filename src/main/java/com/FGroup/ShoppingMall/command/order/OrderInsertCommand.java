package com.FGroup.ShoppingMall.command.order;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;
import com.FGroup.ShoppingMall.dao.OrderDao;
import com.FGroup.ShoppingMall.dto.CartDto;
import com.FGroup.ShoppingMall.dto.OrderDto;

public class OrderInsertCommand implements OrderCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		String stp_No = request.getParameter("p_No");
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);
		CartDao cartDao = sqlSession.getMapper(CartDao.class);

		int o_p_no = 0;
		if (!stp_No.isEmpty() && !stp_No.equals(null)) {
			o_p_no = Integer.parseInt(stp_No);
		}
		String m_no = request.getParameter("m_no");
		int o_m_no = Integer.parseInt(m_no);
		String o_name = request.getParameter("rname");
		String o_addr1 = request.getParameter("raddr1");
		String o_addr2 = request.getParameter("raddr2");
		String o_addr3 = request.getParameter("raddr3");
		String rphone1_1 = request.getParameter("rphone1_1");
		String rphone1_2 = request.getParameter("rphone1_2");
		String rphone1_3 = request.getParameter("rphone1_3");
		String o_note = request.getParameter("rnote");
		String inputPoint = request.getParameter("inputPoint");
		String o_payment = request.getParameter("payment");
		System.out.println(o_payment + "sdff");
		String deposit_name = request.getParameter("deposit_name");
		String o_price = request.getParameter("o_price");
		String o_amount = request.getParameter("o_amount");
		o_note = o_note + "^입금자명: " + deposit_name;
		String o_cellphone = rphone1_1 + "-" + rphone1_2 + "-" + rphone1_3;

		if (inputPoint.isEmpty() || inputPoint.equals(null)) {
			inputPoint = "0";
		}
		if (o_addr3.isEmpty() || o_addr3.equals(null)) {
			o_addr3 = "없음";
		}
		String target = request.getParameter("target");
		String[] p_NoList = null;
		if (target != null) {
			p_NoList = target.split(",");
		}
		if (p_NoList != null) {
			for (String p : p_NoList) {
				if (p != null) {
					CartDto cartDto = orderDao.OrderCarts(o_m_no, Integer.parseInt(p));
					OrderDto orderDto = new OrderDto();
					orderDto.setO_m_no(o_m_no);
					o_p_no = Integer.parseInt(p);
					orderDto.setO_p_no(o_p_no);
					System.out.println(cartDto.getCrt_amount());
					o_amount = Integer.toString(cartDto.getCrt_amount());
					orderDto.setO_amount(o_amount);
					orderDto.setO_name(o_name);
					orderDto.setO_addr1(o_addr1);
					orderDto.setO_addr2(o_addr2);
					orderDto.setO_addr3(o_addr3);
					orderDto.setO_cellphone(o_cellphone);
					orderDto.setO_payment(o_payment);
					System.out.println(o_payment + "o_paymnet");
					orderDto.setO_note(o_note);
					orderDto.setO_price(o_price);
					orderDto.setO_point(inputPoint);
					orderDto.setO_idx(1);
					String x = "2";
					if (o_payment.equals(x)) {
						orderDto.setO_delivery("입금대기");
					} else {
						orderDto.setO_delivery("배송준비중");
					}
					model.addAttribute("orderResult", orderDao.OrderInsert(orderDto));
					orderDao.OrderProductStock(Integer.parseInt(p), Integer.parseInt(o_amount));
					orderDao.OrderCartDelete(o_m_no, Integer.parseInt(p));
				}
			}
		} else {
			OrderDto orderDto = new OrderDto();
			orderDto.setO_m_no(o_m_no);
			orderDto.setO_p_no(o_p_no);
			orderDto.setO_amount(o_amount);
			orderDto.setO_name(o_name);
			orderDto.setO_addr1(o_addr1);
			orderDto.setO_addr2(o_addr2);
			orderDto.setO_addr3(o_addr3);
			orderDto.setO_cellphone(o_cellphone);
			orderDto.setO_payment(o_payment);
			orderDto.setO_note(o_note);
			orderDto.setO_price(o_price);
			orderDto.setO_idx(1);
			String x = "2";
			if (o_payment.equals(x)) {
				orderDto.setO_delivery("입금대기");
			} else {
				orderDto.setO_delivery("배송준비중");
			}
			model.addAttribute("orderResult", orderDao.OrderInsert(orderDto));
			// 재고 수량 감소해야함
			orderDao.OrderProductStock(o_p_no, Integer.parseInt(o_amount));
			orderDao.OrderCartDelete(o_m_no, o_p_no);
		}
		orderDao.orderIdxUpdate();
		// 포인트차감
		orderDao.OrderPoint(o_m_no, Integer.parseInt(inputPoint));

		// 멤버정보 가져오기
		session.setAttribute("loginDto", orderDao.OrderMember(o_m_no));
		session.setAttribute("crt_count", cartDao.cartCount(Integer.parseInt(m_no)));
		model.addAttribute("m_no", m_no);

	}

}
