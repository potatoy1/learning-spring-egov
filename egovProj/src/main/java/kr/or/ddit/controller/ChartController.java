package kr.or.ddit.controller;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ProdService;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/chart")
@Slf4j
@Controller
public class ChartController {
	
	@Autowired
	ProdService prodService;

	//요청URI : /chart/chart01
	//json 구글차트
	@GetMapping("/chart01")
	public String chart01() {
		//forwarding
		return"chart/chart01";
	}
	
	//요청URI : /chart/chart01Multi
	//json 구글 멀티 차트
	@GetMapping("/chart01Multi")
	public String chart01Multi() {
		//forwarding
		return"chart/chart01Multi";
	}
	
	//요청URI : /chart/chart02
	//oracle 구글차트
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping("/chart02")
	public JSONObject amtSale() {
		JSONObject jsonObject = this.prodService.amtSale();
		//forwarding
		return jsonObject;
	}
	/*
	 1. hasRole([role]) : 현재 사용자의 권한이 파라미터의 권한과 동일한 경우 true
	 2. hasAnyRole([role1,role2]): 현재 사용자의 구너한이 파라미터의 권한 중 일치하는 것이 있는 경우 true
	 3. principal : 사용자를 증명하는 주요객첵(User)를 직접 접근
	 4. authentication : SecurityContext에 있는 authentication 객체에 접근 가능
	 5. permitAll : 모든 접근 허용
	 6. denyAll : 모든 접근 비허용
	 7. isAnonymous() : 현재 사용자가 익명(비로그인)인 상태의 경우 true
	 8. isremeberMe() : 현재 사용자가 RememberMe 사용자라면 true
	 9. isAuthenticated() : 현재 사용자가 익명이 아니라면(로그인 상태라면) true
	 10. isFullAuthenticated() :  현재 사용자가 익명이거나 RememberMe 사용자가 아니라면 true
	 */
	//요청URI : /chart/chart03()
	@PreAuthorize("permitAll")
	@GetMapping("/chart03")
	public String chart03(HttpServletRequest request) {
		//spring 파일의 절대경로 가져오기
		// /resources/upload 윈도우 절대경로
		
		String absolutePath = request.getRealPath(request.getContextPath());
//		String absolutePath = request.getSession().getServletContext().getRealPath("/");
		log.info("absolutePath: " + absolutePath);
		
		String uploadPath = absolutePath + "\\resources\\upload";
		
		log.info("uploadPath : " + uploadPath);
		
		//forwarding
		return "chart/chart03";
	}
	
	@PreAuthorize("permitAll")
	@GetMapping("/chart04")
	public String chart04(HttpServletRequest request) {
		
		//forwarding
		return "chart/chart04";
	}
}
