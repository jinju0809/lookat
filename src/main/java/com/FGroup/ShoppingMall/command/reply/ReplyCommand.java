package com.FGroup.ShoppingMall.command.reply;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface ReplyCommand {

	public void execute(SqlSession sqlSession, Model model);

}
