package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.BookVO;

public interface BookServiece {

	//메서드 시그니처
	//도서 목록
	public List<BookVO> list();
}
