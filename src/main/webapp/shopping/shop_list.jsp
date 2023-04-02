<%@ page contentType="text/html; charset=EUC-KR" %> 
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %> 
<% request.setCharacterEncoding("euc-kr"); %>


<%
    //login, login_ok에서 가져오는 항목들
    String userId = (String)session.getAttribute("user_id");
    String name = (String) session.getAttribute("user_name");

    //주소 도로명주소 + 상세주소 + 참고항목 표시
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
        <li><a href="<%= request.getContextPath() %>/login/login.jsp">로그인</a></li>
        <li><a href="<%= request.getContextPath() %>/join/join.jsp">회원가입</a></li>
            <%
                if("admin".equals(userId)) {
                    response.sendRedirect("../admin/adminMain.jsp");
                }
            %>
        <%
        }
           else {
        %>
        
        
        <li><%=name%>님</li>
        <li><a href="<%= request.getContextPath() %>/login/logout.jsp">로그아웃</a></li>
        <%
                if("admin".equals(userId)) {
                	   %>
             <li><a href="<%= request.getContextPath() %>/admin/adminMain.jsp">어드민페이지</a></li>
                	   <% 
                }
        %>	
        	<%
        		if(!("admin".equals(userId))) {
        	%>
        	 <li><a href="<%= request.getContextPath() %>/mypage/myPageMain.jsp">마이페이지</a></li>
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
  <INPUT type=image src="../lib/img/search.png" width="20px" height="20px" value="검색">
  </TD>
 </TR>
 
  <TH>
 
    

  </TH>
</TABLE>
<div class="header">
    <div class="header__menu">
        <ul>
    		<li> <A href="shop_list.jsp">전체</A></li>
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
   out.println("상품이 없습니다");
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
    out.println("<FONT face='돋움체' color=black>");
    out.println( pname.elementAt(j)+"(코드:"+id+")");
    out.println("</FONT></TD></TR>");
    out.println("<TR>");
    out.println("<TD   bgcolor=#eeeeee>");
    out.println(description.elementAt(j));
    out.println("</TD></TR>"); 
    out.println("<TR><TD align=right>");
    out.println("시중가: <STRIKE>"+ pricestr+"</STRIKE>원&nbsp;&nbsp;");  
    out.println("판매가: "+ dpricestr+"원");  
    out.println("</TD></TR>"); 
    out.println("<FORM method=post name=search action=\"sale.jsp\">");
	out.println("<TR>");
    out.println("<TD align=right >");
    out.println("제조(공급)원 : "+sname.elementAt(j)+"&nbsp;&nbsp;");

    if (stocki >0) { 
    
    	 out.println("<INPUT type=submit value=\"바구니에 담기\">");
    	 out.println("주문수량");
         out.println("<INPUT type=text name=quantity size=2 value=1>개");
         out.println("<INPUT type=hidden name=id value="+id+">");
         out.println("<INPUT type=hidden name=go value="+where+">");
         out.println("<INPUT type=hidden name=cat value="+ca+">");
         out.println("<INPUT type=hidden name=pname value="+pn+">");

    
    } else
     out.println("품절");
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
  out.print("&cat="+ca+"&pname="+pn+"\">처음</A>]");
  out.print("[<A href=\"shop_list.jsp?go="+priorpage);
  out.print("&cat="+ca+"&pname="+pn+ "\">이전</A>]");
 } else {
  out.println("[처음]") ;
  out.println("[이전]") ;
 }
 
 if (where < totalpages) {
  out.print("[<A href=\"shop_list.jsp?go="+ nextpage);
  out.print("&cat="+ca+"&pname="+pn+"\">다음</A>]");
  out.print("[<A href=\"shop_list.jsp?go="+ totalpages);
  out.print("&cat="+ca+"&pname="+pn+"\">마지막</A>]");
 } else {
  out.println("[다음]");
  out.println("[마지막]");
 }
 
 out.println (where+"/"+totalpages); 
 out.println ("전체 상품수 :"+totalrows); 
%>
</BODY>
</HTML>