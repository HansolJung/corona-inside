<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Corona Inside : 코로나 현황</title>
	<link rel="stylesheet" href="resources/css/bootstrap.min.css">
	<!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/img/favicon_covid.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" crossorigin="anonymous"></script>
	<!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="resources/css/styles.css" rel="stylesheet" />
    <!-- Custom fonts for this template-->
    <link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
   	<link
       	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
       	rel="stylesheet">

	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zcp9jxvljw&callback=initMap&submodules=geocoder"></script>
	
	
	<link rel="stylesheet" href="resources/css/korea.css" />
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="http://d3js.org/d3.v4.min.js"></script>

	<script src="resources/js/demo/d3.js"></script>
	<script src="resources/js/demo/mapping3.js"></script>
	<script src="resources/js/demo/mapping4.js"></script>
	
	<style>
		#bt1 {background:#7E41D9;}/*전구 켜기 버튼 css속성*/
		#bt2 {background:#7E41D9;}/*전구 끄기 버튼 css속성*/

	</style>
</head>
<body id="page-top">
	<!-- Bootstrap core JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<!-- Third party plugin JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	

	<div id="tooltip" class="hidden">
		<p>This Value : <b id="value"></b></p>
	</div>

	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" style="padding-left: 10px;" href="home">Corona Inside</a>
			<button class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-violet text-white rounded"
				type="button" data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<c:choose>
						<c:when test="${session.getAttribute('username') == null}">
							<li class="nav-item mx-0 mx-lg-1 login-item"><a
								class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
								href="login">로그인 하기</a></li>
						</c:when>
						<c:when test="${session.getAttribute('username') != null}">
							<li class="nav-item mx-0 mx-lg-1"><a
								class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger">
									<%=session.getAttribute("username")%>님 환영합니다.
							</a></li>
						</c:when>
					</c:choose>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger text-selected"
						href="corona">코로나 현황</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						href="vaccine">백신현황</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						href="community">커뮤니티</a></li>
				</ul>
				
			</div>
			<c:choose>
				<c:when test="${session.getAttribute('username') == null}">
					<button class="bg-primary rounded text-white login-btn"
						id="login-btn" onClick="location.href='login'">로그인</button>
				</c:when>
				<c:when test="${session.getAttribute('username') != null}">
					<button class="bg-primary rounded text-white login-btn"
						id="login-btn" onClick="location.href='logout'">로그아웃</button>
				</c:when>
			</c:choose>
		</div>
	</nav>

	<!-- Masthead-->
	<header class="masthead bg-violet text-white text-center">
		<div class="container d-flex align-items-center flex-column">
			<!-- Masthead Heading-->
			<h1 class="masthead-heading text-uppercase mb-0">Corona Inside</h1>
			<!-- Icon Divider-->
			<div class="divider-custom divider-light">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
		</div>
	</header>

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<div class="row">

						<div class="col-xs-12 col-xl-8 col-lg-7">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-violet">일별 신규 확진자 수
									<!-- <button class="bg-violet rounded text-white float-right badge-pill" onClick="buttonClick3(this)">1달</button>			
									<button class="bg-violet rounded text-white float-right mx-3 badge-pill" onClick="buttonClick2(this)">2주</button>
									<button class="bg-violet rounded text-white float-right mx-0 badge-pill" onClick="buttonClick1(this)">1주</button> -->
									
									<div class="btn-group" role="group" aria-label="Basic example" style="float: right;">
												<button type="button" class="btn btn-violet" onClick="buttonClick1(this)">1주</button>
  												<button type="button" class="btn btn-violet" onClick="buttonClick2(this)">2주</button>
  												<button type="button" class="btn btn-violet" onClick="buttonClick3(this)">1달</button>
									</div>

									</h6>
									
								</div>
								<div class="card-body">
									<div id="myBar">
										<div class="chart-bar">
											<canvas id="myBarChart2"></canvas>
										</div>
									</div>
									<br><span class="badge badge-secondary">국내현황 ${beforeHour} 00:00 집계 기준.</span>
									
									
								</div>
							</div>
						</div>
						<!-- Pie Chart -->
						<div class="col-xs-12 col-xl-4 col-lg-5">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-violet">오늘자 검사진행 수</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-pie pt-4 pb-2">
										<canvas id="myPieChart"></canvas>
									</div>
									<div class="mt-4 text-center small">
										<span class="mr-2"> <i
											class="fa fa-circle text-violet"></i> 검사진행 수
										</span> <span class="mr-2"> <i
											class="fa fa-circle text-warning"></i> 치료중 환자 수
										</span> <span class="mr-2"> <i
											class="fa fa-circle text-danger"></i> 사망자 수
										</span>
									</div>
									<br><span class="badge badge-secondary">국내현황 ${beforeHour} 00:00 집계 기준.</span>
								</div>
							</div>
						</div>

						<!-- Area Chart -->
						<div class="col-xs-12 col-xl-12 col-lg-12">
							<div class="card shadow mb-4">
								<!-- Card Header -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-violet">날짜별 누적 확진자 수</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="chart-area">
										<canvas id="myAreaChart"></canvas>
									</div>
									
									<br><span class="badge badge-secondary">국내현황 ${beforeHour} 00:00 집계 기준.</span>
								</div>
							</div>
						</div>

					</div>
					<!-- Content Row -->
					<div class="row">

						<!-- Content Column -->
						<div class="col-xs-12 col-lg-6 mb-4">

							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-violet">지역별 누적확진자 수</h6>
								</div>

								<div class="card-body">
									<div class="chart-bar">
										<canvas id="myBarChart"></canvas>
									</div>
									
									<br><span class="badge badge-secondary">국내현황 ${beforeHour} 00:00 집계 기준.</span>
								</div>

							</div>
							
							
							
							<div class="card shadow mb-4">
								
								<div class="card-header py-3">				
										<a id="section"></a>
									<h6 class="m-0 font-weight-bold text-violet">코로나 뉴스 리스트</h6>
								</div>
								<div class="card-body">
									<ul class="list-group">
										<li class="list-group-item"><a href=${href0} target="_blank">${item0}</a></li>
										<li class="list-group-item"><a href=${href1} target="_blank">${item1}</a></li>
										<li class="list-group-item"><a href=${href2} target="_blank">${item2}</a></li>
										<li class="list-group-item"><a href=${href3} target="_blank">${item3}</a></li>
										<li class="list-group-item"><a href=${href4} target="_blank">${item4}</a></li>
										<li class="list-group-item"><a href=${href5} target="_blank">${item5}</a></li>
										<li class="list-group-item"><a href=${href6} target="_blank">${item6}</a></li>
										<li class="list-group-item"><a href=${href7} target="_blank">${item7}</a></li>
										<li class="list-group-item"><a href=${href8} target="_blank">${item8}</a></li>
										<li class="list-group-item"><a href=${href9} target="_blank">${item9}</a></li>
									</ul>
								</div>
								<script type="text/javascript">
								$(document).ready(function() {
									var target = $(location).attr("hash");
									var offset = ($(this).attr('data-offset') ? $(this).attr('data-offset') : 0);
							
									$('body,html').animate({
										scrollTop: $(target).offset().top - offset
									}, 700);
									
								});
								</script>
							</div>
							
						</div>

						<div class="col-xs-12 col-lg-6 mb-4">

							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-violet">선별진료소 위치</h6>
								</div>
								<div class="card-body">
								<!--<div class="card-body">
                                    <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce
                                        CSS bloat and poor page performance. Custom CSS classes are used to create
                                        custom components and custom utility classes.</p>
                                    <p class="mb-0">Before working with this theme, you should become familiar with the
                                        Bootstrap framework, especially the utility classes.</p>
                                </div>
								<div id="map" style="width: 100%; height: 400px;"></div>  -->
								<div id="map" style="width: 100%; height: 400px;"></div>
								</div>
								
							</div>

							<!-- Illustrations -->
							<!--  <div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-violet">허전해서</h6>
								</div>
								<div class="card-body">
									<div class="text-center">
										<img class="img-fluid px-3 px-sm-4 mt-3 mb-4"
											style="width: 25rem;" src="resources/assets/img/covid.svg"
											alt="">
									</div>
									<p>
										Add some quality, svg illustrations to your project courtesy
										of <a target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>,
										a constantly updated collection of beautiful svg images that
										you can use completely free and without attribution!
									</p>
									<a target="_blank" rel="nofollow" href="https://undraw.co/">Browse
										Illustrations on unDraw &rarr;</a>
								</div>
							
							</div> -->
					
							
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-violet">지역별 데이터
									<!-- <button id="bt1" class="rounded text-white float-right mx-3 badge-pill" onClick="buttonClick4(this)">누적 확진자수</button>
									<button id="bt2" class="rounded text-white float-right mx-0 badge-pill" onClick="buttonClick5(this)">거리두기 단계</button> -->
									
									<div class="btn-group" role="group" aria-label="Basic example" style="float: right;">
												<button type="button" class="btn btn-violet" onClick="buttonClick5(this)">거리두기 단계</button>
  												<button type="button" class="btn btn-violet" onClick="buttonClick4(this)">누적 확진자수</button>
									</div>
									</h6>
								</div>
								  
                                <div class="card-body">
									<div id="container"></div>
									<div id="container2"></div>
									
									<br><span class="badge badge-secondary">국내현황 2021/05/04 00:00 집계 기준 (거리두기 단계)</span>
								</div>
								
							</div>
												
						</div>
						<!-- /.container-fluid -->

					</div>
					<!-- End of Main Content -->

					<!-- Copyright Section-->
					<div class="copyright py-4 text-center text-white">
						<div class="container">
							<small>Copyright © Corona-Inside 2021</small>
						</div>

					</div>



				</div>
				<!-- End of Content Wrapper -->

			</div>
			<!-- End of Page Wrapper -->

			<!-- Bootstrap core JS-->
		
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
			<!-- Third party plugin JS-->
		

			<!-- Custom scripts for all pages-->
			<script src="js/sb-admin-2.js"></script>

			<!-- Page level plugins -->
			<script src="resources/vendor/chart.js/Chart.min.js"></script>

			<!-- Page level custom scripts -->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazyload/1.9.1/jquery.lazyload.js"></script>
			<script>
			
				var btnCount = 0;
				
				function strAddSlash(str) {
					var len = str.length;
					var rtnStr = "";
					for (var i = 0, j = len; i < len; i++, j--) {
						if (j % 2 == 0 && j != len) {
							rtnStr += "/";
						}
						rtnStr += str.charAt(i);
					}
					return rtnStr;
				};



				var date0 = strAddSlash("${InfDTO.getItem()[0].getStateDt()}".substring(4, 8));
				var date1 = strAddSlash("${InfDTO.getItem()[1].getStateDt()}".substring(4, 8));
				var date2 = strAddSlash("${InfDTO.getItem()[2].getStateDt()}".substring(4, 8));
				var date3 = strAddSlash("${InfDTO.getItem()[3].getStateDt()}".substring(4, 8));
				var date4 = strAddSlash("${InfDTO.getItem()[4].getStateDt()}".substring(4, 8));
				var date5 = strAddSlash("${InfDTO.getItem()[5].getStateDt()}".substring(4, 8));
				var date6 = strAddSlash("${InfDTO.getItem()[6].getStateDt()}".substring(4, 8));
				var date7 = strAddSlash("${InfDTO.getItem()[7].getStateDt()}".substring(4, 8));
				var date8 = strAddSlash("${InfDTO.getItem()[8].getStateDt()}".substring(4, 8));
				var date9 = strAddSlash("${InfDTO.getItem()[9].getStateDt()}".substring(4, 8));
				var date10 = strAddSlash("${InfDTO.getItem()[10].getStateDt()}".substring(4, 8));
				var date11 = strAddSlash("${InfDTO.getItem()[11].getStateDt()}".substring(4, 8));
				var date12 = strAddSlash("${InfDTO.getItem()[12].getStateDt()}".substring(4, 8));
				var date13 = strAddSlash("${InfDTO.getItem()[13].getStateDt()}".substring(4, 8));
				var date14 = strAddSlash("${InfDTO.getItem()[14].getStateDt()}".substring(4, 8));
				var date15 = strAddSlash("${InfDTO.getItem()[15].getStateDt()}".substring(4, 8));
				var date16 = strAddSlash("${InfDTO.getItem()[16].getStateDt()}".substring(4, 8));
				var date17 = strAddSlash("${InfDTO.getItem()[17].getStateDt()}".substring(4, 8));
				var date18 = strAddSlash("${InfDTO.getItem()[18].getStateDt()}".substring(4, 8));
				var date19 = strAddSlash("${InfDTO.getItem()[19].getStateDt()}".substring(4, 8));
				var date20 = strAddSlash("${InfDTO.getItem()[20].getStateDt()}".substring(4, 8));
				var date21 = strAddSlash("${InfDTO.getItem()[21].getStateDt()}".substring(4, 8));
				var date22 = strAddSlash("${InfDTO.getItem()[22].getStateDt()}".substring(4, 8));
				var date23 = strAddSlash("${InfDTO.getItem()[23].getStateDt()}".substring(4, 8));
				var date24 = strAddSlash("${InfDTO.getItem()[24].getStateDt()}".substring(4, 8));
				var date25 = strAddSlash("${InfDTO.getItem()[25].getStateDt()}".substring(4, 8));
				var date26 = strAddSlash("${InfDTO.getItem()[26].getStateDt()}".substring(4, 8));
				var date27 = strAddSlash("${InfDTO.getItem()[27].getStateDt()}".substring(4, 8));
				var date28 = strAddSlash("${InfDTO.getItem()[28].getStateDt()}".substring(4, 8));
				var date29 = strAddSlash("${InfDTO.getItem()[29].getStateDt()}".substring(4, 8));
				var date30 = strAddSlash("${InfDTO.getItem()[30].getStateDt()}".substring(4, 8));
				var date31 = strAddSlash("${InfDTO.getItem()[31].getStateDt()}".substring(4, 8));
				
							

				/*
				var date12 = strAddSlash("${InfDTO.getItem()[0].getStateDt()}"
						.substring(4, 8));
				var date11 = strAddSlash("${InfDTO.getItem()[1].getStateDt()}"
						.substring(4, 8));
				var date10 = strAddSlash("${InfDTO.getItem()[2].getStateDt()}"
						.substring(4, 8));
				var date9 = strAddSlash("${InfDTO.getItem()[3].getStateDt()}"
						.substring(4, 8));
				var date8 = strAddSlash("${InfDTO.getItem()[4].getStateDt()}"
						.substring(4, 8));
				var date7 = strAddSlash("${InfDTO.getItem()[5].getStateDt()}"
						.substring(4, 8));
				var date6 = strAddSlash("${InfDTO.getItem()[6].getStateDt()}"
						.substring(4, 8));
				var date5 = strAddSlash("${InfDTO.getItem()[7].getStateDt()}"
						.substring(4, 8));
				var date4 = strAddSlash("${InfDTO.getItem()[8].getStateDt()}"
						.substring(4, 8));
				var date3 = strAddSlash("${InfDTO.getItem()[9].getStateDt()}"
						.substring(4, 8));
				var date2 = strAddSlash("${InfDTO.getItem()[10].getStateDt()}"
						.substring(4, 8));
				var date1 = strAddSlash("${InfDTO.getItem()[11].getStateDt()}"
						.substring(4, 8));
				var date0 = strAddSlash("${InfDTO.getItem()[12].getStateDt()}"
						.substring(4, 8));
				var date00 = strAddSlash("${InfDTO.getItem()[13].getStateDt()}"
						.substring(4, 8));


				*/
				//var sick = strAddComma(date12);
				/* 
				 function slice(var ex) {
				 var month = ex.substring(0,2);
				 var day = ex.substring(2,4);



				 console.log(month);
				 }



				 slice(date12); */
				/*
				var cnt12 = "${InfDTO.getItem()[0].getDecideCnt()}";
				var cnt11 = "${InfDTO.getItem()[1].getDecideCnt()}";
				var cnt10 = "${InfDTO.getItem()[2].getDecideCnt()}";
				var cnt9 = "${InfDTO.getItem()[3].getDecideCnt()}";
				var cnt8 = "${InfDTO.getItem()[4].getDecideCnt()}";
				var cnt7 = "${InfDTO.getItem()[5].getDecideCnt()}";
				var cnt6 = "${InfDTO.getItem()[6].getDecideCnt()}";
				var cnt5 = "${InfDTO.getItem()[7].getDecideCnt()}";
				var cnt4 = "${InfDTO.getItem()[8].getDecideCnt()}";
				var cnt3 = "${InfDTO.getItem()[9].getDecideCnt()}";
				var cnt2 = "${InfDTO.getItem()[10].getDecideCnt()}";
				var cnt1 = "${InfDTO.getItem()[11].getDecideCnt()}";
				var cnt0 = "${InfDTO.getItem()[12].getDecideCnt()}";
				var cnt00 = "${InfDTO.getItem()[13].getDecideCnt()}";

				*/



				var cnt0 = "${InfDTO.getItem()[0].getDecideCnt()}";
				var cnt1 = "${InfDTO.getItem()[1].getDecideCnt()}";
				var cnt2 = "${InfDTO.getItem()[2].getDecideCnt()}";
				var cnt3 = "${InfDTO.getItem()[3].getDecideCnt()}";
				var cnt4 = "${InfDTO.getItem()[4].getDecideCnt()}";
				var cnt5 = "${InfDTO.getItem()[5].getDecideCnt()}";
				var cnt6 = "${InfDTO.getItem()[6].getDecideCnt()}";
				var cnt7 = "${InfDTO.getItem()[7].getDecideCnt()}";
				var cnt8 = "${InfDTO.getItem()[8].getDecideCnt()}";
				var cnt9 = "${InfDTO.getItem()[9].getDecideCnt()}";
				var cnt10 = "${InfDTO.getItem()[10].getDecideCnt()}";
				var cnt11 = "${InfDTO.getItem()[11].getDecideCnt()}";
				var cnt12 = "${InfDTO.getItem()[12].getDecideCnt()}";
				var cnt13 = "${InfDTO.getItem()[13].getDecideCnt()}";
				var cnt14 = "${InfDTO.getItem()[14].getDecideCnt()}";
				var cnt15 = "${InfDTO.getItem()[15].getDecideCnt()}";
				var cnt16 = "${InfDTO.getItem()[16].getDecideCnt()}";
				var cnt17 = "${InfDTO.getItem()[17].getDecideCnt()}";
				var cnt18 = "${InfDTO.getItem()[18].getDecideCnt()}";
				var cnt19 = "${InfDTO.getItem()[19].getDecideCnt()}";
				var cnt20 = "${InfDTO.getItem()[20].getDecideCnt()}";
				var cnt21 = "${InfDTO.getItem()[21].getDecideCnt()}";
				var cnt22 = "${InfDTO.getItem()[22].getDecideCnt()}";
				var cnt23 = "${InfDTO.getItem()[23].getDecideCnt()}";
				var cnt24 = "${InfDTO.getItem()[24].getDecideCnt()}";
				var cnt25 = "${InfDTO.getItem()[25].getDecideCnt()}";
				var cnt26 = "${InfDTO.getItem()[26].getDecideCnt()}";
				var cnt27 = "${InfDTO.getItem()[27].getDecideCnt()}";
				var cnt28 = "${InfDTO.getItem()[28].getDecideCnt()}";
				var cnt29 = "${InfDTO.getItem()[29].getDecideCnt()}";
				var cnt30 = "${InfDTO.getItem()[30].getDecideCnt()}";
				var cnt31 = "${InfDTO.getItem()[31].getDecideCnt()}";
				

				var careCnt = "${InfDTO.getItem()[0].getCareCnt()}";
				var examCnt = "${InfDTO.getItem()[0].getExamCnt()}";
				var deathCnt = "${InfDTO.getItem()[0].getDeathCnt()}";

				var bar0 = "${map.get('제주')}";
				var bar1 = "${map.get('경남')}";
				var bar2 = "${map.get('경북')}";
				var bar3 = "${map.get('전남')}";
				var bar4 = "${map.get('전북')}";
				var bar5 = "${map.get('충남')}";
				var bar6 = "${map.get('충북')}";
				var bar7 = "${map.get('강원')}";
				var bar8 = "${map.get('경기')}";
				var bar9 = "${map.get('세종')}";
				var bar10 = "${map.get('울산')}";
				var bar11 = "${map.get('대전')}";
				var bar12 = "${map.get('광주')}";
				var bar13 = "${map.get('인천')}";
				var bar14 = "${map.get('대구')}";
				var bar15 = "${map.get('부산')}";
				var bar16 = "${map.get('서울')}";
				
				
				
				var sd0 = "${sd0}";
				var sd1 = "${sd1}";
				var sd2 = "${sd2}";
				var sd3 = "${sd3}";
				var sd4 = "${sd4}";
				var sd5 = "${sd5}";
				var sd6 = "${sd6}";
				var sd7 = "${sd7}";
				var sd8 = "${sd8}";
				var sd9 = "${sd9}";
				var sd10 = "${sd10}";
				var sd11 = "${sd11}";
				var sd12 = "${sd12}";
				var sd13 = "${sd13}";
				var sd14 = "${sd14}";
				var sd15 = "${sd15}";
				var sd16 = "${sd16}";


				// 네이버 맵 API
				//var code0 = "${codeMap.get(0).get(1)}";  // 테스트용	
				var flag = 0;
				var arr1 = new Array();
				var arr2 = new Array();
				var arr3 = new Array();
		
				/*
				<c:forEach items="${codeMap}" var="item">
				var i = 0;
				<c:forEach items="${item}" var="so">
				if (i == 0) {
					arr.push("${so}");
					i++;
				} else {
					arr2.push("${so}");
				}
				</c:forEach>
				</c:forEach>
				*/
				
				<c:forEach items="${pointMap}" var="item">
				var i = 0;
				<c:forEach items="${item}" var="so">
				if (i == 0) {
					arr1.push("${so}");
					i++;
				} else if (i == 1){
					arr2.push("${so}");
					i++;
				} else {
					arr3.push("${so}");
					
				}
				</c:forEach>
				</c:forEach>


				
				
				//arr.push("${item}");
				//console.log(arr[0]);

				
				function buttonClick1(bt) {
					/* var obj = document.getElementById("myBarChart3")
					if(obj!=null) {
						
						obj.setAttribute('id','myBarChart2');
					
						//$('#myBar').load("/coronaInsidePrototype/coronaCurrent.jsp");
					}
					alert(obj.getAttribute("id")); */
					updateChartType1();
				}
				function buttonClick2(bt) {
					/* var obj = document.getElementById("myBarChart2")
					
					if(obj!=null) {
						obj.setAttribute('id','myBarChart3');
					
						//$('#myBar').load("/coronaInsidePrototype/coronaCurrent.jsp");
					}
					alert(obj.getAttribute("id")); */
					updateChartType2();
				}

				function buttonClick3(bt) {
					/* var obj = document.getElementById("myBarChart2")
					
					if(obj!=null) {
						obj.setAttribute('id','myBarChart3');
					
						//$('#myBar').load("/coronaInsidePrototype/coronaCurrent.jsp");
					}
					alert(obj.getAttribute("id")); */
					updateChartType3();
				}
				function buttonClick4(bt) {
					remove();
					drawMap('#container');
								
					var bt1 = document.getElementById("bt1");
					bt1.style.background="#343a40";
			
					var bt2 = document.getElementById("bt2");//전구끄기 버튼 색변경
					bt2.style.background="#7E41D9";	
					
					
				}
				function buttonClick5(bt) {
					remove();
					drawMap2('#container2');
		
					var bt2 = document.getElementById("bt2");
					bt2.style.background="#343a40";
				
			
					var bt1 = document.getElementById("bt1");//전구끄기 버튼 색변경
					bt1.style.background="#7E41D9";	
					
					
				}
				
				function update() {
					$('#myBar').load(window.location+'#myBar');
				}


				drawMap('#container');
				
			
				//drawMap2('#container2');
	

				//var KOREA_JSON_DATA_URL = "{% static 'resources/korea.json' %}",
					//TEST_SPOT_JSON_DATA_URL = "{% static 'resources/point.json' %}";
					
				//var KOREA_JSON_DATA_URL ="${korea}",
					//TEST_SPOT_JSON_DATA_URL ="${point}";
						
				

				//initialize();
				
				//var KOREA_JSON_DATA_URL = JSON.parse(${json});
	            //TEST_SPOT_JSON_DATA_URL = "{% static 'map/testSpots.json' %}"
	            
	            //d3_korea_map('#map2');
	 
	        	
				//var code0 = "${codeMap.get(0).get(1)}";
			</script>
			<script src="resources/js/demo/chart-area-demo.js"></script>
			<script src="resources/js/demo/chart-pie-demo.js"></script>
			<script src="resources/js/demo/chart-bar-demo.js"></script>
			<script src="resources/js/demo/chart-bar-demo2.js"></script>
							
			
			<script src="resources/js/demo/mapping.js"></script>
			
			
			<!-- Core theme JS-->
			<script src="resources/js/scripts.js"></script>

		</div>
	</div>
</body>
</html>


