
<%RESPONSE.BUFFER = TRUE%>
<%="<html>"%>
<%="<head>"%>
<%="<META HTTP-EQUIV=""refresh"" content=""5; url=display.asp"">"%>
<%="<title>Display Page</title>"%>
<%="</head>"%>
<%="<body bgcolor=#dcdcdc >"%>

<%
    on error resume next
    call main()
    if err.number > 0 then 
        call global_asa(err.number)
    end if
%>

<%
Sub main()
    Dim tmpUser,tmpTimesaid,tmpIP,tmpMesssage
    tmpUser=Application("User")
    tmpTimesaid=Application("timesaid")
    tmpIP=Application("ip")
    tmpMesssage=Application("message")
    call create_headings()
    call display_body(Application("Tplace"),1,tmpUser,tmpTimesaid,tmpIP,tmpMesssage)
    call display_body(Application("Tplaces"),Application("Tplace")+1,tmpUser,tmpTimesaid,tmpIP,tmpMesssage)
    call terminate_table()
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

sub create_headings()
    Response.Write date & "<BR>" & formatdatetime(time,3)
    Response.Write "<TABLE  BORDER=""1""  HEIGHT = ""80%"" WIDTH = ""100%""  CELLSPACING=""0""  CELLPADDING=""0""  BGCOLOR = ""lightblue"" > "
    Response.Write "<TR>"
    'Response.Write "<TD>"  & "&nbsp;" & "</TD>"
    Response.Write "<TD colspan=""6"" >"  & "<H1><CENTER> Chat with Gogs </CENTER></H1>" &   "</TD>"
    'Response.Write "<TD>"  & "&nbsp;" & "</TD>"
    Response.Write "</TR>"
    Response.Write "<TR>"
    Response.Write "<TD BGCOLOR = ""CADETBLUE"">"  & "&nbsp;" & "</TD>"
    Response.Write "<TD BGCOLOR=""WHEAT"">" & "<H2><PRE>Time</PRE></H2></TD>"
    Response.Write "<TD BGCOLOR=""WHEAT"">" & "<H2><PRE>User</PRE></H2></TD>"
    if session("IP") then
        Response.Write "<TD BGCOLOR=""WHEAT"">" & "<H2><PRE>Message" & SPACE(45) & "</PRE></H2></TD>"
        Response.Write "<TD BGCOLOR=""WHEAT"">" & "<H2><PRE>I.P.</PRE></H2></TD>"
    else
        Response.Write "<TD colspan=""2"" BGCOLOR=""WHEAT"">" & "<H2><PRE>Message" & SPACE(40) & "</PRE></H2></TD>"
    end if
    Response.Write "<TD BGCOLOR = ""CADETBLUE"">"  & "&nbsp;" & "</TD>"
    Response.Write "</TR>"


end sub


sub display_body(firstpos,endpos,tmpUser,tmpTimesaid,tmpIP,tmpMesssage)
    for x = firstpos to endpos step - 1
        Response.Write "<TR>"
        Response.Write "<TD BGCOLOR = ""lightgrey"">"  & "&nbsp;" & "</TD>"
        Response.Write "<TD BGCOLOR = ""aqua"">" & tmpTimesaid(x) & "&nbsp;" & "</TD>"
        Response.Write "<TD BGCOLOR = ""orange"">" & tmpUser(x) & "&nbsp;" & "</TD>"
        if session("IP") then
            Response.Write "<TD BGCOLOR = ""white"">" & tmpMesssage(x) & "&nbsp;" & "</TD>"
            Response.Write "<TD BGCOLOR = ""lightgreen"">" & tmpIP(x) & "&nbsp;" & "</TD>"
        else
            if instr(tmpMesssage(x),"http") = 0 then
                Response.Write "<TD BGCOLOR = ""white"" colspan=""2"">" & tmpMesssage(x) & "&nbsp;" & "</TD>"
            else
                Response.Write "<TD BGCOLOR = ""white"" colspan=""2"">" & _
		     "<A href=" & tmpMesssage(x) & ">" _ 
                     & tmpMesssage(x) & "&nbsp;" & "</TD>"
            end if
        end if
        Response.Write "<TD BGCOLOR = ""lightgrey"">"  & "&nbsp;" & "</TD>"
        Response.Write "</TR>"
    next 
end sub

sub terminate_table()
    Response.Write "<TR>"
    Response.Write "<TD BGCOLOR = ""CADETBLUE"">" & "&nbsp;" & "</TD>"
    Response.Write "<TD BGCOLOR = ""lightgrey"">" & "&nbsp;" & "</TD>"
    Response.Write "<TD BGCOLOR = ""lightgrey"">" & "&nbsp;" & "</TD>"
    if session("IP") then
        Response.Write "<TD BGCOLOR = ""lightgrey"">" & "&nbsp;" & "</TD>"
        Response.Write "<TD BGCOLOR = ""lightgrey"">" & "&nbsp;" & "</TD>"
    else
        Response.Write "<TD  colspan=""2"" BGCOLOR = ""lightgrey"">" & "&nbsp;" & "</TD>"
    end if
    Response.Write "<TD BGCOLOR = ""CADETBLUE"">" & "&nbsp;" & "</TD>"
    Response.Write "</TR>"
    Response.write "</TABLE>" 
end sub
%>
<%="</body>"%>
<%="</html>"%>
