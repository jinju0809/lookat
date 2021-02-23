package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.CartDao;
import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberLoginCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		CartDao cartDao = sqlSession.getMapper(CartDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_id = memberDto.getM_id();
		String m_pw = Sha256.sha256(memberDto.getM_pw());

		if (memberDao.login(m_id, m_pw) != null) {
			resultMap.put("loginResult", 1); // 로그인 성공
			session.setAttribute("loginDto", memberDao.login(m_id, m_pw));
			// 장바구니 개수
			int m_no = memberDao.login(m_id, m_pw).getM_no();
			session.setAttribute("crt_count", cartDao.cartCount(m_no));
			// TEST 코드
			System.out.println("로그인한 회원 DB: " + memberDao.login(m_id, m_pw));
		} else if (memberDto.getM_id() == "") {
			resultMap.put("loginResult", 0); // 아이디 항목 공백
		} else if (memberDto.getM_pw() == "") {
			resultMap.put("loginResult", -1); // 패스워드 항목 공백
		} else if (memberDto.getM_pw().length() < 8) {
			resultMap.put("loginResult", -2); // 패스워드 항목 8자 미만 입력
		} else {
			resultMap.put("loginResult", -3); // 아이디 패스워드 불일치
		}

		return resultMap;

	}

}
