package com.FGroup.ShoppingMall.command.qna;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.common.Paging;
import com.FGroup.ShoppingMall.dao.QnaDao;
import com.FGroup.ShoppingMall.dto.QnaDto;

public class QnaListCommand implements QnaCommand {

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		int totalRecord = qnaDao.totalRecord();

		// SimpleList는 한 페이지에 몇 개의 레코드를 표시할 것인지 여기서 결정합니다.
		int recordPerPage = 15; // 각 ListCommand마다 다르게 설정해도 됩니다.

		int beginRecord = (page - 1) * recordPerPage + 1; // 항상 똑같습니다.
		int endRecord = beginRecord + recordPerPage - 1; // 항상 똑같습니다.
		endRecord = endRecord < totalRecord ? endRecord : totalRecord; // 항상 똑같습니다.

		// beginRecord + endRecord를 list를 가져오는 simpleList()에 전달합니다.
		List<QnaDto> list = qnaDao.qnaList(beginRecord, endRecord);

		String paging = Paging.getPaging("qnaListPage.do", totalRecord, recordPerPage, page);

		model.addAttribute("qnaList", list);

		model.addAttribute("paging", paging);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("page", page);
		model.addAttribute("recordPerPage", recordPerPage);

	}

}
