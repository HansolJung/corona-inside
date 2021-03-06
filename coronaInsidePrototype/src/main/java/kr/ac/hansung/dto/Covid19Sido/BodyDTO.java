package kr.ac.hansung.dto.Covid19Sido;

import java.util.List;


public class BodyDTO {
	
	
	private String pageNo;

    private String totalCount;

    private ItemsDTO items;

    private String numOfRows;
	
	public BodyDTO() {
		super();
	}

	public BodyDTO(BodyDTO dto) {
		super();
		this.pageNo = dto.pageNo;
		this.totalCount = dto.totalCount;
		this.items = dto.items;
		this.numOfRows = dto.numOfRows;
	}

	public String getPageNo() {
		return pageNo;
	}

	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public ItemsDTO getItems() {
		return items;
	}

	public void setItems(ItemsDTO items) {
		this.items = items;
	}

	public String getNumOfRows() {
		return numOfRows;
	}

	public void setNumOfRows(String numOfRows) {
		this.numOfRows = numOfRows;
	}

	@Override
	public String toString() {
		return "BodyDTO [pageNo=" + pageNo + ", totalCount=" + totalCount + ", items=" + items + ", numOfRows="
				+ numOfRows + "]";
	}

	
}
