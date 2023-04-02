<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %> 
<% request.setCharacterEncoding("euc-kr"); %>


<%
    //login, login_ok���� �������� �׸��
    String userId = (String)session.getAttribute("user_id");
    String name = (String) session.getAttribute("user_name");

    //�ּ� ���θ��ּ� + ���ּ� + �����׸� ǥ��
    //String Address= (String) session.getAttribute("roadAddress") + (String) session.getAttribute("detailAddress") + (String) session.getAttribute("extraAddress");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <link href="../lib/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<P align=center>
  <h1>COMMAN</h1>
</P> 

<div class="navbar">
    <ul>
        <%

            if(name == null) {
        %>
        <li><a href="<%= request.getContextPath() %>/login/login.jsp">�α���</a></li>
        <li><a href="<%= request.getContextPath() %>/join/join.jsp">ȸ������</a></li>
            <%
                if("admin".equals(userId)) {
                    response.sendRedirect("../admin/adminMain.jsp");
                }
            %>
        <%
        }
           else {
        %>
        
        
        <li><%=name%>��</li>
        <li><a href="<%= request.getContextPath() %>/login/logout.jsp">�α׾ƿ�</a></li>
        <%
                if("admin".equals(userId)) {
                	   %>
             <li><a href="<%= request.getContextPath() %>/admin/adminMain.jsp">����������</a></li>
                	   <% 
                }
        %>	
        	<%
        		if(!("admin".equals(userId))) {
        	%>
        	 <li><a href="<%= request.getContextPath() %>/mypage/myPageMain.jsp">����������</a></li>
        	<%
        		}
        	%>
        		
       
        <%
            }
        %>
    </ul>
</div>

<FORM method=post name=search action="shop_list.jsp">
<TABLE border=0 width=95%>

 
  <TR>
  <TD align=right>
   <INPUT type=text name=pname>
  <INPUT type=image src="../lib/img/search.png" width="20px" height="20px" value="�˻�">
  </TD>
 </TR>
 
  <TH>
 
    

  </TH>
</TABLE>
<div class="header">
    <div class="header__menu">
        <ul>
    		<li> <A href="shop_list.jsp">��ü</A></li>
    		<li><A href="shop_list.jsp?cat=11">KeyBoard</A></li>
    		<li><A href="shop_list.jsp?cat=22">Mouse</A></li>
    		<li><A href="shop_list.jsp?cat=33">HeadSet</A></li>
    		<li><A href="shop_list.jsp?cat=44">Desk</A></li>
    		<li><A href="shop_list.jsp?cat=55">Chair</A></li>
    		<li><A href="shop_list.jsp?cat=66">etc</A></li>
     	</ul>
        
     </div>
        
</div>
</FORM>
<CENTER>
<TABLE width=95% style="font-size:10pt">
<% 
 String cond="";
 String ca="";
 String pn="";
 
 if (request.getParameter("cat") != null) {
  if( !(request.getParameter("cat").equals("")) ) {
   ca=request.getParameter("cat");
   cond= " where category = '"+ ca+"'";
  }
 }
 
 if (request.getParameter("pname") != null) {
  if ( !(request.getParameter("pname").equals("")) ) {
   pn=request.getParameter("pname");
   cond= " where pname like '%"+ pn+"%'";
  }
 }

 Vector pname=new Vector();
 Vector sname=new Vector();
 Vector keyid=new Vector();
 Vector price=new Vector();
 Vector dprice=new Vector();
 Vector stock=new Vector();
 Vector small=new Vector();
 Vector large=new Vector();
 Vector description=new Vector();
 
 String url = "http://localhost:8080/Shopping/lib/upload/";
 
 NumberFormat nf= NumberFormat.getNumberInstance();
 
 int stocki;
 String pricestr=null;
 String dpricestr=null;
 String filename="";
 
 int where=1;
 
 if (request.getParameter("go") != null) 
  where = Integer.parseInt(request.getParameter("go"));
 
 int nextpage=where+1;
 int priorpage = where-1;
 int startrow=0;
 int endrow=0;
 int maxrows=3;
 int totalrows=0;
 int totalpages=0;
 
 long id=0;
 
 Connection con= null;
 Statement st =null;
 ResultSet rs =null;
 
 try {
  Class.forName("com.mysql.cj.jdbc.Driver");
 } catch (ClassNotFoundException e ) {
  out.println(e);
 }
 
 try{
  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/shopping?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul","root","awd79852");
 } catch (SQLException e) {
  out.println(e);
 }
 
 try {
  st = con.createStatement();
  String sql = "select * from product" ;
  sql = sql+ cond+  " order by id desc";
  rs = st.executeQuery(sql);
 
  if (!(rs.next()))  
   out.println("��ǰ�� �����ϴ�");
  else {
   do {
    keyid.addElement(new Long(rs.getLong("id")));
    pname.addElement(rs.getString("pname"));
    sname.addElement(rs.getString("sname"));
    price.addElement(new Integer(rs.getInt("price")));
    dprice.addElement(new Integer(rs.getInt("downprice"))); 
    stock.addElement(new Integer(rs.getInt("stock")));
    description.addElement(rs.getString("description"));
    small.addElement(rs.getString("small"));
    large.addElement(rs.getString("large"));
   }while(rs.next());
      
   totalrows = pname.size();
   totalpages = (totalrows-1)/maxrows +1;
 
   startrow = (where-1) * maxrows;
   endrow = startrow+maxrows-1  ;
 
   if (endrow >= totalrows)
    endrow=totalrows-1;
      
   for(int j=startrow;j<=endrow;j++) { 
    id= ((Long)keyid.elementAt(j)).longValue();
    stocki= ((Integer)stock.elementAt(j)).intValue();
    filename = url+(String)small.elementAt(j);
    pricestr= nf.format(price.elementAt(j)); 
    dpricestr=nf.format(dprice.elementAt(j)); 
 
    out.println("<TR ><TH rowspan=4>");
    out.println("<A href=JavaScript:view(\""+large.elementAt(j)+"\")>"); 
    out.println("<IMG border=0 width=70 height=70 src=\""+filename+"\">");
    out.println("<TD bgcolor=#DFEDFF>");
    out.println("<FONT face='����ü' color=black>");
    out.println( pname.elementAt(j)+"(�ڵ�:"+id+")");
    out.println("</FONT></TD></TR>");
    out.println("<TR>");
    out.println("<TD   bgcolor=#eeeeee>");
    out.println(description.elementAt(j));
    out.println("</TD></TR>"); 
    out.println("<TR><TD align=right>");
    out.println("���߰�: <STRIKE>"+ pricestr+"</STRIKE>��&nbsp;&nbsp;");  
    out.println("�ǸŰ�: "+ dpricestr+"��");  
    out.println("</TD></TR>"); 
    out.println("<FORM method=post name=search action=\"sale.jsp\">");
	out.println("<TR>");
    out.println("<TD align=right >");
    out.println("����(����)�� : "+sname.elementAt(j)+"&nbsp;&nbsp;");

    if (stocki >0) { 
    
    	 out.println("<INPUT type=submit value=\"�ٱ��Ͽ� ���\">");
    	 out.println("�ֹ�����");
         out.println("<INPUT type=text name=quantity size=2 value=1>��");
         out.println("<INPUT type=hidden name=id value="+id+">");
         out.println("<INPUT type=hidden name=go value="+where+">");
         out.println("<INPUT type=hidden name=cat value="+ca+">");
         out.println("<INPUT type=hidden name=pname value="+pn+">");

    
    } else
     out.println("ǰ��");
    out.println("</TD></TR></FORM>"); 
   }
   rs.close();    
  }
  out.println("</TABLE>");
  st.close();
  con.close();
 } catch (SQLException e) {
  out.println(e);
 } 
 out.println("<HR color=#003399>");
 if (where > 1) {
  out.print("[<A href=\"shop_list.jsp?go=1"); 
  out.print("&cat="+ca+"&pname="+pn+"\">ó��</A>]");
  out.print("[<A href=\"shop_list.jsp?go="+priorpage);
  out.print("&cat="+ca+"&pname="+pn+ "\">����</A>]");
 } else {
  out.println("[ó��]") ;
  out.println("[����]") ;
 }
 
 if (where < totalpages) {
  out.print("[<A href=\"shop_list.jsp?go="+ nextpage);
  out.print("&cat="+ca+"&pname="+pn+"\">����</A>]");
  out.print("[<A href=\"shop_list.jsp?go="+ totalpages);
  out.print("&cat="+ca+"&pname="+pn+"\">������</A>]");
 } else {
  out.println("[����]");
  out.println("[������]");
 }
 
 out.println (where+"/"+totalpages); 
 out.println ("��ü ��ǰ�� :"+totalrows); 
%>
</BODY>
</HTML>