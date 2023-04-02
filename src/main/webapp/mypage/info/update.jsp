<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 이전화면에서 전달 받은 데이터 받기
    // 화면에 미리 보여지도록 처리 하시오
    request.setCharacterEncoding("UTF-8");

    String id = (String)request.getAttribute("id");
    String name = (String)request.getAttribute("name");
    String phone1 = (String)request.getAttribute("phone1");
    String phone2 = (String)request.getAttribute("phone2");
    String phone3 = (String)request.getAttribute("phone3");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2>정보 수정페이지</h2>
    <form action="update_ok.jsp" method="post">
        아이디:<input type="text" name="id" value="<%=id %>" readonly<br/>
        비밀번호:<input type="password" name="password"><br/>
        이름:<input type="text" name="name" value="<%=name%>"><br/>
        전화번호: 
        <select name="phone1">
            <option <%=phone1.equals("010") ? "selected" : "" %>>010</option>
            <option <%=phone1.equals("011") ? "selected" : "" %>>011</option>
            <option <%=phone1.equals("019") ? "selected" : "" %>>019</option>
            <option <%=phone1.equals("017") ? "selected" : "" %>>017</option>
        </select>
        - <input type="text" name="phone2" size="5" value="<%=phone2 %>">
        - <input type="text" name="phone3" size="5" value="<%=phone3 %>"><br/>

        이메일: <input type="text" name="email" size="15">
        @ <select name="email2">
        <option>naver.com</option>
        <option>hanmail.net</option>
        <option>nate.com</option>
        <option>google.com</option>
    </select><br/>
        주소:
        <input type="text" id="sample4_postcode" name="postcode"placeholder="우편번호">
        <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
        <input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소" size="50">
        <input type="text" id="sample4_jibunAddress"  name="jibunAddress" placeholder="지번주소" size="50"> <br />
        <span id="guide" style="color:#999;display:none"></span>
        <input type="text" id="sample4_extraAddress" name="extraAddress" placeholder="참고항목" size="30">
        <input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세주소" size="30"><br />
        <input type="submit" value="수정">
    </form>
</body>

<script type="text/javascript">
    function checkform() {
    //이름 유효성 검사만 함
    //https://velog.io/@cyhse7/.jsp-%EC%97%B0%EC%8A%B5%ED%95%98%EA%B8%B0-07
    /*if ( ! (document.joinform.name.value.length >= 6 && document.joinform.name.value.length <= 12)) {
        alert("6 ~ 12자 사이로 입력해주세요");
        form.name.focus();
    }
}*/
</script>


<!-- 주소찾기 js스크립트-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</html>
