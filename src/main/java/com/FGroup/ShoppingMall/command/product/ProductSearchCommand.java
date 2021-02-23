package com.FGroup.ShoppingMall.command.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.ProductDao;
import com.FGroup.ShoppingMall.dto.ProductSearchDto;

public class ProductSearchCommand {

	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();

		ProductSearchDto productSearchDto = (ProductSearchDto) map.get("productSearchDto");
		int page = productSearchDto.getPage();

		ProductDao productDao = sqlSession.getMapper(ProductDao.class);

		int totalRecord = productDao.searchCount(productSearchDto);
		int recordPerPage = 12;
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = (endRecord < totalRecord) ? endRecord : totalRecord;
		int totalPage = totalRecord / recordPerPage; // 전체 페이지의 개수
		if (totalRecord % recordPerPage != 0) {
			totalPage++;
		}
		totalPage = (totalPage >= page) ? totalPage : page;
		int pagePerBlock = 5;
		int beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
		int endPage = beginPage + pagePerBlock - 1;
		endPage = endPage < totalPage ? endPage : totalPage;

		Map<String, Integer> paging = new HashMap<>();
		paging.put("totalRecord", totalRecord);
		paging.put("page", page);
		paging.put("totalPage", totalPage);
		paging.put("pagePerBlock", pagePerBlock);
		paging.put("beginPage", beginPage);
		paging.put("endPage", endPage);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("paging", paging);

		productSearchDto.setBeginRecord(beginRecord);
		productSearchDto.setEndRecord(endRecord);
		List<ProductSearchDto> list = productDao.productSearch(productSearchDto);

		resultMap.put("list", list);
		resultMap.put("search_count", totalRecord);

		if (list.size() > 0) {
			resultMap.put("result", true);
		} else {
			resultMap.put("result", false);
		}

		return resultMap;

	}

}
