package com.FGroup.ShoppingMall.command.notice;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.FGroup.ShoppingMall.dao.NoticeDao;

public class NoticeUpdateCommand implements NoticeCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) map.get("multipartRequest");
		RedirectAttributes rttr = (RedirectAttributes) map.get("rttr");

		String n_title = multipartRequest.getParameter("n_title");
		String n_content = multipartRequest.getParameter("n_content");
		int n_no = Integer.parseInt(multipartRequest.getParameter("n_no"));
		String n_filename = multipartRequest.getParameter("n_filename2");
		int page = Integer.parseInt(multipartRequest.getParameter("page"));
		System.out.println(page);
		n_content = n_content.replace(">", "sqxdr");
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		// 새로 첨부하려는 파일
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
				File newFile = new File(realPath, uploadFilename);

				// 기존 첨부되어 있는 파일
				// 첨부한 파일(MultipartFile file) -> 업로드 (uploadFile) 합니다.
				if (newFile != null && n_filename != null) {
					File oldFile = new File(realPath, n_filename);
					if (oldFile.exists()) {
						oldFile.delete();
					}
				}
				try {
					file.transferTo(newFile);
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

			}

			else {

				int updateResult = noticeDao.noticeUpdate(n_title, n_content, n_no, n_filename); // 새 첨부가 없는 경우
				rttr.addFlashAttribute("updateResult", updateResult);
				rttr.addFlashAttribute("page", page);
				rttr.addFlashAttribute("afterUpdate", true);

			}
		}
		if (files != null && !files.isEmpty()) {
			int updateResult = noticeDao.noticeUpdate(n_title, n_content, n_no, uploadFileNames);
			rttr.addFlashAttribute("updateResult", updateResult);
			rttr.addFlashAttribute("page", page);
			rttr.addFlashAttribute("afterUpdate", true);
		}

	}

}
