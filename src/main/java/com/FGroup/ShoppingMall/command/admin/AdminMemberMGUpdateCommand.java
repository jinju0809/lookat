package com.FGroup.ShoppingMall.command.admin;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.AdminDao;
import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class AdminMemberMGUpdateCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		AdminDao adminDao = sqlSession.getMapper(AdminDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int m_no = memberDto.getM_no();
		String m_id = memberDto.getM_id();
		String m_name = memberDto.getM_name();
		String m_addr1 = memberDto.getM_addr1();
		String m_addr2 = memberDto.getM_addr2();
		String m_addr3 = memberDto.getM_addr3();
		String m_phone = memberDto.getM_phone();
		String m_email = memberDto.getM_email();
		String m_grade = memberDto.getM_grade();

		if (m_name.equals("")) {
			resultMap.put("result", -1); // 이름 공백
		} else if (!(Pattern.matches("^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$", m_phone))) {
			resultMap.put("result", -2); // 폰번호 정규화 불일치
		} else if (m_email.equals("@")) {
			resultMap.put("result", -3); // 이메일 공백
		} else if (memberDao.emailCheck(m_id, m_email) != null) {
			resultMap.put("result", -4); // 이메일 중복
		} else if (!(Pattern.matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$",
				m_email))) {
			resultMap.put("result", -5); // 이메일 정규화 불일치
		} else if (adminDao.memberMGUpdate(m_no, m_name, m_addr1, m_addr2, m_addr3, m_phone, m_email, m_grade) == 1) {
			resultMap.put("result",
					adminDao.memberMGUpdate(m_no, m_name, m_addr1, m_addr2, m_addr3, m_phone, m_email, m_grade));
		} else {
			resultMap.put("result", -6);
		}

		return resultMap;
	}

}
