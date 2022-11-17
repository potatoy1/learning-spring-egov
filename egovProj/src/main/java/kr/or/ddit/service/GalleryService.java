package kr.or.ddit.service;


import java.util.List;

import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.BookVO;

public interface GalleryService {

	//메서드 시그니처
	//한권의 책에 대한 여러 개의 이미지 목록
	public BookVO list(BookVO bookVO);

	//도서 목록 가져와서 select에 추가하기
	public List<BookVO> bookList();
	
	//변경된 사진 db에 반영
	public int updatePost(AttachVO attachVO);

	//이미지 삭제
	public int deletePost(AttachVO attachVO);
	
	//도서 검색
	public List<BookVO> searchBook(BookVO bookVO);
}
