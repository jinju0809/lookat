package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberFindIdCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_name = memberDto.getM_name();
		String m_email = memberDto.getM_email();

		if (m_name.equals("")) {
			resultMap.put("findIdResult", 0);
		} else if (m_email.equals("")) {
			resultMap.put("findIdResult", -1);
		} else if (!(Pattern.matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$", m_email))) {
			resultMap.put("findIdResult", -2);
		} else if (memberDao.findId(m_name, m_email) == null) {
			resultMap.put("findIdResult", -3);
		} else if (memberDao.findId(m_name, m_email) != null) {
			resultMap.put("findIdResult", 1);
			resultMap.put("findIdId", memberDao.findId(m_name, m_email).getM_id());
			resultMap.put("findIdGrade", memberDao.findId(m_name, m_email).getM_grade());
			resultMap.put("findIdRegDate", memberDao.findId(m_name, m_email).getM_regdate());
		} else {
			resultMap.put("findIdResult", -4);
		}

		return resultMap;

	}

}
