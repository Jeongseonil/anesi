<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="../css/mainCss.css" rel="stylesheet">
<link href="../css/Cart.css" rel="stylesheet">
<link href="../css/order.css" rel="stylesheet">
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>

<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
//값을 받아온 후, categoryNo 변수에 값을 저장합니다.
$(document).ready(function() {
  $('.category-link').on('click', function() {
    // 클릭 이벤트가 발생한 요소에서 categoryNo 값을 얻습니다.
    var categoryNo = $(this).closest('ul.subcategory-list').data('category-no');

    // 콘솔에 categoryNo 값을 출력합니다.

    var categoryName = $(this).text();
  });
});
</script>
</head>
<body>
<div class="category-list-container">
  <ul class="category-list">
    <li><a onclick="fnMoveaa('10')">가구</a>
      <ul class="subcategory-list">
        <li><a class="category-link">침대</a></li>
        <li><a class="category-link">소파</a></li>
        <li><a class="category-link">수납장</a></li>
        <li><a class="category-link">의자</a></li>
        <li><a class="category-link">식탁</a></li>
      </ul></li>
    <li><a onclick="fnMoveaa('20')">조명</a>
      <ul class="subcategory-list">
        <li><a class="category-link">장스텐드</a></li>
        <li><a class="category-link">단스탠드</a></li>
        <li><a class="category-link">무드등</a></li>
        <li><a class="category-link">천장등</a></li>
      </ul></li>
    <li><a onclick="fnMoveaa('30')">패브릭</a>
      <ul class="subcategory-list">
        <li><a class="category-link">침구</a></li>
        <li><a class="category-link">커튼</a></li>
        <li><a class="category-link">러그</a></li>
      </ul></li>
    <li><a onclick="fnMoveaa('40')">가전</a>
      <ul class="subcategory-list">
        <li><a class="category-link">냉장고</a></li>
        <li><a class="category-link">tv</a></li>
        <li><a class="category-link">세탁기</a></li>
        <li><a class="category-link">음향/영상가전</a></li>
        <li><a class="category-link">청소가전</a></li>
      </ul></li>
    <li><a onclick="fnMoveaa('50')">데코/식물</a>
      <ul class="subcategory-list">
        <li><a class="category-link">조화</a></li>
        <li><a class="category-link">꽃다발</a></li>
        <li><a class="category-link">화병</a></li>
        <li><a class="category-link">그림 액자</a></li>
        <li><a class="category-link">캔들 디퓨저</a></li>
      </ul></li>
    <li><a onclick="fnMoveaa('60')">반려동물</a>
      <ul class="subcategory-list">
        <li><a class="category-link">하우스/방석</a></li>
        <li><a class="category-link">캣타워/스크래쳐</a></li>
        <li><a class="category-link">안전문/울타리</a></li>
        <li><a class="category-link">밥그릇/급식기</a></li>
        <li><a class="category-link">위생용품</a></li>
      </ul></li>
  </ul>
</div>
</body>
</html>