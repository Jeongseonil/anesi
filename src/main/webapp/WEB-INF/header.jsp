<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://cdn.jsdelivr.net/npm/vue-apexcharts"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<!--자동검색기능  -->
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">

<link href="../css/Header.css" rel="stylesheet">
<link href="../css/mainCss.css" rel="stylesheet">

<style>
.category1{
	width: 170px;
	background-color: rgba(255, 255, 255, 0.9);
}
.category2{
	width: 170px;
	background-color: rgba(255, 255, 255, 0.9);
	border-left: 1px solid #e8e8e8;
}
.categoryAllBox{
	display: inline-block;
	width: 350px;
	top: 157px;
	z-index: 1000;
	position: fixed;
}
.categoryAllBox2{
	display: flex;
}
.category-box1{
	font-size: 16px; 
	padding : 10px 0px 10px 0px;
	width : 170px;
}
.category-box2{
	font-size: 16px; 
	padding : 10px 0px 10px 0px;
	width : 170px;
}
.categoryBox1{
	padding: 10px 40px 10px 0;
	cursor : pointer;
}
.categoryBox2{
	padding: 10px 40px 10px 0;
	cursor : pointer;
}
.categoryAllBox:hover .category-box1 {
    background: none;
}
.categoryAllBox:hover .category-box1.hovered {
  background: #B795D2;
  color: white;
}
.categoryAllBox:hover .category-box2:hover {
    background: #C8B0DB;
    color: #fff;
}
.categoryNo{
	margin-left: 10px;
	font-family:'Pretendard-Regular';
}
.nav1{
	position : relative;
	width: 100%;
	height: 75px;
	border-bottom: 1px solid #e8e8e8;
	border-top: 1px solid #e8e8e8;
}
.nav-left{
	display: inline-block;
	height: 40px;
	margin-top: 5px;
	position: absolute;
	left: 0;
}
.nav-left button{
	height: 100%;
    width: 115px;
}
.nav-mid{
	display: inline-block;
}
.search-container{
	display: inline-block;
	float: left;
}
.category-title{
	font-size: 18px;
    font-family: 'Pretendard-Regular';
    color: #424242;
    position: absolute;
    top: 10px;
    margin-left: 6px;
}
.navi-wrap{
	position: relative;
	width: 500px;
	float: right;
	height: 100px;
}
.flow-container{
	margin-top: 55px;
	clear: both;
}
.logo-wrap{
	display: inline-block;
	float: left;
	margin-top: 12px;
}
.top-left{
	display: inline-block;
	float: left;
	margin-top: 40px;
	margin-left: 10px;
}
.top-wrap{
	width: 100%;
	height: 108px;
}
.icon1{
	margin-right: 15px;
}
.icon2{
	margin-right: 10px;
	display: inline-block !important;
	position: relative;
}
.aCnt{
	position: absolute;
	top: -15px;
	left: 5px;
	font-size: 13px;
	line-height: 18px;
}
.icon3{
	margin-right: 20px;
}
.hamburger{
	width: 24px;
}
.over{
	background: #A782C3;
    color: white;
}
</style>
</head>
<body>
<% 
    boolean isLoggedIn = false;
    Object sessionNo = session.getAttribute("sessionNo");
    if (sessionNo != null) {
        isLoggedIn = true;
    }
%>
<div id="app1">
	<header>
		<div class="top-wrap">
		<div class="logo-wrap">
			<a href="/main.do"><img class="logo"src="../css/image/anesilogo.png" /> </a>
		</div>
		<div class="top-left"> 
			<a class="aaa1" href="/product/storemain.do">스토어</a>
			<a class="bbb" href="/community/main.do">커뮤니티</a>
			<a class="ccc" href="/used/main.do">중고장터</a>
			<a class="ccc" v-if="sessionStatus == 'A'" href="http://localhost:8080/admin/main.do" target="_blank">관리자페이지</a>
		</div>
		<div class="navi-wrap"> 
			<ul id="header_navi" v-if="userNo==''">
				<li id="login-button">
					<a href="../login.do" id="login-button-link">
						<i class="fa-solid fa-door-open"></i>
					</a>
					<span class="fon" id="login-button-text">로그인</span>
				</li>
				<li>
					<a href="../join.do">
						<i class="fa-solid fa-user-plus "></i>
					</a>
					<span class="fon">회원가입</span>
				</li>
				<li class="icon1">
					<a href="http://localhost:8080/scrapbook.do">
						<i class="fa-solid fa-bookmark "></i>
					</a>
					<span></span>
				</li>
				<li class="icon2">
					<a href="http://localhost:8080/alarm.do">
						<i class="fa-solid fa-bell "></i>
					</a>
					<span></span>
				</li>
				<li class="icon3">
					<a href="../product/cart.do">
						<i class="fa fa-shopping-cart "></i>
					</a>
					<span></span>
				</li>
			</ul>
			<ul id="header_navi" v-if="userNo !=''">
				<li id="login-button">
					<a href="../logout.do" id="login-button-link">
						<i class="fa-solid fa-door-closed"></i>
					</a>
					<span class="fon" id="login-button-text" style="margin-left : 3px; margin-right : 3px;">로그아웃</span>
				</li>
				<li>
					<a href="../mypage.do">
						<i class="fa-solid fa-user "></i>
					</a>
					<span class="fon">마이페이지</span>
				</li>
				<li class="icon1">
					<a href="http://localhost:8080/scrapbook.do">
						<i class="fa-solid fa-bookmark "></i>
					</a>
					<span></span>
				</li>
				<li class="icon2">
				<span class="aCnt" v-if="alarmList.length != 0">{{alarmList.length}}</span>
					<a href="http://localhost:8080/alarm.do" >
						<i class="fa-solid fa-bell "></i>
					</a>
					
				</li>
				<li class="icon3">
					<a href="../product/cart.do">
						<i class="fa fa-shopping-cart "></i>
					</a>
					<span></span>
				</li>
			</ul>
			<button class="headerbtn" @click="fnShowCommunityButton">글쓰기<i class="fa-solid fa-chevron-down fa-lg" style="color: #ffffff; margin-left: 5px"></i></button>
			<div class="communityButton" :class="{ show: communityflg }">
				<div class="btnBox11">
					<a @click="fnMoveCommunity('1')"><img alt="" src="../css/image/communityAdd2.png" class="communityImg">커뮤니티 글쓰기</a>
					<a @click="fnMoveCommunity('2')"><img alt="" src="../css/image/communityAdd.png" class="communityImg">상품 리뷰 쓰기</a>
					<a @click="fnMoveCommunity('3')"><img alt="" src="../css/image/communityAdd3.png" class="communityImg">중고 물품 등록</a>
				</div>
			</div>
		</div>
		</div>
		<div class="nav1">
			<div class="nav-left">
				<button class="category-toggle" @mouseover="categoryFlg">
					<div><img class="hamburger" src="../css/image/Main/hamburger.png"> <span class="category-title">카테고리</span></div>
				</button> 
				
			</div>
			<div class="search-container">
				 <input type="text" id="search_input" placeholder="제품명을 입력하세요">
				 <a id="glass" class="glass"><i class="fa-solid fa-magnifying-glass"></i></a>
				 <div id="recent_search" class="recent-search-container" style="display: none;"></div>
			</div>
			<div class="flow-container">
		        <div class="flow-text" >
		            <div class="flow-wrap">우리집 고양이 망치도 좋아하는 ANESI </div>
		            <div class="flow-wrap">#미래를 담은 클래식한 디자인,ANESI </div>
		            <div class="flow-wrap"># 행복을 만드는 너와나의집, ANESI </div>
		            <div class="flow-wrap"># 가을맞이 새로운 Mood로의 변화주기 </div>
		            <div class="flow-wrap">불가능했던 공간의 짜잔 수납의 가능성 </div>
		            <div class="flow-wrap">중고라 적고 새로운 트렌드라 읽는다! </div>
		            <div class="flow-wrap">나도 MZ세대 식집사! 반려식물 구경와:)</div>
		            <div class="flow-wrap">Hello! Welcome to our ANESI </div>
    		        <div class="flow-wrap">우리집 고양이 망치도 좋아하는 ANESI </div>
		            
		
		
		        </div>
			</div>
		</div>
		
		
	</header>
	<div class="categoryAllBox" v-if="flg" @mouseleave="flgout">
			<div class="categoryAllBox2">
				<div class="category1">
					<div class="category-box1" :class="{ 'hovered': item.hovered }" v-for="item in categoryList1" @mouseover="fnGetcategoryList2(item)">
						<div class="categoryBox1">
							<span class="categoryNo">{{item.categoryName}}</span>
						</div>
					</div>
				</div>
				<div class="category2" v-if="categoryList2.length != 0" >
					<div class="category-box2" v-for="item in categoryList2">
						<div class="categoryBox2" @click="fnCategoryPage(item.categoryNo)">
							<span class="categoryNo">{{item.categoryName}}</span>					
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script src="../js/jquery.js"></script>
<script>
	var app = new Vue({   
		el : '#app1',
		data : {
			userNo : '${sessionNo}',
			sessionStatus : '${sessionStatus}',
			flg : false,
			product : {	//상품 맵				
				productName : "",
				productPrices : "",
				manufacturer : "",
				country : "",
				discount : "",
				category : "",
				discountYn  : "",
			},
			category1No : "",
			categoryList1 : [], //카테고리 대분류
			categoryList2 : [],
			category2Name : "",
			communityflg : false,
			alarmList : []
		},// data
		methods : {
			fnGetcategoryList1(){
				var self = this;
				var nparmap = {};
	            $.ajax({
	                url : "../product/category.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) { 
	                	self.categoryList1 = data.list;	 
	                	console.log(self.categoryList1);
	                }
	            });
			},
			fnGetcategoryList2(item){
				var self = this;
				var nparmap = {no : item.categoryNo};
				self.category1Name = item.categoryName;
				self.category1No = item.categoryNo;
				this.categoryList1.forEach(category => {
			        if (category === item) {
			          category.hovered = true;
			        } else {
			          category.hovered = false;
			        }
			      });
	            $.ajax({
	                url : "../product/category2.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) { 
	                	self.categoryList2 = data.list;
	                	self.product.category = '';
	                	self.category2Name = '';
	                }
	            });
			},
			fnCategoryPage(item){
				$.pageChange("/category/product.do" , {categoryNo : item});
				
			},
			categoryFlg(){
				this.flg=true;
			},
			flgout(){
				this.flg=false;
				this.categoryList2 = [];
			},
			fnMoveCommunity(type){
				var self = this;
				if(type == '1'){
					$.pageChange("http://localhost:8080/community/write.do" , {});
				} else if(type == '2') {
					$.pageChange("http://localhost:8080/mypage/myShopping.do" , {});
				} else if(type == '3') {
					$.pageChange("http://localhost:8080/used/inquire.do" , {});
				}
			},
			fnShowCommunityButton(){
				var self = this;
				self.communityflg = !self.communityflg;
			},
			
			fnGetAlarm : function() {
				var self = this;
				var nparmap = {userNo : self.userNo};
				 $.ajax({
		                url : "../alarmList.dox",
		                dataType:"json",	
		                type : "POST", 
		                data : nparmap,
		                success : function(data) { 
		                	self.alarmList = data.list;
		                }
	            }); 
			},
		}, // methods
		created : function() {
			var self = this;
			self.fnGetcategoryList1();
			self.fnGetAlarm();
		}// created
	});
	   var isLoggedIn = <%= isLoggedIn %>;

	    /* $(document).ready(function(){
	        // 로그인되어 있지 않은 경우 로그인 버튼 및 아이콘을 조작합니다.
	        if(!isLoggedIn) {
	            $('#login-button-link').attr('href', '../login.do'); // 로그인 링크를 설정합니다.
	            $('#login-button-text').text('로그인'); // 로그인 버튼의 텍스트를 "로그인"으로 설정합니다.
	            $('.fa-door-open').removeClass('fa-door-open').addClass('fa-door-closed');
	            // 로그인 아이콘의 클래스를 변경하여 닫힌 문 모양으로 설정합니다.
	        } else { // 로그인되어 있는 경우 로그아웃 버튼 및 아이콘으로 조작합니다.
	            $('#login-button-link').attr('href', '../logout.do'); // 로그아웃 링크를 설정합니다.
	            $('#login-button-text').text('로그아웃'); // 로그인 버튼의 텍스트를 "로그아웃"으로 설정합니다.
	            $('.fa-door-closed').removeClass('fa-door-closed').addClass('fa-door-open');
	            // 로그인 아이콘의 클래스를 변경하여 열린 문 모양으로 설정합니다.
	        }
	    }); */
	
	
	function saveRecentSearch(search) {
		  if (!search) return;

		  // 검색어 기록을 가져옵니다.
		  var recentSearches = JSON.parse(localStorage.getItem("recentSearches")) || [];
		  
		  
		  // 동일한 검색어가 있는지 확인하고, 있다면 제거합니다.
		  var index = recentSearches.indexOf(search);
		  if (index > -1) recentSearches.splice(index, 1);

		  // 최근 검색어 기록에 새로운 검색어를 추가합니다.
		  recentSearches.unshift(search);
		  
		  // 최근 검색어 목록을 최대 10개로 유지합니다.
		  recentSearches = recentSearches.slice(0, 6);

		  // 변경된 검색어 기록을 저장합니다.
		  localStorage.setItem("recentSearches", JSON.stringify(recentSearches));
		  
		  // 화면에 변경된 검색어 기록을 표시합니다.
		  showRecentSearches();
		}
	    function showRecentSearches() {
	        // localStorage에서 최근 검색어를 가져옵니다.
	        var recentSearches = JSON.parse(localStorage.getItem("recentSearches")) || [];

	        // 최근 검색어 목록을 비웁니다.
	        $('#recent_search').empty();
	        
	        if (recentSearches.length === 0) {
	            // 최근 검색어가 없다면 메시지를 출력합니다.
	            var message = $('<li>').text('최근 검색어가 없습니다.');
	            $('#recent_search').append(message);
	        } else {
	            // 목록을 순회하며 화면에 최근 검색어를 추가합니다.
	            for (var i = 0; i < recentSearches.length; i++) {
	                var search = recentSearches[i];
	                var li = $('<li class="recent-search-item"></li>').text(search);
	                var deleteIcon = $('<i class="fa-solid fa-xmark"></i>');

	                // Delete icon에 클릭 이벤트 핸들러 등록
	                deleteIcon.click(function() {
	                    // 클릭한 아이템의 텍스트(검색어) 가져오기
	                    var searchText = $(this).parent().text();

	                    // localStorage에서 해당 텍스트(검색어) 제거
	                    var indexToRemove = recentSearches.indexOf(searchText);
	                    if (indexToRemove > -1) {
	                        recentSearches.splice(indexToRemove, 1);
	                        localStorage.setItem("recentSearches", JSON.stringify(recentSearches));
	                        
	                        showRecentSearches();  // 리스트 업데이트
	                    }
	                });

	                li.append(deleteIcon);
	                $('#recent_search').append(li);
	            }		  
		  $('.category-link').on('click', function () {
			  var categoryName = $(this).text();

			  $.ajax({
			      url: "/product/getProductsByCategory.dox",
			      type: "POST",
			      data: { categoryName: categoryName },
			      success: function (products) {
			          // 상품 목록 처리 코드 (예: 리스트 렌더링)
			      },
			      error: function (error) {
			          console.log("카테고리 별 상품 목록을 가져오는데 실패했습니다: ", error);
			      }
			  });
			});

		  function loadCategoryProducts(categoryName) {
			  // 서버에서 카테고리별 상품 데이터를 가져오는 AJAX 요청
			  $.ajax({
			    method: "POST",
			    url: "/product/getProductsByCategory.dox",
			    data: {
			      categoryName: categoryName
			    },
			    success: function(response) {

			      var data = response;

			      // testcate.do 페이지로 이동하면서 category와 list 데이터를 전달합니다.
			      var url = "/testcate.do";
			      var params = "categoryName=" + encodeURIComponent(categoryName) + "&list=" + encodeURIComponent(JSON.stringify(data.list));

			      window.location.href = url + "?" + params;
			    },
			    error: function(error) {
			      console.error("Error occurred while fetching category data:", error);
			    }
			  });
			}

			$(document).ready(function() {
			  $('.category-link').on('click', function() {
			    var categoryName = $(this).text();

			    loadCategoryProducts(categoryName); // 데이터를 AJAX로 가져와서 로컬에서 처리
			  });
			});


			  }
		}
		$('#search_input').focus(function() {
			  $('#recent_search').show();
			});

			$('#search_input').blur(function() {
			  setTimeout(function() {
			    $('#recent_search').hide();
			  }, 200);
			});
		
		$(document).ready(function() {
			  showRecentSearches();
			});
		$('body').on('click', '.recent-search-item', function() {
			  var search = $(this).text();
			  $('#search_input').val(search);
			  searchProduct(search);
			});
		$('body').on('click', '.recent-search-item .fa-xmark', function() {
			$(document).ready(function(){
		        var isLoggedIn = <%= isLoggedIn %>; // 로그인이 되어 있는지 여부를 나타내는 변수입니다.

		        // 로그인되어 있지 않은 경우 로그인 버튼 및 아이콘을 조작합니다.
		        if(!isLoggedIn) {
		            $('#login-button-link').attr('href', '../login.do'); // 로그인 링크를 설정합니다.
		            $('#login-button-text').text('로그인'); // 로그인 버튼의 텍스트를 "로그인"으로 설정합니다.
		            $('.fa-door-open').removeClass('fa-door-open').addClass('fa-door-closed');
		            // 로그인 아이콘의 클래스를 변경하여 닫힌 문 모양으로 설정합니다.
		        } else { // 로그인되어 있는 경우 로그아웃 버튼 및 아이콘으로 조작합니다.
		            $('#login-button-link').attr('href', '../logout.do'); // 로그아웃 링크를 설정합니다.
		            $('#login-button-text').text('로그아웃'); // 로그인 버튼의 텍스트를 "로그아웃"으로 설정합니다.
		            $('.fa-door-closed').removeClass('fa-door-closed').addClass('fa-door-open');
		            // 로그인 아이콘의 클래스를 변경하여 열린 문 모양으로 설정합니다.
		        }
		    });
			  // 이벤트 버블링 상위 요소에 영향을 주지 않도록 합니다.
			  return false;
			});
		
	
		// 카테고리 토글
		$('.category-toggle').click(function() {
			$('.category-list-container').slideToggle('fast');
		});

		// 서브 카테고리 토글 이벤트
		$('.category-list > li > a').click(function(event) {
			event.preventDefault();
			$(this).siblings('.subcategory-list').slideToggle('fast');
		});
		function searchProduct(productName) {
			  if(!productName) return;
		    $.ajax({
		        url: "/product/searchProduct.dox",
		        method: "POST",
		        data: {
		            productName: productName,
		        },
		    }).done(function(response) {

		        // 세션 정보와 검색어를 함께 저장합니다.
		        sessionStorage.setItem("searchResult", JSON.stringify(response));
		        sessionStorage.setItem("searchKeyword", productName);

		        // searchProduct.jsp로 이동합니다.
		        window.location.href = "/searchProduct.do?productName=" + encodeURIComponent(productName);
		    });
		    
		}
		// 검색 아이콘 클릭 시 검색어를 가지고 searchProduct 함수를 실행합니다.
		$('#glass').click(function() {
		    var productName = $('#search_input').val();
			
		    saveRecentSearch(productName);
		    searchProduct(productName);
		});

		
		$("#search_input").on("keypress", function(e) {
		    if (e.keyCode === 13) {
		        var productName = $(this).val();

		        saveRecentSearch(productName);
		        searchProduct(productName);
		    }
		});
		
		

		


</script>