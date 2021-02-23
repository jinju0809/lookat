package com.FGroup.ShoppingMall.command.qnaReply;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.Q_ReplyDao;

public class Q_RereplyInsertCommand implements Q_ReplyCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		Q_ReplyDao q_replyDao = sqlSession.getMapper(Q_ReplyDao.class);

		// 댓글이 달릴 게시글의 정보 가져오기 = 원글
		int r_groupOrd = Integer.parseInt(request.getParameter("r_groupOrd"));
		int r_group = Integer.parseInt(request.getParameter("r_group"));
		// 1. 원글의 GroupOrd보다 큰 GroupOrd를 1씩 증가시킨다.
		System.out.println("초기 group :" + r_group);
		System.out.println("초기 groupOrd :" + r_groupOrd);

		Map<String, Integer> map2 = new HashMap<String, Integer>();
		map2.put("r_groupOrd", r_groupOrd);
		map2.put("r_group", r_group);
		q_replyDao.replyUpdatebGroupOrd(map2);

		String r_writer = request.getParameter("r_writer");
		String r_content = request.getParameter("rereply_content");
		int r_m_no = Integer.parseInt(request.getParameter("r_m_no"));
		int r_q_no = Integer.parseInt(request.getParameter("r_q_no"));
		int r_delete = Integer.parseInt(request.getParameter("r_delete"));

		r_groupOrd += 1;
		int r_depth = Integer.parseInt(request.getParameter("r_depth")) + 1;
		System.out.println("결과 group :" + r_group);
		System.out.println("결과 groupOrd :" + r_groupOrd);
		q_replyDao.rereplyInsert(r_writer, r_content, r_q_no, r_m_no, r_delete, r_group, r_groupOrd, r_depth);

	}

}
