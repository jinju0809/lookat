package com.FGroup.ShoppingMall.command.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.ProductDao;

public class ProductListCommand implements ProductCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		ProductDao productDao = sqlSession.getMapper(ProductDao.class);
		model.addAttribute("list", productDao.productList());

		Map<String, Object> map = model.asMap();
		String p_Category = "category";
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		if (request != null) {
			p_Category = request.getParameter("p_Category");
		}

		model.addAttribute("p_Category", p_Category);

	}

}
