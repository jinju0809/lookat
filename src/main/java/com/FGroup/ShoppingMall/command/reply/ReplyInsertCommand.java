package com.FGroup.ShoppingMall.command.reply;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.ReplyDao;

public class ReplyInsertCommand implements ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String r_writer = request.getParameter("r_writer");
		String r_content = request.getParameter("r_content");
		int r_n_no = Integer.parseInt(request.getParameter("r_n_no"));
		int r_m_no = Integer.parseInt(request.getParameter("r_m_no"));

		ReplyDao replyDao = sqlSession.getMapper(ReplyDao.class);

		replyDao.replyInsert(r_writer, r_content, r_n_no, r_m_no);

	}

}
