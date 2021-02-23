package com.FGroup.ShoppingMall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.FGroup.ShoppingMall.command.reviewReply.R_ReplyDeleteCommand;
import com.FGroup.ShoppingMall.command.reviewReply.R_ReplyInsertCommand;
import com.FGroup.ShoppingMall.command.reviewReply.R_ReplyUpdateCommand;
import com.FGroup.ShoppingMall.command.reviewReply.R_RereplyInsertCommand;

@Controller
public class R_ReplyController {

	@Autowired
	private SqlSession sqlSession;

	private R_ReplyInsertCommand r_replyInsertCommand;
	private R_ReplyDeleteCommand r_replyDeleteCommand;
	private R_ReplyUpdateCommand r_replyUpdateCommand;
	private R_RereplyInsertCommand r_rereplyInsertCommand;

	@Autowired
	public void setReplyCommand(R_ReplyInsertCommand r_replyInsertCommand,
								R_ReplyDeleteCommand r_replyDeleteCommand,
								R_ReplyUpdateCommand r_replyUpdateCommand,
								R_RereplyInsertCommand r_rereplyInsertCommand) {
		this.r_replyInsertCommand = r_replyInsertCommand;
		this.r_replyDeleteCommand = r_replyDeleteCommand;
		this.r_replyUpdateCommand = r_replyUpdateCommand;
		this.r_rereplyInsertCommand = r_rereplyInsertCommand;
	}

	@RequestMapping(value = "r_replyInsert.do", method = RequestMethod.POST)
	public String r_replyInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		r_replyInsertCommand.execute(sqlSession, model);
		return "redirect:reviewViewPage.do?rv_no=" + request.getParameter("r_rv_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "r_replyDelete.do", method = RequestMethod.POST)
	public String r_replyDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		r_replyDeleteCommand.execute(sqlSession, model);
		return "redirect:reviewViewPage.do?rv_no=" + request.getParameter("r_rv_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "r_replyUpdate.do", method = RequestMethod.POST)
	public String r_replyUpdate(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		r_replyUpdateCommand.execute(sqlSession, model);
		return "redirect:reviewViewPage.do?rv_no=" + request.getParameter("r_rv_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "r_rereplyInsert.do", method = RequestMethod.POST)
	public String r_rereplyInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		r_rereplyInsertCommand.execute(sqlSession, model);
		return "redirect:reviewViewPage.do?rv_no=" + request.getParameter("r_rv_no") + "&page=" + request.getParameter("page");
	}
}
