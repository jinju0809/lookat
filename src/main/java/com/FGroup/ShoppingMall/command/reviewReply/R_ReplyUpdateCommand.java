package com.FGroup.ShoppingMall.command.reviewReply;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.R_ReplyDao;

public class R_ReplyUpdateCommand implements R_ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String r_content = request.getParameter("edit_content");
		int r_no = Integer.parseInt(request.getParameter("r_no"));
		R_ReplyDao r_replyDao = sqlSession.getMapper(R_ReplyDao.class);
		r_replyDao.replyUpdate(r_no, r_content);
		
	}

}
