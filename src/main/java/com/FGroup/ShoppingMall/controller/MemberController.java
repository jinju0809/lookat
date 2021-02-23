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
import org.springframework.web.bind.annotation.ResponseBody;

import com.FGroup.ShoppingMall.command.member.MemberChangePasswordCommand;
import com.FGroup.ShoppingMall.command.member.MemberDeleteCommand;
import com.FGroup.ShoppingMall.command.member.MemberEmailAuthCommand;
import com.FGroup.ShoppingMall.command.member.MemberEmailAuthConfirmCommand;
import com.FGroup.ShoppingMall.command.member.MemberFindIdCommand;
import com.FGroup.ShoppingMall.command.member.MemberFindPasswordCommand;
import com.FGroup.ShoppingMall.command.member.MemberIdCheckCommand;
import com.FGroup.ShoppingMall.command.member.MemberLoginCommand;
import com.FGroup.ShoppingMall.command.member.MemberLoginURLCommand;
import com.FGroup.ShoppingMall.command.member.MemberLogoutCommand;
import com.FGroup.ShoppingMall.command.member.MemberRegisterCommand;
import com.FGroup.ShoppingMall.command.member.MemberUpdateCommand;
import com.FGroup.ShoppingMall.dto.MemberDto;

@Controller
public class MemberController {

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private JavaMailSender mailSender;

	private MemberLoginURLCommand memberLoginURLCommand;
	private MemberLoginCommand memberLoginCommand;
	private MemberLogoutCommand memberLogoutCommand;
	private MemberIdCheckCommand memberIdCheckCommand;
	private MemberFindIdCommand memberFindIdCommand;
	private MemberFindPasswordCommand memberFindPasswordCommand;
	private MemberEmailAuthCommand memberEmailAuthCommand;
	private MemberEmailAuthConfirmCommand memberEmailAuthConfirmCommand;
	private MemberRegisterCommand memberRegisterCommand;
	private MemberChangePasswordCommand memberChangePasswordCommand;
	private MemberUpdateCommand memberUpdateCommand;
	private MemberDeleteCommand memberDeleteCommand;

	@Autowired
	private void setCommand(MemberLoginURLCommand memberLoginURLCommand,
							MemberLoginCommand memberLoginCommand,
							MemberLogoutCommand memberLogoutCommand,
							MemberIdCheckCommand memberIdCheckCommand,
							MemberFindIdCommand memberFindIdCommand,
							MemberFindPasswordCommand memberFindPasswordCommand,
							MemberEmailAuthCommand memberEmailAuthCommand,
							MemberEmailAuthConfirmCommand memberEmailAuthConfirmCommand,
							MemberRegisterCommand memberRegisterCommand,
							MemberChangePasswordCommand memberChangePasswordCommand,
							MemberUpdateCommand memberUpdateCommand,
							MemberDeleteCommand memberDeleteCommand) {
		this.memberLoginURLCommand = memberLoginURLCommand;
		this.memberLoginCommand = memberLoginCommand;
		this.memberLogoutCommand = memberLogoutCommand;
		this.memberIdCheckCommand = memberIdCheckCommand;
		this.memberFindIdCommand = memberFindIdCommand;
		this.memberFindPasswordCommand = memberFindPasswordCommand;
		this.memberEmailAuthCommand = memberEmailAuthCommand;
		this.memberEmailAuthConfirmCommand = memberEmailAuthConfirmCommand;
		this.memberRegisterCommand = memberRegisterCommand;
		this.memberChangePasswordCommand = memberChangePasswordCommand;
		this.memberUpdateCommand = memberUpdateCommand;
		this.memberDeleteCommand = memberDeleteCommand;
	}

	@RequestMapping(value = "loginPage.do", method = RequestMethod.GET)
	public String loginPage(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		memberLoginURLCommand.execute(sqlSession, model);
		return "member/loginPage";
	}

	@RequestMapping(value = "login.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody // JSON 타입으로 파싱
	public Map<String, Object> memberLogin(@RequestBody MemberDto memberDto, HttpServletRequest request, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto); // 뷰에 데이터를 넘김
		}
		model.addAttribute("request", request);
		return memberLoginCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String memberLogout(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		memberLogoutCommand.execute(sqlSession, model);
		return "redirect:index.do";
	}

	@RequestMapping(value = "idCheck.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberIdCheck(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		return memberIdCheckCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "findId.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberFindId(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		return memberFindIdCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "findPassword.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberFindPassword(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		return memberFindPasswordCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "emailAuth.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberEmailAuth(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		model.addAttribute("mailSender", mailSender);
		return memberEmailAuthCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "emailAuthConfirm.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberEmailAuthConfirm(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		model.addAttribute("mailSender", mailSender);
		return memberEmailAuthConfirmCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "register.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberRegister(@RequestBody MemberDto memberDto, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		return memberRegisterCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "changePassword.do", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberChangePassword(@RequestBody MemberDto memberDto, HttpServletRequest request, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		model.addAttribute("request", request);
		return memberChangePasswordCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "update.do", method = RequestMethod.PUT, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberUpdate(@RequestBody MemberDto memberDto, HttpServletRequest request, Model model) {
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		model.addAttribute("request", request);
		return memberUpdateCommand.execute(sqlSession, model);
	}

	@RequestMapping(value = "member/{m_no}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> memberDelete(@PathVariable("m_no") int m_no, @RequestBody MemberDto memberDto, HttpServletRequest request, Model model) {
		model.addAttribute("m_no", m_no);
		if (memberDto != null) {
			model.addAttribute("memberDto", memberDto);
		}
		model.addAttribute("request", request);
		return memberDeleteCommand.execute(sqlSession, model);
	}

}