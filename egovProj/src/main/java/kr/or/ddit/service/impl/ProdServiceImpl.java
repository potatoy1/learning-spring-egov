package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import kr.or.ddit.mapper.ProdMapper;
import kr.or.ddit.service.ProdService;

public class ProdServiceImpl implements ProdService{

	@Autowired
	ProdMapper prodMapper;
	
	//상품 별 판매금액 조회
	public List<Map<String,Object>> amtSale() {
		return this.prodMapper.amtSale();
	}
}
