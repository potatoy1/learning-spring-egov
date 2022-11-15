package kr.or.ddit.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.GalleryService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/gallery")
@Controller
public class GalleryController {
	
	@Autowired
	GalleryService galleryService; 
	
	//이미지목록
	//요청URI : /gallery/list
	//요청파라미터 : ?bookId=3
	@GetMapping("/list")
	public String list(Model model,@ModelAttribute BookVO bookVO) {
		bookVO  = this.galleryService.list(bookVO);
		log.info("bookVO : " + bookVO);
		
		
		//공통 약속
		model.addAttribute("bodyTitle", "이미지 목록");
		model.addAttribute("bookVO", bookVO);
		
		//forwarding
		return "gallery/list";
	}
	
	//요청URI : /gallery/bookList
	//방식 : get
	//도서 목록 가져와서 select에 추가하기
	//json 데이터로 리턴
	@ResponseBody
	@GetMapping("/bookList")
	public List<BookVO> bookList() {
		List<BookVO> bookVOList = this.galleryService.bookList();
		log.info("bookVOList: " + bookVOList);
		
		return bookVOList;
	}
}
