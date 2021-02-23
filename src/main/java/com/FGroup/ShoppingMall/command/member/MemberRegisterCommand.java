package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberRegisterCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_id = memberDto.getM_id();
		String m_pw = memberDto.getM_pw();
		String m_pw2 = memberDto.getM_pw2();
		String m_name = memberDto.getM_name();
		String m_phone = memberDto.getM_phone();
		String m_email = memberDto.getM_email();
		boolean check1 = memberDto.isCheck1();
		boolean check2 = memberDto.isCheck2();

		// TEST 코드
		System.out.println("비밀번호 설정 : " + m_pw);
		System.out.println("비밀번호 확인 : " + m_pw2);

		if (m_id.equals("")) {
			resultMap.put("registerResult", 0); // 아이디 항목 공백
		} else if (memberDao.idCheck(m_id) != null) {
			resultMap.put("registerResult", -1); // 아이디 중복
		} else if (!(Pattern.matches("^[a-z][0-9a-z]{4,19}$", m_id))) {
			resultMap.put("registerResult", -2); // 아이디 정규화 불일치
		} else if (m_pw.equals("")) {
			resultMap.put("registerResult", -3); // 패스워드 항목 공백
		} else if (!(Pattern.matches("^(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9`~!@#$%^&*()-_=+]{8,16}$", m_pw))) {
			resultMap.put("registerResult", -4); // 패스워드 정규화 불일치
		} else if (!(m_pw.equals(m_pw2))) {
			resultMap.put("registerResult", -5); // 패스워드 확인 불일치
		} else if (m_name.equals("")) {
			resultMap.put("registerResult", -6); // 이름 항목 공뱅
		} else if (!(Pattern.matches("^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$", m_phone))) {
			resultMap.put("registerResult", -7); // 폰번호 정규화 불일치
		} else if (m_email.equals("@")) {
			resultMap.put("registerResult", -8); // 이메일 항목 공백
		} else if (memberDao.emailCheck(m_id, m_email) != null) {
			resultMap.put("registerResult", -9); // 이메일 중복
		} else if (!(Pattern.matches("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$", m_email))) {
			resultMap.put("registerResult", -10); // 이메일 정규화 불일치
		} else if (check1 == false) {
			resultMap.put("registerResult", -11); // 이용약간 동의선택 필요
		} else if (check2 == false) {
			resultMap.put("registerResult", -12); // 이용약간 동의선택 필요
		} else {
			m_pw = Sha256.sha256(memberDto.getM_pw());
			memberDao.register(m_id, m_pw, m_name, m_phone, m_email);
			resultMap.put("registerResult", 1);
			// TEST 코드
			System.out.println("비밀번호(암호화) : " + m_pw);
		}

		return resultMap;

	}

}
