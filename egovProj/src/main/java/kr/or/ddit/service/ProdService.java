package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

public interface ProdService {
	//상품 별 판매금액 조회
	public List<Map<String,Object>> amtSale();
}
