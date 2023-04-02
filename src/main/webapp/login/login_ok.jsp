<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");

    // 1.DB연결 변수 선언
    String url="jdbc:mysql://localhost:3306/shopping?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
    String sqlId="root";
    String sqlPassword="awd79852";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "select * from members where ID = ? and PASSWORD = ? ";

    try {
        // 1. 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        // 2. conn 생성
        conn = DriverManager.getConnection(url, sqlId, sqlPassword);
        // 3. pstmt 생성
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, password);

        // 4. sql 실행
        rs = pstmt.executeQuery();

        if(rs.next()) { //로그인 성공(인증의 수단 session)
            id = rs.getString("id");
            String name = rs.getString("name");
            String roadAddress = rs.getString("roadAddress");
            String detailAddress = rs.getString("detailAddress");
            String extraAddress = rs.getString("extraAddress");

            session.setAttribute("user_id", id);
            session.setAttribute("user_name", name);
            session.setAttribute("roadAddress", roadAddress);
            session.setAttribute("detailAddress", detailAddress);
            session.setAttribute("extraAddress", extraAddress);

            if("admin".equals(id)) {
                response.sendRedirect("../admin/adminMain.jsp");
            } else {
                response.sendRedirect("../shopping/shop_list.jsp");
            }

        } else {   //로그인 실패
            response.sendRedirect("login_fail.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp"); //에러가 난 경우도 리다이렉트
    } finally {
        try{
            if(conn != null) conn.close();
            if(pstmt != null) pstmt.close();
            if(rs != null) rs.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>