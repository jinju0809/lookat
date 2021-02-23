package com.FGroup.ShoppingMall.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public class MemberLoginURLCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();

		String before_url = request.getHeader("referer");

		if (before_url.equals("http://localhost:9090/ShoppingMall/loginPage.do")
				|| before_url.equals("http://localhost:9090/ShoppingMall/findIdPage.do")
				|| before_url.equals("http://localhost:9090/ShoppingMall/findPasswordPage.do")
				|| before_url.equals("http://localhost:9090/ShoppingMall/signUpPage.do")) {
		} else {
			session.setAttribute("referer", before_url);
			System.out.println("로그인 전 페이지: " + before_url);
		}

		return null;

	}

}