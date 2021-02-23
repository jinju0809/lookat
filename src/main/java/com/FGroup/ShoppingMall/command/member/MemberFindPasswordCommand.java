package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberFindPasswordCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_id = memberDto.getM_id();
		String m_name = memberDto.getM_name();
		String m_email = memberDto.getM_email();

		if (m_id.equals("")) {
			resultMap.put("findPasswordResult", 0);
		} else if (!(Pattern.matches("^[a-z][0-9a-z]{4,19}$", m_id))) {
			resultMap.put("findPasswordResult", -1);
		} else if (m_name.equals("")) {
			resultMap.put("findPasswordResult", -2);
		} else if (m_email.equals("")) {
			resultMap.put("findPasswordResult", -3);
		} else if (!(Pattern.matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$", m_email))) {
			resultMap.put("findPasswordResult", -4);
		} else if (memberDao.idCheck(m_id) == null) {
			resultMap.put("findPasswordResult", -5);
		} else if (memberDao.findPassword(m_id, m_name, m_email) == null) {
			resultMap.put("findPasswordResult", -6);
		} else if (memberDao.findPassword(m_id, m_name, m_email) != null) {
			resultMap.put("findPasswordResult", 1);
		} else {
			resultMap.put("findPasswordResult", -7);
		}

		return resultMap;

	}

}
