<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<link href="../css/mainCss.css" rel="stylesheet">
<meta charset="EUC-KR">
<title>��������������</title>
<style>

/* 
*{
border : 1px solid black;
} */
.main-category__title{
 	 font-size : 25px;
 	 font-weight : bold;
}
.product-main-category__image{
	width:100px;
	height:100px;
}


.production-item-thumnail__image{
	width:250px;
	height:250px;
}

.product-main-category__name{
	font-size : 15px;
}
.won_icon,.production-item-price__orginal2{
	text-decoration: line-through;
}

.production-item__content{
	width:220px;
	height:338px;
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
      
.category-order_toggle{
	background-color:#A782C3;
	border: #fff;
	text-align: center;
	border-radius:10px; 
	padding:8px;
	height:35px; 
	width: 100px;
	font-family: 'Pretendard-Regular';
	color :  #fff;
 	 position:relative;
  	flex : 0 0 5;
 }
.category-order_toggle:hover {
    background-color:rgb(235, 236, 237);
    transition: 0.7s;
    
}  
.category-order-list {

  list-style-type: none;
  padding: 0;
  margin: 0;
  position:absolute;
}

.category-order-list li {

  /* ī�װ��� ��Ÿ�ϸ� */
  padding: .5em;
  border-bottom: 1px solid #ccc;
}
.category-order-list-container {
	background :  #fff;
   	width: 100px;
    

}

.aaa {
  color: #A782C3; /* ���ϴ� ���� */
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3); /* �׸��� �߰� */
}


.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5); /* �������� ������ ��� */
  display: flex;
  align-items: center;
  justify-content: center;
    z-index:1000;
  
}

.modal-card {
  background-color: #fff;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
}




</style>
</head>
<!-- �ּ� �� �����ּ��� -->
<body>
<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="product_store_main_ontop_category.jsp"></jsp:include>


	<div id="store_main">
	
	

<span class="main-category__title">��ü��ǰ</span>
<div><button class="category-order_toggle">
	  ����<i class="fa-solid fa-chevron-down"></i>
</button></div>
<!-- ��ǰ �����ϴ� ��ư-->

<div class="category-order-list-container" style="display:none;">


  
  
	
	
		<div class="production-item__content" v-for="item in list">
		
			<a @click="fnProductView(item.productNo)" class="production-item-thumnail">
		
			    <img class="production-item-thumnail__image animate__animated animate__pulse"
			         alt="�����" :src="item.imgPath + '/' + item.imgName">
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
				<span class="production-item-price__orginal2">{{ formatPrice(item.productPrice) }}</span>
			   </span>
			    <!-- production-item-price__sell  : �Ĵ� ���� -->
		       <div class="production-item-price__sell">
			    <span class="won_icon">��</span>
			    <span class="production-item-price__sell2" v-if="item.discountPrice!=''">{{formatPrice(item.discountPrice)}}</span>
			    <span class="production-item-price__sell2" v-else>{{ formatPrice(item.productPrice) }}</span>
			    </div>
	        </span>
	        
			    <!--  production-item-rating : ����-->
		       <div class="production-item-rating">
		       	<!-- �����-->
			   	<i class="fa-solid fa-star" style="color: #A782C3;"></i>
			    <span class="production-item-rating__score">4.5</span>
			   </div>
			   <!-- ��ٱ��Ϲ�ư-->
			   <a v-if="userId!=''">
					<i @click="fnInsertUserCart(item)" v-if="!(cartList.includes(item.productNo))"class="fa fa-shopping-cart modal-toggle-button" ></i>
					<i @click="fnUpdateUserCart(item)" v-if="cartList.includes(item.productNo)" class="fa fa-shopping-cart modal-toggle-button" ></i>
				</a>
				
		    	<!-- �����ϱ��ư-->
		    	<a><i class="fa-solid fa-share-nodes"></i></a>
		    	<!-- ��ũ����ư-->
		    	<a v-if="userId!=''">
		    		<i @click="fnInsertScrapbook(item)" v-if="!(scrapbookList.includes(item.productNo))" class="fa-regular fa-bookmark modal-toggle-button"></i>
		    		<i @click="fnDeleteScrapbook(item)" v-if="scrapbookList.includes(item.productNo)"class="fa-regular fa-solid fa-bookmark"></i>
	    		</a>
		    	<a v-else><i @click="openScrapModal"class="fa-regular fa-bookmark modal-toggle-button"></i></a>
	    </div> <!-- class="production-item__content" ��-->
	    
	    
	    
    	<div class="modal" v-if="showCartModal" >
		  <div class="modal-card">
		    <h2>��ٱ��Ͽ� �߰�</h2>
		    <p>��ǰ�� ��ٱ��Ͽ� ��ҽ��ϴ�.��ٱ��Ϸ� �̵��Ͻðڽ��ϱ�?</p>
		    <button @click="closeModal">���ΰ���ϱ�</button>
		    <button @click="fnMoveCart" >��ٱ��Ϸ� �̵��ϱ�</button>
		  </div>
		</div>
		
    	<div class="modal" v-if="showScrapModal">
		  <div class="modal-card"  v-if="userId!=''">
		    <h2>��ũ���Ͽ� ���</h2>
		    <p>��ǰ�� ��ũ���Ǿ����ϴ�.</p>
		    <button @click="closeModal">���ΰ���ϱ�</button>
		    <button @click="fnMoveScrapbook">��ũ�������� �̵��ϱ�</button>
		  </div>
		  
		  <div class="modal-card"  v-else>
		    <h2>�α����� ��� �����մϴ�.</h2>
		    <p>�α����Ͻðڽ��ϱ�?</p>
		    <button @click="closeModal">���ΰ���ϱ�</button>
		    <button @click="fnMoveLoginPage">�α����������� �̵��ϱ�</button>
		  </div>
		</div>
		
		
	
    	<div class="modal" v-if="showScrapDeleteModal">
		  <div class="modal-card">
		    <h2>��ũ���Ͽ��� �����Ǿ����ϴ�.</h2>
		    <button @click="closeModal">���ΰ���ϱ�</button>
		    <button @click="fnMoveScrapbook">��ũ�������� �̵��ϱ�</button>
		  </div>
		  
		</div>
    	<div class="modal" v-if="showScrapModalBan">
		  <div class="modal-card">
		    <h2>�̹� ����ǰ�Դϴ�.</h2>
		    <p>��ũ������ Ȯ�����ּ���</p>
		    <button @click="closeModal">���ΰ���ϱ�</button>
		    <button @click="fnMoveMyPage">��ũ�������� �̵��ϱ�</button>
		  </div>
		</div>
	
	    
    </div>

<div id="app" v-cloak 
    :data-session-product-no="${ProductNo}"
    :data-session-product-name="${sessionProductName}">
</div>
	
	<jsp:include page="footer.jsp"></jsp:include>
	
</body>
</html>
<script>

$(document).ready(function() {
    // ��ǰ���� ��ư Ŭ�� �̺�Ʈ �߰�
    var isListOpen = false; // Flag to track the state of the list container

    $('.category-order_toggle').click(function() {
        if (!isListOpen) { // ���� ����� �����ִ� ��쿡�� ����
            $('.category-order-list-container').slideDown('slow');
            isListOpen = true;
        }
    });

    // ��� �׸� Ŭ�� �̺�Ʈ �߰�
    $('.category-order-list a').click(function() {
        // ��� �׸��� Ŭ���ϸ� ����� �ݽ��ϴ�.
        $('.category-order-list-container').slideUp('slow');
        isListOpen = false;
    });
});


var app = new Vue({
	  el: "#store_main",
	  data: {
		    list: [],
		    list2: [],
		    item: "",
		    showCartModal: true,
		    showScrapModal false,
		    userId: "${ sessionId }",
		    userNo: "${ sessionNo }",
		    productNo: Number(document.getElementById("app").dataset.sessionProductNo),
		    productName: document.getElementById("app").dataset.sessionProductName,
		    scrapbookList: [],
		    cartList: []
		},
	  computed: {
	    filteredList() {
	      if (!this.productNo && !this.productName) {
	        return this.list;
	      }

	      return this.list.filter(
	        (product) =>
	          (!this.productNo || product.productNo === this.productNo) &&
	          (!this.productName || product.productName === this.productName)
	      );
	    }
	  },
	  methods: {
		  fnGetList: function {
			    var self = this;
			    var nparmap = {
			        keyword: self.keyword,
			        categoryOrderBar: self.categoryOrderBar,
			        productNo: self.productNo,
			        productName: self.productName
			    };
			    $.ajax({
			        url: "/product/searchProduct.dox",
			        dataType: "json",
			        type: "POST",
			        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			        data: nparmap,
			        success: function (data) {
			            self.list = data.productList;
			        }
			    });
			},


	     fnOrderBy: function (orderBy) {
            var self = this;
            self.categoryOrderBar = orderBy; // ī�װ��� ���İ� ����
            self.fnGetList(); // AJAX ��û ������
	     },
	      
	      
	    //�̹��� ���콺 ���������� pulse �ִϸ��̼�
        addPulseAnimation: function(event) {
            event.currentTarget.classList.add('animate__animated', 'animate__pulse');
        },
        removePulseAnimation: function(event) {
            event.currentTarget.classList.remove('animate__animated', 'animate__pulse');
        },
        

        formatPrice: function(price) {
            // õ �������� ��ǥ(,)�� �߰��ϴ� ���Խ� ó��
            return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        },
        
        
        
        // ��� ����
	    openCartModal: function() {
          var self = this;
          self.showCartModal = true;
	    },
	    openScrapModal: function() {
          var self = this;
          self.showScrapModal = true;
	    },
	    openScrapDeleteModal: function() {
          var self = this;
          self.showScrapDeleteModal = true;
	    },
	
	    // ��� �ݱ�
	    closeModal: function() {
	      this.showCartModal = false;
	      this.showScrapModal = false;
	      this.showScrapModalBan = false;
	      this.showScrapDeleteModal = false;
      
	      location.reload();


	    },
	    
	    fnMoveCart : function() {
        	location.href = "/product/cart.do";
	    },
	    fnMoveScrapbook : function() {
        	location.href = "/scrapbook.do";
	    },
	    fnMoveLoginPage : function() {
        	location.href = "/login.do";
	    },
	    
	    fnCheckCart : function(item) {
	    	var self = this;
            var nparmap = {userNo: self.userNo};
           
          
            $.ajax({
                url : "/product/selectCartList.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	for(let i=0; i<data.list.length;i++){
                        self.cartList.push(data.list[i].productNo.toString());
                     }
                }
            }); 
            
		},
		
		fnAddNonUserCart : function(item) {
	    	var self = this;
            var nparmap = { userNo: self.userNo, productNo: item.productNo};
 
            $.ajax({
                url : "/product/insertCart.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	/* alert("��Ͽ�"); */
                   console.log(self.userNo);

                }
            }); 
            
            self.openCartModal();
            console.log(self.showCartModal);

		}, 
		
		
	    
	    fnUpdateUserCart : function(item) {
	    	var self = this;
            var nparmap = { userNo: self.userNo, productNo: item.productNo};
 
            $.ajax({
                url : "/product/addCartCnt.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 

                }
            }); 
            
            self.openCartModal();
            console.log(self.showCartModal);

		}, 
	    fnInsertUserCart : function(item) {
	    	var self = this;
            var nparmap = { userNo: self.userNo, productNo: item.productNo};
 
            $.ajax({
                url : "/product/insertCart.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	/* alert("��Ͽ�"); */
                   console.log(self.userNo);

                }
            }); 
            
            self.openCartModal();
            console.log(self.showCartModal);

		}, 
		
		fnCheckScrap : function(item) {
	    	var self = this;
            var nparmap = {userNo: self.userNo};
           
          
            $.ajax({
                url : "/product/selectScrapList.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	for(let i=0; i<data.list.length;i++){
                        self.scrapbookList.push(data.list[i].productNo.toString());
                     }
                }
            }); 
            
		},
		
	    fnInsertScrapbook : function(item) {
	    	var self = this;
            var nparmap = { userNo: self.userNo, productNo: item.productNo};
           
            $.ajax({
                url : "/product/insertScrap.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	
                }
            }); 
            self.openScrapModal();
            console.log(self.showScrapModal);
		},
	    fnDeleteScrapbook : function(item) {
	    	var self = this;
            var nparmap = { userNo: self.userNo, productNo: item.productNo};
           
            $.ajax({
                url : "/product/deleteScrap.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	console.log("������")
                }
            }); 
            self.openScrapDeleteModal();
            console.log(self.showScrapModal);
		},
		
		
		
		fnProductView : function(productNo){
	    	var self = this;
	    	   $.pageChange("/product/view.do",{no : productNo});//�����ʿ������ �Ķ���� ������{}

		}
		
		
		

     }, // methods
	created : function() {
		var self = this;
		self.fnGetList();
		self.fnCheckCart();
		self.fnCheckScrap();
	
	

	}// created
});
</script>