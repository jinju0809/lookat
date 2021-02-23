package com.FGroup.ShoppingMall.command.notice;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.NoticeDao;
import com.FGroup.ShoppingMall.dao.ReplyDao;
import com.FGroup.ShoppingMall.dto.ReplyDto;

public class NoticeViewCommand implements NoticeCommand {

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		ReplyDao replyDao = sqlSession.getMapper(ReplyDao.class);
		int r_n_no = Integer.parseInt(request.getParameter("n_no"));
		List<ReplyDto> replyList = replyDao.replyList(r_n_no);

		int n_no = Integer.parseInt(request.getParameter("n_no"));
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);

		// 조회수 처리
		int n_hit = noticeDao.noticeHit(n_no);
		model.addAttribute("n_hit", n_hit);
		// viewPage 처리
		model.addAttribute("noticeDto", noticeDao.noticeView(n_no));
		model.addAttribute("page", request.getParameter("page"));
		// 댓글리스트 처리
		model.addAttribute("replyList", replyList);

	}

}
