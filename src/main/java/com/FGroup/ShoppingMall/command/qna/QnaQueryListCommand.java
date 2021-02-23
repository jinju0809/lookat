package com.FGroup.ShoppingMall.command.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.common.Paging;
import com.FGroup.ShoppingMall.dao.QnaDao;
import com.FGroup.ShoppingMall.dto.QnaDto;

public class QnaQueryListCommand implements QnaCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String column = request.getParameter("column");
		String query = request.getParameter("query");

		String strPage = request.getParameter("page");
		int page = 1;
		if (strPage != null && !strPage.isEmpty()) {
			page = Integer.parseInt(strPage);
		}

		// column + query를 DB에 전달하기 위해서 Map으로 만든다.
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("column", column);
		map2.put("query", query);

		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		int totalQueryRecord = qnaDao.getTotalQueryRecord(map2);

		// 검색 결과는 한 페이지당 3개씩 보여준다.
		int recordPerPage = 10;
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = endRecord < totalQueryRecord ? endRecord : totalQueryRecord;

		// beginRecord ~ endRecord 사이 목록을 가져온다.
		map2.put("beginRecord", beginRecord + "");
		map2.put("endRecord", endRecord + "");

		List<QnaDto> list = qnaDao.queryQnaList(map2);

		// 페이징
		String paging = Paging.getPaging("queryQnaListPage.do?column=" + column + "&query=" + query, totalQueryRecord, recordPerPage, page);

		request.setAttribute("column", column);
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		request.setAttribute("totalRecord", totalQueryRecord);
		request.setAttribute("page", page);
		request.setAttribute("recordPerPage", recordPerPage);

	}

}
