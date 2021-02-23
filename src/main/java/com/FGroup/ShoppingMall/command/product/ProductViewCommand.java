package com.FGroup.ShoppingMall.command.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.ProductDao;
import com.FGroup.ShoppingMall.dto.ProductDto;

public class ProductViewCommand implements ProductCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int p_No = Integer.parseInt(request.getParameter("p_No"));
		String checkResult = request.getParameter("checkResult");

		ProductDao productDao = sqlSession.getMapper(ProductDao.class);
		ProductDto productDto = productDao.productInfo(p_No);
		String name = productDto.getP_Name();
		String color = productDto.getP_Color();
		// String size = productDto.getP_Size();

		List<ProductDto> list = new ArrayList<ProductDto>();

		list = productDao.productViews(name, color);

		model.addAttribute("prodViewlist", list);
		model.addAttribute("checkResult", checkResult);
	}

}
