package kr.co.sist.util;

import kr.co.sist.user.board.SearchVO;

public class BoardUtil {

	private static String[] columnName = { "subject", "content", "writer" };

	public static String numToField(String fieldNum) {
		return columnName[Integer.parseInt(fieldNum)];
	}

	/**
	 * 페이지네이션을 사용하면 매개변수로 입력객체되는 객체의 currentPage번호totalPage수, totalCount수 검색을 수행하면
	 * field의 값, keyword,url이 반드시 입력되어야 한다.
	 * 
	 * @param sVO
	 * @return
	 */
	public String pagination(SearchVO sVO) {// 현재 페이지에 따라 다르게

		StringBuilder pagination = new StringBuilder();

		if (sVO.getTotalCount() != 0)
			;
		{
			// 1. 한 화면에 보여줄 인덱스의 수 [1][2][3]
			int pageNumber = 3;
			// 2. 화면에 보여줄 시작페이지 번호(1,2,3이면 1시작 4,5,6이면 4시작 7,8,9이면 7시작)
			int startPage = ((sVO.getCurrentPage() - 1) / pageNumber) * pageNumber + 1;
			// 3. 화면에 보여줄 마지막 페이지 번호
			int endPage = startPage + pageNumber - 1;
			// 4. 총 페이지 수가 연산된마지막 페이지 수보다 작다면 총 페이지수가 마지막 페이지수로 설정된다.
			if (sVO.getTotalpage() <= endPage) {
				endPage = sVO.getTotalpage();
			}

			// 5. 첫 페이지가 인덱스 화면이 아닌 경우 (3보다 큰 경우)

			int movePage = 0;
			StringBuilder prevMark = new StringBuilder();
			prevMark.append("[	&lt;&lt;	]");

			if (sVO.getCurrentPage() > pageNumber) {// 현재페이지가 pagination의 수보다 크면
				prevMark.delete(0, prevMark.length());
				// 이전으로 가서 링크를 만들어준다.
				movePage = startPage - 1; // 4,5,6 -> 1 7,8,9->4
				prevMark.append("[<a href=\"").append(sVO.getUrl()).append("?currentPage=").append(movePage);
				// 검색 키워드가 존재할 때
				if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
					prevMark.append("&field=").append(sVO.getField()).append("&keyword=").append(sVO.getKeyword());

				} // end if

				prevMark.append("\">&lt;&lt;</a> ]");

			} // end if
			prevMark.append(" ... ");

			pagination.append(prevMark);

			movePage = startPage;

			StringBuilder pageLink = new StringBuilder();

			while (movePage <= endPage) {

				if (movePage == sVO.getCurrentPage()) {
					pageLink.append("[ ").append(movePage).append(" ]");
					// 현재 페이지는 링크를 설정하지 않는다. -> if else문으로
				} else {
					pageLink.append("[ <a href='").append(sVO.getUrl()).append("jsp?currentPage=").append(movePage);

					// 검색 키워드가 존재할 때
					if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
						prevMark.append("&field=").append(sVO.getField()).append("&keyword=").append(sVO.getKeyword());

					} // end if

					pageLink.append("'>").append(movePage).append("</a> ]");

				} // end if

				movePage++;

			} // end while

			pagination.append(pageLink);
			pagination.append(" ... ");

			// 7. 뒤에 페이지가 더 있는 경우
			StringBuilder nextMark = new StringBuilder();
			nextMark.append("[	&gt;&gt; ]");

			if (sVO.getTotalpage() > endPage) {
				nextMark.delete(0, nextMark.length());
				movePage = endPage + 1;

				nextMark.append("[ <a href ='").append(sVO.getUrl()).append("?currentPage=").append(movePage);

				// 검색 키워드가 존재할 때
				if (sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
					nextMark.append("&field=").append(sVO.getField()).append("&keyword=").append(sVO.getKeyword());

				} // end if

				nextMark.append("'> &gt;&gt;</a> ]");

			}

			pagination.append(nextMark);

			return pagination.toString(); // 무한 재귀 호출 -> StackOverflow
		}

	}

} // class
