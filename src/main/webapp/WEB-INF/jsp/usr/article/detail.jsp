<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="&nbsp;&nbsp;&nbsp;&nbsp;${article.id }번 글" />

<%@ include file="../../common/head.jsp" %>
    <section class="mt-8 text-lg">
        <div class="container mx-auto px-3">
            <div class="table-box-type">
                <table class="table table-lg">
                    <tr>
                        <th>번호</th>
                        <td>${article.id }</td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td>${article.updateDate.substring(2, 16) }</td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>${article.writerName }</td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>${article.title }</td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>${article.body }</td>
                    </tr>
                    <tr>
                        <th>조회수</th>
                        <td>${article.views }</td>
                    </tr>
                </table>
            </div>
            
            <div class="mt-3 text-sm">
                <button class="btn btn-active btn-sm" onclick="history.back();">뒤로가기</button>
                <c:if test="${rq.getLoginedMemberId() == article.memberId }">
                    <a class="btn btn-active btn-sm" href="modify?id=${article.id }">수정</a>
                    <a class="btn btn-active btn-sm" href="doDelete?id=${article.id }" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
                </c:if>
            </div>
            <button class=" mt-3 btn btn-active" onclick="">👍 좋아요 👍</button>
        </div>
    </section>
<%@ include file="../../common/foot.jsp" %>