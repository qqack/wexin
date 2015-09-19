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
	<!--meta name="viewport" content="width=device-width,initial-scale=1" /-->
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html {width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{width:100%;height:100%;}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=t2L0Sa4Wo7G39aoCZri5WTmR"></script>
	<script src="//7u2n9p.com1.z0.glb.clouddn.com/jquery/2.1.3/jquery.min.js"></script>
	<title>显示位置</title>
</head>
<body>
	<div id="allmap"></div>
	<input id = "input" type="button" onclick="getPhoto();" value="添加头像" />
	<div id="message">
	</div>
</body>
</html>
<script type="text/javascript">
	
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	var point = new BMap.Point(112.921631, 27.902252);
	map.centerAndZoom(point, 15);
	
	//添加变大变小控件
	var opts = {type: BMAP_NAVIGATION_CONTROL_ZOOM}    
	map.addControl(new BMap.NavigationControl(opts));
		
	// 编写自定义函数,创建标注
	function addMarker(point){
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);
	}
	
	var data_info = [
					 [112.921631, 27.902252,"地址：计算机学院"],
					];
	var opts2 = {
				width : 250,     // 信息窗口宽度
				height: 80,     // 信息窗口高度
				title : "信息窗口" , // 信息窗口标题
				enableMessage:true//设置允许信息窗发送短息
			   };
	for(var i=0;i<data_info.length;i++){
		var marker = new BMap.Marker(new BMap.Point(data_info[i][0],data_info[i][1]));  // 创建标注
		var content = data_info[i][2];
		map.addOverlay(marker);               // 将标注添加到地图中
		addClickHandler(content,marker);
	}
	function addClickHandler(content,marker){
		marker.addEventListener("click",function(e){
			openInfo(content,e)}
		);
	}
	function openInfo(content,e){
		var p = e.target;
		var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
		var infoWindow = new BMap.InfoWindow(content,opts2);  // 创建信息窗口对象 
		map.openInfoWindow(infoWindow,point); //开启信息窗口
	}
	//添加头像
	function getPhoto(){
		
		
		var marker = new BMap.Point(112.921631, 27.902252);
		var pt = new BMap.Point(112.921631, 27.902252+0.0025);
		
		addMarker(marker); 
		var myIcon = new BMap.Icon("./404.jpg", new BMap.Size(50,50));
		var marker2 = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
		marker2.addEventListener("click",openInfo);
		map.addOverlay(marker2);
		  
	}
		
	
	// <%
	// 	int i=1;
	// 	for(double[] mynum : locations){
	// 		//out.println(mynum[0] + " " + mynum[1]);
	// 		out.print("var point= new BMap.Point("+mynum[1]+", "+mynum[0]+");var label= new BMap.Label("+(i++)+",{offset:new BMap.Size(20,-10)});addMarker(point,label);");
	// 	}
		
	// %>
       

	
</script>
