package com.FGroup.ShoppingMall.command.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.ProductDao;

public class ProductCategoryCommand implements ProductCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();

		HttpServletRequest request = (HttpServletRequest) map.get("request");

		ProductDao productsDao = sqlSession.getMapper(ProductDao.class);

		model.addAttribute("p_Category", request.getParameter("p_Category"));
		model.addAttribute("categoryList", productsDao.productCategory(request.getParameter("p_Category")));

	}

}