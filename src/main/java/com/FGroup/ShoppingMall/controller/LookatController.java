package com.FGroup.ShoppingMall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LookatController {

	@RequestMapping(value = { "/", "index" }, method = RequestMethod.GET)
	public String index() {
		return "index";
	}

	// member
	@RequestMapping(value = "signUpPage.do", method = RequestMethod.GET)
	public String signUpPage() {
		return "member/signUpPage";
	}

	@RequestMapping(value = "findIdPage.do", method = RequestMethod.GET)
	public String findIdPage() {
		return "member/findIdPage";
	}

	@RequestMapping(value = "findPasswordPage.do", method = RequestMethod.GET)
	public String findPasswordPage() {
		return "member/findPasswordPage";
	}

	@RequestMapping(value = "emailAuthPage.do", method = RequestMethod.GET)
	public String emailAuthPage() {
		return "member/emailAuthPage";
	}

	@RequestMapping(value = "profilePage.do", method = RequestMethod.GET)
	public String profilePage() {
		return "member/profilePage";
	}

	@RequestMapping(value = "modifyPage.do", method = RequestMethod.GET)
	public String modifyPage() {
		return "member/modifyPage";
	}

	@RequestMapping(value = "changePasswordPage.do", method = RequestMethod.GET)
	public String changePasswordPage() {
		return "member/changePasswordPage";
	}

	// admin
	@RequestMapping(value = "adminPage.do", method = RequestMethod.GET)
	public String adminPage() {
		return "admin/adminPage";
	}

	@RequestMapping(value = "memberMGPage.do", method = RequestMethod.GET)
	public String memberMGPage() {
		return "admin/memberMGPage";
	}

	@RequestMapping(value = "memberMGModifyPage.do", method = RequestMethod.GET)
	public String memberMGModifyPage() {
		return "admin/memberMGModifyPage";
	}

}