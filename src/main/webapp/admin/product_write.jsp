<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 등록</title>
</head>
<body>

</body>

<script type="text/javascript">

    function check(f) {
        blank=false;
        for (i=0; i<f.elements.length;i++) {
            if (f.elements[i].value=="")
                if (f.elements[i].name != "large")
                    blank= true;
        }
        if (blank==true)
            alert("모든 항목을 입력하십시오");
        else
            f.submit();
    }
</SCRIPT>
</HEAD>
<BODY>
[<A href= "adminMain.jsp"> 메인으로 </A>]

<FORM method=post action="product_save.jsp" enctype="multipart/form-data" >
    <TABLE border=0 width=300 >
        <TR>
            <TH bgcolor=#DFEDFF colspan=2>상품 올리기</TH>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>작성자</TH>
            <TD bgcolor=#eeeeee> <INPUT type=text name=wname size=20>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>상품 분류</TH>
            <TD bgcolor=#eeeeee>
                <FONT size=-1  color=white>
                    <SELECT name=category size=1>
                        <OPTION value=11>KeyBoard
                        <OPTION value=22>Mouse
                        <OPTION value=33>HeadSet
                        <OPTION value=44>Desk
                        <OPTION value=55>Chair
                        <OPTION value=66>etc
                    </SELECT>
                </FONT>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>상품명</TH>
            <TD bgcolor=#eeeeee>
                <INPUT type=text name=pname size=30>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>제조원</TH>
            <TD bgcolor=#eeeeee>
                <INPUT type=text name=sname size=30>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>시중가</TH>
            <TD bgcolor=#eeeeee>
                <INPUT type=text name=price size=10>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>판매가</TH>
            <TD bgcolor=#eeeeee>
                <INPUT type=text name=dprice size=10>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>입고 수량</TH>
            <TD bgcolor=#eeeeee>
                <INPUT type=text name=stock size=10>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>작은 이미지</TH>
            <TD bgcolor=#eeeeee>
                <INPUT type=file name=small size=30>
            </TD>
        </TR>
        <TR>
            <TH width=20% bgcolor=#DFEDFF>큰 이미지</TH>
            <TD bgcolor=#eeeeee>
                <INPUT type=file name=large size=30>
            </TD>
        </TR>
        <TR>
            <TH bgcolor=#DFEDFF>상품 내용</TH>
            <TD bgcolor=#eeeeee>
            </TD>
        </TR>
        <TR>
            <TD colspan=2>
                <TEXTAREA name=description cols=70 rows=5></TEXTAREA>
            </TD>
        </TR>
        <TR>
            <TD colspan=2>
                <INPUT type=button value="저장" onClick="check(this.form)" >
                <INPUT type=reset value="다시 쓰기" >
            </TD>
        </TR>
    </TABLE>
    </CENTER>
</FORM>


</html>
