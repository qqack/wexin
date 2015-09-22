<%@page import="java.util.Date"%><%@page import="java.io.IOException"%><%@page import="java.io.InputStreamReader"%><%@page import="java.io.BufferedReader"%><%@page import="java.io.Reader"%><%@page import="java.security.MessageDigest"%><%@page import="java.util.Arrays"%><%@page import="org.dom4j.Element"%><%@page import="org.dom4j.DocumentHelper"%><%@page import="org.dom4j.Document"%><%@ page contentType="text/html;charset=utf-8"%><%@ page import="java.sql.*"%><% 
final HttpServletRequest final_request=request; 
final HttpServletResponse final_response=response; 
class wechat{
	public wechat(){
		getXmlDate();
	}
    //从输入流读取post参数  
    public String readStreamParameter(ServletInputStream in){  
        StringBuilder buffer = new StringBuilder();  
        BufferedReader reader=null;  
        try{  
            reader = new BufferedReader(new InputStreamReader(in, "utf-8")); 
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

	public void getLocation(double x,double y){
		Connection con;
		Statement st;
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch(Exception e) { 
			//out.print(e);
		}
		try {
		    String uri="jdbc:mysql://127.0.0.1:3306/test";
		    con=DriverManager.getConnection(uri,"root","123456");
		    st=con.createStatement();
		    st.executeUpdate("insert into location (location_x,location_y) values ("+x+","+y+")");
		  	st.close();
		    con.close();
		} catch(SQLException e1) {
			//out.print(e1);
		}
	}
	//获取xml中的数据
	public void getXmlDate(){
		String postStr=null; 
		String fromUsername = "";
		String toUsername = "";
		String msgtype = "";
		String content = "";
		double location_x = 0;
		double location_y = 0;
		try{  
		    postStr=this.readStreamParameter(final_request.getInputStream()); 
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
		     	location_x = Double.parseDouble(root.elementText("Location_X"));
		     	location_y = Double.parseDouble(root.elementText("Location_Y"));
		     	this.getLocation(location_x,location_y);
		     }else{
		     	content = "已收到";
		     }
		} 
		String time = new Date().getTime()+""; 
		String echostr = request.getParameter("echostr");

		if(echostr != null){
			this.print(echostr);
		}else{
			String s = "<xml><ToUserName><![CDATA["+fromUsername+"]]></ToUserName>"+
				"<FromUserName><![CDATA["+toUsername+"]]></FromUserName>"+
				"<CreateTime>"+time+"</CreateTime>"+
				"<MsgType><![CDATA[text]]></MsgType>"+
				"<Content><![CDATA["+content+"]]></Content>"+
				"<MsgId>225</MsgId>"+
				"</xml>";
			this.print(s);

		}
	}
}

wechat weixin = new wechat();


%>