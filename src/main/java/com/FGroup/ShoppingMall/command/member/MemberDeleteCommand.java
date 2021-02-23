package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dao.NoticeDao;
import com.FGroup.ShoppingMall.dao.QnaDao;
import com.FGroup.ShoppingMall.dao.ReviewDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberDeleteCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		int m_no = (int) map.get("m_no");
		MemberDto memberDto = (MemberDto) map.get("memberDto");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		ReviewDao reviewDao = sqlSession.getMapper(ReviewDao.class);
		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_id = memberDto.getM_id();
		String m_pw = Sha256.sha256(memberDto.getM_pw());
		String m_pw2 = Sha256.sha256(memberDto.getM_pw2());

		if (m_pw.equals("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
				|| m_pw2.equals("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")) {
			resultMap.put("deleteResult", -0); // 패스워드 공백
		} else if (!(m_pw.equals(m_pw2))) {
			resultMap.put("deleteResult", -1); // 패스워드 확인 불일치
		} else if (memberDao.login(m_id, m_pw) == null) {
			resultMap.put("deleteResult", -2); // 아이디 패스워드 불일치
		} else {
			resultMap.put("deleteResult", 1);
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
			memberDao.memberDelete(m_no);
			if (session.getAttribute("loginDto") != null) {
				session.invalidate();
			}
			System.out.println(m_id + "님 회원탈퇴 완료");
		}

		return resultMap;
	}

}
