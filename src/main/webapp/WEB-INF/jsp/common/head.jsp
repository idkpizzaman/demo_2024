<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>
<!-- 데이지UI, 테일윈드 -->
<link
	href="https://cdn.jsdelivr.net/npm/daisyui@4.12.8/dist/full.min.css"
	rel="stylesheet" type="text/css" />
<script src="https://cdn.tailwindcss.com"></script>
<!-- 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
<!-- 제이쿼리 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 공통 css -->
<link rel="stylesheet" href="/resource/common.css" />
<script src="/resource/common.js" defer="defer"></script>
</head>
<body>
	<div class="h-20 mt-6 flex container mx-auto text-3xl">
		<div class="h-3">
			<a class="h-40 w-40 px-3 flex items-center" href="/">
			    <img
				src="https://cdn-icons-png.flaticon.com/256/4509/4509324.png"
				alt="로고" />
		    </a>
		</div>
		<div class="grow"></div>
		<ul class="flex mr-10">
			<li class="hover:underline"><a
				class="h-full px-3 flex items-center"
				href="/usr/article/list?boardId=1"><span>NOTICE</span></a></li>
			<li class="hover:underline"><a
				class="h-full px-3 flex items-center"
				href="/usr/article/list?boardId=2"><span>FREE</span></a></li>
			<c:if test='${rq.getLoginedMemberId() == 0 }'>
				<li class="hover:underline"><a
					class="h-full px-3 flex items-center" href="/usr/member/login"><span>LOGIN</span></a></li>
			</c:if>
			<c:if test='${rq.getLoginedMemberId() != 0 }'>
				<li class="hover:underline"><a
					class="h-full px-3 flex items-center" href="/usr/member/doLogout"><span>LOGOUT</span></a></li>
			</c:if>
			<div class="dropdown mb-72 mt-3">
				<div tabindex="0" role="button" class="btn m-1">
					Theme
					<svg width="12px" height="12px"
						class="inline-block h-2 w-2 fill-current opacity-60"
						xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2048 2048">
                        <path
							d="M1799 349l242 241-1017 1017L7 590l242-241 775 775 775-775z"></path>
                    </svg>
				</div>
				<ul tabindex="0"
					class="dropdown-content bg-base-300 rounded-box z-[1] w-52 p-2 shadow-2xl">
					<li><input type="radio" name="theme-dropdown"
						class="theme-controller btn btn-sm btn-block btn-ghost justify-start"
						aria-label="Default" value="default" /></li>
					<li><input type="radio" name="theme-dropdown"
						class="theme-controller btn btn-sm btn-block btn-ghost justify-start"
						aria-label="Retro" value="retro" /></li>
					<li><input type="radio" name="theme-dropdown"
						class="theme-controller btn btn-sm btn-block btn-ghost justify-start"
						aria-label="Cyberpunk" value="cyberpunk" /></li>
					<li><input type="radio" name="theme-dropdown"
						class="theme-controller btn btn-sm btn-block btn-ghost justify-start"
						aria-label="Valentine" value="valentine" /></li>
					<li><input type="radio" name="theme-dropdown"
						class="theme-controller btn btn-sm btn-block btn-ghost justify-start"
						aria-label="Aqua" value="aqua" /></li>
				</ul>
			</div>
		</ul>
	</div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<section class="my-3 text-2xl">
		<div class="container mx-auto px-3 ml-10">
			<div>${pageTitle }</div>
		</div>
	</section>