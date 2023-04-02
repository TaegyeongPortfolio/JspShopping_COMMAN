<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    // 정보수정 화면으로 가기전에
    // 아이디 기준으로 회원정보를 조회해서 다음 화면으로 전달

    String id = (String)session.getAttribute("user_id");
    //DB연결에 필요한 변수 선언
    String url="jdbc:mysql://localhost:3306/shopping?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
    String sqlId="root";
    String sqlPassword="awd79852";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "select * from members where ID = ? ";

    try {
            // 드라이버 호출
        // 1. 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        // 2. conn 생성
        conn = DriverManager.getConnection(url, sqlId, sqlPassword);
        // 3. pstmt 생성
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        // sql실행
        rs = pstmt.executeQuery();

        if(rs.next()){
            id = rs.getString("id");
            String name = rs.getString("name");
            String phone1 = rs.getString("phone1");
            String phone2 = rs.getString("phone2");
            String phone3 = rs.getString("phone3");

            // 포워드로 전달하기 위해
            request.setAttribute("id", id);
            request.setAttribute("name", name);
            request.setAttribute("phone1", phone1);
            request.setAttribute("phone2", phone2);
            request.setAttribute("phone3", phone3);

            // 포워드 이동

            request.getRequestDispatcher("update.jsp").forward(request, response);
        } else { //세션이 만료된 경우
            response.sendRedirect("../login/login.jsp");
            }
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("/login/login.jsp");
        } finally {
            try {
                if(conn != null) conn.close();
                if(pstmt != null) pstmt.close();
                if(rs != null) rs.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
    }
%>