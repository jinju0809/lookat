package com.FGroup.ShoppingMall.command.admin;

import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.command.member.Sha256;
import com.FGroup.ShoppingMall.dao.MemberDao;
import com.FGroup.ShoppingMall.dto.MemberDto;

public class AdminMemberMGSendPasswordCommand implements AdminCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MemberDto memberDto = (MemberDto) map.get("memberDto");

		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String m_id = memberDto.getM_id();
		String m_email = memberDto.getM_email();

		// 이메일을 보내는 작업은 예외 처리가 필요합니다.
		try {

			JavaMailSender mailSender = (JavaMailSender) map.get("mailSender");

			// MimeMessage 클래스가 이메일의 내용을 작성합니다.
			MimeMessage message = mailSender.createMimeMessage();
			message.setHeader("Content-Type", "text/plain; charset=utf-8");
			// message.setFrom(new InternetAddress("보내는사람의'지메일주소'", "마스터")); // 보내는 사람
			message.setFrom(new InternetAddress("lookatspring@gmail.com", "LOOKAT")); // 보내는 사람
			InternetAddress to = new InternetAddress(m_email); // 받는 사람
			InternetAddress[] toList = { to }; // 받는 사람을 배열에 저장해 두면 여러 곳에 한 번에 보낼 수도 있습니다.
			// message.setRecipient(Message.RecipientType.TO, to); 한명에게 보냅니다.
			message.setRecipients(Message.RecipientType.TO, toList); // 여러 명에게 보냅니다.
			message.setSubject("임시 비밀번호 입니다."); // 제목

			// 임시 비밀번호 생성
			int index = 0;
			char[] charSet = { 'a', 'b', 'c', 'd', 'e', 
								'f', 'g', 'h', 'i', 'j', 
								'k', 'l', 'm', 'n', 'o', 
								'p', 'q', 'r', 's', 't', 
								'u', 'v', 'w', 'x', 'y', 
								'z', '0', '1', '2', '3', 
								'4', '5', '6', '7', '8', 
								'9' };
			StringBuilder sb = new StringBuilder("");
			for (int i = 0; i < 8; i++) {
				index = (int) (charSet.length * Math.random());
				sb.append(charSet[index]);
			}
			String temporaryPw = sb.toString();

			String m_pw = Sha256.sha256(temporaryPw);
			memberDao.changePassword(m_id, m_pw);

			resultMap.put("m_email", m_email);

			message.setText("임시 비밀번호: " + temporaryPw); // 본문
			mailSender.send(message); // 메일을 보냅니다.

			return resultMap;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultMap;
	}

}
