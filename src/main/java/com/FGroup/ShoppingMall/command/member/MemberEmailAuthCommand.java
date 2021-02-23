package com.FGroup.ShoppingMall.command.member;

import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;

import com.FGroup.ShoppingMall.dto.MemberDto;

public class MemberEmailAuthCommand implements MemberCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		// 이메일을 보내는 작업은 예외 처리가 필요합니다.
		try {

			Map<String, Object> map = model.asMap();
			MemberDto memberDto = (MemberDto) map.get("memberDto");
			JavaMailSender mailSender = (JavaMailSender) map.get("mailSender");

			Map<String, Object> resultMap = new HashMap<String, Object>();

			String m_email = memberDto.getM_email();

			// MimeMessage 클래스가 이메일의 내용을 작성합니다.
			MimeMessage message = mailSender.createMimeMessage();
			message.setHeader("Content-Type", "text/plain; charset=utf-8");
			// message.setFrom(new InternetAddress("보내는사람의'지메일주소'", "마스터")); // 보내는 사람
			message.setFrom(new InternetAddress("lookatspring@gmail.com", "LOOKAT")); // 보내는 사람
			InternetAddress to = new InternetAddress(m_email); // 받는 사람
			InternetAddress[] toList = { to }; // 받는 사람을 배열에 저장해 두면 여러 곳에 한 번에 보낼 수도 있습니다.
			// message.setRecipient(Message.RecipientType.TO, to); 한명에게 보냅니다.
			message.setRecipients(Message.RecipientType.TO, toList); // 여러 명에게 보냅니다.
			message.setSubject("인증 요청 메일입니다."); // 제목
			long authKey = (long) (Math.random() * 10000000000L) + 1234567890; // 랜덤하게 마음대로 만듭니다.
			message.setText("인증코드: " + authKey); // 본문
			mailSender.send(message); // 메일을 보냅니다.

			resultMap.put("authKey", authKey);

			return resultMap;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

}