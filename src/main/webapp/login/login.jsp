<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <link href="../lib/login.css" rel="stylesheet" type="text/css">
</head>
<body>


<script type="text/javascript">
    function checkform() {
        if ( document.LoginForm.id.value == "") {
            alert("아이디를 입력해주세요");
            form.id.focus();
            return false;
        }
        else if (document.LoginForm.password.value == ""){
            alert("비밀번호를 입력해주세요");
            form.password.focus();
            return false;
        }
        // 만약 값이 다 넘어왔다면 전송해줘라
        document.LoginForm.submit();
    }
</script>


        <!--<p> 아이디 : <input type="text" name="id"> <br>
        비밀 번호 : <input type="password" name="password"> <br>
        <input type="button" value="로그인" onclick="checkform()">-->

    <div class="center">
        <h1>Login</h1>
        <form name="LoginForm" action="login_ok.jsp" method="post" >
            <div class="txt_field">
                <input type="text" name="id">
                <span></span>
                <label>ID</label>
            </div>
            <div class="txt_field">
                <input type="password" name="password">
                <label>Password</label>
                <span></span>
            </div>
            <div class="pass">비밀번호를 잊으셨나요?</div>
            <input type="submit" value="Login">
            <div class="signup_link">
                <div class="signup_link">
                    회원이 아니신가요? <a href="#">가입하기</a>
                </div>
            </div>
        </form>

    </div>

</body>
</html>
