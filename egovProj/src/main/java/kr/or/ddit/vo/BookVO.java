package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

public class BookVO {
	private int bookId;
	private String title;
	private String category;
	//골뱅이NumberFormat(pattern="#,###")
	@NumberFormat(style= Style.NUMBER)
	private int price;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date insertDate;
	//책 내용(CLOB)
	private String content;
	//첨부파일 테이블(1:N관계)
	private List<AttachVO> attachVOList;
	
	public BookVO() {}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<AttachVO> getAttachVOList() {
		return attachVOList;
	}
	public void setAttachVOList(List<AttachVO> attachVOList) {
		this.attachVOList = attachVOList;
	}
	@Override
	public String toString() {
		return "BookVO [bookId=" + bookId + ", title=" + title + ", category=" + category + ", price=" + price
				+ ", insertDate=" + insertDate + ", content=" + content + ", attachVOList=" + attachVOList + "]";
	}
	
}
