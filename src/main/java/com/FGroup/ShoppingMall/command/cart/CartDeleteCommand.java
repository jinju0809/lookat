package com.FGroup.ShoppingMall.command.cart;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;

public class CartDeleteCommand implements CartCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String stm_no = request.getParameter("m_no");
		int m_no = Integer.parseInt(stm_no);
		String page = request.getParameter("page");
		String target = request.getParameter("target");
		String[] p_NoList = target.split(",");

		CartDao cartDao = sqlSession.getMapper(CartDao.class);

		int cartDelResult = 0;
		for (int i = 0; i < p_NoList.length; i++) {
			int p_no = Integer.parseInt(p_NoList[i]);
			cartDelResult = cartDao.cartDelete(p_no, m_no);
		}
		model.addAttribute("cartDelResult", cartDelResult);
		model.addAttribute("page", page);
		model.addAttribute("m_no", m_no);

	}

}