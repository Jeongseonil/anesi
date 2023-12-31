<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="../js/jquery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<link href="../css/mainCss.css" rel="stylesheet">
<link href="../css/searchId.css" rel="stylesheet">
<meta charset="EUC-KR">
<title>패스워드 찾기</title>
<style>
</style>
<jsp:include page="header.jsp"></jsp:include>
</head>
<!-- 아이디/패스워드 찾기 -->
<body>
	<div id="app">
		<div id="container">
			<div class="content">
				<div class="title">
					<span>
						가입한 정보을 입력해주세요.
					</span>
				</div>
				<div class="email-input">
					<input @Click="reset" v-model="userEmail" placeholder="이메일">
					<button id="hidden-btn" class="btn" @click="emailCheck">확인</button>
				</div>
				<div v-if="email == '0'">
					<span>등록된 이메일 주소가 아닙니다.</span>
				</div>								
				<div class="select-email">
					<a href="javascript:;" @click="fnselectEmailBtn">가입한 이메일 찾기</a>
				</div>
				<div id="hidden" v-if="email == '1'">
					<div class="user-input">
						<input v-model="userName"  placeholder="이름">
						<input v-model="userPhone" placeholder="전화번호">
					</div>
					<div class="select-btn">
						<button class="btn" @click="searchPwd">패스워드 찾기</button>
					</div>
				</div>
				<div class="text-box">
					<span class="text1">회원가입 시 입력한 정보가 기억나지 않는다면?</span>
					<div class="text2">고객센터 문의하기(1010-4563)</div>
				</div>
			</div>
			<div class="modal" v-if="showScrapModal">
				<div class="content-box">
				<div class="review-back">
					<button class="back-btn" @click="closeScrapModal()"><i  class="fa-solid fa-x fa-2x" style="color: #bdbdbd;"></i></button>
				</div>
					<div class="content1" v-if="!emailSelectYn">
						<div class="title1">
							가입한 정보를 입력해주세요.
						</div>
						<div class="user-input1">
							<input v-model="userName" placeholder="이름">
							<input v-model="userPhone" placeholder="전화번호">
						</div>
						<div class="select-btn1">
							<button class="btn" @click="searchEmail">이메일 찾기</button>
						</div>
					</div>
					<div v-if="emailSelectYn">
						<div class="content2" v-if="emailSelect==undefined">
							<div class="text1">
								가입된 정보가 없습니다.
							</div>
							<div class="select-btn1">
								<button class="select-btn2" @click="emailSelectYn = false">돌아가기</button>
							</div>
						</div>
						<div class="content2" v-else>
							<div class="text1">
								Email : {{emailSelect.userEmail}}
							</div>
							<div class="select-btn1">
								<button class="select-btn2" @click="closeScrapModal">완료</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<jsp:include page="footer.jsp"></jsp:include>
</html>
<script>
$(document).ready(function(){
    $("#hidden-btn").click(function(){
    	
    		$("#hidden").slideToggle(400)
    	
        
    })
})
var app = new Vue({
	el : '#app',
	data : {
		showScrapModal : false,
		userEmail : "",
		userName : "",
		userPhone : "",
		email : "",
		emailSelect : {},
		emailSelectYn : false,
	},// data
	methods : {
		emailCheck : function(){
			 var self = this;
	         var nparmap = {userEmail : self.userEmail};	            
	         $.ajax({
	             url : "emailSearch.dox",
	             dataType:"json",	
	             type : "POST", 
	             data : nparmap,
	             success : function(data) {                
	               	self.email = data.emailCheck;
	             }                
	         }); 
		},
		searchEmail(){
			var self = this;
			if(self.userName==""){
				alert("이름을 입력하세요");
				return;
			}
			if(self.userPhone==""){
				alert("휴대폰 번호를 입력하세요");
				return;
			}
            var nparmap = {userName : self.userName, userPhone : self.userPhone};	            
            $.ajax({
                url : "emailSearch1.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {                
               		self.emailSelect = data.emailSelect;
               		self.emailSelectYn = true;
                }                
            });
		},
		reset : function(){
			var self=this
			self.email="";
		},
		searchPwd : function(){
			var self = this;
            var nparmap = {userEmail : self.userEmail, userName : self.userName, userPhone : self.userPhone};           
            $.ajax({
                url : "pwdSearch.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {                
               		alert(data.message);
                }                
            }); 
		},
		fnselectEmailBtn(){
			var self = this;
			self.showScrapModal = true;
		},
		closeScrapModal(){
			var self = this;
			self.showScrapModal = false;
			self.emailSelectYn = false;
			self.userName = "";
			self.userPhone = ""
		}
	}, // methods
	created : function() {
		var self = this;

	}// created
});
</script>