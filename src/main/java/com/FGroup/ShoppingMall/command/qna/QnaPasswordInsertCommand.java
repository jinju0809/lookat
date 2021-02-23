package com.FGroup.ShoppingMall.command.qna;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.QnaDao;

public class QnaPasswordInsertCommand implements QnaCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int q_no = Integer.parseInt(request.getParameter("q_no"));
		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);

		model.addAttribute("qnaDto", qnaDao.qnaPassword(q_no));

	}

}
