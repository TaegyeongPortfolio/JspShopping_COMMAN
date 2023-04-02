<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    /*
    1. 폼에서 넘어온 데이터를 각각 처리한다.
    2. SQL문을 이용해서 DB에 업데이트 작업.
    3. executeUpdate() 성공시 1을 반환, 실패시 0을 반환
    4. 업데이트가 성공하면 세션에 저장된 이름을 변경한 후에 update_succes.jsp로 리다이렉트
        업데이트에 실해시, update_fail.jsp로 리다이렉트
     */
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String phone1 = request.getParameter("phone1");
    String phone2 = request.getParameter("phone2");
    String phone3 = request.getParameter("phone3");
    String email = request.getParameter("email");
    String postcode = request.getParameter("postcode");
    String roadAddress = request.getParameter("roadAddress");
    String jibunAddress = request.getParameter("jibunAddress");
    String detailAddress = request.getParameter("detailAddress");
    String extraAddress = request.getParameter("extraAddress");

    //DB연결에 필요한 변수 선언
    String url="jdbc:mysql://localhost:3306/shopping?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
    String sqlId="root";
    String sqlPassword="awd79852";

    Connection conn = null;
    PreparedStatement pstmt = null;


    String sql = "update members set password = ?, name = ?, phone1 = ?, phone2 = ?, phone3 = ?, email = ?, postcode = ?, roadAddress = ?, jibunAddress = ?, detailAddress = ?, extraAddress = ?"
            + "where id = ?";

    try {
        // 1. 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        // 2. conn 생성
        conn = DriverManager.getConnection(url, sqlId, sqlPassword);
        // 3. pstmt 생성
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, password);
        pstmt.setString(2, name);
        pstmt.setString(3, phone1);
        pstmt.setString(4, phone2);
        pstmt.setString(5, phone3);
        pstmt.setString(6, email);
        pstmt.setString(7, postcode);
        pstmt.setString(8, roadAddress);
        pstmt.setString(9, jibunAddress);
        pstmt.setString(10, detailAddress);
        pstmt.setString(11, extraAddress);
        pstmt.setString(12, id);

        int result = pstmt.executeUpdate();

        if(result == 1) {
            session.setAttribute("user_name", name);
            response.sendRedirect("update_success.jsp");
        } else {
            response.sendRedirect("update_fail.jsp");
            }
        } catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("update_fail.jsp");
        } finally {
            try{
                if(conn != null) conn.close();
                if(pstmt != null) pstmt.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
    }
%>