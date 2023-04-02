<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %> 
<% request.setCharacterEncoding("utf-8"); %>

<HTML>
<HEAD>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <link href="../lib/main.css" rel="stylesheet" type="text/css">
</head>
</HEAD>
<BODY>

<FORM method=post name=search action="product_list.jsp">
<TABLE border=0 width=95%>
 <TR>
  <TD align=right>
   <INPUT type=text name=pname>
  <INPUT type=image src="../lib/img/search.png" width="20px" height="20px" value="검색">
  </TD>
 </TR>
 
 
 <TR>
  <TH>
   <FONT size=-1>
    [<A href="adminMain.jsp">어드민 메인으로</A>]-
    <A href="product_list.jsp">전체</A>-
    <A href="product_list.jsp?cat=11">KeyBoard</A>-
    <A href="product_list.jsp?cat=22">Mouse</A>-
    <A href="product_list.jsp?cat=33">HeadSet</A>-
    <A href="product_list.jsp?cat=44">Desk</A>-
    <A href="product_list.jsp?cat=55">Chair</A>-
    <A href="product_list.jsp?cat=66">etc</A>
   </FONT>
  </TH>
 </TR>
</TABLE>
</FORM>

<CENTER>
<TABLE border=0 width=95% cellpadding=4 cellspacing=4 style="font-size:10pt">
 <TR>
  <TH width=5% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>번호</NOBR>
   </FONT>
  </TH>
  <TH width=25% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>상품명</NOBR>
   </FONT>
  </TH>
  <TH width=10% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>코드번호</NOBR>
   </FONT>
  </TH>
  <TH width=15% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>제조원</NOBR>
   </FONT>
  </TH>
  <TH width=10% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>판매시작일</NOBR>
   </FONT>
  </TH>
  <TH width=10% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>판매가(원)</NOBR>
   </FONT>
  </TH>
  <TH width=10% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>재고량</NOBR>
   </FONT>
  </TH>
  <TH width=15% bgcolor=#DFEDFF>
   <FONT color=black face=굴림>
    <NOBR>분류</NOBR>
   </FONT>
  </TH>
 </TR>
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
 Vector cat=new Vector();
 Vector dprice=new Vector();
 Vector inputdate=new Vector();
 Vector stock=new Vector();
 String category=null;
 
 long id=0;
 
 NumberFormat nf = NumberFormat.getInstance();
 String downprice=null; 
 
 int where=1;
 int totalgroup=0;
 int maxpages=2;
 int startpage=1;
 int endpage=startpage+maxpages-1;
 int wheregroup=1;
 if (request.getParameter("go") != null) {
  where = Integer.parseInt(request.getParameter("go"));
  wheregroup = (where-1)/maxpages + 1;
  startpage=(wheregroup-1) * maxpages+1;  
  endpage=startpage+maxpages-1; 
 } else if (request.getParameter("gogroup") != null) {
  wheregroup = Integer.parseInt(request.getParameter("gogroup"));
  startpage=(wheregroup-1) * maxpages+1;  
  where = startpage ; 
  endpage=startpage+maxpages-1; 
 }
 int nextgroup=wheregroup+1;
 int priorgroup= wheregroup-1;
 
 int startrow=0;
 int endrow=0;
 int maxrows=5;
 int totalrows=0;
 int totalpages=0;
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
  String sql = "select * from product";
  sql = sql+ cond+  " order by id";
  rs = st.executeQuery(sql);
  if (!(rs.next()))  {
   out.println("상품이 없습니다");
  } else {
   do {
    keyid.addElement(new Long(rs.getLong("id")));
    cat.addElement(rs.getString("category"));
    pname.addElement(rs.getString("pname"));
    sname.addElement(rs.getString("sname"));
    dprice.addElement(new Integer(rs.getInt("downprice")));
    String idate = rs.getString("inputdate");
    idate = idate.substring(0,8);
    inputdate.addElement(idate);
    stock.addElement(new Integer(rs.getInt("stock")));
   }while(rs.next());

   totalrows = pname.size();
   totalpages = (totalrows-1)/maxrows +1;
   startrow = (where-1) * maxrows;
   endrow = startrow+maxrows-1  ;
   if (endrow >= totalrows)
    endrow=totalrows-1;
   totalgroup = (totalpages-1)/maxpages +1;
   if (endpage > totalpages) 
    endpage=totalpages;
   for(int j=startrow;j<=endrow;j++) {
    id= ( (Long)keyid.elementAt(j) ).longValue();
    downprice=nf.format( ((Integer)dprice.elementAt(j)).intValue() ); 
    switch ( Integer.parseInt((String)cat.elementAt(j)) ) {
     case 11:  
      category="KeyBoard";
      break;
     case 22:  
      category="Mouse";
      break;
     case 33:  
      category="HeadSet";
      break;
     case 44:  
      category="Desk";
      break;
     case 55:  
      category="Chair";
      break;
     case 66:  
      category="etc";
      break;
     default:
      break;
    }
    out.println("<TR>");
    out.println("<TH width=5%  bgcolor=#eeeeee>");
    out.println(j+1+"</TH>");
    out.println("<TD width=25% bgcolor=#eeeeee>");
    out.print("<A href=\"product_read.jsp?id="+id + "&go=" + where);
    out.print("&cat="+ca+"&pname="+pn+"\">"+pname.elementAt(j));  
    out.println("</A></TD>");
    out.println("<TD  width=10% bgcolor=#eeeeee>");
    out.println(id + "</TD>");
    out.println("<TD width=15% bgcolor=#eeeeee>");
    out.println(sname.elementAt(j) + "</TD>");
    out.println("<TD width=10% bgcolor=#eeeeee>");
    out.println(inputdate.elementAt(j)+ "</TD>");
    out.println("<TD width=10% bgcolor=#eeeeee align=right>");
    out.println(downprice+ "</TD>");
    out.println("<TD width=10% bgcolor=#eeeeee align=right>");
    out.println(stock.elementAt(j) + "</TD>");
    out.println("<TD width=15% bgcolor=#eeeeee>");
    out.println(category + "</TD>");
    out.println("</TR>"); 
   }
   rs.close();    
  }
  out.println("</TABLE>");
  st.close();
  con.close();
 } catch (SQLException e) {
  out.println(e);
 } 

 if (wheregroup > 1) {
  out.print("[<A href=\"product_list.jsp?gogroup=1"); 
  out.print("&cat="+ca+"&pname="+pn+"\">처음</A>]");
  out.print("[<A href=\"product_list.jsp?gogroup="+priorgroup);
  out.print("&cat="+ca+"&pname="+pn+ "\">이전</A>]");
 } else {
  out.println("[처음]") ;
  out.println("[이전]") ;
 }
 
 if (totalrows !=0) {  
  for(int jj=startpage; jj<=endpage; jj++) {
   if (jj==where) 
    out.println("["+jj+"]") ;
   else {
    out.print("[<A href=\"product_list.jsp?go="+jj) ;
    out.print("&cat="+ca+"&pname="+pn+"\">"+jj + "</A>]") ;
   }
  } 
 }
 if (wheregroup < totalgroup) {
  out.print("[<A href=\"product_list.jsp?gogroup="+ nextgroup);
  out.print("&cat="+ca+"&pname="+pn+"\">다음</A>]");
  out.print("[<A href=\"product_list.jsp?gogroup="+ totalgroup);
  out.print("&cat="+ca+"&pname="+pn+"\">마지막</A>]");
 } else {
  out.println("[다음]");
  out.println("[마지막]");
 }
 out.println ("전체상품수 :"+totalrows); 
%>
</BODY>
</HTML>