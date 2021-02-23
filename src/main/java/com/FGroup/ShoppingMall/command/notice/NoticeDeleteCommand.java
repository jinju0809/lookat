package com.FGroup.ShoppingMall.command.notice;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.NoticeDao;
import com.FGroup.ShoppingMall.dao.ReplyDao;

public class NoticeDeleteCommand implements NoticeCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int n_no = Integer.parseInt(request.getParameter("n_no"));

		// 리플레이가 있으면 리플레이 삭제
		ReplyDao replyDao = sqlSession.getMapper(ReplyDao.class);
		int replyCount = replyDao.replyCount(n_no);
		if (replyCount != 0) {
			replyDao.allReplyDelete(n_no);
		}

		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		noticeDao.noticeDelete(n_no);

		// 첨부가 있으면 첨부파일 삭제
		String n_filename = request.getParameter("n_filename");
		String realPath = request.getServletContext().getRealPath("resources/storage");

		if (n_filename != null && !n_filename.isEmpty()) {
			File file = new File(realPath, n_filename);
			if (file.exists()) {
				file.delete();
			}
		}

	}

}
