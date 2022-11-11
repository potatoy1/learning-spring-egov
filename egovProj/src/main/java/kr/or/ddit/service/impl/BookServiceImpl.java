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
}
