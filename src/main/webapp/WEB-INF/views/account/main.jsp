<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- 상단 메뉴 -->
	<jsp:include page="../navbar.jsp"/>
</head>
<style>
	.tabWrap { width: 900px; height: 500px; }
	.tab_Menu { margin: 0px; padding: 0px; list-style: none; }
	.tabMenu { width: 150px; margin: 0px; text-align: center; 
			   padding-top: 10px; padding-bottom: 10px; float: left; 
			   border: 1px solid gray; }
		.tabMenu a { color: #000000; font-weight: bold; text-decoration: none; }
	.current { background-color: #FFFFFF; 
			   border: 1px solid blue; border-bottom:hidden; }
	.tabPage { width: 900px; height: 470px; float: left; }
	.btn
	{
		width: 150px;
		height: 30px;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.0.min.js" ></script>

<script type="text/javascript">
	function tabSetting() {
		// 탭 컨텐츠 hide 후 현재 탭메뉴 페이지만 show
		$('.tabPage').hide();
		$($('.current').find('a').attr('href')).show();

		// Tab 메뉴 클릭 이벤트 생성
		$('li').click(function (event) {
			var tagName = event.target.tagName; // 현재 선택된 태그네임
			var selectedLiTag = (tagName.toString() == 'A') ? $(event.target).parent('li') : $(event.target); // A태그일 경우 상위 Li태그 선택, Li태그일 경우 그대로 태그 객체
			var currentLiTag = $('li[class~=current]'); // 현재 current 클래그를 가진 탭
			var isCurrent = false;  
			
			// 현재 클릭된 탭이 current를 가졌는지 확인
			isCurrent = $(selectedLiTag).hasClass('current');
			
			// current를 가지지 않았을 경우만 실행
			if (!isCurrent) {
				$($(currentLiTag).find('a').attr('href')).hide();
				$(currentLiTag).removeClass('current');

				$(selectedLiTag).addClass('current');
				$($(selectedLiTag).find('a').attr('href')).show();
			}

			return false;
		});
	}

	$(document).ready(function(){
		// 탭 초기화 및 설정
		tabSetting();

	});


	
</script>
<body>
<div align="center">
	<div class="tabWrap" style="margin:1%;" align="center">
		<ul class="tab_Menu">
			<li class="tabMenu">
				<a href="#tabContent01">관리자</a>
			</li>
			<li class="tabMenu">
				<a href="#tabContent02" >운전자</a>
			</li>
			<li class="tabMenu">
				<a href="#tabContent03" >차량</a>
			</li>
		</ul>
		<div class="tab_Content_Wrap">
			<!-- 관리자 -->
			<div id="tabContent01" class="tabPage" >
				<div  style="float:left; width:100%;" >
					<table id="jqGrid" style="width:100%">
						<thead>
							<tr>
								<th>선택</th>
								<th>아이디</th>
								<th>성명</th>
								<th>생년월일</th>
							</tr>
						</thead>
						<tbody>
	                   	<c:if test="${fn:length(adminList) gt 0 }">
	                   		<c:forEach var="data" items="${adminList}" varStatus="status">
	                    			<tr>
		                            <td align="center">
		                            	<input type="radio" name="rdo1" >
		                            </td>
	                            	<td class="idx" hidden="true">${adminTotalCnt - status.index}</td>
		                            <td class="userId">${data.adminId}</td>
		                            <td class="userName">${data.adminName }</td>
		                            <td class="userBirth">${data.birthDate }</td>
		                        </tr>
	                    		</c:forEach>
	                   	</c:if>
	                   	
	                   	<c:if test="${fn:length(adminList) le 0 }">
	                   		<tr>
	                   			<td colspan="4" style="text-align:center;">검색결과가 없습니다.</td>
	                   		</tr>
	                   	</c:if>
	                   </tbody>
	               </table>
	          </div>
              <!-- paging -->
				<div class="paging">
					<c:if test="${fn:length(adminList) gt 0 }">
						<c:if test="${adminPagingUtil.startPage ne 1}">
							<span class="btn prev"><a href="#none">이전</a></span>
						</c:if>
						<c:forEach var="pageNum" begin="${adminPagingUtil.startPage }" end="${adminPagingUtil.endPage }">
                        <c:choose>
                            <c:when test="${pageNum eq  adminPagingUtil.curPage}">
                            	<a href="/account?page=${pageNum}">${pageNum}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/account?page=${pageNum}">${pageNum}</a> 
                            </c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${adminPagingUtil.curPage ne adminPagingUtil.pageCnt && adminPagingUtil.pageCnt > 0}">
							<span class="btn next"><a href="/account?page=${pageNum}">다음</a></span>
						</c:if>
					</c:if>
				</div>
              <!-- // paging -->
			</div>
			
			<!-- 운전자 -->
			<div id="tabContent02" class="tabPage">
				<div>
					<table id="jqGrid" style="width:100%">
						<thead>
							<tr>
								<th>선택</th>
								<th>아이디</th>
								<th>성명</th>
								<th>생년월일</th>
							</tr>
						</thead>
						<tbody>
	                   	<c:if test="${fn:length(driverList) gt 0 }">
	                   		<c:forEach var="data" items="${driverList}" varStatus="status">
	                    			<tr>
		                            <td align="center"> 
		                            	<input type="radio" name="rdo2">
		                            </td>
	                            	<td class="idx" hidden="true">${driverTotalCnt - status.index}</td>
		                            <td class="userId">${data.driverId}</td>
		                            <td class="userName">${data.driverName }</td>
		                            <td class="userBirth">${data.birthDate }</td>
		                        </tr>
	                    		</c:forEach>
	                   	</c:if>
	                   	
	                   	<c:if test="${fn:length(driverList) le 0 }">
	                   		<tr>
	                   			<td colspan="4" style="text-align:center;">검색결과가 없습니다.</td>
	                   		</tr>
	                   	</c:if>
	                   </tbody>
	               </table>
               </div>
				<!-- paging -->
				<div class="paging">
					<c:if test="${fn:length(driverList) gt 0 }">
						<c:if test="${driverPagingUtil.startPage ne 1}">
							<span class="btn prev"><a href="#none">이전</a></span>
						</c:if>
						<c:forEach var="pageNum" begin="${driverPagingUtil.startPage }" end="${driverPagingUtil.endPage }">
                        <c:choose>
                            <c:when test="${pageNum eq  driverPagingUtil.curPage}">
                            	<a href="#" class="on">${pageNum}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="#">${pageNum}</a> 
                            </c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${driverPagingUtil.curPage ne driverPagingUtil.pageCnt && driverPagingUtil.pageCnt > 0}">
							<span class="btn next"><a href="#">다음</a></span>
						</c:if>
					</c:if>
				</div>
              <!-- // paging -->               
               
			</div>
			
			<!-- 차량 -->
			<div id="tabContent03" class="tabPage">
				<div>
					<table id="jqGrid" style="width:100%">
						<thead>
							<tr>
								<th>선택</th>
								<th>차량번호</th>
								<th>제조사</th>
								<th>세부모델</th>
								<th>연료</th>
							</tr>
						</thead>
						<tbody>
	                   	<c:if test="${fn:length(carList) gt 0 }">
	                   		<c:forEach var="data" items="${carList}" varStatus="status">
	                    			<tr>
		                            <td align="center">
		                            	<input type="radio" name="rdo3">
		                            </td>
	                            	<td class="idx" hidden="true">${carTotalCnt - status.index}</td>
		                            <td class="car">${data.carId}</td>
		                            <td class="brand">${data.brandName }</td>
		                            <td class="modelDtl">${data.modelDtlName }</td>
		                            <td class="fuel">${data.fuelName }</td>
		                        </tr>
	                    		</c:forEach>
	                   	</c:if>
	                   	
	                   	<c:if test="${fn:length(carList) le 0 }">
	                   		<tr>
	                   			<td colspan="4" style="text-align:center;">검색결과가 없습니다.</td>
	                   		</tr>
               			</c:if>
						</tbody>
              	</table>
              </div>
              <!-- paging -->
				<div class="paging">
					<c:if test="${fn:length(carList) gt 0 }">
						<c:if test="${carPagingUtil.startPage ne 1}">
							<span class="btn prev"><a href="#none">이전</a></span>
						</c:if>
						<c:forEach var="pageNum" begin="${carPagingUtil.startPage }" end="${carPagingUtil.endPage }">
                        <c:choose>
                            <c:when test="${pageNum eq  carPagingUtil.curPage}">
                            	<a href="#" class="on">${pageNum}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="#">${pageNum}</a> 
                            </c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${carPagingUtil.curPage ne carPagingUtil.pageCnt && carPagingUtil.pageCnt > 0}">
							<span class="btn next"><a href="#">다음</a></span>
						</c:if>
					</c:if>
				</div>
              <!-- // paging --> 
			</div>
		</div>
	</div>
	<div>
		<input type="button" class="btn" value="관리자 신규 등록">
		<input type="button" class="btn" value="운전자 신규 등록">
		<input type="button" class="btn" value="차량 신규 등록">
		<input type="button" class="btn" value="수 정">
		<input type="button" class="btn" value="계정삭제">
	</div>
</div>
</body>
</html>
