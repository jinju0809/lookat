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

import com.FGroup.ShoppingMall.command.notice.NoticeDeleteCommand;
import com.FGroup.ShoppingMall.command.notice.NoticeInsertCommand;
import com.FGroup.ShoppingMall.command.notice.NoticeListCommand;
import com.FGroup.ShoppingMall.command.notice.NoticeQueryListCommand;
import com.FGroup.ShoppingMall.command.notice.NoticeUpdateCommand;
import com.FGroup.ShoppingMall.command.notice.NoticeViewCommand;
import com.FGroup.ShoppingMall.dto.NoticeDto;

@Controller
public class NoticeController {

	@Autowired
	private SqlSession sqlSession;

	private NoticeListCommand noticeListCommand;
	private NoticeViewCommand noticeViewCommand;
	private NoticeInsertCommand noticeInsertCommand;
	private NoticeDeleteCommand noticeDeleteCommand;
	private NoticeUpdateCommand noticeUpdateCommand;
	private NoticeQueryListCommand noticeQueryListCommand;

	@Autowired
	public void setNoticeCommand(NoticeListCommand noticeListCommand,
									NoticeViewCommand noticeViewCommand,
									NoticeInsertCommand noticeInsertCommand,
									NoticeDeleteCommand noticeDeleteCommand,
									NoticeUpdateCommand noticeUpdateCommand,
									NoticeQueryListCommand noticeQueryListCommand) {
		this.noticeListCommand = noticeListCommand;
		this.noticeViewCommand = noticeViewCommand;
		this.noticeInsertCommand = noticeInsertCommand;
		this.noticeDeleteCommand = noticeDeleteCommand;
		this.noticeUpdateCommand = noticeUpdateCommand;
		this.noticeQueryListCommand = noticeQueryListCommand;
	}

	@RequestMapping(value = "noticeInsertPage.do", method = RequestMethod.GET)
	public String noticeInsertPage() {
		return "notice/noticeInsertPage";
	}

	@RequestMapping(value = "noticeUpdatePage.do", method = RequestMethod.POST)
	public String noticeUpdatePage(@ModelAttribute("noticeDto") NoticeDto noticeDto) {
		System.out.println("[" + noticeDto.getN_content() + "]");
		return "notice/noticeUpdatePage";
	}

	@RequestMapping(value = "noticeListPage.do", method = RequestMethod.GET)
	public String noticeListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		noticeListCommand.execute(sqlSession, model);
		return "notice/noticeListPage";
	}

	@RequestMapping(value = "noticeViewPage.do", method = RequestMethod.GET)
	public String noticeViewPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		noticeViewCommand.execute(sqlSession, model);
		return "notice/noticeViewPage";
	}

	@RequestMapping(value = "noticeInsert.do", method = RequestMethod.POST)
	public String noticeInsert(MultipartHttpServletRequest multipartRequest, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		noticeInsertCommand.execute(sqlSession, model);
		return "redirect:noticeListPage.do";
	}

	@RequestMapping(value = "noticeDelete.do", method = RequestMethod.POST)
	public String noticeDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		noticeDeleteCommand.execute(sqlSession, model);

		return "redirect:noticeListPage.do";
	}

	@RequestMapping(value = "noticeUpdate.do", method = RequestMethod.POST)
	public String noticeUpdate(MultipartHttpServletRequest multipartRequest, RedirectAttributes rttr, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		model.addAttribute("rttr", rttr);
		noticeUpdateCommand.execute(sqlSession, model);
		return "redirect:noticeViewPage.do?n_no=" + multipartRequest.getParameter("n_no") + "&page=" + multipartRequest.getParameter("page");
	}

	@RequestMapping(value = "queryNoticeListPage.do", method = RequestMethod.GET)
	public String queryNoticeListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		noticeQueryListCommand.execute(sqlSession, model);
		return "notice/noticeListPage";
	}

}
