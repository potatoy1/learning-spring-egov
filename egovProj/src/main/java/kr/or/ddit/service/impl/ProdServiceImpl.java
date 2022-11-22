package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ProdMapper;
import kr.or.ddit.service.ProdService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProdServiceImpl implements ProdService{

	@Autowired
	ProdMapper prodMapper;
	
	//상품 별 판매금액 조회
	@Override
	public JSONObject amtSale() {
		List<Map<String,Object>> list = this.prodMapper.amtSale();
		
//		log.info("list: " + list.get(0).toString());
		for(int i=0;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			log.info(map.toString());
		}
		
		//JSONObject를 만들어보자
		JSONObject data = new JSONObject();
		
		//1. cols 배열에 넣기
		//JSON 컬럼객체
		JSONObject col1 = new JSONObject(); //상품명(속성명)
		JSONObject col2 = new JSONObject(); //금액(속성명)
		
		JSONArray title = new JSONArray();
		col1.put("label", "상품명");
		col1.put("type", "string");
		col2.put("label", "금액");
		col2.put("type", "number");
		title.add(col1);
		title.add(col2);
		
		data.put("cols", title);
		
		//2.rows에 넣기
		JSONArray body = new JSONArray();
		for(Map<String,Object> map : list) {
			JSONObject prodName = new JSONObject();
			prodName.put("v", map.get("PRODNAME"));//상품명
			
			JSONObject money = new JSONObject();
			money.put("v", map.get("MONEY"));//금액
			
			JSONArray row = new JSONArray();
			row.add(prodName);
			row.add(money);
			
			JSONObject cell = new JSONObject();
			cell.put("c", row);
			
			body.add(cell);//레코드 1행 추가
		}
		
		data.put("rows",body);
		
		return data;
	}
}
