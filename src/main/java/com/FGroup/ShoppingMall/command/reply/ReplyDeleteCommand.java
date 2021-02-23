package com.FGroup.ShoppingMall.command.reply;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.ReplyDao;

public class ReplyDeleteCommand implements ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int r_no = Integer.parseInt(request.getParameter("r_no"));
		ReplyDao replyDao = sqlSession.getMapper(ReplyDao.class);
		replyDao.replyDelete(r_no);

	}

}
