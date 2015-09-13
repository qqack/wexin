<%@page import="java.util.Date"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.Reader"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.util.Arrays"%>
<%@page import="org.dom4j.Element"%>  
<%@page import="org.dom4j.DocumentHelper"%>  
<%@page import="org.dom4j.Document"%>
<% 
final HttpServletRequest final_request=request; 
final HttpServletResponse final_response=response; 
class wx{
    //从输入流读取post参数  
    public String readStreamParameter(ServletInputStream in){  
        StringBuilder buffer = new StringBuilder();  
        BufferedReader reader=null;  
        try{  
            reader = new BufferedReader(new InputStreamReader(in));  
            String line=null;  
            while((line = reader.readLine())!=null){  
                buffer.append(line);  
            }  
        }catch(Exception e){  
            e.printStackTrace();  
        }finally{  
            if(null!=reader){  
                try {  
                    reader.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
        return buffer.toString();  
    }  
    public void print(String s) {

		try{ 
			final_response.getWriter().print(s);
			final_response.getWriter().flush();
			final_response.getWriter().close();
		}
		catch(Exception e){
		}
	}
}

wx weixin = new wx();
//获取xml中的数据
String postStr=null; 
String fromUsername = "";
String toUsername = "";
String msgtype = "";
String content = "";
try{  
    postStr=weixin.readStreamParameter(final_request.getInputStream()); 
}catch(Exception e){  
    e.printStackTrace();  
}  

if (null!=postStr&&!postStr.isEmpty()){  
    Document document=null;  
    try{  
        document = DocumentHelper.parseText(postStr);  
    }catch(Exception e){  
        e.printStackTrace();  
    }  
    Element root=document.getRootElement();  
     fromUsername = root.elementText("FromUserName");  
     toUsername = root.elementText("ToUserName");
     msgtype = root.elementText("MsgType");
     if(msgtype.equals("text")){  
     	content = root.elementTextTrim("Content");
     }else if(msgtype.equals("location")){
     	content = "获取地理位置成功";
     }else{
     	content = "已收到";
     }
} 
String time = new Date().getTime()+""; 
String path = request.getContextPath(); 

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
String echostr = request.getParameter("echostr");



if(echostr != null){
	out.println(echostr);
}else{
	String s = "<xml><ToUserName><![CDATA["+fromUsername+"]]></ToUserName>"+
		"<FromUserName><![CDATA["+toUsername+"]]></FromUserName>"+
		"<CreateTime>"+time+"</CreateTime>"+
		"<MsgType><![CDATA[text]]></MsgType>"+
		"<Content><![CDATA["+content+"]]></Content>"+
		"<MsgId>225</MsgId>"+
		"</xml>";
	weixin.print(s);
}
// 数据库连接
		try{
			
			Class.forName("com.mysql.jdbc.Driver").newInstance(); //MYSQL驱动
	        con = DriverManager.getConnection("jdbc:mysql://10.1.8.9:3306/qiuqiu", "qiuqiu", "123456"); //链接MYSQL
		} catch (Exception em) {
	          out.print("MYSQL ERROR:" + em.getMessage());
	    }
%>
