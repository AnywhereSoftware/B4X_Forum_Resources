B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files

#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private allitems As CustomListView
	Private searchfield As B4XFloatTextField
	Dim su As StringUtils
	
	Private Selenium As Pnd_Selenium
	Private Download As Button
	Private ImageView1 As ImageView
	Private DDD As DDD
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"Google Image Downloader")
	
	DDD.Initialize
	'The designer script calls the DDD class. A new class instance will be created if needed.
	'In this case we want to create it ourselves as we want to access it in our code.
	xui.RegisterDesignerClass(DDD)
	
	Sleep(500) ' To show MainForm before Chrome
	
	Dim UserAgent As String = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
	Selenium.AddArgument("--headless")
	Selenium.AddArgument("--disable-blink-features=AutomationControlled")
	Selenium.AddArgument("--user-agent=" & UserAgent)
	Selenium.AddExperimentalOption("useAutomationExtension", False)
	Selenium.AddExperimentalOption("excludeSwitches", Array As String("enable-automation"))
	Selenium.Initialize("Selenium", File.DirApp & "\chrome\chromedriver.exe") 'caution, may be need different way to have it with your app !!!
	Selenium.ExecuteScript("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})", "")
	Dim Parameters As Map = CreateMap("userAgent":UserAgent)
	Selenium.ExecuteCdpCommand("Network.setUserAgentOverride", Parameters)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub searchfield_EnterPressed
	Selenium.NavigateTo("https://www.google.com/search?q="&searchfield.TextField.Text.Trim&"&sclient=img")

End Sub

Sub Selenium_NavigationFinished
	
	Dim idx As Int=0
	
	Dim AllImgTagsList As List = Selenium.FindByXPathList("//img")           ' we are looking to find every IMG tag in the page, AllImgTagsList now represent List of IMG tags
	For Each OneImgtag As Pnd_WebElement In AllImgTagsList                   ' OneImgtag now represent one IMG tag from <img to >
		Dim ImageLink As String = OneImgtag.GetDomProperty("src")            ' get ImageLink from "src"
		If ImageLink.ToLowerCase.StartsWith("data") Then                     ' to exclude base64 encoded images like: data:image/svg+xml;base64,PHN2XRj... - this can be done with FindByXPathList, but this is just an example
			allitems.Add(additem(ImageLink),idx)
			idx=idx+1
		End If
	Next

End Sub

Private Sub B4XPage_CloseRequest
	Selenium.Quit
	ExitApplication
End Sub


Private Sub additem(s_img As String) As B4XView

	Dim p As B4XView=xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, allitems.GetBase.Width, 150dip)
	p.LoadLayout("item")
	
	'split info from base64_image
	
	Dim whatkindofimg As String=s_img.SubString2(0,s_img.IndexOf(","))
	Dim dataofimg As String=s_img.SubString(s_img.IndexOf(",")+1)
	'Log(whatkindofimg)
	'Log(dataofimg)
	
'	Select Case whatkindofimg
'		Case "data:image/png;base64"
'		Case "data:image/gif;base64"
'		Case Else
'			'data:image/jpeg;base64
'	End Select
	
	Dim src() As Byte = su.DecodeBase64(dataofimg)
	ImageView1.SetImage(BytesToImage(src))
	'Log("XXX")

	Return p	

End Sub



Public Sub BytesToImage(bytes() As Byte) As B4XBitmap
	Dim In As InputStream
	In.InitializeFromBytesArray(bytes, 0, bytes.Length)
	Dim bmp As Image
	bmp.Initialize2(In)
	Return bmp
End Sub

Private Sub Download_Click
	'Dim button As Button = Sender
	Dim index As Int = allitems.GetItemFromView(Sender)
	Dim pnl As Pane = allitems.GetPanel(index)
	Dim imgv As ImageView= DDD.GetViewByName(pnl, "ImageView1")
	Dim Out As OutputStream = File.OpenOutput(File.DirApp, "download_" & DateTime.Now.As(String).Trim & ".png",False)
	imgv.GetImage.WriteToStream(Out)
	Out.Close
	ShowFolderAtExplorer(File.DirApp)

End Sub


Sub ShowFolderAtExplorer(expdir As String)
	Dim js As Shell
	Dim params As List
	params.Initialize
	params.add(QUOTE & expdir.Replace("/","\") & QUOTE)
	js.Initialize("js", "explorer.exe", params)
	js.WorkingDirectory = "C:\Windows"
	js.Run(-1)
End Sub