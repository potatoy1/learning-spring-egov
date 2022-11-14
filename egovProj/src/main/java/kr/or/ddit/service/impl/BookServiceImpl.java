package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BookMapper;
import kr.or.ddit.service.BookServiece;
import kr.or.ddit.vo.BookVO;

@Service
public class BookServiceImpl implements BookServiece{

	@Autowired
	BookMapper bookMapper;

	//도서 목록
	@Override
	public List<BookVO> list() {
		return	this.bookMapper.list();
	}
	
	//상세 보기
	@Override
	public BookVO detail(int bookId){
		return this.bookMapper.detail(bookId);
	}
	
	//도서 수정
	@Override
	public int updatePost(BookVO bookVO) {
		return this.bookMapper.updatePost(bookVO);
	}
	
	//도서 등록
	@Override
	public int insertPost(BookVO bookVO) {
		return this.bookMapper.insertPost(bookVO);
	}
}
