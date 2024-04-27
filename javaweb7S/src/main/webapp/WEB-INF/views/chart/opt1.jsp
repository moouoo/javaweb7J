<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs3.jsp" />
<title>총수익 / 총비용</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['bar']});
  	google.charts.setOnLoadCallback(drawChart);

  	function drawChart() {
    	var data = google.visualization.arrayToDataTable([
      		['Year', '총수익', '총비용'],
      		['2020 ~ 지금까지', ${vo.revenue}, ${vo2.expense}],
      		/* ['2020 ~ 지금까지', 300, ${vo.expense}], */
    	]);

    	var options = {
      		chart: {
        		title: '총수익 / 총비용',
        		subtitle: '2020 ~ 현재까지',
      		}
    	};

    	var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

    	chart.draw(data, google.charts.Bar.convertOptions(options));
    	
    }
</script>
</head>
<body>
	<div id="columnchart_material" style="width: 800px; height: 500px;"></div>
	<p><br/></p>
	<p>지금까지의 순수익은
		[<script>
			var revenue = ${vo.revenue};
			var expense = ${vo2.expense};
			var netIncome = revenue - expense;
			document.write(netIncome.toLocaleString('en'));
		</script>]원 입니다.
	</p>
</body>
</html>