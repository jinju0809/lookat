package com.FGroup.ShoppingMall.command.cart;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;

public class CartCheckCommand implements CartCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
	}

	public String executee(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		String p_No = (String) map.get("p_No");
		CartDao cartDao = sqlSession.getMapper(CartDao.class);
		String stm_no = (String) map.get("m_no");
		int m_no = 0;
		if (stm_no != null && !stm_no.isEmpty()) {
			m_no = Integer.parseInt(stm_no);
		}
		String checkResult = "0";
		if (m_no != 0) {
			List<Integer> pnolist = cartDao.memberCart(m_no);
			if (pnolist.contains(Integer.parseInt(p_No))) {
				checkResult = "1";
			} else {
				checkResult = "0";
			}
		}

		return checkResult;

	}

}