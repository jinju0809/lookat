package com.FGroup.ShoppingMall.command.reviewReply;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface R_ReplyCommand {

	public void execute(SqlSession sqlSession, Model model);

}
