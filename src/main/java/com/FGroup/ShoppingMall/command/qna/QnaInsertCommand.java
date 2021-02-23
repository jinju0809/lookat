package com.FGroup.ShoppingMall.command.qna;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.FGroup.ShoppingMall.dao.QnaDao;

public class QnaInsertCommand implements QnaCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) map.get("multipartRequest");

		// multipartRequest에 저장된 일반 파라미터는 getParameter()를 씁니다.
		// String m_name = request.getParameter("m_name");
		String q_title = multipartRequest.getParameter("q_title");
		String q_content = multipartRequest.getParameter("q_content");
		int q_m_no = (Integer.parseInt(multipartRequest.getParameter("q_m_no")));
		int q_p_no = (Integer.parseInt(multipartRequest.getParameter("q_p_no")));
		String q_pw = multipartRequest.getParameter("q_pw");
		String q_secret = multipartRequest.getParameter("q_secret");

		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		List<MultipartFile> files = multipartRequest.getFiles("files");
		int count = 0;
		String uploadFileNames = "";

		// 첨부를 하나씩 꺼내기
		for (MultipartFile file : files) {
			// 꺼낸 첨부가 있는지 검사
			if (file != null && !file.isEmpty()) {

				// MultipartFile file에서 첨부하는 파일명을 알아냅니다.
				String originalFilename = file.getOriginalFilename();

				// 업로드 할 파일명의 중복 방지 대책을 수립합니다.
				// 원래파일명_업로드시간.확장자

				// abcde.jpg
				// 확장자 (jpg 구하기)
				String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
				// 파일명 (abcde 구하기)
				String filename = originalFilename.substring(0, originalFilename.lastIndexOf("."));
				filename = filename.replace("[", "");
				filename = filename.replace("]", "");

				// 업로드 할 파일명 만들기 (abcde_업로드시간.jpg)
				String uploadFilename = filename + "_" + System.currentTimeMillis() + "." + extension;

				// 업로드 할 경로 구하기
				// 업로드는 resources/storage 디렉토리에 저장하기로 합니다.
				// 자바 코드로 storage 디렉토리를 만들기 때문에 미리 만들어 둘 필요가 없습니다.
				String realPath = multipartRequest.getServletContext().getRealPath("resources/storage");

				// 업로드 할 경로가 없으면 storage 디렉토리를 만듭니다.
				File dir = new File(realPath);
				if (!dir.exists()) {
					dir.mkdirs();
				}

				// 이제 업로드 할 파일명(uploadFilename)과 경로(realPath)를 모두 알고 있습니다.
				File uploadFile = new File(realPath, uploadFilename);

				// 첨부한 파일(MultipartFile file) -> 업로드 (uploadFile) 합니다.
				try {
					file.transferTo(uploadFile);
				} catch (Exception e) {
					e.printStackTrace();
				}

				count++;
				if (count < files.size()) {
					uploadFileNames += uploadFilename + "^";
				}
				if (count >= files.size()) {
					uploadFileNames += uploadFilename;
				}
				// 테이블에 데이터를 저장합니다.

			}
		} // for (MultipartFile file : files) {
		System.out.println(q_title);
		System.out.println(q_p_no);
		System.out.println(q_content);
		System.out.println(q_m_no);
		System.out.println(q_pw);
		System.out.println(q_secret);
		System.out.println("up" + uploadFileNames);
		if (files != null && !files.isEmpty()) {
			if (q_pw != null && q_pw != "" && q_secret != null) {
				qnaDao.qnaInsert(q_m_no, q_p_no, q_title, q_content, q_pw, uploadFileNames, q_secret); // 첨부가 있는 경우
			} else {
				qnaDao.qnaInsert(q_m_no, q_p_no, q_title, q_content, "a", uploadFileNames, "n"); // 첨부가 있는 경우
			}
		} else {
			if (q_pw != null && q_pw != "" && q_secret != null) {
				qnaDao.qnaInsert(q_m_no, q_p_no, q_title, q_content, q_pw, "첨부없음", q_secret); // 첨부가 없는 경우
			} else {
				qnaDao.qnaInsert(q_m_no, q_p_no, q_title, q_content, "a", "첨부없음", "n"); // 첨부가 없는 경우
			}
		}

	}

}
