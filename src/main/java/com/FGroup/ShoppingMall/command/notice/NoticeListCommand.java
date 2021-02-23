package com.FGroup.ShoppingMall.command.notice;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.common.Paging;
import com.FGroup.ShoppingMall.dao.NoticeDao;
import com.FGroup.ShoppingMall.dto.NoticeDto;

public class NoticeListCommand implements NoticeCommand {

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public void execute(SqlSession sqlSession, Model model) {

		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		// 총 게시물의 숫자를 구합니다.
		int totalRecord = noticeDao.totalRecord();

		// 한 페이지에 몇 개의 레코드를 표시할 것인지 여기서 결정합니다.
		int recordPerPage = 10; // 각 ListCommand마다 다르게 설정해도 됩니다.
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = endRecord < totalRecord ? endRecord : totalRecord;

		// beginRecord + endRecord를 list에 전달합니다.
		List<NoticeDto> list = noticeDao.noticeList(beginRecord, endRecord);

		String paging = Paging.getPaging("noticeListPage.do", totalRecord, recordPerPage, page);

		model.addAttribute("list", list);

		model.addAttribute("paging", paging);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("page", page);
		model.addAttribute("recordPerPage", recordPerPage);

	}

}
