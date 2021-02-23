package com.FGroup.ShoppingMall.command.review;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.R_ReplyDao;
import com.FGroup.ShoppingMall.dao.ReviewDao;

public class ReviewDeleteCommand implements ReviewCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int rv_no = Integer.parseInt(request.getParameter("rv_no"));

		// 리플레이가 있으면 리플레이 삭제
		R_ReplyDao r_replyDao = sqlSession.getMapper(R_ReplyDao.class);
		int replyCount = r_replyDao.replyCount(rv_no);
		if (replyCount != 0) {
			r_replyDao.allReplyDelete(rv_no);
		}

		ReviewDao reviewDao = sqlSession.getMapper(ReviewDao.class);
		reviewDao.reviewDelete(rv_no);

		// 첨부가 있으면 첨부파일 삭제
		String rv_filename = request.getParameter("rv_filename");
		String realPath = request.getServletContext().getRealPath("resources/storage");

		if (rv_filename != null && !rv_filename.isEmpty()) {
			File file = new File(realPath, rv_filename);
			if (file.exists()) {
				file.delete();
			}
		}

	}
}
