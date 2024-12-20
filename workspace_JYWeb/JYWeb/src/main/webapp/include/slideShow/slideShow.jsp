<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/abb02b8c73.js" crossorigin="anonymous"></script>
<script language="javascript" src="<%=request.getContextPath()%>/include/slideShow/slideShow.js"></script>
</head>
<body >

		<!-- 회전목마: 사진, 왼.오버튼, 섹션버튼 -->
		<div class="slideShow">
			<div class="slidePic">
				<a href="#"> <img src="<%=request.getContextPath()%>/common/slide/slidePic1.png" alt="슬라이드사진1"/></a> 
				<a href="#"> <img src="<%=request.getContextPath()%>/common/slide/slidePic2.png" alt="슬라이드사진2"/></a> 
				<a href="#"> <img src="<%=request.getContextPath()%>/common/slide/slidePic3.png" alt="슬라이드사진3"/></a> 
				<a href="#"> <img src="<%=request.getContextPath()%>/common/slide/slidePic4.png" alt="슬라이드사진4"/></a> 
				<a href="#"> <img src="<%=request.getContextPath()%>/common/slide/slidePic5.png" alt="슬라이드사진25"/></a> 
			</div>
			<div class="slideSideIcon">
				<a href="#" class="prev"><i
					class="fa-solid fa-circle-chevron-left"></i></a> <a href="#"
					class="next"><i class="fa-solid fa-circle-chevron-right"></i></a>
			</div>
			<div class="slideFooterIcon">
				<a href="#" class="active"><i class="fa-solid fa-circle-dot"></i></a>
				<a href="#"><i class="fa-solid fa-circle-dot"></i></a> <a href="#"><i
					class="fa-solid fa-circle-dot"></i></a> <a href="#"><i
					class="fa-solid fa-circle-dot"></i></a> <a href="#"><i
					class="fa-solid fa-circle-dot"></i></a>
			</div>
		</div>
		
</body>
</html>