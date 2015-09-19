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
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMarker();//向地图中添加marker
        $.get("api.jsp", function(result){
        });
    }
    
    //创建地图函数：
    function createMap(){
        var map = new BMap.Map("allmap");//在百度地图容器中创建一个地图
        var point = new BMap.Point(120.780238,31.580612);//定义一个中心点坐标
        map.centerAndZoom(point,11);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
    }
    
    
    
    
    
    
    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }
    
    
    
    
    
    
    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
    var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
    map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
    var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
    map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
    var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
    map.addControl(ctrl_sca);
    }
    
    //标注点数组
    var markerArr = [{title:"昆山市司法局",content:"前进西路148号 电话：57507618",point:"120.967547|31.389313",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"高新区(玉山镇)司法所",content:"昆山市北门路757号 电话：57571148",point:"120.959274|31.415357",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"巴城镇司法所",content:"巴城镇景城南路88号 电话：57980698",point:"120.885415|31.457413",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"周市镇司法所",content:"周市镇惠安路12号 电话：57625148",point:"121.0033|31.470966",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"开发区司法办",content:"昆山市长江中路428号 电话：55216821",point:"120.984417|31.391332",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"陆家镇司法所",content:"陆家镇政府院内 电话：57671667",point:"121.054943|31.320739",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"花桥镇司法所",content:"花桥镇花溪路 电话：57691212",point:"121.096589|31.307288",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"千灯镇司法所",content:"千灯镇政府院内 电话：57466467",point:"121.01045|31.273946",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"淀山湖镇司法所",content:"淀山湖镇振淀路229号 电话：57488204",point:"121.037282|31.183918",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"张浦镇司法所",content:"张浦镇银河路2号 电话：57453612",point:"120.942727|31.279115",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"锦溪镇司法所",content:"锦溪镇普庆路116号 电话：57224860",point:"120.908043|31.186915",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ,{title:"周庄镇司法所",content:"周庄镇全旺路100号 电话：57211692",point:"120.858565|31.135356",isOpen:0,icon:{w:32,h:32,l:0,t:0,x:6,lb:5}}
         ];
    //创建marker


    function addMarker(){
        for(var i=0;i<markerArr.length;i++){
            var json = markerArr[i];
            var p0 = json.point.split("|")[0];
            var p1 = json.point.split("|")[1];
            var point = new BMap.Point(p0,p1);
            var iconImg = createIcon(json.icon);
            var marker = new BMap.Marker(point,{icon:iconImg});
            var iw = createInfoWindow(i);
            var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
            marker.setLabel(label);
            map.addOverlay(marker);
            label.setStyle({
                        borderColor:"#808080",
                        color:"#333",
                        cursor:"pointer"
            });
            
            (function(){
                var index = i;
                var _iw = createInfoWindow(i);
                var _marker = marker;
                _marker.addEventListener("click",function(){
                    this.openInfoWindow(_iw);
                });
                _iw.addEventListener("open",function(){
                    _marker.getLabel().hide();
                })
                _iw.addEventListener("close",function(){
                    _marker.getLabel().show();
                })
                label.addEventListener("click",function(){
                    _marker.openInfoWindow(_iw);
                })
                if(!!json.isOpen){
                    label.hide();
                    _marker.openInfoWindow(_iw);
                }
            })()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i){
        var json = markerArr[i];
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
        return iw;
    }
    //创建一个Icon
    function createIcon(json){
        var icon = new BMap.Icon("404.jpg", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
        return icon;
    }
    
    initMap();//创建和初始化地图
</script>
</html>

