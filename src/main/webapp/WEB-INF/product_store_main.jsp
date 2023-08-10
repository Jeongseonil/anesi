<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<link href="../css/mainCss.css" rel="stylesheet">
<meta charset="EUC-KR">
<title>��ǰ����������</title>
<style>

body{
	width: 1300px;
	margin: 0px  auto;
	font-size: 14px;
	font-family: 'Pretendard-Regular';
}
.product-main-category__image{
	width:100px;
	height:100px;
}


.production-item-thumnail__image{
	width:200px;
	height:250px;
}

.product-main-category__name{
	font-size : 15px;
}

.production-item__content{
	  float : left;
	  margin : 50px;
}

#product-main-category__total > li {
        display: inline-block;
        position: relative;
        top: 10px;
      }
      #product-main-category__total > li > a {
        display:block; position:relative; padding-bottom:19px;
        margin: 40px;
      }
      #product-main-category__total > li > a > img {
        width:100px; height:100px;
      }
      #product-main-category__total > li > a > span {
        position:absolute; bottom:0; left:50%; color:#666; line-height:1.462em; white-space:nowrap; transform:translate(-50%, 0)
      }


</style>
</head>
<!-- �ּ� �� �����ּ��� -->
<body>
	<div id="app">
	<div><h1>ī�װ���</h1></div>
	<ul id ="product-main-category__total">
	
		<li><a href="javascript:;"><img src="../css/image/productMain/productMain_category1.png"><span>����</span></a></li>
		<li><a href="javascript:;"><img src="../css/image/productMain/productMain_category1.png"><span>����</span></a></li>
		<li><a href="javascript:;"><img src="../css/image/productMain/productMain_category1.png"><span>�к긯</span></a></li>
		<li><a href="javascript:;"><img src="../css/image/productMain/productMain_category1.png"><span>����</span></a></li>
		<li><a href="javascript:;"><img src="../css/image/productMain/productMain_category1.png"><span>����/�Ĺ�</span></a></li>
		<li><a href="javascript:;"><img src="../css/image/productMain/productMain_category1.png"><span>�ݷ�����</span></a></li>
		
	</ul>
	
	<div><h1>�α��ǰ</h1></div>
	
		<div class="production-item__content" v-for="item in list">
			<a href="javascript:;" class="production-item-thumnail">
			    <img class="production-item-thumnail__image" src="../css/image/productMain/productMain_category1.png" >
		    </a>
		    <div class="production-item-header" >
			    <span class="production-item-header__brand" >{{item.manufacturer}}</span>
			    <span class="production-item-header__name">{{item.productName}}</span>
			    <div class="production-item-header__kind">{{item.categoryName}} 
			    <span class="production-item-header__country">{{item.country}}</span>
			    </div>
		    </div>
			 
		    <span class="production-item-price">
		    
		       <span class="production-item-price__orginal" v-if="item.discountPrice!=''">
			    ����
			    <span class="won_icon">��</span>
			    <span class="production-item-price__orginal2" >{{item.productPrice}}</span>
			   </span>
			    
			    
			    <!-- production-item-price__sell  : �Ĵ� ���� -->
		       <div class="production-item-price__sell">
			    <span class="won_icon">��</span>
			    <span class="production-item-price__sell2" v-if="item.discountPrice!=''">{{item.discountPrice}}</span>
			    <span class="production-item-price__sell2" v-else>{{item.productPrice}}</span>
			    </div>
	        </span>
	        
	        
			    <!--  production-item-rating : ����-->
		       <div class="production-item-rating">
		       	<!-- �����-->
			   	<i class="fa-solid fa-star" style="color: #A782C3;"></i>
			    <span class="production-item-rating__score">4.5</span>
			   </div>
				<a><i class="fa fa-shopping-cart "></i></a>
		    
	    </div> <!-- class="production-item__content" ��-->
		
	</div>
</body>
</html>
<script>
var app = new Vue({
	el : '#app',
	data : {
		list : [],
		item : ""
	},// data
	methods : {
		fnGetList : function(){
            var self = this;
            var nparmap = {};
            $.ajax({
                url : "/product/store_main.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	console.log(data);
                	self.list = data.list;
                }
            }); 
		}
     }, // methods
	created : function() {
		var self = this;
		self.fnGetList();

	}// created
});
</script>