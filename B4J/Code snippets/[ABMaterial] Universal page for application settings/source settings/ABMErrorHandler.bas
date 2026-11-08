B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
'Handler class
' OPTIONAL
'----------------------START MODIFICATION 4.00-------------------------------
Sub Class_Globals
	
End Sub

Public Sub Initialize
	
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	Dim jReq As JavaObject = req
	Dim errorUri As String = jReq.RunMethod("getAttribute", Array("javax.servlet.error.request_uri"))
	Log(errorUri)
	' the error message
	Dim errorMessage As String = jReq.RunMethod("getAttribute", Array("javax.servlet.error.message"))
	Log(errorMessage)
	' the error code
	Dim statusCode As String = jReq.RunMethod("getAttribute", Array("javax.servlet.error.status_code"))
	Dim errorCode As Int
	If IsNumber(statusCode) Then
		errorCode = statusCode
	Else
		errorCode = 200
	End If
	Dim htmlErrorTitle As String
	Dim htmlErrorInfo As String
	Select errorCode
		Case 200
			htmlErrorTitle = "Everything's Alright. :)"
			htmlErrorInfo = "It seems everything is working great.<br />If you frequently see this please contact us."
		Case 400
			htmlErrorTitle = "Bad Request. :("
			htmlErrorInfo = "The server cannot process the request due to something that is perceived to be a client error."
		Case 403
			htmlErrorTitle = "Access Denied. :("
			htmlErrorInfo = "The requested resource requires authentication."
		Case 404
			htmlErrorTitle = "Resource Not Found. :("
			htmlErrorInfo = "The requested resource could not be found but may be available again in the future."
		Case 405
			htmlErrorTitle = "Method Not Allowed. :("
			htmlErrorInfo = "The method received in the request-line is known by the origin server but not supported by the target resource."
		Case 500
			htmlErrorTitle = "Internal Server Error. :("
			htmlErrorInfo = "An unexpected condition was encountered.<br />Our support team has been dispatched to fix it."
		Case 501
			htmlErrorTitle = "Not Implemented. :("
			htmlErrorInfo = "The server cannot recognize the request method."
		Case 503
			htmlErrorTitle = "Service Unavailable. :("
			htmlErrorInfo = "We've got some trouble with our backend upstream cluster.<br />Our support team has been dispatched to bring it back online."
		Case Else
			htmlErrorTitle = "Unknown. :("
			htmlErrorInfo = "It seems something is wrong.<br />Our support team has been dispatched to fix this."
	End Select
		
	Dim htmlText As String = $"<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta http-equiv="cache-control" content="no-cache, no-store" />
        <meta http-equiv="expires" content="0" />
        <meta http-equiv="pragma" content="no-cache" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui"/>
		<meta name="apple-mobile-web-app-capable" content="yes">
        <title>${errorCode} - ${htmlErrorTitle}</title>
        <style type="text/css">html{font-family:sans-serif;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0}body,html{width:100%;height:100%;background-color:rgba(155,155,155,0.3)}body{color:#000;text-align:left;padding:0;min-height:100%;display:table;font-family:"Open Sans",Arial,sans-serif}h1{font-family:inherit;font-weight:500;line-height:1.1;color:inherit;margin:.37em 0}h1 span{border-right:solid 2px #e64320;padding-right:3px}.paused{border-right:solid 1px transparent}a{text-decoration:none;color:#333;border-bottom:dotted 1px #707070;background-color:transparent}a:active,a:hover{outline:0}.lead{color:#333;margin-top:0}.wrapper{display:table-cell;vertical-align:middle;padding:0 20px}@media (max-width:601px){.border{width:2%}.wrapper{width:96%}h1{font-size:1.4em}.lead,a{font-size:14px;line-height:1}}@media (max-width:901px) and (min-width:602px){.border{width:5%}.wrapper{width:90%}h1{font-size:1.6em}.lead,a{font-size:16px;line-height:1.1}}@media (max-width:1440px) and (min-width:902px){.border{width:10%}.wrapper{width:80%}h1{font-size:1.8em}.lead,a{font-size:18px;line-height:1.2}}@media (min-width:1441px){.border{width:15%}.wrapper{width:70%}h1{font-size:2em}.lead,a{font-size:21px;line-height:1.4}}</style>
    </head>
    <body>
		<div class="border"></div>
		<div class="wrapper">
			<div class="cover">
				<h1 id="title"><span id="titlespan">${htmlErrorTitle} </span></h1>
				<p class="lead">Error ${errorCode}: ${htmlErrorInfo}</p>
				<a href="/${ABMShared.AppName}/">You can go back to the homepage by clicking here!</a>
			</div>
		</div>
		<div class="border"></div>
    </body>
	<script type="text/javascript">
		var p=document.getElementById("title"),ps=document.getElementById("titlespan"),n=0,str=ps.innerHTML,i=40;p.innerHTML='<span id="titlespan"></span>';var myVar=setInterval(function(){n+=1,p.innerHTML='<span id="titlespan">'+str.slice(0,n)+"</span>",p.innerHTML==='<span id="titlespan">'+str+"</span>"&&(clearInterval(myVar),document.getElementById("titlespan").className+=" paused")},i);		
	</script>
</html>"$
	
	resp.ContentType = "text/html"
	resp.Write(htmlText)
End Sub
'----------------------END MODIFICATION 4.00-------------------------------