package com.FGroup.ShoppingMall.command.qna;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.QnaDao;
import com.FGroup.ShoppingMall.dao.R_ReplyDao;

public class QnaDeleteCommand implements QnaCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int q_no = Integer.parseInt(request.getParameter("q_no"));

		// 리플레이가 있으면 리플레이 삭제
		R_ReplyDao r_replyDao = sqlSession.getMapper(R_ReplyDao.class);
		int replyCount = r_replyDao.replyCount(q_no);
		if (replyCount != 0) {
			r_replyDao.allReplyDelete(q_no);
		}

		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		qnaDao.qnaDelete(q_no);

		// 첨부가 있으면 첨부파일 삭제
		String q_filename = request.getParameter("q_filename");
		String realPath = request.getServletContext().getRealPath("resources/storage");

		if (q_filename != null && !q_filename.isEmpty()) {
			File file = new File(realPath, q_filename);
			if (file.exists()) {
				file.delete();
			}
		}

	}

}
