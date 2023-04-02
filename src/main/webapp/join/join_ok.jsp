<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String passwordCheck = request.getParameter("passwordCheck");
    String phone1= request.getParameter("phone1");
    String phone2 = request.getParameter("phone2");
    String phone3 = request.getParameter("phone3");
    String email = request.getParameter("email");
    String postcode = request.getParameter("postcode");
    String roadAddress = request.getParameter("roadAddress");
    String jibunAddress= request.getParameter("jibunAddress");
    String detailAddress = request.getParameter("detailAddress");
    String extraAddress = request.getParameter("extraAddress");

    // 1. DB연결 변수선언
    String url="jdbc:mysql://localhost:3306/shopping?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
    String sqlId="root";
    String sqlPassword="awd79852";

    Connection conn = null;
    PreparedStatement pstmt = null;

    String sql = "insert into members values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try {
        // 1. 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        // 2. conn 생성
        conn = DriverManager.getConnection(url, sqlId, sqlPassword);
        // 3. pstmt 생성
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, id);
        pstmt.setString(3, password);
        pstmt.setString(4, passwordCheck);
        pstmt.setString(5, phone1);
        pstmt.setString(6, phone2);
        pstmt.setString(7, phone3);
        pstmt.setString(8, email);
        pstmt.setString(9, postcode);
        pstmt.setString(10, roadAddress);
        pstmt.setString(11, jibunAddress);
        pstmt.setString(12, detailAddress);
        pstmt.setString(13, extraAddress);

        // 4. sql문 실행
        int result = pstmt.executeUpdate();

        if (result == 1) {    // 성공
            response.sendRedirect("join_success.jsp");
        } else { //실패
            response.sendRedirect("join_fail.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if(conn != null) conn.close();
            if(pstmt != null) pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>