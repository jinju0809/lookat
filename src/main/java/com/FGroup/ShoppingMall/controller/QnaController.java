package com.FGroup.ShoppingMall.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.FGroup.ShoppingMall.command.qna.QnaDeleteCommand;
import com.FGroup.ShoppingMall.command.qna.QnaInsertCommand;
import com.FGroup.ShoppingMall.command.qna.QnaInsertPageCommand;
import com.FGroup.ShoppingMall.command.qna.QnaListCommand;
import com.FGroup.ShoppingMall.command.qna.QnaPasswordInsertCommand;
import com.FGroup.ShoppingMall.command.qna.QnaQueryListCommand;
import com.FGroup.ShoppingMall.command.qna.QnaUpdateCommand;
import com.FGroup.ShoppingMall.command.qna.QnaViewCommand;
import com.FGroup.ShoppingMall.dto.QnaDto;

@Controller
public class QnaController {

	@Autowired
	private SqlSession sqlSession;

	private QnaListCommand qnaListCommand;
	private QnaViewCommand qnaViewCommand;
	private QnaInsertCommand qnaInsertCommand;
	private QnaDeleteCommand qnaDeleteCommand;
	private QnaUpdateCommand qnaUpdateCommand;
	private QnaQueryListCommand qnaQueryListCommand;
	private QnaInsertPageCommand qnaInsertPageCommand;
	private QnaPasswordInsertCommand qnaPasswordInsertCommand;

	@Autowired
	public void setQnaCommand(QnaListCommand qnaListCommand,
								QnaViewCommand qnaViewCommand,
								QnaInsertCommand qnaInsertCommand,
								QnaDeleteCommand qnaDeleteCommand,
								QnaUpdateCommand qnaUpdateCommand,
								QnaQueryListCommand qnaQueryListCommand,
								QnaInsertPageCommand qnaInsertPageCommand,
								QnaPasswordInsertCommand qnaPasswordInsertCommand) {
		this.qnaListCommand = qnaListCommand;
		this.qnaViewCommand = qnaViewCommand;
		this.qnaInsertCommand = qnaInsertCommand;
		this.qnaDeleteCommand = qnaDeleteCommand;
		this.qnaUpdateCommand = qnaUpdateCommand;
		this.qnaQueryListCommand = qnaQueryListCommand;
		this.qnaInsertPageCommand = qnaInsertPageCommand;
		this.qnaPasswordInsertCommand = qnaPasswordInsertCommand;
	}

	@RequestMapping(value = "qnaInsertPage.do", method = RequestMethod.GET)
	public String qnaInsertPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		qnaInsertPageCommand.execute(sqlSession, model);
		return "qna/qnaInsertPage";
	}

	@RequestMapping(value = "qnaUpdatePage.do", method = RequestMethod.POST)
	public String qnaUpdatePage(@ModelAttribute("qnaDto") QnaDto qnaDto) {
		return "qna/qnaUpdatePage";
	}

	@RequestMapping(value = "qnaPasswordInsertPage.do", method = RequestMethod.GET)
	public String qnaPasswordInsertPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		qnaPasswordInsertCommand.execute(sqlSession, model);
		return "qna/qnaPasswordInsertPage";
	}

	@RequestMapping(value = "qnaListPage.do", method = RequestMethod.GET)
	public String qnaListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		qnaListCommand.execute(sqlSession, model);
		return "qna/qnaListPage";
	}

	@RequestMapping(value = "qnaViewPage.do", method = RequestMethod.GET)
	public String qnaViewPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		qnaViewCommand.execute(sqlSession, model);
		return "qna/qnaViewPage";
	}

	@RequestMapping(value = "qnaInsert.do", method = RequestMethod.POST)
	public String qnaInsert(MultipartHttpServletRequest multipartRequest, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		qnaInsertCommand.execute(sqlSession, model);
		return "redirect:qnaListPage.do";
	}

	@RequestMapping(value = "qnaDelete.do", method = RequestMethod.POST)
	public String qnaDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		qnaDeleteCommand.execute(sqlSession, model);
		return "redirect:qnaListPage.do";
	}

	@RequestMapping(value = "qnaUpdate.do", method = RequestMethod.POST)
	public String qnaUpdate(MultipartHttpServletRequest multipartRequest, RedirectAttributes rttr, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		model.addAttribute("rttr", rttr);
		qnaUpdateCommand.execute(sqlSession, model);
		return "redirect:qnaViewPage.do?q_no=" + multipartRequest.getParameter("q_no") + "&page=" + multipartRequest.getParameter("page");
	}

	@RequestMapping(value = "queryQnaListPage.do", method = RequestMethod.GET)
	public String queryQnaListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		qnaQueryListCommand.execute(sqlSession, model);
		return "qna/qnaListPage";
	}

}
