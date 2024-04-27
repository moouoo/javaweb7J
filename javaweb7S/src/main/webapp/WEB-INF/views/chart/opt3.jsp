<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs3.jsp" />
<title>비용별 관여 퍼센트</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
    
    function drawChart() {
    	var data = google.visualization.arrayToDataTable([
        	['Task', 'expense per all'],
          	['가축비용', ${vo10.registP}],
          	['인력비용', ${vo5.memberP}],
          	['약품비용', ${vo6.medicineP}],
          	['사료비용', ${vo7.feedP}],
          	['정액비용', ${vo8.semenP}],
          	['시설비용', ${vo9.facilityP}]
		]);

        var options = {
        	title: '비용별 관여 퍼센트',
          	is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        
        chart.draw(data, options);
	}
</script>
</head>
<body>
	<div id="piechart_3d" style="width: 900px; height: 500px;"></div>
	<p><br/></p>
	
</body>
</html>