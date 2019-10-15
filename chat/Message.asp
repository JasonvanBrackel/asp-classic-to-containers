<html>
<body bgcolor=#dcdcdc >
<%
    on error resume next
    call main()
    if err.number > 0 then 
        call global_asa(err.number)
    end if
%>

<%
sub main()
    dim  User , timesaid , ip , message
    username = REQUEST("username")
    timesaid = formatdatetime(time,4)
    ip =  request.servervariables("REMOTE_ADDR")
    message = request("message")

    if message = "" and username = "" then 
        username = "Guest"
        message = "New visitor from I.P. " & request.servervariables("REMOTE_ADDR")
    else
        if message = "" then message = "is too frustrated to talk"
        if username = "" then username = "anonymous"
    end if
    call putinfo(username,timesaid,ip,message)
    call display_prompt(username)

end sub

sub display_prompt(username)
    Response.Write "<form method=""POST"" action=""message.asp"">"
    Response.Write "<TABLE  BORDER=""5"" frame=""above"" HEIGHT = ""100%"" WIDTH = ""100%""  CELLSPACING=""0""  CELLPADDING=""0""  BGCOLOR = ""lightblue"" > "
    Response.Write "<TR>"
    Response.Write "<TD>"  & "&nbsp;" & "</TD>"
    if username = ""  or username = "anonymous" then
        Response.Write "<TD>" 
        response.write "Enter a username : " 
        Response.Write "</TD>" 
        Response.Write "<TD>" 
        response.write "<input name=""username"" type=""TEXT"" size=16>"
        Response.Write "</TD>" 
    else
        Response.Write "<TD>"
        response.write "Username : "
        Response.Write "</TD>" 
        Response.Write "<TD>"
        response.write "<input name=""username"" type=""TEXT"" & value=" & username & " size=16>"
        Response.Write "</TD>" 
    end if

    Response.Write "<TD>"  & "<input name=""message"" type=""TEXT"" size=50>" 
    Response.Write  "&nbsp;" & "<input Type=""submit"" value=""SEND"">" & "</TD>"
    Response.Write "<TD>"  & "&nbsp;" & "</TD>"
    Response.Write "</TR>"
    Response.Write "</TABLE>"
    response.write "</form>"

end sub



sub putinfo(username,timesaid,ip,message)
    dim TempArray1,TempArray2,TempArray3,TempArray4

    if message = "ip" then 
        session("IP") = true
        message = ""
        exit sub
    end if
    if message = "reset" then 
        session("IP") = false
        message = ""
        exit sub
    end if


    Application.lock
    if Application("Tplace") => Application("Tplaces") then
        Application("Tplace")=0
    else
        Application("Tplace") = Application("Tplace") + 1
    end if
    TempArray1=Application("User")
    TempArray2=Application("timesaid")
    TempArray3=Application("ip")
    TempArray4=Application("Message")

    if instr(1,mid(message,1,3),"cls") = 0 then
        TempArray4(Application("Tplace")) = message
    else 
        redim TempArray1(Application("Tplaces"))
        redim TempArray2(Application("Tplaces"))
        redim TempArray3(Application("Tplaces"))
        redim TempArray4(Application("Tplaces"))
        TempArray4(Application("Tplace")) = "Page Cleared by : " & username
    end if

    TempArray1(Application("Tplace")) = username
    TempArray2(Application("Tplace")) = timesaid 
    TempArray3(Application("Tplace")) = ip 

    Application("User")=TempArray1
    Application("timesaid")=TempArray2
    Application("ip")=TempArray3
    Application("message")=TempArray4
    Application.unlock 
end sub

Sub global_asa(temp)
    response.write temp
    'this if section implace of global.asa
    Application.lock
    Application("Tplace")=1
    Application("Tplaces")=25
    redim Temp(25)
    Application("User")=Temp
    Application("timesaid")=Temp
    Application("ip")=Temp
    Application("message")=Temp
    Application.unlock
End Sub

%>
</body>
</html>







