package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberUpdateCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int m_no = memberDto.getM_no();
		String m_id = memberDto.getM_id();
		String m_pw = Sha256.sha256(memberDto.getM_pw());
		String m_pw2 = Sha256.sha256(memberDto.getM_pw2());
		String m_name = memberDto.getM_name();
		String m_addr1 = memberDto.getM_addr1();
		String m_addr2 = memberDto.getM_addr2();
		String m_addr3 = memberDto.getM_addr3();
		String m_phone = memberDto.getM_phone();
		String m_email = memberDto.getM_email();

		if (m_pw.equals("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
				|| m_pw2.equals("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")) {
			resultMap.put("updateResult", 0); // 패스워드 공백
		} else if (!(m_pw.equals(m_pw2))) {
			resultMap.put("updateResult", -1); // 패스워드 확인 불일치
		} else if (memberDao.login(m_id, m_pw) == null) {
			resultMap.put("updateResult", -2); // 아이디 패스워드 불일치
		} else if (m_name.equals("")) {
			resultMap.put("updateResult", -3); // 이름 공백
		} else if (!(Pattern.matches("^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$", m_phone))) {
			resultMap.put("updateResult", -4); // 폰번호 정규화 불일치
		} else if (m_email.equals("@")) {
			resultMap.put("updateResult", -5); // 이메일 공백
		} else if (memberDao.emailCheck(m_id, m_email) != null) {
			resultMap.put("updateResult", -6); // 이메일 중복
		} else if (!(Pattern.matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$", m_email))) {
			resultMap.put("updateResult", -7); // 이메일 정규화 불일치
		} else if (memberDao.memberUpdate(m_no, m_name, m_addr1, m_addr2, m_addr3, m_phone, m_email) == 1) {
			resultMap.put("updateResult", memberDao.memberUpdate(m_no, m_name, m_addr1, m_addr2, m_addr3, m_phone, m_email));
			session.setAttribute("loginDto", memberDao.login(m_id, m_pw));
		} else {
			resultMap.put("updateResult", -8);
		}
		return resultMap;
	}

}
