package com.FGroup.ShoppingMall.dao;

import java.util.List;
import java.util.Map;

import com.FGroup.ShoppingMall.dto.R_ReplyDto;

public interface R_ReplyDao {

	public List<R_ReplyDto> replyList(int r_q_no); // 메소드의 이름이 mapper의 쿼리문 id가 됩니다.

	public int replyInsert(String r_writer, String r_content, int r_q_no, int r_m_no);

	public int rereplyInsert(String r_writer, String r_content, int r_q_no, int r_m_no, int r_delete, int r_group,
			int r_groupOrd, int r_depth);

	public int replyDelete(int r_no);

	public int replyCount(int r_q_no);

	public int allReplyDelete(int q_no);

	public int replyUpdate(int r_no, String r_content);

	public int replyUpdatebGroupOrd(Map<String, Integer> map);

}
