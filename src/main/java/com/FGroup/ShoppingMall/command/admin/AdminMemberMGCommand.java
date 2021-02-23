package com.FGroup.ShoppingMall.command.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.AdminDao;
import com.FGroup.ShoppingMall.dto.AdminDto;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class AdminMemberMGCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		AdminDto adminDto = (AdminDto) map.get("adminDto");

		String member_type = adminDto.getMember_type();
		String search_member = adminDto.getSearch_member();

		AdminDao adminDao = sqlSession.getMapper(AdminDao.class);
		List<MemberDto> list = adminDao.memberList(member_type, search_member);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", list);
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				if (!(list.get(i).getM_grade().equals("관리자등급"))) {
					resultMap.put("listResult", true);
					return resultMap;
				} else {
					resultMap.put("listResult", false);
				}
			}
		} else {
			resultMap.put("listResult", false);
		}

		return resultMap;
		
	}

}
