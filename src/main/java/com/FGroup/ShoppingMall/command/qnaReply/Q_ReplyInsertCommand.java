package com.FGroup.ShoppingMall.command.qnaReply;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.Q_ReplyDao;

public class Q_ReplyInsertCommand implements Q_ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String r_writer = request.getParameter("r_writer");
		String r_content = request.getParameter("r_content");
		int r_q_no = Integer.parseInt(request.getParameter("r_q_no"));
		int r_m_no = Integer.parseInt(request.getParameter("r_m_no"));

		Q_ReplyDao q_replyDao = sqlSession.getMapper(Q_ReplyDao.class);

		q_replyDao.replyInsert(r_writer, r_content, r_q_no, r_m_no);

	}

}
