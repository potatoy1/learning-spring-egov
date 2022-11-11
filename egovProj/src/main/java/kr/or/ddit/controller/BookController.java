package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.BookServiece;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/book")
@Controller
public class BookController {

	@Autowired
	BookServiece bookServiece;
	
	@GetMapping("/list")
	public String list(Model model) {
		
		List<BookVO> bookVOList  = this.bookServiece.list();
		log.info("bookVOList : " + bookVOList);
		
		//공통 약속
		model.addAttribute("bodyTitle", "도서 목록");
		model.addAttribute("bookVOList", bookVOList);
		
		//forwarding
		return "book/list";
	}
}
