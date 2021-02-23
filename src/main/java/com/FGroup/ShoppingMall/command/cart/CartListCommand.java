package com.FGroup.ShoppingMall.command.cart;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.common.Paging;
import com.FGroup.ShoppingMall.dao.CartDao;
import com.FGroup.ShoppingMall.dto.CartDto;
import com.FGroup.ShoppingMall.dto.ProductDto;

public class CartListCommand implements CartCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		CartDao cartDao = sqlSession.getMapper(CartDao.class);
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		String stm_no = request.getParameter("m_no");
		int m_no = 0;
		if (stm_no != null) {
			m_no = Integer.parseInt(stm_no);
		} else {
			System.out.println(request.getParameter("m_no"));
		}
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if (m_no > 0) {
			// 전체 게시글이 몇 개인지 알아내야함..
			int totalRecord = cartDao.totalRecord(m_no);
			// SimpleList는 한 페이지에 몇 개의 레코드를 표시할 것인지 여기서 결정한다..
			int recordPerPage = 5; // 페이지당 5개 글 보임.. 각 ListCommand마다 다르게 설정해도 된다.
			int beginRecord = (page - 1) * recordPerPage + 1;
			int endRecord = beginRecord + recordPerPage - 1;
			// endRecord페이지가 전체 페이지개수보다 커질 수 있음 방지
			endRecord = endRecord < totalRecord ? endRecord : totalRecord;
			// beginRecord + endRecord 를 list를 가져오는 sipleList()에 전달한다.
			List<CartDto> list = cartDao.cartList(m_no, beginRecord, endRecord);
			// beginRecord부터 endRecord까지 목록 만들기

			List<ProductDto> prodList = new ArrayList<ProductDto>();
			for (CartDto cartDto : list) {
				prodList.add(cartDao.cartProduct(cartDto.getCrt_p_no()));
			}
			String paging = Paging.getPaging("cartListPage.do?m_no=" + m_no, totalRecord, recordPerPage, page);

			model.addAttribute("paging", paging);
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("page", page);
			session.setAttribute("crt_count", cartDao.cartCount(m_no));
			model.addAttribute("cartList", list);
			model.addAttribute("prodList", prodList);

		}

	}

}