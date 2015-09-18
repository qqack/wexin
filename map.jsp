<%@ page contentType="text/html;charset=utf-8"%><%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%
final HttpServletRequest final_request=request; 
final HttpServletResponse final_response=response; 
    	class wx{
    		HttpServletResponse final_response;
    		public wx(HttpServletResponse response){
    			final_response = response;
    		}
    		public ArrayList<double[]> getLocation(){
    			Connection con;
				Statement st;
				ResultSet rs;
				ArrayList<double[]> mylist = new ArrayList<double[]>();
				try{
					Class.forName("com.mysql.jdbc.Driver").newInstance();
				} catch(Exception e) { 
					this.print(e.toString());
				}
				try {
				    String uri="jdbc:mysql://127.0.0.1:3306/test";
				    con=DriverManager.getConnection(uri,"root","123456");
				    st=con.createStatement();
				    rs=st.executeQuery("select * from location");
				     while(rs.next()){
				     	double[] location = new double[2];
				        double x = rs.getDouble("location_x");
				        double y = rs.getDouble("location_y");
				        location[0] = x;
				        location[1] = y;
				        mylist.add(location);
				    }
				  	st.close();
				    con.close();
				} catch(SQLException e1) {
					this.print(e1.toString());
					//out.print(e1);
				}
				return mylist;
			}
		    public void print(String s) {
				try{ 
					final_response.getWriter().print(s);
					//final_response.getWriter().flush();
					//final_response.getWriter().close();
				}
				catch(Exception e){
				}
			}
    	}
    	wx weixin = new wx(final_response);
    	ArrayList<double[]> locations = weixin.getLocation();
    %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html {width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{width:100%;height:500px;}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=t2L0Sa4Wo7G39aoCZri5WTmR"></script>
	<title>显示位置</title>
</head>
<body>
	<div id="allmap"></div>
	
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	var point = new BMap.Point(112.921631, 27.902252);
	map.centerAndZoom(point, 15);
	map.disableDoubleClickZoom(true);
		
	// 编写自定义函数,创建标注
	function addMarker(point,label){
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);
		marker.setLabel(label);
	}
	
	
	function deletePoint(){
		var allOverlay = map.getOverlays();
		for (var i = 0; i < allOverlay.length -1; i++){
			if(allOverlay[i].getLabel().content == "我是id=1"){
				map.removeOverlay(allOverlay[i]);
				return false;
			}
		}
	}
	function viewPoint(){
		var point= new BMap.Point(112.921631, 27.902252);
		var label= new BMap.Label("我在这里",{offset:new BMap.Size(20,-10)});
		addMarker(point,label);
	}
	function getPhoto(){
		// 百度地图API功能
		var map = new BMap.Map("allmap");
		//var point = new BMap.Point(116.404, 39.915);
		var point = new BMap.Point(112.921631, 27.902252);
		map.centerAndZoom(point, 15);
		
		//创建小狐狸
		var pt = new BMap.Point(112.921631, 27.902252);
		var myIcon = new BMap.Icon("http://developer.baidu.com/map/jsdemo/img/fox.gif", new BMap.Size(300,157));
		var marker2 = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
		map.addOverlay(marker2);              // 将标注添加到地图中
	}
	<%
		int i=1;
		for(double[] mynum : locations){
			//out.println(mynum[0] + " " + mynum[1]);
			out.print("var point= new BMap.Point("+mynum[1]+", "+mynum[0]+");var label= new BMap.Label("+(i++)+",{offset:new BMap.Size(20,-10)});addMarker(point,label);");
		}
		
	%>
</script>
