package com.FGroup.ShoppingMall.command.qna;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface QnaCommand {

	public void execute(SqlSession sqlSession, Model model);

}
