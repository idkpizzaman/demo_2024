<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${boardName } 게시판" />

<%@ include file="../../common/head.jsp" %>
    <section class="my-8 text-lg">
        <div class="container mx-auto px-3">
            <div class="mb-2 ml-3 text-sm">
                <div><span>총 : ${articlesCnt }개</span></div>
            </div>
            <div class="table-box-type">
                <table>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="article" items="${articles }">
                            <tr>
                                <td>${article.id }</td>
                                <td class="hover:underline"><a href="detail?id=${article.id }">${article.title }</a></td>
                                <td>${article.writerName }</td>
                                <td>${article.updateDate.substring(2, 16) }</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
          
            <br />
            
            <c:if test="${rq.getLoginedMemberId() != 0 }">
                <div class="flex justify-end mt-2 mr-3">
                    <a class="btn btn-active" href="write">글쓰기</a>
                </div>
            </c:if>
            
            <div class="flex justify-center mt-3">
                <div class="join">
                
                    <c:if test="${from != 1 }">
                        <a class="join-item btn btn-sm" href="?boardId=${param.boardId }&cPage=1"><i class="fa-solid fa-angles-left"></i></a>
                        <a class="join-item btn btn-sm" href="?boardId=${param.boardId }&cPage=${from - 1 }"><i class="fa-solid fa-caret-left"></i></a>
                    </c:if>
                
                    <c:forEach begin="${from }" end="${end }" var="i">
                        <a class="join-item btn btn-sm ${cPage == i ? 'btn-active' : '' }" href="?boardId=${param.boardId }&cPage=${i }">${i }</a>
                    </c:forEach>
                    
                    <c:if test="${end != totalPageCnt }">
                        <a class="join-item btn btn-sm" href="?boardId=${param.boardId }&cPage=${end + 1 }"><i class="fa-solid fa-angles-right"></i></a>
                        <a class="join-item btn btn-sm" href="?boardId=${param.boardId }&cPage=${totalPageCnt }"><i class="fa-solid fa-caret-right"></i></a>
                    </c:if>
                    
                </div>
            </div>
            
        </div>
    </section>
<%@ include file="../../common/foot.jsp" %>