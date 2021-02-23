package com.FGroup.ShoppingMall.command.cart;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;

public class CartUpdateCommand implements CartCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
	}

	public String executee(SqlSession sqlSession, Model model) {
		CartDao cartDao = sqlSession.getMapper(CartDao.class);
		Map<String, Object> map = model.asMap();
		String stp_No = (String) map.get("p_No");
		String stcrt_amount = (String) map.get("crt_amount");
		String stm_no = (String) map.get("m_no");
		System.out.println(stp_No + '-' + stcrt_amount + '-' + stm_no);
		int m_no = 0;
		int p_No = 0;
		int crt_amount = 0;
		if (stm_no != null && !stm_no.isEmpty()) {
			m_no = Integer.parseInt(stm_no);
			p_No = Integer.parseInt(stp_No);
			crt_amount = Integer.parseInt(stcrt_amount);
		}
		String updateResult = "0";
		if (m_no != 0) {
			updateResult = Integer.toString(cartDao.cartUpdate(m_no, p_No, crt_amount));
		}

		return updateResult;

	}

}