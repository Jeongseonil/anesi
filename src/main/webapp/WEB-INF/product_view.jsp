<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="https://cdn.jsdelivr.net/npm/vue-apexcharts"></script>
<script src="https://unpkg.com/vuejs-paginate@latest"></script>
<script src="https://unpkg.com/vuejs-paginate@0.9.0"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
<link href="../css/mainCss.css" rel="stylesheet">
<link href="../css/inquiry.css" rel="stylesheet">
<link href="../css/review.css" rel="stylesheet">
<link href="../css/login.css" rel="stylesheet">
<link href="../css/productView.css" rel="stylesheet">
<meta charset="EUC-KR">
<title>��ǰ �� ������</title>
<style>
.modal{
	z-index: 10000 !important;
}
.review-back1{
	position: absolute;
	top: 20px;
	right: 50px;
	
}
.review-back1 i{
	font-size: 50px;
}
.review-back1 button{
	background-color: rgba(0, 0, 0, 0);
    border: 0;
}
</style>
</head>
<!-- ��ǰ �� ������ -->
<jsp:include page="header.jsp"></jsp:include>
<body>
	<div id="app">
		<div id="container">
			<div class="content">
				<div class="content-box">
					<div class="main-left">
						<div class="category-wrap" v-for="(item,index) in category">
							{{item.categoryName}} 
							<span class="category-span" v-if="index !== category.length - 1"> > </span>
						</div>
						<div class="main-view">
							<div class="main-img-table">
								<ul class="main-ul">
									<li class="main-li" v-for="item in img">
										<a href="javascript:;">
											<img alt="������ �̹���" :src="item.imgPath+'/'+item.imgName" @mouseover="clickImg(item.imgPath, item.imgName)">
										</a>	
									</li>
									<li class="main-li" v-for="item in imgList">
										<a href="javascript:;">
											<img alt="������ �̹���" :src="item.imgPath+'/'+item.imgName" @mouseover="clickImg(item.imgPath, item.imgName)">
										</a>
									</li>
								</ul>
							</div>
							<div class="main-img">
								<img alt="�����" :src="mainImg">
							</div>
						</div>
					</div>
						<div class="main-box">
							<div class="manufacturer">
								{{product.manufacturer}}
							</div>
							<div class="main-title" >
								<span class="product-title">{{product.productName}}</span>
								<div class="scrapbook">
									<i @click="fnInsertScrapbook()" v-if="scrapbookList.length == 0" class="fa-regular fa-bookmark modal-toggle-button" style="cursor:pointer"></i>
               						<i @click="fnDeleteScrapbook()" v-if="scrapbookList.length != 0"class="fa-regular fa-solid fa-bookmark" style="color:#A782C3; cursor:pointer;"></i>
               						<a class="share_button" @click="shareSelectedOption()"><i class="fa-solid fa-share-nodes"></i></a>
								</div>
							</div>
							<div class="main-csat">
								<div class="main-star" v-for="(rating, index) in csatAvg" :key="index">
							      <span v-for="star in 5" :key="star">
							        <template v-if="rating >= star ">
							          <i class="fa-solid fa-star" style="color: #A782C3;"></i> <!-- ä���� ��ǥ -->
							        </template>
							        <template v-else-if="rating +0.3 >= star">
							         <span style="display: inline-block; position: relative;">
							            <i class="fa-solid fa-star" style="color: #ababab;"></i> <!-- ��ä���� ��ǥ -->
							            <i class="fa-solid fa-star" style="color: #A782C3; position: absolute; left: 0; top:1.4px; width: 65%; overflow: hidden;"></i>
							          </span>
							        </template>
							        <template v-else-if="rating + 0.5 >= star">
							         <span style="display: inline-block; position: relative;">
							            <i class="fa-solid fa-star" style="color: #ababab;"></i> <!-- ��ä���� ��ǥ -->
							            <i class="fa-solid fa-star" style="color: #A782C3; position: absolute; left: 0; top:1.5px; width: 50%; overflow: hidden;"></i>
							          </span>
							        </template>
							        <template v-else-if="rating +0.8 >= star">
							         <span style="display: inline-block; position: relative;">
							            <i class="fa-solid fa-star" style="color: #ababab;"></i> <!-- ��ä���� ��ǥ -->
							            <i class="fa-solid fa-star" style="color: #A782C3; position: absolute; left: 0; top:1.5px; width: 40%; overflow: hidden;"></i>
							          </span>
							        </template>
							        
							        <template v-else>
							         <i class="fa-solid fa-star" style="color: #ababab;"></i> <!-- �� ��ǥ -->
							        </template>
							      </span>
							    </div>
								{{csat.csatAvg}} <span class="text5">({{csat.csatCnt}})</span>
								
							</div>
							<div v-if="product.discount > 0">
								<div class="main-discount">
									<span class="price">{{product.productPrice | formatPrice}}��</span> <span class="dis">{{product.discount}}% </span>
								</div>
								<div class="discount-price">
									{{discountPrice | formatPrice}}��
								</div>
							</div>
							<div v-else>
								<div class="main-price2">
									{{defaultPrice | formatPrice}}��
								</div>
							</div>
							<div class="main-option">
								<select class="option-box" v-model="option1" @change="addToSelectedOptions">
									<option value="">��ǰ�� �����ϼ���.</option>
									<option v-for="item in option" :key="item.optionNo + '-' + item.optionName" :value="item.optionNo">
										{{item.optionName}}(+{{item.optionPrice | formatPrice}}��)
									</option>
								</select>
							</div>
							<div class="choice-option">
								<ul>
							       <li v-for="(selectedOption, index) in selectedOptions" :key="index">
							        <span>{{ selectedOption.optionName }}</span>
							        <button class="del-btn"  @click="removeSelectedOption(index)">
							        	<i class="fa-solid fa-x"></i>
							        </button> 
							        <div class="option-stock">
							        	 <div class="quantity-box">
										   <button class="minus-btn" @click="decreaseQuantity(selectedOption)">
										   		<i class="fa-solid fa-minus" style="color: #4c6794;"></i>
										   </button>
							               <input v-model ="selectedOption.quantity" min="1">
							               <button class="plus-btn" @click="increaseQuantity(selectedOption)">
							               		<i class="fa-solid fa-plus" style="color: #4b638b;"></i>
							               </button>
										 </div>
										 <div class="option-stock-price">
										 	{{ calculateTotalPrice(selectedOption) | formatPrice}}��
										 </div>
							        </div>							        
							       </li>
							    </ul>
							    
							</div>
							<div class="total-price">
							    <div class="total-title">�ֹ��ݾ�</div>
							    <div class="total-price1">
							    	<span class="total-price2">{{totalPrice | formatPrice}}��</span>
							    </div>
							</div>
							<div class="main-btn-wrap">
								<button class="btn1" @click="fnCart">��ٱ���</button>
								<button class="btn2" @click="fnPay">�ٷα���</button>
							</div>
						</div>
					</div>
					<div id="product"></div>
					<div class="nav-box">
						<div class="nav-wrap">
							<div class="product-a"><a href="javascript:;" @click="scrollUpFromSection('product', 160)">��ǰ����</a></div>
							<div class="review-a"><a href="javascript:;" @click="scrollUpFromSection('review', 240)">����  <span class="review-span" v-if="csat.csatCnt > 0"> {{csat.csatCnt}}</span></a></div>
							<div class="inquiry-a"><a href="javascript:;" @click="scrollUpFromSection('inquiry', 240)">���� <span class="review-span" v-if="inquiryListCnt > 0">{{inquiryListCnt}}</span></a></div>
							<div class="product-a"><a href="javascript:;" @click="scrollUpFromSection('Etc', 250 )">���/ȯ��</a></div>
						</div>
					</div>
					
					<div class="content-box2">
						<div class="content-view">
							<div class="content-title">
								��ǰ ����
								<div class="content-text-box">
									<div class="text1">�Ǹ��� ���ŷ� ���� �ȳ�</div>
									<div>�Ǹ��ڸ� ��Ī�Ͽ� ���� �Ա� �����ϴ� �Һ��� ���� ��ʰ� �ð� �ֽ��ϴ�.</div>
									<div>�Ǹ��ڿ� ����/ī������ �����Ͻ� ��, ���е��� ���Ǹ� ��Ź�帮��,</div>
									<div>�ǽɵǴ� ��� �Ƴ׽� �����ͷ� �Ű��� �ֽñ� �ٶ��ϴ�.</div>
								</div>
							</div>
							<div class="content-img-box" :style="{overflow : contentImgBoxflg ? 'hidden' : 'visible', display : contentImgBoxflg ? 'block' : 'initial'}">
								<div class="content-img" v-for="item in imgList2">
									<img alt="�������̹���" :src="item.imgPath+'/'+item.imgName">
								</div>
								<button v-if="contentImgBoxflg" @click="fnToggleContentImgBoxFlg">�̹��� �ε�</button>
							</div>
							<div class="content-review" id="review">
								<div class="review-title2" >
									<span class="review-text1">���� </span><span class="review-text2" v-if="csat.csatCnt > 0"> {{csat.csatCnt}}</span>
									<button class="review-btn" @click="openScrapModal" >���侲��</button>
								</div>
								<div class="modal noneDisplay" v-if="showScrapModal" :class="{'showDisplay' : showScrapModal}">
									
							        <div class="review-add">
							        <div class="review-back">
										<button class="back-btn" @click="closeScrapModal()"><i  class="fa-solid fa-x fa-2x" style="color: #bdbdbd;"></i></button>
									</div>
							        	<div class="review-add-box">
								        	<div class="review-add-product">
								        		<div class="review-title1">���侲��</div>
								        		<div class="review-top-wrap">
									        		<div class="review-product-img">
									        			<img class="review-product-img1" alt="�����ǰ�̹���" :src="mainImg">
									        		</div>
									        		<div class="review-product-name">
									        			<div class="review-product">
											        		<div class="review-manufacturer">
																{{product.manufacturer}}
															</div>
										        			<div class="review-add-name">{{product.productName}}</div>
										        			<span class="review-add-option" v-for="(item, index) in uniqueOptions" :key="item">
														      {{ item }}
														    <span v-if="index !== uniqueOptions.length - 1">+</span>
									        			</div>
									        		</div>
								        		</div>
								        		
									        	<div class="review-product-csat">
									        		<div :class="reviewCsatClass">
									        			���� ��
									        		</div>
									        		<span class="notCheck" v-if="reviewCsatCheck == true">�ʼ� �Է� �׸��Դϴ�.</span>
									        		<div class="review-csat-box">
										        		<div class="review-csat1">������</div>									        	
														<div class="star-rating">
														  <i v-for="(star, index) in stars" :key="index"
														      :class="starClass(index)"
														      @mouseover="hover(index + 1)"
															  @click="rate(index + 1)"
															  @mouseout="clearHover"></i>
														</div>
													</div>																									
									        	</div>
									        	<div class="img-add">
									        		<div class="img-add1">���� ÷��(����)</div>
									        		<div class="img-add2">������ ÷�����ּ���.(�ִ� 1��)</div>
									        	</div>
									        	<div class="review-img-btn-wrap">
									        		<input type="file" id="file1" name="file1" style="display: none;" @change="handleFileChange">
												    <label for="file1" class="file-upload-label">
												      <div class="img-icon"><i class="fa-regular fa-image fa-2x" style="color: #A782C3;"></i></div>
												      <div class="img-btn-text">���� �߰��ϱ�</div>
												    </label>
									        	</div>	
									        	<p class="fileName" v-if="selectedFile">���� �̸�: {{ selectedFile.name }}</p>
									        	<div :class="reviewTitleClass">
									        		���� �ۼ�
									        	</div>
									        	<span class="notCheck" v-if="reviewCheck == true">�ʼ� �Է� �׸��Դϴ�.</span>
									        	<div class="review-add-textarea">
									        		<textarea :class="reviewTextareaClass" @click="reviewTextarea" @input="updateCharacterCount1" rows="10" cols="53.9" v-model="reviewText" placeholder="�ڼ��ϰ� ������ ����� �ٸ������� ū ������ �˴ϴ�."></textarea>
									        		 <div class="character-count">{{ characterCount1 }} / 200</div>
									        	</div>
									        	<div class="review-add-btn-wrap"> 
									        		<button @click="fnReviewAdd" class="review-add-btn">�Ϸ�</button>
									        	</div>
								        	</div>
							        	</div>
							        	
							        </div>
								</div>
								<div class="csat-box">
									<div class="csat1">
										<div class="csat-box1">
											<div style="display: inline-block" v-for="(rating, index) in csatAvg" :key="index">
										      <span v-for="star in 5" :key="star">
										        <template v-if="rating >= star ">
										          <i class="fa-solid fa-star fa-2x" style="color: #A782C3;"></i> <!-- ä���� ��ǥ -->
										        </template>
										        <template v-else-if="rating +0.3 >= star">
										         <span style="display: inline-block; position: relative;">
										            <i class="fa-solid fa-star fa-2x" style="color: #ababab;"></i> <!-- ��ä���� ��ǥ -->
										            <i class="fa-solid fa-star fa-2x" style="color: #A782C3; position: absolute; left: 0; width: 65%; overflow: hidden;"></i>
										          </span>
										        </template>
										        <template v-else-if="rating + 0.5 >= star">
										         <span style="display: inline-block; position: relative;">
										           <i class="fa-solid fa-star fa-2x" style="color: #ababab;"></i> <!-- ��ä���� ��ǥ -->
										            <i class="fa-solid fa-star fa-2x" style="color: #A782C3; position: absolute; left: 0; width: 50%; overflow: hidden;"></i>
										          </span>
										        </template>
										        <template v-else-if="rating +0.8 >= star">
										         <span style="display: inline-block; position: relative;">
										            <i class="fa-solid fa-star fa-2x" style="color: #ababab;"></i> <!-- ��ä���� ��ǥ -->
										            <i class="fa-solid fa-star fa-2x" style="color: #A782C3; position: absolute; left: 0; width: 40%; overflow: hidden;"></i>
										          </span>
										        </template>
										        
										        <template v-else>
										          <i class="fa-solid fa-star fa-2x" style="color: #ababab;"></i>
										        </template>
										      </span>
										    </div>
											<span class="csatAvg">{{csat.csatAvg}}</span>
										</div>
									</div>
									<div class="csat2">
										<div id="chart">
        									<apexchart type="bar" height="150" :options="chartOptions" :series="series"></apexchart>
     									</div>
									</div>
								</div> <!-- csat-box end -->
								<div class="review-wrap">
									<div class="review-box" v-if="reviewList.length > 0" v-for="item in reviewList">
										<div class="user-profile">
											<img class="user-profileImg" alt="�������̹���" :src="item.uImgPath+'/'+item.uImgName">
										</div>
										<div class="review-user">
											
											<div class="review-user-box">
												<div class="user-nick">{{item.nick}}</div>
												<span v-for="index in item.csat"><i class="fa-solid fa-star" style="color: #A782C3;"></i></span><span v-for="index in 5-item.csat"><i class="fa-solid fa-star" style="color: #ababab;"></i></span>
												<span>{{item.createDate}}</span>
												
											</div>
										</div>
										<div v-if="item.optionName != undefined" class="review-optionName">
											<span class="review-optionName1">{{item.optionName}}</span>
										</div>
										<div class="review-img-box" v-if="item.rImgName !=undefined">
											<a href="javascript:;" @click="zoomImg(item.rImgPath,item.rImgName)"><img class="review-img" alt="�����̹���" :src="item.rImgPath+'/'+item.rImgName"></a>
										</div>
										<div class="review-content">
											{{item.content}}
										</div>
										<div class="review-help"  v-if="!helpList.includes(item.rNo)">
											<button class="help-btn" @click="fnHelp(item.rNo)">������ �ſ�</button> <span v-if="item.help > 0">{{item.help}}���� ������ �Ǿ����ϴ�.</span>
										</div>	
										<div class="review-help" v-else>
											<button class="help-btn1" @click="fndeleteHelp(item.rNo)"><i class="fa-solid fa-check" style="color: #ffffff;"></i>�����</button> <span v-if="item.help > 0">{{item.help}}���� ������ �Ǿ����ϴ�.</span>
										</div>	
										 
									</div>
									<div class="review-box2" v-if="reviewList.length == 0">
										ù ���並 �����ּ���!
									</div>
									<template v-if="pageCount > 1">
									  <paginate
									    :page-count="pageCount"
									    :page-range="5"
									    :margin-pages="2"
									    :click-handler="fnSearch"
									    :prev-text="'<'"
									    :next-text="'>'"
									    :container-class="'pagination'"
									    :page-class="'page-item'">
									  </paginate>
									</template>
								</div> <!-- review-wrap end -->
							</div><!-- content-review end -->
							<div class="inquiry-wrap" id="inquiry">
								<div class="review-title2" >
									<span class="review-text1">���� </span><span class="review-text2" v-if="inquiryListCnt > 0"> {{inquiryListCnt}}</span>
									<button class="review-btn" @click="openScrapModal2">�����ϱ�</button>
								</div>
								<div class="modal noneDisplay" v-if="showScrapModal2" :class="{'showDisplay' : showScrapModal2}">
									<div class="inquiry-add-wrap">
										<div class="review-back">
											<button class="back-btn" @click="closeScrapModal2()"><i  class="fa-solid fa-x fa-2x" style="color: #bdbdbd;"></i></button>
										</div>
										<div class="inquiry-add-box">										
											<div class="inquiry-add-title">
												��ǰ �����ϱ�
											</div>
											<div class="inquiry-add-category">
												<div class="inquiry-content-title">
													���� ����
												</div>
												<div class="inquiry-category-box">
													<div class="inquiry-category-box1 active category-box11" @click="changeCategoryStyle('��ǰ')">��ǰ</div>
													<div class="inquiry-category-box1 category-box21" @click="changeCategoryStyle('���')">���</div>
													<div class="inquiry-category-box1 category-box3" @click="changeCategoryStyle('��ǰ')">��ǰ</div>
													<div class="inquiry-category-box1 category-box4" @click="changeCategoryStyle('��ȯ')">��ȯ</div>
													<div class="inquiry-category-box1 category-box5" @click="changeCategoryStyle('ȯ��')">ȯ��</div>
													<div class="inquiry-category-box1 category-box6" @click="changeCategoryStyle('��Ÿ')">��Ÿ</div>
												</div>											
											</div>
											<div class="inquiry-add-option">
												<div :class="optionCheckStyle">
													��ǰ �� �ɼ�	
												</div>
												<div class="inquiry-option-select">
													<select :class="inquirySelectClass" v-model="inquiryOption">
														<option value=0>��ǰ�� �����ϼ���.</option>
														<option v-for="item in option" :value="item.optionNo">
															{{item.optionName}}
														</option>
													</select>
													<div class="option-not-check" v-if="inquiryOption == 0">
														<label class="styled-checkbox">																												
															<input class="inquiry-checkbox" type="checkbox" id="optionYnCheckbox" @click="optionCheckYn">														    														
															<span class="inquiry-span">���þ���</span>
														</label>
													</div>
												</div>
											</div>
											<div class="inquiry-add-content">
												<div :class="{'inquiry-title' : !inquiryCheck, 'not-check-title2' : inquiryCheck}">
													���ǳ���
												</div>												
												<textarea :class="{'inquiry-add-text' : !inquiryCheck, 'not-check-textarea2' : inquiryCheck}" @click="inquiryTextarea" @input="updateCharacterCount2" rows="10" cols="53.9" v-model="inquiryText" placeholder="���� ������ �Է��ϼ���."></textarea>
									        	<div class="character-count">{{ characterCount2 }} / 200</div>
											</div>
											<div class="privateText" v-if="privateCheck">
												<label class="styled-checkbox">	
													<input class="inquiry-checkbox" type="checkbox" id="openYnCheckbox" @click="privateInquiry">
													<span class="inquiry-span">��б۷� �����ϱ�</span>
												</label>
											</div>
											<div class="inquiry-add-btn-wrap">
												<button @click="inquiryAdd" class="inquiry-add-btn">�Ϸ�</button>
											</div>
										</div>
									</div>
								</div>
								<div class="inquiry-content" v-for="item in inquiryList" v-if="inquiryListCnt > 0">
									<div class="inquiry-category">
										{{item.purchaseYn}}  | {{item.inquiryCategory}}  | <span class="reply-Y" v-if="item.reply!=undefined">�亯�Ϸ�</span><span v-if="item.reply==undefined">�̴亯</span>
									</div>
									<div class="inquiry-user">
										<span class="inquiry-nick">{{item.nick}}</span>
										<span class="inquiry-time">{{item.cDateTime}}</span>
									</div>
									<div v-if="item.openYn =='Y'" class="inquiry-question">
										<span class="a-icon">
											<i class="fa-solid fa-q" style="color: #A782C3;"></i>
										</span>
										<span class="inquiry-content-text">
											{{item.content}}
										</span>
									</div>
									<div  class="inquiry-answer">
										<span class="a-icon" v-if="item.reply != undefined && item.openYn =='Y'">
											<i  class="fa-solid fa-a" style="color: #A782C3;"></i>
										</span>
										<span class="inquiry-reply" v-if="item.reply!=undefined && item.openYn =='Y'">
											{{item.reply}}
										</span>
									</div>
									<div class="private-inquiry" v-if="item.openYn=='N'">
										<span class="q-icon">
											<i  class="fa-solid fa-q" style="color: #A782C3;"></i>
										</span>
										<span class="rock-icon">
											<i class="fa-solid fa-lock" style="color: rgb(175, 175, 175);"></i>
										</span>
										<span class="private-text" v-if="userNo == item.userNo || status == 'A'">
											{{item.content}}
										</span>
										<span class="private-text" v-else>
											��б��Դϴ�.
										</span>
										<div  class="inquiry-answer" v-if="userNo == item.userNo || status == 'A'">
										<span class="a-icon" v-if="item.reply != undefined">
											<i  class="fa-solid fa-a" style="color: #A782C3;"></i>
										</span>
										<span class="inquiry-reply" v-if="item.reply!=undefined">
											{{item.reply}}
										</span>
									</div>
									</div>
								</div>
								<div v-if="inquiryListCnt == 0" class="non-inquiry-cnt">
									���� ������ �����ϴ�.
								</div>
								<template v-if="pageCount1 > 1">
									  <paginate
									    :page-count="pageCount1"
									    :page-range="5"
									    :margin-pages="2"
									    :click-handler="fnSearch1"
									    :prev-text="'<'"
									    :next-text="'>'"
									    :container-class="'pagination'"
									    :page-class="'page-item'">
									  </paginate>
									</template>
							</div>
						<div class="Etc-box" id="Etc">
							<div class="delivery Etc">
								<div class="Etc-title">
									���
								</div>
								<table class="Etc-table">
									<tr>
										<td>���</td>
										<td>��ü�������, ����Ϲ�� <small>(��ǰ ������ Ȯ��)</small></td>
									</tr>
									<tr>
										<td>��ۺ�</td>
										<td>������</td>
									</tr>
									<tr>
										<td>��ۺҰ� ����</td>
										<td>��ۺҰ� ������ �����ϴ�.</td>
									</tr>
								</table>
							</div>
							<div class="refund Etc">
								<div class="Etc-title">
									��ȯ/ȯ��
								</div>
								<table class="Etc-table">
									<tr>
										<td>��ǰ��ۺ�</td>
										<td>50,000��<small>(���� ��ۺ� ������ ��� 100,000���ΰ�)</small></td>
									</tr>
									<tr>
										<td>��ȯ��ۺ�</td>
										<td>100,000��</td>
									</tr>
									<tr>
										<td>������ ��</td>
										<td>��õ������ ���� ������ 1366,(����,�����̼�Ÿ�� 7F)</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="Etc-box">
							<div class="Etc-box2">
								<div class="Etc-title2">��ǰ/��ȯ ������ ���� ��û ���� �Ⱓ</div>
								<div class="Etc-text">��ǰ �� ���� �Ǹ��ڿ� �����ϼż� ��ǰ����, �ù��, ��ۺ�, ��ǰ�� �ּҵ��� �����Ͻ��� ��ǰ ��ǰ�� �߼��� �ֽñ� �ٶ��ϴ�.</div>
								<ol>
									<li>������ �ܼ� ������ ��ǰ ���� �� 7�� �̳� <small>(������ ��ǰ��ۺ� �δ�)</small></li>
									<li>ǥ��/����� ����, ��೻��� �ٸ��� ����� ��� ��ǰ ���� �� 3���� �̳�, �� ����� �� �� �Ǵ� �� �� �־��� ���κ���30�� �̳�. ���� �ϳ� ����� ��ǰ/��ȯ�Ұ�<small>(�Ǹ��� ��ǰ��ۺ� �δ�)</small></li>
								</ol>
							</div>
							<div>
								<div class="Etc-title2">��ǰ/��ȯ �Ұ��� ����</div>
								<div class="Etc-text">�Ʒ��� ���� ��� ��ǰ/��ȯ�� �Ұ����մϴ�.</div>
								<ol>
									<li>��ǰ��û�Ⱓ�� ���� ���<span></span></li>
									<li>�������� å�� �ִ� ������ ��ǰ ���� ��� �Ǵ� �Ѽյ� ��� <small> (��, ��ǰ�� ������ Ȯ���ϱ� ���Ͽ� ���� ���� �Ѽ��� ���� ����)</small></li>
									<li>������ �����Ͽ����� ������ �ѼյǾ� ��ǰ��ġ�� ������ ��ǵ� ���<small> (��: ��ǰ, ȭ��ǰ)</small></li>
									<li>�������� ��� �Ǵ� �Ϻ� �Һ� ���Ͽ� ��ǰ�� ��ġ�� ������ ������ ���<small> (���� ������ �Ƿ� �Ǵ� �±װ� ������ ��ǰ�� ��ǰ�� ���)</small></li>
									<li>�ð��� ����� ���Ͽ� ���ǸŰ� ����� ������ ��ǰ ���� ��ġ�� ������ ������ ���<small>(��: ��ǰ, ȭ��ǰ)</small></li>
									<li>���ֹ� Ȯ�� �� ��ǰ���ۿ� ���� �ֹ����ۻ�ǰ</li>
									<li>������ ������ ��ǰ ���� ������ �Ѽ��� ���<small>(CD/DVD/GAME/������ ��� ���� ���� ��)</small></li>
								</ol>
							</div>
						</div>
						</div>
						
						<div class="modal noneDisplay" v-if="showScrapModal3" :class="{'showDisplay' : showScrapModal3}">
							<div class="container">
							<div class="review-back">
								<button class="back-btn" @click="closeScrapModal3()"><i  class="fa-solid fa-x fa-2x" style="color: #bdbdbd;"></i></button>
							</div>
								<div class="content1">
									<div class="logo2">
										<a href="main.do"><img alt="logo" src="../css/image/footer_img.png" ></a>
									</div>
									<div class="login-wrap">
										<div class="login-title">
											<span class="title1">�α���</span>
										</div>
										<div class="login-box"> <!-- �α��� �Է� �ڽ� -->
											<input class="login-input" v-model="userEmail" placeholder="�̸���" @keyup.enter="fnLogin">
											<input class="login-input" type="password" v-model="pwd" placeholder="�н�����" @keyup.enter="fnLogin">
										</div>
										<div class="login-btn">
											<button class="loginBtn btn" @click="fnLogin">�α���</button>
										</div>
									</div>
									<div class="a-wrap"> <!-- ��Ÿ��� -->
										<a href="/selectEmail.do" class="a a1">���̵�ã��</a>
										<a href="/join.do" class="a a2">ȸ������</a>
									</div>
									<div class="non-user-wrap1" v-if="!nonUserScrapbook"> <!-- ��ȸ�� �ֹ� ��ȸ -->
										<button class="loginBtn1 btn" @click="fnPay1">��ȸ�� �����ϱ�</button>
									</div>
									<div class="non-user-wrap1" v-if="nonUserScrapbook"> <!-- ��ȸ�� �ֹ� ��ȸ -->
										<button class="loginBtn1 btn" @click="closeScrapModal3()">���� ����ϱ�</button>
									</div>
								</div>
							</div>		
						</div>
						<div class="modal noneDisplay" v-if="showScrapModal4" :class="{'showDisplay' : showScrapModal4}">
							<div class="modal-card">
								<h2>��ٱ��Ͽ� �߰�</h2>
								<p>��ǰ�� ��ٱ��Ͽ� ��ҽ��ϴ�. ��ٱ��Ϸ� �̵��Ͻðڽ��ϱ�?</p>
								<button @click="fnMedal" class="left_button">���ΰ���ϱ�</button> 
								<button @click="fnMoveCart" class="right_button">��ٱ��Ϸ� �̵��ϱ�</button>
							</div>	
						</div>
						<div class="modal noneDisplay" v-if="showScrapModal5" :class="{'showDisplay' : showScrapModal5}">
							<div class="modal-card">
								<h2>���� �ۼ�</h2>
								<p>�̹� �ۼ��� ���䰡 �ֽ��ϴ�. �����Ͻðڽ��ϱ�?</p>
								<button @click="fnMedal" class="left_button">���ΰ���ϱ�</button>
								<button @click="fnReviewEdit" class="right_button">�����ϱ�</button>
							</div>	
						</div>
						<div @click="closeScrapModal3()" class="modal noneDisplay" v-if="showScrapModal6" :class="{'showDisplay' : showScrapModal6}">
							<div class="review-back1">
									<button class="back-btn" @click="closeScrapModal3()"><i  class="fa-solid fa-x fa-2x" style="color: #bdbdbd;"></i></button>
							</div>
								<div>
									<img :src="zoomInImg">
								</div>
						</div>
						<div class="recently-viewed">
						<div class="recently-box">
						<div class="recently-box2">
						<div class="recently-box3">
      						<div class="main-option">
								<select class="option-box" v-model="option1" @change="addToSelectedOptions">
									<option value="">��ǰ�� �����ϼ���.</option>
									<option v-for="item in option" :key="item.optionNo + '-' + item.optionName" :value="item.optionNo">
										{{item.optionName}}(+{{item.optionPrice | formatPrice}}��)
									</option>
								</select>
							</div>
							<div class="choice-option">
								<ul>
							       <li v-for="(selectedOption, index) in selectedOptions" :key="index">
							        <span>{{ selectedOption.optionName }}</span>
							        <button class="del-btn"  @click="removeSelectedOption(index)">
							        	<i class="fa-solid fa-x" style="color: #6e86af;"></i>
							        </button> 
							        <div class="option-stock">
							        	 <div class="quantity-box">
										   <button class="minus-btn" @click="decreaseQuantity(selectedOption)">
										   		<i class="fa-solid fa-minus" style="color: #4c6794;"></i>
										   </button>
							               <input v-model ="selectedOption.quantity" min="1">
							               <button class="plus-btn" @click="increaseQuantity(selectedOption)">
							               		<i class="fa-solid fa-plus" style="color: #4b638b;"></i>
							               </button>
										 </div>
										 <div class="option-stock-price">
										 	{{ calculateTotalPrice(selectedOption) | formatPrice}}��
										 </div>
							        </div>							        
							       </li>
							    </ul>    
							</div>

							</div>
							<div class="total-price">
							    <div class="total-title">�ֹ��ݾ�</div>
							    <div class="total-price1">
							    	<span class="total-price2">{{totalPrice | formatPrice}}��</span>
							    </div>
							</div>
							<div class="main-btn-wrap">
								<button class="btn1" @click="fnCart">��ٱ���</button>
								<button class="btn2" @click="fnPay">�ٷα���</button>
							</div>
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
<script src="../js/jquery.js"></script>
<script>
Vue.component('paginate', VuejsPaginate)
function adjustHeight() {
    const recentlyViewed = document.querySelector('.recently-viewed');
    const windowHeight = window.innerHeight;

    // ����� ���̸� �������� ���� ����
    const adjustedHeight = windowHeight - 270; // 220px�� top �Ӽ� ��

    recentlyViewed.style.height = adjustedHeight + 'px';
    recentlyViewed.style.height = adjustedHeight + 'px';
}
window.addEventListener('DOMContentLoaded', adjustHeight);
window.addEventListener('resize', adjustHeight);
var app = new Vue({
	el : '#app',
	components: {
        apexchart: VueApexCharts,
      },
	data : {
		status : '${sessionStatus}',
		cartCheck : [],
		nonuserNo : "",
		selectHelp : [],
		nonUserScrapbook : false,
		category : {},
		scrapbookList : [],
		userEmail : "",
		pwd : "",
		inquirySelectClass : 'option-select-box',
		inquiryTextareaClass : 'inquiry-add-text',
		inquiryTitleClass : 'inquiry-title',
		inquiryOptionCheck : false,
		optionCheckStyle : 'inquiry-content-title',
		inquiryCheck : false,
		optionCheckbox : false,
		openYn : "Y",
		privateCheck : false,
		purchaseYn : "",
		inquiryText : "",
		inquiryCategory : "��ǰ",
		inquiryOption : 0,
		inquiryListCnt : 0,
		inquiryList : [],
		reviewTitleClass : 'review-title',
		reviewTextareaClass : 'review-add-text',
		reviewCsatClass : 'review-csat',
		reviewCsatCheck : false,
		reviewCheck : false,
		characterCount1: 0,
		characterCount2: 0,
		defaultPrice : 0,
		stars: Array(5).fill('empty'),
	    selectedRating: 0,
	    hoveringRating: 0,
		reviewText : "",
		selectedFile: null,
		reviewPrice : 0,
		reviewUser : [],
		userNo : '${sessionNo}',
		totalPrice : 0,
		selectedOptions : [],
		discountPrice : 0,
		optionName : "",
		option1 : "",
		option : [],
		optionPrice : "",
		productNo : '${map.no}',
		product : {},
		csat : {},
		csatAvg : [],
		imgList : [],
		img : [],
		imgList2 : [],
		reviewList : [],
		num : 0 ,
		mainImg : "",
		csatCnt : [],
		selectPage: 1,
		selectPage1: 1,
		pageCount: 1,
		pageCount1: 1,
		cnt : 0,
		cnt1 : 0,
		showScrapModal : false,
		showScrapModal2 : false,
		showScrapModal3 : false,
		showScrapModal4 : false,
		showScrapModal5 : false,
		showScrapModal6 : false,
		zoomInImg : "",
		helpList : [],
		reviewCheck1 : 0,
		contentImgBoxflg : true,
		/* �׷��� ���� */
		series: [{
            data : []
          }],
          chartOptions: {
            chart: {
              type: 'bar',
              height: 50,
              toolbar : {show : false},
              
            },
            tooltip:{
            	 enabled : false
            },
            plotOptions: {
              bar: {
                borderRadius: 4,
                horizontal: true,
              }
            },
            dataLabels: {
             
            },
            fill: {
            	colors: ['#A782C3']
              },
            xaxis: {
            	labels : {show : false},
              categories: ['5��', '4��', '3��', '2��', '1��'
              ],
              axisTicks: { show: false },
              axisBorder: { show: false },
            }
          }, /* �׷��� �� */
	},// data
	filters: {
	    formatPrice(price) {
	      return price.toLocaleString('ko-KR');
	    },
	  },
	  computed: {
		    uniqueOptions() {
		      const uniqueSet = new Set();
		      return this.reviewUser
		        .map(item => item.optionName)
		        .filter(option => {
		          if (!uniqueSet.has(option)) {
		            uniqueSet.add(option);
		            return true;
		          }
		          return false;
		        });
		    }
		  },
	methods : {
		fnLogin : function(){
            var self = this;
            var nparmap = {userEmail : self.userEmail, pwd : self.pwd};
            if(self.userEmail == ""){
            	alert("�̸����� �Է��ϼ���.");
            	return;
            }
            if(self.pwd == ""){
            	alert("��й�ȣ�� �Է��ϼ���.");
            	return;
            }
            $.ajax({
                url : "../login.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {                
               		if(data.success){                		
               			location.reload();	                	
                   	} else {	
                   		alert(data.message);
                   	}
                }                
            }); 
        },
		
		fnGetList : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/productSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.product = data.product;
	            		self.fnGetCategory();
	               		var price = self.product.productPrice - Math.round(self.product.productPrice * (self.product.discount/100));
	               		var price2 = Math.floor(price / 100) * 100;
	               		self.discountPrice =price2
	               		self.product.productPrice = self.product.productPrice
	               		self.defaultPrice = self.product.productPrice;
	                }                
	            }); 
		},
		fnGetCategory : function(){
			var self = this;
            var nparmap = {categoryNo : self.product.categoryNo};	            
            $.ajax({
                url : "../categorySearch.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {                
               		self.category = data.category;
               		
                }                
            }); 
		},
		fnGetInquiryList : function(){
			 	var self = this;
				var startNum = ((self.selectPage1-1) * 5);
				var lastNum = 5;
	            var nparmap = {productNo : self.productNo,startNum : startNum, lastNum : lastNum};	            
	            $.ajax({
	                url : "/selectInquiryList.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.inquiryList = data.inquiryList;
	               		self.cnt1 = data.cnt;
						self.pageCount1 = Math.ceil(self.cnt1 / 5);
	               		for(var i=0; i<self.inquiryList.length; i++){
	               			if(self.inquiryList[i].purchaseYn=="Y"){
	               				self.inquiryList[i].purchaseYn="����"
	               			}else{
	               				self.inquiryList[i].purchaseYn="�񱸸�"
	               			}
	               			
	               		}
	                }                
	            }); 
		},
		 fnSearch1 : function(pageNum){
				var self = this;
				self.selectPage1 = pageNum;
				var startNum = ((self.selectPage1-1) * 5);
				var lastNum = 5;
				var nparmap = {productNo : self.productNo,startNum : startNum, lastNum : lastNum};
				$.ajax({
					url : "/selectInquiryList.dox",
					dataType : "json",
					type : "POST",
					data : nparmap,
					success : function(data) {
						self.inquiryList = data.inquiryList;
						self.cnt1 = data.cnt;
						self.pageCount1 = Math.ceil(self.cnt1 / 5);
						for(var i=0; i<self.inquiryList.length; i++){
	               			if(self.inquiryList[i].purchaseYn=="Y"){
	               				self.inquiryList[i].purchaseYn="����"
	               			}else{
	               				self.inquiryList[i].purchaseYn="�񱸸�"
	               			}
	               		}
					}
				});
			},
		fnGetInquiryListCnt : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/selectInquiryListCnt.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.inquiryListCnt = data.inquiryListCnt;
	               		}
	                              
	            }); 
		},
		fnAvg : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/csatSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.csat = data.csat;
	               		self.num = 5 - self.csat.csatAvg;
	               		self.csatAvg = [self.csat.csatAvg];	         
	                }                
	            }); 
		},
		fnOption : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/optionSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.option = data.option;
	              
	                }                
	            }); 
		},
		fnImg : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/imgSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.imgList = data.imgList;
	                }                
	            }); 
		},
		fnThumbnailImg : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/imgThumbnailSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.img = data.img;
	               		self.mainImg = self.img[0].imgPath+"/"+self.img[0].imgName
	                }                
	            }); 
		},
		fnContentImg : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/imgSearch2.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.imgList2 = data.imgList2;
	                }                
	            }); 
		},
		fnReview : function(){
			 var self = this;
			 	var startNum = ((self.selectPage-1) * 5);
	    		var lastNum = 5;
	            var nparmap = {productNo : self.productNo,startNum : startNum, lastNum : lastNum};	            
	            $.ajax({
	                url : "/reviewSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {                
	               		self.reviewList = data.reviewList;
	               		self.cnt = data.cnt;
		                self.pageCount = Math.ceil(self.cnt / 5);
		                
	                }                
	            })
		},
		 fnSearch : function(pageNum){	
			var self = this;
			self.selectPage = pageNum;
			var startNum = ((pageNum-1) * 5);
			var lastNum = 5;
			var nparmap = {productNo : self.productNo,startNum : startNum, lastNum : lastNum};
			$.ajax({
				url : "/reviewSearch.dox",
				dataType : "json",
				type : "POST",
				data : nparmap,
				success : function(data) {
					self.reviewList = data.reviewList;
					self.cnt = data.cnt;
					self.pageCount = Math.ceil(self.cnt / 5);
				}
			});
		},
		fnReviewCnt : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo};	            
	            $.ajax({
	                url : "/reviewCntSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {
	                	var csat1 = data.csat1
	                	var csat2 = data.csat2
	                	var csat3 = data.csat3
	                	var csat4 = data.csat4
	                	var csat5 = data.csat5
	               		self.csatCnt = [csat5, csat4, csat3, csat2, csat1];
	               		self.series = [{
	                        data: self.csatCnt
	                      }]
	                }                
	            })
		},
		fnReviewUser : function(){
			 var self = this;
	            var nparmap = {productNo : self.productNo, userNo : self.userNo};	            
	            $.ajax({
	                url : "/reviewUserSearch.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {
	                	self.reviewUser = data.user	
	                	if(self.reviewUser.length==0){
	                		self.purchaseYn = "N"
	                	}else{
	                		self.purchaseYn = "Y"
	                	}
	                	var optionSet = new Set();
	                	var optionNames = [];

	                	for (var i = 0; i < self.reviewUser.length; i++) {
	                	  self.reviewPrice += self.reviewUser[i].orderPrice;
	                	  optionSet.add(self.reviewUser[i].optionName);
	                	}

	                	optionSet.forEach(option => {
	                	  optionNames.push(option);
	                	});

	                	self.optionName = optionNames.join(" + ");
	                }                
	            })
		},
		handleFileChange(event) {
		     
		      this.selectedFile = event.target.files[0];
		    },
		fnReviewAdd : function(){
			var self = this;
			if(self.reviewText == ""){
				self.reviewCheck = true;
				self.changeTextareaStyle();
			}
			if(self.selectedRating ==0){
				self.reviewCsatCheck = true;
				self.changeCsatStyle();
			}
			if(self.reviewCheck || self.reviewCsatCheck){
				return;	
			}
            var nparmap = {userNo : self.userNo, reviewText : self.reviewText, productNo : self.productNo, csat : self.selectedRating, optionName : self.optionName};
            $.ajax({
                url:"/reviewAdd.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
	           		var form = new FormData();
	           		alert("��ϵǾ����ϴ�.")
	       	        form.append( "file1",  $("#file1")[0].files[0] );
	       	     	form.append( "idx",  data.idx); // pk
	       	     	if(self.selectedFile != null){
	       	     		self.upload(form); 	       	     		
	       	     	}else{
	       	     		self.optionName = "";	       	     		
	       	     		self.reviewPrice = 0;
	       	     		self.selectedRating = 0;
	       	     		self.reviewText = "";
	       	     		self.showScrapModal = false;
		       	 		self.fnReview();
		       			self.fnReviewCnt();
		       			self.fnReviewUser();
		       			self.fnAvg();
		       			self.fnReviewCheck();
	       	     	}
                }
            });
		},
		 upload : function(form){
	    	var self = this;
	         $.ajax({
	             url : "/reviewFileUpload.dox"
	           , type : "POST"
	           , processData : false
	           , contentType : false
	           , data : form
	           , success:function(response) { 
	        		self.fnReview();
	       			self.fnReviewCnt();
	       			self.fnReviewUser();
	       			self.fnAvg();
	       			self.optionName = "";	       	     		
       	     		self.reviewPrice = 0;
       	     		self.selectedRating = 0;
       	     		self.reviewText = "";
       	     		self.showScrapModal = false;
	           }	           
	       });
		},
		changeCsatStyle() {
		      if (this.reviewCsatCheck) {		    	
		        this.reviewCsatClass = 'not-check-csat';
		      } else {
		        this.reviewCsatClass = 'review-csat';		        
		      }	
		},
		changeTextareaStyle() {
		      if (this.reviewCheck) {
		        this.reviewTextareaClass = 'not-check-textarea';
		        this.reviewTitleClass = 'not-check-title';
		      } else {
		        this.reviewTextareaClass = 'review-add-text';
		        this.reviewTitleClass = 'review-title';
		      }	
		},
		changeOptionStyle() {
		      if (this.inquiryOptionCheck) {		    	
		        this.optionCheckStyle = 'not-check-option';
		        this.inquirySelectClass = 'not-check-select';
		      } else {
		        this.optionCheckStyle = 'inquiry-content-title';
		        this.inquirySelectClass = 'option-select-box';
		      }	
		},
		reviewTextarea(){
			this.reviewCheck=false;
			this.changeTextareaStyle();
		},
		inquiryTextarea(){
			this.inquiryCheck=false;
			
		},
		addToSelectedOptions() {
		      const selectedItem = this.option.find(item => item.optionNo === this.option1);
		      if (selectedItem) {
		    	const existingOption = this.selectedOptions.find(opt => opt.optionNo === selectedItem.optionNo);
		    	if (existingOption) {
		            existingOption.quantity++; // �̹� �ִ� ��ǰ�� ���� ����
		          }else{
		        	  this.selectedOptions.push({
		        		  productNo : this.productNo,
				          optionNo: selectedItem.optionNo,
				          optionName: selectedItem.optionName,
				          quantity : 1
				        }); 
		        	  this.calculateOrderTotal();
		          }
		        this.option1="";
		      }
		    },
		removeSelectedOption(index) {
		        this.selectedOptions.splice(index, 1);
		        this.calculateOrderTotal();
		      },
		decreaseQuantity(selectedOption) {
		        if (selectedOption.quantity > 1) {
		          selectedOption.quantity--;
		          this.calculateOrderTotal();
		        }
		      },
		increaseQuantity(selectedOption) {
		    	  selectedOption.quantity = selectedOption.quantity + 1;
		    	  this.calculateOrderTotal();
		        
		      },
		   // totalPrice ��� �޼���
		calculateTotalPrice(selectedOption) {
		        const item = this.option.find(opt => opt.optionNo === selectedOption.optionNo);
		        return item ? (item.optionPrice+this.discountPrice) * selectedOption.quantity : 0;
		      },

		      // �� �ֹ��ݾ� ��� �޼���
		calculateOrderTotal() {
		        this.totalPrice = this.selectedOptions.reduce((total, option) => {
		          return total + this.calculateTotalPrice(option);
		        }, 0);
		      },
		fnPay : function(){
			 var self = this;
			 if(self.selectedOptions.length == 0){
				 alert("��ǰ�� �������ּ���.");
				 return;
			 }
			 if(self.userNo==null || self.userNo==""){
				 self.showScrapModal3 = true;
				 return;
			 }
			if(self.selectedOptions.length > 0 && (self.userNo !=null || self.userNo !="")){
				 $.pageChange("../order/main.do" , {product : self.selectedOptions});
			 } 
			},
		fnPay1 : function(){
			var self = this;
			if(self.selectedOptions.length == 0){
				alert("��ǰ�� �������ּ���.");
				return;
			}
			if(self.selectedOptions.length > 0){
				$.pageChange("../order/main.do" , {product : self.selectedOptions});
			} 
			},
		clickImg : function(imgPath,imgName){
			var self = this
			self.mainImg = imgPath+"/"+imgName;
			},
		prevPage() {
			this.currentPage--;
			},
		nextPage() {
			this.currentPage++;
			},
		openScrapModal: function() {
		    var self = this;
		    if(self.reviewCheck1 > 0){
				self.showScrapModal5 = true;
			} else{
			    self.showScrapModal = true;	
			}
		    
		    },
		openScrapModal2: function() {
		    var self = this;
		    if(self.userNo == "" || self.userNo == null){
	    		self.showScrapModal3 = true;
				self.nonUserScrapbook = true;
				return;
	    	}
		    self.showScrapModal2 = true;
		    },
		closeScrapModal: function() {
			var self = this;
			self.showScrapModal = false;
			self.selectedFile = null;
			self.reviewText="";
			self.selectedRating=0;
			self.characterCount1=0;
			},
		closeScrapModal2: function() {
			var self = this;
			self.showScrapModal2 = false;
			self.characterCount2=0;
			self.inquiryOption = 0;
			self.inquiryText="";
			self.inquiryCategory = "��ǰ";
			self.privateCheck = false;
			},
		closeScrapModal3: function() {
			var self = this;
			self.showScrapModal3 = false;
			self.showScrapModal6 = false;
			self.nonUserScrapbook = false;
			},
		starClass(index) {
			 const rating = this.hoveringRating || this.selectedRating;
			 if (rating >= index + 1) {
			     return 'fa-solid fa-star custom-star filled';
			  } else if (rating >= index + 0.5) {
			     return 'fa-solid fa-star custom-star half';
			  } else {
			     return 'fa-solid fa-star custom-star empty';
			   }
			 },
		hover(rating) {
			 this.hoveringRating = rating;
			 },
		rate(rating) {
			 this.selectedRating = rating;
			 this.hoveringRating = 0; // Ŭ������ �� ȣ�� ���� ����
			 this.reviewCsatCheck = false;
			 this.changeCsatStyle();
			 },
		clearHover() {
			 if (this.selectedRating === 0) {
			   this.hoveringRating = 0;
			    }
			 },
		updateCharacterCount1() {
			 this.characterCount1 = this.reviewText.length;			
			 },
		updateCharacterCount2() {			 
			 this.characterCount2 = this.inquiryText.length;
			 },
		changeCategoryStyle(category) {
			// inquiryCategory ������ ������Ʈ
			this.inquiryCategory = category;
			if(category =="��ǰ" || this.inquiryCategory == "��ǰ"){
				this.privateCheck = false;
			}else{
				this.privateCheck = true;
			}
			// ���õ� ����� active Ŭ������ �߰��ϰ� ������ ����� active Ŭ������ ����
			const boxes = document.querySelectorAll('.inquiry-category-box1');
			boxes.forEach(box => box.classList.remove('active'));
			event.target.classList.add('active');
			},
		privateInquiry(){
				var self = this;
				const checkbox = document.getElementById('openYnCheckbox');
			    self.openYn = checkbox.checked ? "N" : "Y";
			},
		inquiryAdd(){
				 var self = this;
				 if(self.inquiryText == ""){
					 
					 self.inquiryCheck = true;
				 }
				 if(self.inquiryOption == 0 && !self.optionCheckbox){
					 self.inquiryOptionCheck = true;
					 self.changeOptionStyle();
				 } 
				 if(self.inquiryCheck || self.inquiryOptionCheck){
					 return;
				 }
		         var nparmap = {productNo : self.productNo, userNo : self.userNo, content : self.inquiryText, openYn : self.openYn, inquiryCategory : self.inquiryCategory, purchaseYn : self.purchaseYn, optionNo : self.inquiryOption};
		         $.ajax({
		             url : "/inquiryAdd.dox",
		             dataType:"json",	
		             type : "POST", 
		             data : nparmap,
		             success : function(data) {
		                alert(data.message);
		                self.fnGetInquiryList();
		        		self.fnGetInquiryListCnt();
		        		self.showScrapModal2=false;
		        		self.inquiryText = "";
		        		self.inquiryOption = 0;
		        		self.inquiryCategory = "��ǰ";
		        		self.privateCheck = false;
		             }             
		            });
			},
			optionCheckYn(){
				var self = this;				
				const checkbox = document.getElementById('optionYnCheckbox');
			    self.optionCheckbox = checkbox.checked ? true : false;
			    self.inquiryOptionCheck = false;
			    self.changeOptionStyle();
			},
			fnCheckScrap : function() {
		    	var self = this;
	            var nparmap = {userNo: self.userNo, productNo : self.productNo};
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
			fnInsertScrapbook : function() {
		    	var self = this;
	            var nparmap = { userNo: self.userNo, productNo: self.productNo};
	            if(self.userNo == "" || self.userNo==null){
	            	self.showScrapModal3 = true;
	            	self.nonUserScrapbook = true;
	            	return;
	            }
	            $.ajax({
	                url : "/product/insertScrap.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) { 
	                	self.fnCheckScrap();
	                }
	            }); 
	            
			},
		    fnDeleteScrapbook : function() {
		    	var self = this;
	            var nparmap = { userNo: self.userNo, productNo: self.productNo};
	           
	            $.ajax({
	                url : "/product/deleteScrap.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) { 
	                	self.fnCheckScrap();
	                	self.scrapbookList = [];
	                }
	            }); 
	            
			},
			 shareSelectedOption() {
			      // ���� �������� URL�� ��������
			      const currentUrl = window.location.href;
			      
			      // �ؽ�Ʈ�� Ŭ�����忡 ����
			      const textArea = document.createElement("textarea");
			      textArea.value = currentUrl;
			      document.body.appendChild(textArea);
			      textArea.select();
			      document.execCommand("copy");
			      document.body.removeChild(textArea);
			      
			      alert("���� ������ URL�� ����Ǿ����ϴ�.");
			    },
			   fnSelectHelp(){
			    	var self = this;
			    	if(self.userNo==""||self.userNo==null){
			    		return;
			    	}
		            var nparmap = { userNo: self.userNo};
		            $.ajax({
		                url : "/reviewSelectHelp.dox",
		                dataType:"json",	
		                type : "POST", 
		                data : nparmap,
		                success : function(data) { 
		                	self.selectHelp=data.selectHelp
		                	self.helpList = [];
		                	self.selectHelp.forEach(item => self.helpList.push(item.rNo));		                
		                }
		            });
			    },
			   fnHelp(rNo){
			    	var self = this;			
			    	if(self.userNo == "" || self.userNo == null){
			    		self.showScrapModal3 = true;
						self.nonUserScrapbook = true;
						return;
			    	}
		            var nparmap = { userNo: self.userNo, productNo: self.productNo, rNo : rNo};
		            $.ajax({
		                url : "/reviewHelp.dox",
		                dataType:"json",	
		                type : "POST", 
		                data : nparmap,
		                success : function(data) { 
		                	self.fnReview();
		                	self.fnSelectHelp();
		                }
		            });
			    },
			   fndeleteHelp(rNo){
			    	var self = this;
		            var nparmap = { userNo: self.userNo, productNo: self.productNo, rNo : rNo};
		            $.ajax({
		                url : "/reviewDeleteHelp.dox",
		                dataType:"json",	
		                type : "POST", 
		                data : nparmap,
		                success : function(data) {
		                	self.helpList = [];
		                	self.fnReview();
		                	self.fnSelectHelp();
		                }
		            });
			    },
			    scrollUpFromSection(sectionId, amount) {
			    	  const section = document.getElementById(sectionId);
			    	  if (section) {
			    	    const currentScrollPosition = section.getBoundingClientRect().top + window.scrollY;
			    	    const targetScrollPosition = currentScrollPosition - amount;
			    	    window.scrollTo({
			    	      top: targetScrollPosition,
			    	      behavior: "smooth"
			    	    });
			    	}
			    },
			    fnCart(){
			    	var self = this;
			    	if(self.selectedOptions.length == 0){
			    		alert("��ǰ�� �������ּ���.")
			    	}
			    	self.selectedOptions.forEach(selectedOption => {
			    		  const item = self.cartCheck.find(cartItem => cartItem.optionNo === selectedOption.optionNo);
			    		  if (item) {
			    			  self.showScrapModal4 = true;
			    			  return;
			    		  }
			    		
			    	for(let i=0; i<self.selectedOptions.length; i++){
			    		if(self.userNo!=""||self.userNo!=null){
			    			var nparmap = { userNo: self.userNo, productNo: self.productNo, optionNo : self.selectedOptions[i].optionNo, cnt:self.selectedOptions[i].quantity};	
			    		}
			    		if(self.userNo==""||self.userNo==null){
			    			var nparmap = { nonUserNo: self.nonuserNo, productNo: self.productNo, optionNo : self.selectedOptions[i].optionNo, cnt:self.selectedOptions[i].quantity};
			    		}
				            $.ajax({
				                url : "/cartAdd.dox",
				                dataType:"json",	
				                type : "POST", 
				                data : nparmap,
				                success : function(data) {
				                	self.showScrapModal4 = true;
				                	 self.selectedNparmap = nparmap;
				                	 // �Ѱܹ��� nparmap ���� LocalStorage�� ����
				                	  localStorage.setItem("selectedNparmap", JSON.stringify(nparmap));
				                }
				            });
			    	}
			    	})
		           
			    },
			    fnMoveCart(){
			    	location.href = "/product/cart.do"
			    },
			    fnMedal(){
			    	var self = this;
			    	self.showScrapModal4 = false;
			    	location.reload();
			    	
			    },
			  //��ȸ�� ��ȣ ��Ű�ҷ����� �� 
				fnaaa : function(item){
					var self = this;
		            var nparmap = '';
		            //{ nonuserNo: self.nonuserNo, productNo: item.productNo};
					 $.ajax({
			                url : "/nonUserCookie.dox",
			                dataType:"json",	
			                type : "POST", 
			                data : nparmap,
			                success : function(data) { 
			                	self.nonuserNo = data.value;
			                	self.fnCartCheck();
			                }
			            }); 
				},
				fnCartCheck(){
			    	var self = this;			    	
			    	if(self.userNo!=""||self.userNo!=null){			    		
			    		var nparmap = { userNo: self.userNo, productNo: self.productNo};
			    	}
			    	if(self.userNo==""||self.userNo==null){
			    		var nparmap = { nonUserNo: self.nonuserNo, productNo: self.productNo};
			    	}	
			    	
				    $.ajax({
				              url : "/cartCheck.dox",
				              dataType:"json",	
				              type : "POST", 
				              data : nparmap,
				           success : function(data) {
				               self.cartCheck=data.cartCheck
				           }
				        });
			    	},
			    	fnReviewEdit(){
			    		location.href="/mypage/myReview.do"
			    	},
			    	fnReviewCheck(){
			    		var self = this;
			            var nparmap = { userNo: self.userNo, productNo: self.productNo};
			            $.ajax({
			                url : "/selectReviewCheck.dox",
			                dataType:"json",	
			                type : "POST", 
			                data : nparmap,
			                success : function(data) {
			                	if(data.reviewCheck > 0){
			                		self.reviewCheck1 = 1;
			                	}
			                }
			            });
			    	},
			    	fnToggleContentImgBoxFlg(){
			    		this.contentImgBoxflg = !this.contentImgBoxflg;
			    		const section = document.getElementById('product');
				    	  if (section) {
				    	    const currentScrollPosition = section.getBoundingClientRect().top + window.scrollY;
				    	    const targetScrollPosition = currentScrollPosition + 300;
				    	    window.scrollTo({
				    	      top: targetScrollPosition,
				    	    });
				    	}
			    	},
			    	zoomImg(path,name){
			    		this.showScrapModal6 = true;
			    		this.zoomInImg=path+"/"+name;
			    		console.log(this.zoomInImg);
			    	}
			     
	}, // methods
	created : function() {
		var self = this;
		self.fnGetList();
		self.fnAvg();
		self.fnOption();
		self.fnImg();
		self.fnThumbnailImg();
		self.fnContentImg();
		self.fnReview();
		self.fnReviewCnt();
		self.fnReviewUser();
		self.changeCsatStyle();
		self.changeTextareaStyle();
		self.fnGetInquiryList();
		self.fnGetInquiryListCnt();
		self.fnCheckScrap();
		self.fnSelectHelp();
		self.fnaaa();
		self.fnReviewCheck();
	}// created
});
</script>