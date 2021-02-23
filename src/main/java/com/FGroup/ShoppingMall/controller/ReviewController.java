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

import com.FGroup.ShoppingMall.command.review.ReviewDeleteCommand;
import com.FGroup.ShoppingMall.command.review.ReviewInsertCommand;
import com.FGroup.ShoppingMall.command.review.ReviewInsertPageCommand;
import com.FGroup.ShoppingMall.command.review.ReviewListCommand;
import com.FGroup.ShoppingMall.command.review.ReviewQueryListCommand;
import com.FGroup.ShoppingMall.command.review.ReviewUpdateCommand;
import com.FGroup.ShoppingMall.command.review.ReviewViewCommand;
import com.FGroup.ShoppingMall.dto.ReviewDto;

@Controller
public class ReviewController {

	@Autowired
	private SqlSession sqlSession;

	private ReviewListCommand reviewListCommand;
	private ReviewViewCommand reviewViewCommand;
	private ReviewInsertCommand reviewInsertCommand;
	private ReviewDeleteCommand reviewDeleteCommand;
	private ReviewUpdateCommand reviewUpdateCommand;
	private ReviewQueryListCommand reviewQueryListCommand;
	private ReviewInsertPageCommand reviewInsertPageCommand;

	@Autowired
	public void setReviewCommand(ReviewListCommand reviewListCommand,
									ReviewViewCommand reviewViewCommand,
									ReviewInsertCommand reviewInsertCommand,
									ReviewDeleteCommand reviewDeleteCommand,
									ReviewUpdateCommand reviewUpdateCommand,
									ReviewQueryListCommand reviewQueryListCommand,
									ReviewInsertPageCommand reviewInsertPageCommand) {
		this.reviewListCommand = reviewListCommand;
		this.reviewViewCommand = reviewViewCommand;
		this.reviewInsertCommand = reviewInsertCommand;
		this.reviewDeleteCommand = reviewDeleteCommand;
		this.reviewUpdateCommand = reviewUpdateCommand;
		this.reviewQueryListCommand = reviewQueryListCommand;
		this.reviewInsertPageCommand = reviewInsertPageCommand;
	}

	@RequestMapping(value = "reviewInsertPage.do", method = RequestMethod.GET)
	public String reviewInsertPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		reviewInsertPageCommand.execute(sqlSession, model);
		return "review/reviewInsertPage";
	}

	@RequestMapping(value = "reviewUpdatePage.do", method = RequestMethod.POST)
	public String reviewUpdatePage(@ModelAttribute("reviewDto") ReviewDto reviewDto) {
		return "review/reviewUpdatePage";
	}

	@RequestMapping(value = "reviewListPage.do", method = RequestMethod.GET)
	public String reviewListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		reviewListCommand.execute(sqlSession, model);
		return "review/reviewListPage";
	}

	@RequestMapping(value = "reviewViewPage.do", method = RequestMethod.GET)
	public String reviewViewPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		reviewViewCommand.execute(sqlSession, model);
		return "review/reviewViewPage";
	}

	@RequestMapping(value = "reviewInsert.do", method = RequestMethod.POST)
	public String reviewInsert(MultipartHttpServletRequest multipartRequest, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		reviewInsertCommand.execute(sqlSession, model);
		return "redirect:reviewListPage.do";
	}

	@RequestMapping(value = "reviewDelete.do", method = RequestMethod.POST)
	public String reviewDelete(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		reviewDeleteCommand.execute(sqlSession, model);
		return "redirect:reviewListPage.do";
	}

	@RequestMapping(value = "reviewUpdate.do", method = RequestMethod.POST)
	public String reviewUpdate(MultipartHttpServletRequest multipartRequest, RedirectAttributes rttr, Model model) {
		model.addAttribute("multipartRequest", multipartRequest);
		model.addAttribute("rttr", rttr);
		reviewUpdateCommand.execute(sqlSession, model);
		return "redirect:reviewViewPage.do?rv_no=" + multipartRequest.getParameter("rv_no") + "&page=" + multipartRequest.getParameter("page");
	}

	@RequestMapping(value = "queryReviewListPage.do", method = RequestMethod.GET)
	public String queryReviewListPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		reviewQueryListCommand.execute(sqlSession, model);
		return "review/reviewListPage";
	}

}
