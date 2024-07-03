<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="&nbsp;&nbsp;&nbsp;&nbsp;${article.id }번 글" />

<%@ include file="../../common/head.jsp" %>

    <script>
        $(document).ready(function(){
            getLikePoint();
            
            $('#likePointBtn').click(async function(){
                
            	let liked = $('i.fa-heart').hasClass('fa-solid');
                try{
                    await $.ajax({
                        url : '../likePoint/doLikePoint',
                        type : 'GET',
                        data : {
                            relTypeCode : 'article',
                            relId : ${article.id },
                            liked : liked
                        },
                    })
                    
                    let totalCnt = await getLikePoint();
                    
                    $('#likePointCnt').html(totalCnt.data);
                } catch (error) {
                    console.log('Error : ', error);
                }
            })
        })
        
        const getLikePoint = async function(){
        	let likePointBtn = $('#likePointBtn');
            return $.ajax({
                url : '../likePoint/getLikePoint',
                type : 'GET',
                data : {
                    relTypeCode : 'article',
                    relId : ${article.id }
                },
                dataType : 'json',
                success : function(data) {
                    if (data.success) {
                        $likePointBtn.html(`
                            <i class="fa-solid fa-heart"></i>
                            <span id="likePointCnt">${article.likePoint }</span>
                        `);
                    } else {
                    	likePointBtn.html(`
                            <i class="fa-regular fa-heart"></i>
                            <span id="likePointCnt">${article.likePoint }</span>
                        `);
                    }
                },
                error : function(xhr, status, error) {
                    console.log(error);
                }
            })
        }
    </script>

    <section class="mt-8 text-lg">
        <div class="container mx-auto px-3 pb-8 border-bottom-line">
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
                    <tr>
                        <th>추천수</th>
                        <td>
                            <c:if test="${rq.getLoginedMemberId() == 0 }">
                                <span>${article.likePoint } 개</span>
                            </c:if>
                            <c:if test="${rq.getLoginedMemberId() != 0 }">
                                <button id="likePointBtn" class="btn btn-sm btn-outline">
                                  좋아요
                                  <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    class="h-6 w-6"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke="currentColor">
                                    <path
                                      stroke-linecap="round"
                                      stroke-linejoin="round"
                                      stroke-width="2"
                                      d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                                  </svg>
                                </button>
                                &nbsp;&nbsp;
                                <span id="likePointCnt">${article.likePoint } 개</span>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div class="mt-3">
                <button class="btn btn-active btn-sm" onclick="history.back();">뒤로가기</button>
                <c:if test="${rq.getLoginedMemberId() == article.memberId }">
                    <a class="btn btn-active btn-sm" href="modify?id=${article.id }">수정</a>
                    <a class="btn btn-active btn-sm" href="doDelete?id=${article.id }" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
                </c:if>
            </div>
            <button class=" mt-3 btn btn-active" id="likePointBtn">👍 좋아요 👍</button>
        </div>
    </section>
    <script>
        const replyForm_onSubmit = function(form){
            form.body.value = form.body.value.trim();
            
            if (form.body.value.length == 0) {
                alert('비어있는 댓글은 작성할 수 없습니다');
                form.body.focus();
                return;
            }
            
            form.submit();
        }
    </script>

    <section class="my-5 text-base">
        <div class="container mx-auto px-3">
            <div class="text-lg">댓글</div>

            <form action="../reply/doWrite" method="post" onsubmit="replyForm_onSubmit(this); return false;">
                <input type="hidden" name="relTypeCode" value="article"/>
                <input type="hidden" name="relId" value="${article.id }"/>
                <div class="mt-4 reply-border p-4">
                    <div class="mb-2"><span>닉네임</span></div>
                    <textarea class="textarea textarea-bordered textarea-lg w-full" name="body" placeholder="댓글을 입력해보세요"></textarea>
                    <div class="flex justify-end"><button class="btn btn-active btn-sm">작성</button></div>
                </div>
            </form>
        </div>
    </section>
<%@ include file="../../common/foot.jsp" %>