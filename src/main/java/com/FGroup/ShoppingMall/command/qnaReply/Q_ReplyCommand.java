package com.FGroup.ShoppingMall.command.qnaReply;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface Q_ReplyCommand {

	public void execute(SqlSession sqlSession, Model model);

}
