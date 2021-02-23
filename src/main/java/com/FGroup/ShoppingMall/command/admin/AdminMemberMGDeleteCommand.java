package com.FGroup.ShoppingMall.command.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dao.NoticeDao;
import com.FGroup.ShoppingMall.dao.QnaDao;
import com.FGroup.ShoppingMall.dao.ReviewDao;

public class AdminMemberMGDeleteCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		int m_no = (int) map.get("m_no");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		ReviewDao reviewDao = sqlSession.getMapper(ReviewDao.class);
		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		List<Integer> n_list = noticeDao.noticeNo(m_no);
		List<Integer> r_list = reviewDao.reviewNo(m_no);
		List<Integer> q_list = qnaDao.qnaNo(m_no);
		for (int n_no : n_list) {
			noticeDao.noticeDelete(n_no);
		}
		for (int r_no : r_list) {
			reviewDao.reviewDelete(r_no);
		}
		for (int q_no : q_list) {
			qnaDao.qnaDelete(q_no);
		}
		resultMap.put("result", memberDao.memberDelete(m_no));

		return resultMap;
	}

}
