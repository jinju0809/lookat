package com.FGroup.ShoppingMall.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.FGroup.ShoppingMall.command.admin.AdminMemberDSCommand;
import com.FGroup.ShoppingMall.command.admin.AdminMemberDeliveryCommand;
import com.FGroup.ShoppingMall.command.admin.AdminMemberMGCommand;
import com.FGroup.ShoppingMall.command.admin.AdminMemberMGDeleteCommand;
import com.FGroup.ShoppingMall.command.admin.AdminMemberMGProfileCommand;
import com.FGroup.ShoppingMall.command.admin.AdminMemberMGSendPasswordCommand;
import com.FGroup.ShoppingMall.command.admin.AdminMemberMGUpdateCommand;
import com.FGroup.ShoppingMall.command.admin.AdminMemberODCommand;
import com.FGroup.ShoppingMall.command.order.OrderListCommand;
import com.FGroup.ShoppingMall.dto.AdminDto;
import com.FGroup.ShoppingMall.dto.MemberDto;

@Controller
public class AdminController {

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private JavaMailSender mailSender;

	private AdminMemberMGCommand adminMemberMGCommand;
	private AdminMemberMGDeleteCommand adminMemberMGDeleteCommand;
	private AdminMemberMGProfileCommand adminMemberMGProfileCommand;
	private AdminMemberMGUpdateCommand adminMemberMGUpdateCommand;
	private AdminMemberMGSendPasswordCommand adminMemberMGSendPasswordCommand;
	private AdminMemberDeliveryCommand adminMemberDCommand;
	private AdminMemberDSCommand adminMemberDSCommand;
	private AdminMemberODCommand adminMemberODCommand;
	private OrderListCommand orderListCommand;

	@Autowired
	private void setCommand(AdminMemberMGCommand adminMemberMGCommand,
							AdminMemberMGDeleteCommand adminMemberMGDeleteCommand,
							AdminMemberMGProfileCommand adminMemberMGProfileCommand,
							AdminMemberMGUpdateCommand adminMemberMGUpdateCommand,
							AdminMemberMGSendPasswordCommand adminMemberMGSendPasswordCommand,
							AdminMemberDeliveryCommand adminMemberDCommand,
							AdminMemberDSCommand adminMemberDSCommand,
							AdminMemberODCommand adminMemberODCommand,
							OrderListCommand orderListCommand) {
		this.adminMemberMGCommand = adminMemberMGCommand;
		this.adminMemberMGProfileCommand = adminMemberMGProfileCommand;
		this.adminMemberMGDeleteCommand = adminMemberMGDeleteCommand;
		this.adminMemberMGUpdateCommand = adminMemberMGUpdateCommand;
		this.adminMemberMGSendPasswordCommand = adminMemberMGSendPasswordCommand;
		this.adminMemberDCommand = adminMemberDCommand;
		this.adminMemberDSCommand = adminMemberDSCommand;
		this.adminMemberODCommand = adminMemberODCommand;
		this.orderListCommand = orderListCommand;
	}

	@RequestMapping(value = "memberMG.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberMG(@RequestBody AdminDto adminDto, Model model) {
		if (adminDto != null) {
			model.addAttribute("adminDto", adminDto);
		}
		return adminMemberMGCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "member/{m_no}", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberMGView(@PathVariable("m_no") int m_no, Model model) {
		model.addAttribute("m_no", m_no);
		return adminMemberMGProfileCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "memberMG/{m_no}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberMGDelete(@PathVariable("m_no") int m_no, Model model) {
		model.addAttribute("m_no", m_no);
		return adminMemberMGDeleteCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "memberMGUpdate.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberMGUpdate(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		return adminMemberMGUpdateCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "sendByPw.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberMGSendPassword(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		model.addAttribute("mailSender", mailSender);
		return adminMemberMGSendPasswordCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "deliveryChange.do", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String memberDeliveryStatus(@RequestParam String o_idx, @RequestParam String o_delivery, Model model) {
		model.addAttribute("o_idx", o_idx);
		model.addAttribute("o_delivery", o_delivery);
		return adminMemberDSCommand.excutee(sqlSession, model);
	}

	@RequestMapping(value = "memberDeliveryPage.do", method = RequestMethod.GET)
	public String memberDelivery(HttpServletRequest request, Model model) {
		adminMemberDCommand.execute(sqlSession, model);
		return "admin/adminDeliveryListPage";
	}

	@RequestMapping(value = "adminMemberODPage.do", method = RequestMethod.GET)
	public String adminMemberPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		orderListCommand.execute(sqlSession, model);
		return "admin/adminOrderListPage";
	}

}
