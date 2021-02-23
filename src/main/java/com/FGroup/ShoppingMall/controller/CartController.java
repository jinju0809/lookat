package com.FGroup.ShoppingMall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.FGroup.ShoppingMall.command.cart.CartCheckCommand;
import com.FGroup.ShoppingMall.command.cart.CartDeleteCommand;
import com.FGroup.ShoppingMall.command.cart.CartInsertCommand;
import com.FGroup.ShoppingMall.command.cart.CartListCommand;
import com.FGroup.ShoppingMall.command.cart.CartUpdateCommand;

@Controller
public class CartController {

	@Autowired
	private SqlSession sqlSession;

	private CartInsertCommand cartInsertCommand;
	private CartListCommand cartListCommand;
	private CartDeleteCommand cartDeleteCommand;
	private CartCheckCommand cartCheckCommand;
	private CartUpdateCommand cartUpdateCommand;

	@Autowired
	public void setCommand(CartInsertCommand cartInsertCommand,
							CartListCommand cartListCommand,
							CartDeleteCommand cartDeleteCommand,
							CartCheckCommand cartCheckCommand,
							CartUpdateCommand cartUpdateCommand) {
		this.cartInsertCommand = cartInsertCommand;
		this.cartListCommand = cartListCommand;
		this.cartDeleteCommand = cartDeleteCommand;
		this.cartCheckCommand = cartCheckCommand;
		this.cartUpdateCommand = cartUpdateCommand;
	}

	@RequestMapping(value = "getText", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	@ResponseBody // return하는 데이터가 response(응답)임(데이터를 반환함)을 뜻하는 애너테이션..
	public String getText(@RequestParam String p_No, @RequestParam String m_no, Model model) {
		model.addAttribute("p_No", p_No);
		model.addAttribute("m_no", m_no);
		return cartCheckCommand.executee(sqlSession, model);
	}

	@RequestMapping(value = "cartChange", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String cartChange(@RequestParam String p_No, @RequestParam String m_no, @RequestParam String crt_amount, Model model) {
		model.addAttribute("p_No", p_No);
		model.addAttribute("m_no", m_no);
		model.addAttribute("crt_amount", crt_amount);
		return cartUpdateCommand.executee(sqlSession, model);
	}

	@RequestMapping(value = "cart.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String cartInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		cartInsertCommand.execute(sqlSession, model);
		return "redirect:cartListPage.do";
	}

	@RequestMapping(value = "cartListPage.do", method = RequestMethod.GET)
	public String cartList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		cartListCommand.execute(sqlSession, model);
		return "cart/cartListPage";
	}

	@RequestMapping(value = "cartDelete.do", method = RequestMethod.POST)
	public String cartDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		cartDeleteCommand.execute(sqlSession, model);
		return "redirect:cartListPage.do";
	}

}
