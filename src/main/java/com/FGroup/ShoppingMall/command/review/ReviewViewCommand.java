package com.FGroup.ShoppingMall.command.review;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.R_ReplyDao;
import com.FGroup.ShoppingMall.dao.ReviewDao;
import com.FGroup.ShoppingMall.dto.R_ReplyDto;

public class ReviewViewCommand implements ReviewCommand {

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		R_ReplyDao r_replyDao = sqlSession.getMapper(R_ReplyDao.class);

		int r_rv_no = Integer.parseInt(request.getParameter("rv_no"));

		List<R_ReplyDto> replyList = r_replyDao.replyList(r_rv_no);

		int rv_no = Integer.parseInt(request.getParameter("rv_no"));
		ReviewDao reviewDao = sqlSession.getMapper(ReviewDao.class);

		// 조회수 처리
		int rv_hit = reviewDao.reviewHit(rv_no);
		model.addAttribute("rv_hit", rv_hit);
		// viewPage 처리
		model.addAttribute("reviewDto", reviewDao.reviewView(rv_no));
		model.addAttribute("page", request.getParameter("page"));
		// 댓글리스트 처리
		model.addAttribute("replyList", replyList);

	}

}
