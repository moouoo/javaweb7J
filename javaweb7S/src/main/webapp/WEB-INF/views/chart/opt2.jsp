<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<title>년도 별 수익 / 비용</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['bar']});
  	google.charts.setOnLoadCallback(drawChart);

  	function drawChart() {
    	var data = google.visualization.arrayToDataTable([
      		['Year', '수익', '비용'],
      		['${year}', ${vo3.YRevenue}, ${vo4.YExpense}],
    	]);

    	var options = {
      		chart: {
        		title: '년도 별 수익 / 비용',
        		subtitle: '2020 ~ 2025',
      		}
    	};

    	var chart = new google.charts.Bar(document.getElementById('opt2'));

    	chart.draw(data, google.charts.Bar.convertOptions(options));
    	
    }
  	
  	function yearChange(){
  		let year = document.getElementById("year").value;
  		location.href='${ctp}/chart/opt2?year='+year;
  	}
</script>
</head>
<body>
	<div class="container">
		<h2>년도 별 수익 / 비용</h2>
		<p><br/></p>
	<select id="year" name="year" onchange="yearChange()">
		<option value="">선택</option>
		<option value="2020" ${year == 2020 ? 'selected' : '' }>2020</option>
		<option value="2021" ${year == 2021 ? 'selected' : '' }>2021</option>
		<option value="2022" ${year == 2022 ? 'selected' : '' }>2022</option>
		<option value="2023" ${year == 2023 ? 'selected' : '' }>2023</option>
		<option value="2024" ${year == 2024 ? 'selected' : '' }>2024</option>
		<option value="2025" ${year == 2025 ? 'selected' : '' }>2025</option>
	</select>
	<div id="opt2" style="width: 800px; height: 500px;"></div><hr/>
	<p>${year }년도의 순수익은
		[<script>
			var revenue = ${vo3.YRevenue};
			var expense = ${vo4.YExpense};
			var netIncome = revenue - expense;
			document.write(netIncome.toLocaleString('en'));
		</script>]원 입니다.
	<div style="text-align: center;">
		<input type="button" value="돌아가기" class="btn btn-info m-2" onclick="location.href='${ctp}/chart/chart';" /><br/>
	</div>
	</div>
</body>
</html>