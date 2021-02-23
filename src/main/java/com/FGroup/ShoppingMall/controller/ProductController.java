package com.FGroup.ShoppingMall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.FGroup.ShoppingMall.command.product.ProductCategoryCommand;
import com.FGroup.ShoppingMall.command.product.ProductListCommand;
import com.FGroup.ShoppingMall.command.product.ProductSearchCommand;
import com.FGroup.ShoppingMall.command.product.ProductViewCommand;
import com.FGroup.ShoppingMall.command.qna.QnaListCommand;
import com.FGroup.ShoppingMall.command.review.ReviewListCommand;
import com.FGroup.ShoppingMall.dto.ProductSearchDto;

@Controller
public class ProductController {

	@Autowired
	private SqlSession sqlSession;

	private ProductListCommand productListCommand;
	private ProductViewCommand productViewCommand;
	private ProductCategoryCommand productCategoryCommand;
	private ReviewListCommand reviewListCommand;
	private QnaListCommand qnaListCommand;

	@Autowired
	public void setCommand(ProductListCommand productListCommand,
							ProductCategoryCommand productCategoryCommand,
							ProductViewCommand productViewCommand,
							ReviewListCommand reviewListCommand,
							QnaListCommand qnaListCommand) {
		this.productListCommand = productListCommand;
		this.productViewCommand = productViewCommand;
		this.productCategoryCommand = productCategoryCommand;
		this.reviewListCommand = reviewListCommand;
		this.qnaListCommand = qnaListCommand;
	}

	@RequestMapping(value = "shopGuide.do", method = RequestMethod.GET)
	public String shopGuide() {
		return "template/shopGuide";
	}

	@RequestMapping(value = "productListPage.do", method = RequestMethod.GET)
	public String productListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		productListCommand.execute(sqlSession, model);
		return "products/productListPage";
	}

	@RequestMapping(value = "productCategoryPage.do", method = RequestMethod.GET)
	public String productCategoryPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		productCategoryCommand.execute(sqlSession, model);
		return "redirect:productListPage.do?p_Category=" + request.getParameter("p_Category");
	}

	@RequestMapping(value = "productViewPage.do", method = RequestMethod.GET)
	public String productViewPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		productViewCommand.execute(sqlSession, model);
		reviewListCommand.execute(sqlSession, model);
		qnaListCommand.execute(sqlSession, model);
		return "products/productViewPage";
	}

	@RequestMapping(value = "search.do", method = RequestMethod.GET)
	public String searchPage(@RequestParam("search") String search, Model model) {
		model.addAttribute("search", search);
		return "products/productSearch";
	}

	@RequestMapping(value = "productSearch.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> productSearch(@RequestBody ProductSearchDto productSearchDto, Model model) {
		model.addAttribute("productSearchDto", productSearchDto);
		ProductSearchCommand productSearchCommand = new ProductSearchCommand();
		return productSearchCommand.execute(sqlSession, model);
	}
}
