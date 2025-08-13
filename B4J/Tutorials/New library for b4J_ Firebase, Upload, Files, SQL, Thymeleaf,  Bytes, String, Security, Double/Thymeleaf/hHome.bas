B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
'Handler class
Sub Class_Globals
	Dim Thymeleaf As ThymeleafSupport
	Dim myUser As infoData
	Dim clsValue As clsContent
End Sub

Public Sub Initialize	
	
	clsValue.Initialize
	myUser.Initialize
End Sub

Sub Handle(req As ServletRequest, resp As ServletResponse)
	
	Dim ThymeleafTemplate As String = File.Combine(File.DirApp & "/www/templates","template1.htm")
	Dim variable As Map
	variable.Initialize
	variable.Put("date", DateTime.Date(DateTime.Now))
	variable.Put("uri", "https://tummosoft.com")
	variable.Put("user", myUser.User)
	variable.Put("roles", myUser.Roles)
	variable.Put("logout", "/logout.do")
	
	Thymeleaf.Initialize
	Thymeleaf.Encoding = "UTF-8"
	Thymeleaf.Cacheable = True
	'1200000L // TTL=20m
	Thymeleaf.CacheTTLMs = 1200000
	Thymeleaf.Variables = variable
	
	Thymeleaf.setVariable("pagetitle","Hello world")
	Thymeleaf.setVariable("des","单词意思是灵活的意思")
	Thymeleaf.setVariable("canonical","http://127.0.0.1/home")	
	Thymeleaf.setVariable("vietnamese","Xin chào các bạn!!!")
	
	Dim map2 As Map
	map2.Initialize
	
	Dim x1 As Int = 3
	Dim x2 As Int = 4
	
	map2.Put("h1", "This is h1 tag")
	map2.Put("is_caculator", True)
	map2.Put("x1", x1)
	map2.Put("x2", x2)
	
	Thymeleaf.Variables = map2
	
	Dim arr() As String = Array As String ("Monday","Tuesday", "Wednesday", "Thursday", "Friday")
	Thymeleaf.setVariable("myarrs", arr)
	
	Dim info As infoData
	info.Initialize
	info.Name = "DAVID"
	info.Age = "25"
	Thymeleaf.setVariable("authors", info)
	
	Dim html As String = Thymeleaf.toHTML(ThymeleafTemplate)
		
	'Log(html)
	resp.CharacterEncoding = "UTF-8"
	resp.Write(html)
	
End Sub