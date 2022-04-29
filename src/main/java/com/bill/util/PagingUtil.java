package com.bill.util;

public class PagingUtil {
	
    private int pageSize = 5;
    private int rangeSize = 5;
    private int curPage = 1;
    private int curRange = 1;
    private int listCnt;
    private int pageCnt;
    private int rangeCnt;
    private int startPage = 1;
    private int endPage = 1;
    private int startIndex = 0;
    private int prevPage;
    private int nextPage;
	
    public PagingUtil(int listCnt, int curPage){
        
        // 총 게시물 수와 현재 페이지를 Controller로 부터 받아온다.
        setCurPage(curPage);
        setListCnt(listCnt);
        setPageCnt(listCnt);
        setRangeCnt(pageCnt);
        rangeSetting(curPage);
        setStartIndex(curPage);
    }
    
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getRangeSize() {
		return rangeSize;
	}
	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getListCnt() {
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getPrevPage() {
		return prevPage;
	}
	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	public int getCurRange() {
		return curRange;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public int getRangeCnt() {
		return rangeCnt;
	}
	public int getStartIndex() {
		return startIndex;
	}
	public void setPageCnt(int listCnt) {
        this.pageCnt = (int) Math.ceil(listCnt*1.0/pageSize);
    }
    public void setRangeCnt(int pageCnt) {
        this.rangeCnt = (int) Math.ceil(pageCnt*1.0/rangeSize);
    }
    public void rangeSetting(int curPage){
        
        setCurRange(curPage);        
        this.startPage = (curRange - 1) * rangeSize + 1;
        this.endPage = startPage + rangeSize - 1;
        
        if(endPage > pageCnt){
            this.endPage = pageCnt;
        }
        
        this.prevPage = curPage - 1;
        this.nextPage = curPage + 1;
    }
    public void setCurRange(int curPage) {
        this.curRange = (int)((curPage-1)/rangeSize) + 1;
    }
    public void setStartIndex(int curPage) {
        this.startIndex = (curPage-1) * pageSize;
    }
}
