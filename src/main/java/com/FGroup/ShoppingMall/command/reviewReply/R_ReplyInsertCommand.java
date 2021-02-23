package com.FGroup.ShoppingMall.command.reviewReply;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.R_ReplyDao;

public class R_ReplyInsertCommand implements R_ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String r_writer = request.getParameter("r_writer");
		String r_content = request.getParameter("r_content");
		int r_rv_no = Integer.parseInt(request.getParameter("r_rv_no"));
		int r_m_no = Integer.parseInt(request.getParameter("r_m_no"));

		R_ReplyDao r_replyDao = sqlSession.getMapper(R_ReplyDao.class);

		r_replyDao.replyInsert(r_writer, r_content, r_rv_no, r_m_no);
	}

}
