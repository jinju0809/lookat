package com.FGroup.ShoppingMall.command.cart;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;

public class CartInsertCommand implements CartCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int p_No = Integer.parseInt(request.getParameter("p_No"));
		int o_amount = Integer.parseInt(request.getParameter("o_amount"));
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		CartDao cartDao = sqlSession.getMapper(CartDao.class);
		int cartResult = 0;
		cartResult = cartDao.cartInsert(m_no, p_No, o_amount);
		model.addAttribute("cartResult", cartResult);
		model.addAttribute("m_no", m_no);

	}

}