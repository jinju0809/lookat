package com.FGroup.ShoppingMall.command.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;
import com.FGroup.ShoppingMall.dao.OrderDao;
import com.FGroup.ShoppingMall.dto.CartDto;
import com.FGroup.ShoppingMall.dto.ProductDto;

public class OrderDoCommand implements OrderCommand {
	// 제품 상세보기에서 주문을 누르면 나타나는 페이지
	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);
		List<ProductDto> prodList = new ArrayList<ProductDto>();
		CartDao cartDao = sqlSession.getMapper(CartDao.class);
		List<CartDto> cartList = new ArrayList<CartDto>();
		String stp_No = request.getParameter("p_No");
		String sto_amount = request.getParameter("o_amount");
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		// view에서 바로 구매할 때
		int p_No = 0;
		int o_amount = 0;
		if (stp_No != null && sto_amount != null) {
			p_No = Integer.parseInt(stp_No);
			o_amount = Integer.parseInt(sto_amount);
			// 카트에 넣음..넣기전에 검사^^
			List<Integer> pnolist = cartDao.memberCart(m_no);
			if (pnolist.contains(p_No)) {
			} else {
				orderDao.OrderCart(m_no, p_No, o_amount);
			}

			model.addAttribute("o_amount", o_amount);
			model.addAttribute("productDto", orderDao.OrderProduct(p_No));
			session.setAttribute("crt_count", cartDao.cartCount(m_no));
		}
		// 카트에서 주문할 경우
		String target = request.getParameter("target");
		String[] p_NoList = null;
		if (target != null && target.equals("all")) {
			List<Integer> p_NoLists = orderDao.orderAll(m_no);
			System.out.println(p_NoLists);
			target = "";
			for (int i : p_NoLists) {
				target = target + i + ",";
			}
			p_NoList = target.split(",");
		} else if (target != null && !target.equals("all")) {
			p_NoList = target.split(",");
		}

		if (p_NoList != null && !target.equals("all")) {
			for (String p : p_NoList) {
				if (p != null && !p.equals("")) {
					cartList.add(orderDao.OrderCarts(m_no, Integer.parseInt(p)));
					prodList.add(orderDao.OrderProduct(Integer.parseInt(p)));
				}
				model.addAttribute("cartList", cartList);
				model.addAttribute("prodList", prodList);
			}
		}
		// 구매자 정보 넘겨주기
		model.addAttribute("memberDto", orderDao.OrderMember(m_no));

	}

}