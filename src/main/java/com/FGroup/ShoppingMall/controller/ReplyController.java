package com.FGroup.ShoppingMall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.FGroup.ShoppingMall.command.reply.ReplyDeleteCommand;
import com.FGroup.ShoppingMall.command.reply.ReplyInsertCommand;
import com.FGroup.ShoppingMall.command.reply.ReplyUpdateCommand;
import com.FGroup.ShoppingMall.command.reply.RereplyInsertCommand;

@Controller
public class ReplyController {

	@Autowired
	private SqlSession sqlSession;

	private ReplyInsertCommand replyInsertCommand;
	private ReplyDeleteCommand replyDeleteCommand;
	private ReplyUpdateCommand replyUpdateCommand;
	private RereplyInsertCommand rereplyInsertCommand;

	@Autowired
	public void setReplyCommand(ReplyInsertCommand replyInsertCommand,
								ReplyDeleteCommand replyDeleteCommand,
								ReplyUpdateCommand replyUpdateCommand,
								RereplyInsertCommand rereplyInsertCommand) {
		this.replyInsertCommand = replyInsertCommand;
		this.replyDeleteCommand = replyDeleteCommand;
		this.replyUpdateCommand = replyUpdateCommand;
		this.rereplyInsertCommand = rereplyInsertCommand;
	}

	@RequestMapping(value = "replyInsert.do", method = RequestMethod.POST)
	public String replyInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		replyInsertCommand.execute(sqlSession, model);
		return "redirect:noticeViewPage.do?n_no=" + request.getParameter("r_n_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "replyDelete.do", method = RequestMethod.POST)
	public String replyDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		replyDeleteCommand.execute(sqlSession, model);
		return "redirect:noticeViewPage.do?n_no=" + request.getParameter("r_n_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "replyUpdate.do", method = RequestMethod.POST)
	public String replyUpdate(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		replyUpdateCommand.execute(sqlSession, model);
		return "redirect:noticeViewPage.do?n_no=" + request.getParameter("r_n_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "rereplyInsert.do", method = RequestMethod.POST)
	public String rereplyInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		rereplyInsertCommand.execute(sqlSession, model);
		return "redirect:noticeViewPage.do?n_no=" + request.getParameter("r_n_no") + "&page=" + request.getParameter("page");
	}
}
