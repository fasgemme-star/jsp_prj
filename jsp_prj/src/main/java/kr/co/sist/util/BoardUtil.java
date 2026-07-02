package kr.co.sist.util;

public class BoardUtil {

	private BoardUtil() {

	}

	/**
	 * 
	 * pagination을 생성
	 * @param currentPage: 현재 페이지
	 * @param totalPage: 총 페이지수 
	 * @param url: 이동할 url
	 * @param fieldNum: 검색 필드명(0: title, 1:content, 2:id)
	 * @param keyword: 검색어
	 * @return
	 */
	public static String pagination(int currentPage, int totalPage, String url, String fieldNum, String keyword) {
		
		
		// 1.한 화면에 보여줄 pagination의 수
		int pageNum = 3;

		// 2.한 화면에 보여줄 시작 pagination의 번호
		int startPage = ((currentPage - 1) / pageNum) * pageNum + 1;

		// 3.한 화면에 보여줄 마지막 pagination의 번호
		// int endPage = (((startPage-1) + pageNum)/pageNum)*pageNum;
		int endPage = (startPage - 1) + pageNum;

		// 4.총 페이지 수가 연산된 마지막 페이지 수보다 작다면, 총 페이지 수가 마지막 페이지 수로 설정되어야 한다
		if (totalPage <= endPage) {
			endPage = totalPage;
		}
		StringBuilder pagination = new StringBuilder();
		pagination.append("<ul class='pagination justify-content-center'>");
		// 5.이전 페이지로 가기위한 <<
		StringBuilder prevMark = new StringBuilder();
		prevMark.append("<li class='page-item page-link'>Previous</li>");
		int movePage = 0;
		if (currentPage > pageNum) {
			movePage = startPage - 1;
			prevMark.delete(0, prevMark.length());
			prevMark.append("<li class='page-item'><a class='page-link' href='").append(url)
					.append("?currentPage=").append(movePage);

			if (keyword != null && !keyword.isEmpty()) {
				prevMark.append("&fieldNum=").append(fieldNum).append("&keyword=").append(keyword);
			} // end if

			prevMark.append("'>Previous</a></li>");

		}
		pagination.append(prevMark.toString());
		// 6.시작페이지부터 끝페이지까지 화면에 출력
		movePage = startPage;
		StringBuilder pageLink = new StringBuilder();

		while (movePage <= endPage) {
			if (movePage == currentPage) {
				pageLink.append("<li class='page-item'><span class='page-link active'>").append(movePage)
						.append("</span></li>");
			} else {
				pageLink.append("<li class='page-item'><a class='page-link' href='").append(url)
						.append("?currentPage=").append(movePage);
				if (keyword != null && !keyword.isEmpty()) {
					pageLink.append("&fieldNum=").append(fieldNum).append("&keyword=")
							.append(keyword);
				} // end if
				pageLink.append("'>").append(movePage).append("</a></li>");
			} // end if
			movePage++;
		} // end while

		if (pageLink.toString().isEmpty()) {
			pageLink.append("<li class='page-item'><span class='page-link'>1</span></li>");
		}
		pagination.append(pageLink.toString());

		// 7. 다음 페이지가 있는 경우 이동을 위한 >>
		StringBuilder nextMark = new StringBuilder("<li class='page-item page-link'>Next</li>");
		if (totalPage > endPage) {
			movePage = endPage + 1;
			nextMark.delete(0, nextMark.length());
			nextMark.append("<li class='page-item'><a class='page-link' href='").append(url)
					.append("?currentPage=").append(movePage);
			if (keyword != null && !keyword.isEmpty()) {
				nextMark.append("&fieldNum=").append(fieldNum).append("&keyword=").append(keyword);
			} // end if
			nextMark.append("'>Next</a></li></ul>");
		}

		pagination.append(nextMark.toString());
		return pagination.toString();
	}
}
