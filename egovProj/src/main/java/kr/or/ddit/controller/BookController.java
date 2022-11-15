package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.BookService;
import kr.or.ddit.vo.BookVO;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@RequestMapping("/book")
@Controller
public class BookController {

	@Autowired
	BookService bookService;
	
	@GetMapping("/list")
	public String list(Model model) {
		
		List<BookVO> bookVOList  = this.bookService.list();
		log.info("bookVOList : " + bookVOList);
		
		//공통 약속
		model.addAttribute("bodyTitle", "도서 목록");
		model.addAttribute("bookVOList", bookVOList);
		
		//forwarding
		return "book/list";
	}
	
	//도서 상세
	//요청URI : /book/detail?bookId=3
	//요청파라미터 : bookId=3
	//메소드 이름 : detail
	//목록에서 title을 클릭 시 상세페이지로 이동
	//1) 스프링에서 요청파라미터를 매개변수로 받을 수 있다.
	//   요청파라미터는 String타입. int형 매개변수로도 받을 수 있음(자동 형변환 가능)
	// 	  매개변수 : String bookId/ int bookId
	//2) Map<String,String> / Map<String,Object> 가능
	//3) 골뱅이ModelAttribute BookVO bookVO
	//4) 골뱅이RequestParam Map<String, Object>
	@GetMapping("/detail")
	public String detail(int bookId, Model model) {
		log.info("bookId: " + bookId);

		//책 상세보기 데이터 가져옴
		BookVO bookVO = this.bookService.detail(bookId);
		log.info("bookVO: " + bookVO);
		
		//공통 약속
		model.addAttribute("bodyTitle", "도서 상세");
		model.addAttribute("bookVO", bookVO);
		
		//forwarding
		return "book/write";
	}
	
	//요청 URI : /book/updatePost
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute BookVO bookVO) {
		log.info("bookVO : " + bookVO.toString());

		int result = this.bookService.updatePost(bookVO);
		log.info("result :"  + result);
		
		return "redirect:/book/detail?bookId="+bookVO.getBookId();
	}
	
	
	@GetMapping("/insert")
	public String insert(Model model) {
		//공통 약속
		model.addAttribute("bodyTitle", "도서 상세");
		//forwarding
		return "book/insert";
	}
	
	
	@PostMapping("/insert")
	public String insertPost(@ModelAttribute BookVO bookVO) {
		log.info("bookVO : " + bookVO.toString());
		
		int result = this.bookService.insertPost(bookVO);
		log.info("result :"  + result);
		
		//bookVO.getBookId()는 매퍼xml의 selectKey를 통해 채워질 것임
		return "redirect:/book/detail?bookId="+bookVO.getBookId();
	}
}
