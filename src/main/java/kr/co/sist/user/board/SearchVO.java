package kr.co.sist.user.board;

/**
 * 현재페이지, 시작번호, 끝 번호, 검색컬럼, 검색값, 검색URL
 */
public class SearchVO {
	private int startNum,endNum,currentPage,totalpage,totalCount; //검색 시작번호, 끝번호, 현재페이지번호, 총 페이지 수, 총 게시물의 수
	private String field="0", keyword,url;//검색할 field의 대응되는 숫자, 검색 값, 이동할 url 
	//필드는 기본이 0, 키워드 받기

	public int getStartNum() {
		return startNum;
	}

	public String getUrl() {
		return url;
	}



	public int getTotalpage() {
		return totalpage;
	}

	public void setTotalpage(int totalpage) {
		this.totalpage = totalpage;
	}

	public void setUrl(String url) {
		this.url = url;
	}



	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	@Override
	public String toString() {
		return "SearchVO [startNum=" + startNum + ", endNum=" + endNum + ", currentPage=" + currentPage + ", totalpage="
				+ totalpage + ", totalCount=" + totalCount + ", field=" + field + ", keyword=" + keyword + ", url="
				+ url + "]";
	}



	
}
