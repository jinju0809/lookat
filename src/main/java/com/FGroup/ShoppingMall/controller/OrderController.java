package com.FGroup.ShoppingMall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.FGroup.ShoppingMall.command.order.OrderCheckCommand;
import com.FGroup.ShoppingMall.command.order.OrderDeleteCommand;
import com.FGroup.ShoppingMall.command.order.OrderDoCommand;
import com.FGroup.ShoppingMall.command.order.OrderInsertCommand;
import com.FGroup.ShoppingMall.command.order.OrderListCommand;
import com.FGroup.ShoppingMall.command.order.OrderViewCommand;

@Controller
public class OrderController {

	@Autowired
	private SqlSession sqlSession;

	private OrderDoCommand orderDoCommand;
	private OrderInsertCommand orderInsertCommand;
	private OrderListCommand orderListCommand;
	private OrderViewCommand orderViewCommand;
	private OrderDeleteCommand orderDeleteCommand;
	private OrderCheckCommand orderCheckCommand;

	@Autowired
	public void setCommand(OrderDoCommand orderDoCommand,
							OrderInsertCommand orderInsertCommand,
							OrderListCommand orderListCommand,
							OrderViewCommand orderViewCommand,
							OrderDeleteCommand orderDeleteCommand,
							OrderCheckCommand orderCheckCommand) {
		this.orderDoCommand = orderDoCommand;
		this.orderInsertCommand = orderInsertCommand;
		this.orderListCommand = orderListCommand;
		this.orderViewCommand = orderViewCommand;
		this.orderDeleteCommand = orderDeleteCommand;
		this.orderCheckCommand = orderCheckCommand;
	}

	@RequestMapping(value = "order.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		orderDoCommand.execute(sqlSession, model);
		return "order/orderPage";
	}

	@RequestMapping(value = "orderInsert.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		orderInsertCommand.execute(sqlSession, model);
		return "redirect:orderListPage.do";
	}

	@RequestMapping(value = "orderListPage.do", method = RequestMethod.GET)
	public String orderListpage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		orderListCommand.execute(sqlSession, model);
		return "order/orderListPage";
	}

	@RequestMapping(value = "orderView.do", method = RequestMethod.GET)
	public String orderViewpage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		orderViewCommand.execute(sqlSession, model);
		return "order/orderViewPage";
	}

	@RequestMapping(value = "orderCancel.do", method = RequestMethod.GET)
	public String orderCancel(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		orderDeleteCommand.execute(sqlSession, model);
		return "redirect:orderListPage.do";
	}

	@RequestMapping(value = "myPage.do", method = RequestMethod.GET)
	public String myPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		orderCheckCommand.execute(sqlSession, model);
		return "myPage/myPage";
	}

	@RequestMapping(value = "orderCheckPage.do", method = RequestMethod.GET)
	public String orderCheckPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		model.addAttribute("od", request.getParameter("od"));
		orderListCommand.execute(sqlSession, model);
		return "myPage/orderCheckPage";
	}
}
