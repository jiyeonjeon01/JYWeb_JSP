<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 회전목마: 사진, 왼.오버튼, 섹션버튼 -->
		<div class="slideShow">
			<div class="slidePic">
				<a href="#"> <img src="./media/slidePic1.png"></a> <a href="#">
					<img src="./media/slidePic2.png">
				</a> <a href="#"> <img src="./media/slidePic3.png"></a> <a
					href="#"> <img src="./media/slidePic4.png"></a> <a href="#">
					<img src="./media/slidePic5.png">
				</a>
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