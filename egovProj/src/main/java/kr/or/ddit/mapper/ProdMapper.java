package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

public interface ProdMapper {

	//상품 별 판매금액 조회
	public List<Map<String,Object>> amtSale();
}
  