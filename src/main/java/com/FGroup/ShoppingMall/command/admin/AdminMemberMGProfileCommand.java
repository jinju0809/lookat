package com.FGroup.ShoppingMall.command.admin;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class AdminMemberMGProfileCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		int m_no = (int) map.get("m_no");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		MemberDto memberDto = memberDao.memberView(m_no);
		if (memberDto != null) {
			resultMap.put("memberDto", memberDto);
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
		}

		return resultMap;
	}

}
