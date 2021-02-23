package com.FGroup.ShoppingMall.command.qna;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.Q_ReplyDao;
import com.FGroup.ShoppingMall.dao.QnaDao;
import com.FGroup.ShoppingMall.dto.Q_ReplyDto;

public class QnaViewCommand implements QnaCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		Q_ReplyDao q_replyDao = sqlSession.getMapper(Q_ReplyDao.class);

		int r_q_no = Integer.parseInt(request.getParameter("q_no"));

		List<Q_ReplyDto> replyList = q_replyDao.replyList(r_q_no);

		int q_no = Integer.parseInt(request.getParameter("q_no"));
		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);

		// 조회수 처리
		int q_hit = qnaDao.qnaHit(q_no);
		model.addAttribute("q_hit", q_hit);
		// viewPage 처리
		model.addAttribute("qnaDto", qnaDao.qnaView(q_no));
		model.addAttribute("page", request.getParameter("page"));
		// 댓글리스트 처리
		model.addAttribute("replyList", replyList);

	}

}
