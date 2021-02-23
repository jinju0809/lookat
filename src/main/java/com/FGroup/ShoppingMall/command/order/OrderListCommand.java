package com.FGroup.ShoppingMall.command.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.common.Paging;
import com.FGroup.ShoppingMall.dao.OrderDao;
import com.FGroup.ShoppingMall.dto.OrderDto;
import com.FGroup.ShoppingMall.dto.ProductDto;

public class OrderListCommand implements OrderCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String stm_no = request.getParameter("m_no");
		int m_no = 0;
		if (stm_no != null) {
			m_no = Integer.parseInt(stm_no);
		}
		int orderResult = 0;
		int deleteResult = 0;
		if (request.getParameter("orderResult") != null) {
			orderResult = Integer.parseInt(request.getParameter("orderResult"));
		}
		if (request.getParameter("deleteResult") != null) {
			deleteResult = Integer.parseInt(request.getParameter("deleteResult"));
		}
		if (m_no > 0) {
			// 페이징처리..
			int page = 1;
			if (request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
				// 페이지 알아내기
			}
			// 전체 게시글이 몇 개인지 알아내야함..
			int totalRecord = orderDao.totalRecord(m_no);
			System.out.println(totalRecord);
			int recordPerPage = 5; // 페이지당 5개 글 보임..
			int beginRecord = (page - 1) * recordPerPage + 1;
			int endRecord = beginRecord + recordPerPage - 1;
			endRecord = endRecord < totalRecord ? endRecord : totalRecord;
			// 중복제거
			List<OrderDto> orderList = orderDao.OrderLists(m_no, beginRecord, endRecord);
			// 전체
			List<OrderDto> list = orderDao.OrderList(m_no, beginRecord, endRecord);
			System.out.println(list);
			model.addAttribute("list", list);
			model.addAttribute("orderList", orderList);
			List<ProductDto> prodList = new ArrayList<ProductDto>();
			for (OrderDto orderDto : list) {
				prodList.add(orderDao.OrderProduct(orderDto.getO_p_no()));
			}
			model.addAttribute("prodList", prodList);
			String paging = Paging.getPaging("orderListPage.do?m_no=" + m_no, totalRecord, recordPerPage, page);
			model.addAttribute("paging", paging);
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("page", page);
			model.addAttribute("orderResult", orderResult);
			model.addAttribute("deleteResult", deleteResult);
		}

	}// excute

}
