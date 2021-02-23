package com.FGroup.ShoppingMall.command.qnaReply;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.Q_ReplyDao;

public class Q_ReplyDeleteCommand implements Q_ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int r_no = Integer.parseInt(request.getParameter("r_no"));
		Q_ReplyDao q_replyDao = sqlSession.getMapper(Q_ReplyDao.class);
		q_replyDao.replyDelete(r_no);

	}

}
