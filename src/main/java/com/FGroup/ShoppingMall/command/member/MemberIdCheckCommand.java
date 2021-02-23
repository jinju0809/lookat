package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberIdCheckCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_id = memberDto.getM_id();

		if (memberDao.idCheck(m_id) == null) {
			resultMap.put("idResult", 1);
		} else {
			resultMap.put("idResult", 0); // 중복된 아이디인 경우 0
		}

		return resultMap;

	}

}
