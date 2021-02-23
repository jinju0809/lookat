package com.FGroup.ShoppingMall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.FGroup.ShoppingMall.command.qnaReply.Q_ReplyDeleteCommand;
import com.FGroup.ShoppingMall.command.qnaReply.Q_ReplyInsertCommand;
import com.FGroup.ShoppingMall.command.qnaReply.Q_ReplyUpdateCommand;
import com.FGroup.ShoppingMall.command.qnaReply.Q_RereplyInsertCommand;

@Controller
public class Q_ReplyController {

	@Autowired
	private SqlSession sqlSession;

	private Q_ReplyInsertCommand q_replyInsertCommand;
	private Q_ReplyDeleteCommand q_replyDeleteCommand;
	private Q_ReplyUpdateCommand q_replyUpdateCommand;
	private Q_RereplyInsertCommand q_rereplyInsertCommand;

	@Autowired
	public void setReplyCommand(Q_ReplyInsertCommand q_replyInsertCommand,
								Q_ReplyDeleteCommand q_replyDeleteCommand,
								Q_ReplyUpdateCommand q_replyUpdateCommand,
								Q_RereplyInsertCommand q_rereplyInsertCommand) {
		this.q_replyInsertCommand = q_replyInsertCommand;
		this.q_replyDeleteCommand = q_replyDeleteCommand;
		this.q_replyUpdateCommand = q_replyUpdateCommand;
		this.q_rereplyInsertCommand = q_rereplyInsertCommand;
	}

	@RequestMapping(value = "q_replyInsert.do", method = RequestMethod.POST)
	public String q_replyInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		q_replyInsertCommand.execute(sqlSession, model);
		return "redirect:qnaViewPage.do?q_no=" + request.getParameter("r_q_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "q_replyDelete.do", method = RequestMethod.POST)
	public String q_replyDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		q_replyDeleteCommand.execute(sqlSession, model);
		return "redirect:qnaViewPage.do?q_no=" + request.getParameter("r_q_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "q_replyUpdate.do", method = RequestMethod.POST)
	public String q_replyUpdate(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		q_replyUpdateCommand.execute(sqlSession, model);
		return "redirect:qnaViewPage.do?q_no=" + request.getParameter("r_q_no") + "&page=" + request.getParameter("page");
	}

	@RequestMapping(value = "q_rereplyInsert.do", method = RequestMethod.POST)
	public String q_rereplyInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		q_rereplyInsertCommand.execute(sqlSession, model);
		return "redirect:qnaViewPage.do?q_no=" + request.getParameter("r_q_no") + "&page=" + request.getParameter("page");
	}
}
