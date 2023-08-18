<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>   
.quickmenu{
      
   position: fixed;
   top: 50;
   right: 0;
    
    }   
</style>

<div align="right">
 <div style="opacity:0.7;" class="quickmenu"><img src="/img/logo/qnaboard.png"></div>
</div>
<script>
$(document).ready(function(){
  var currentPosition = parseInt($(".quickmenu").css("top"));
  $(window).scroll(function() {
    var position = $(window).scrollTop(); 
    $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
  });
});
</script>   
<h2>
   <spring:message code="reference.header.list" />
</h2>



<table border="1">
   <tr>
      <th align="center" width="80"><spring:message code="reference.no" />
      </th>

      <th align="center" width="320"><spring:message
            code="reference.title" /></th>

      <th align="center" width="100"><spring:message
            code="reference.writer" /></th>

      <th align="center" width="180"><spring:message
            code="reference.date" /></th>
   </tr>
   <c:choose>
      <c:when test="${empty list}">
         <tr>
            <td colspan="4">게시물이 없습니다.</td>
         </tr>
      </c:when>
      <c:otherwise>
         <c:forEach items="${list}" var="reference">
  <tr>
    <td align="center">
      <c:choose>
        <c:when test="${empty reference.no}"><b>ㄴ</b></c:when>
        <c:otherwise>${reference.no}</c:otherwise>
      </c:choose>
    </td>

    <td align="left">
      <a href="/client/reference/referenceDetail${pagination.makeQuery(pagination.pageRequest.page)}&referenceNo=${reference.referenceNo}">
        ${reference.referenceTitle}
      </a>
    </td>

    <td align="center">
      <c:choose>
        <c:when test="${empty reference.no}">
          <b>관리자</b>
        </c:when>
        <c:otherwise>
          ${reference.userName}
        </c:otherwise>
      </c:choose>
    </td>

    <td align="center">
      <fmt:formatDate pattern="yyyy-MM-dd HH:mm"
                      value="${reference.referenceDate}" />
    </td>
  </tr>
</c:forEach>
      </c:otherwise>
   </c:choose>
</table>
<!-- 페이징 네비게이션 -->
<div>
   <c:if test="${pagination.prev}">
      <a href="${pagination.makeQuery(pagination.endPage - 1)}">&laquo;</a>
   </c:if>
   <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}"
      var="idx">
      <a href="/client/reference/referenceList${pagination.makeQuery(idx)}">${idx}</a>
   </c:forEach>
   <c:if test="${pagination.next && pagination.endPage > 0}">
      <a href="${pagination.makeQuery(pagination.endPage +1)}">&raquo;</a>
   </c:if>
</div>

<div>
   <button type="button" id="btnWrite">
      <spring:message code="action.new" />
   </button>
</div>


<script>
   var result = "${msg}";
   if (result === "SUCCESS") {
      alert("글 등록 성공");
   }
</script>
<script>
   $(document).ready(function() {
      $("#btnWrite").on("click", function(event) {
         $.ajax({
            url : "/client/reference/checkReference",
            contentType : "application/json; charset=UTF-8",
            type : "get",
            success : function(data) {

               if (data == "SUCCESS") {
                  alert("글 쓰기 권한이 없습니다!!!");

               } else {
                  location.href = "/client/reference/referenceRegister";
               }
            }
         });
      });
   });
</script>
