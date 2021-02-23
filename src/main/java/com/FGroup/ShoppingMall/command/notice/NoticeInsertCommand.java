package com.FGroup.ShoppingMall.command.notice;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.FGroup.ShoppingMall.dao.NoticeDao;

public class NoticeInsertCommand implements NoticeCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) map.get("multipartRequest");

		// multipartRequest에 저장된 일반 파라미터는 getParameter()를 씁니다.
		// String m_name = request.getParameter("m_name");
		String n_title = multipartRequest.getParameter("n_title");
		String n_content = multipartRequest.getParameter("n_content");
		int n_m_no = (Integer.parseInt(multipartRequest.getParameter("n_m_no")));
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);

		n_content = n_content.replace(">", "sqxdr");

		List<MultipartFile> files = multipartRequest.getFiles("files");
		int count = 0;
		String uploadFileNames = "";

		// 첨부를 하나씩 꺼내기
		for (MultipartFile file : files) {
			// 꺼낸 첨부가 있는지 검사
			if (file != null && !file.isEmpty()) {
				// MultipartFile file에서 첨부하는 파일명을 알아냅니다.
				String originalFilename = file.getOriginalFilename();

				// 확장자
				String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
				// 파일명
				String filename = originalFilename.substring(0, originalFilename.lastIndexOf("."));

				// 파일명에 [ ] 가 포함되어있을시에 이를 제거해주는 부분입니다.
				filename = filename.replace("[", "");
				filename = filename.replace("]", "");

				// 업로드 할 파일명
				String uploadFilename = filename + "_" + System.currentTimeMillis() + "." + extension;
				// 업로드 파일명은 "파일명_파일만들어진시간.확장자"로 결정되게됩니다.

				// 파일이 저장될 경로는 "프로젝트의경로/resource/storage"가 되게됩니다.
				String realPath = multipartRequest.getServletContext().getRealPath("resources/storage");

				// 만약 업로드 경로에 폴더가 없다면 자동으로 해당폴더를 만들어줍니다.
				// 해당코드의경우 storage가 없다면 새로 생성됩니다.
				File dir = new File(realPath);
				if (!dir.exists()) {
					dir.mkdirs();
				}

				// 파일의 경로와 이름의 정보가 모두 있으므로 새파일로 만들어줍니다.
				File uploadFile = new File(realPath, uploadFilename);

				// 첨부한 파일(MultipartFile file) -> 업로드 (uploadFile) 합니다.
				try {
					file.transferTo(uploadFile);
				} catch (Exception e) {
					e.printStackTrace();
				}

				count++;
				// count는 파일갯수를 확인하는 역할로. 다중첨부시에 구분자(^)을 넣기위한 장치입니다.
				// uploadFileNames에 다중첨부된 모든 파일명들을 "^"로 구분하여 저장합니다.
				if (count < files.size()) {
					uploadFileNames += uploadFilename + "^";
				}
				if (count >= files.size()) {
					uploadFileNames += uploadFilename;
				}
				// 테이블에 데이터를 저장합니다.

			}
		} // for (MultipartFile file : files) {

		if (files != null && !files.isEmpty()) {
			noticeDao.noticeInsert(n_title, n_m_no, n_content, uploadFileNames); // 첨부가 있는 경우
		} else {

			noticeDao.noticeInsert(n_title, n_m_no, n_content, "첨부없음"); // 첨부가 없는 경우
		}

	}

}
