package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberChangePasswordCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_id = memberDto.getM_id();
		String m_pw = memberDto.getM_pw();
		String c_pw = memberDto.getC_pw();
		String c_pw2 = memberDto.getC_pw2();

		String s_m_pw = Sha256.sha256(memberDto.getM_pw());
		String s_c_pw = Sha256.sha256(memberDto.getC_pw());

		if (m_pw.equals("")) {
			resultMap.put("changePasswordResult", 0);
		} else if (c_pw.equals("")) {
			resultMap.put("changePasswordResult", -1);
		} else if (!(Pattern.matches("^(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9`~!@#$%^&*()-_=+]{8,16}$", c_pw))) {
			resultMap.put("changePasswordResult", -2);
		} else if (c_pw2.equals("")) {
			resultMap.put("changePasswordResult", -3);
		} else if (!(c_pw.equals(c_pw2))) {
			resultMap.put("changePasswordResult", -4);
		} else if (memberDao.login(m_id, s_m_pw) == null) {
			resultMap.put("changePasswordResult", -5);
		} else {
			memberDao.changePassword(m_id, s_c_pw);
			session.setAttribute("loginDto", memberDao.login(m_id, s_c_pw));
			resultMap.put("changePasswordResult", 1);
		}

		return resultMap;
	}

}
