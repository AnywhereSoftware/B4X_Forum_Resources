B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=clvwithresizingtext.zip

Sub Class_Globals
	
	Private Loremipsum As String = $"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sem est, tempor in vulputate in, scelerisque vel magna. Quisque a augue id ligula aliquam facilisis quis eget enim. Phasellus ac leo sit amet diam venenatis finibus non a mi. Sed vel metus sed ipsum egestas feugiat a lobortis tortor. Cras mauris sem, posuere eget ipsum eu, sagittis gravida lorem. Donec venenatis mauris eget felis malesuada bibendum. Phasellus scelerisque est vitae lacus blandit pulvinar. Nam eleifend sit amet turpis id mattis.
Fusce ac venenatis nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Pellentesque sodales pulvinar turpis non varius. Integer lorem odio, euismod eget ipsum at, tristique dictum elit. Mauris efficitur commodo odio, nec tincidunt massa iaculis sit amet. Morbi ullamcorper pulvinar enim nec efficitur. Suspendisse potenti. Proin at commodo urna. Suspendisse dui diam, ullamcorper vel eros mollis, ultricies luctus diam. Proin eu arcu maximus, eleifend lectus vitae, bibendum turpis. Fusce id massa nec mi imperdiet consequat. Suspendisse potenti. Phasellus malesuada augue nec augue condimentum, a varius arcu lacinia. Maecenas faucibus fermentum scelerisque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur tellus quam, pellentesque nec odio sed, vehicula pulvinar lacus.
Nulla consectetur ac augue vel tristique. Mauris pretium enim sed rhoncus mattis. Aenean eget mauris pulvinar, aliquet arcu venenatis, tempus massa. Nulla nec est egestas, sodales quam vel, tempus turpis. Phasellus felis sem, molestie ac ultricies quis, posuere sed purus. Donec varius mi quam, in tristique tortor hendrerit at. Curabitur nec ultricies enim, vel vehicula leo. Ut venenatis metus a erat venenatis laoreet. In hac habitasse platea dictumst. Nulla venenatis odio vitae ipsum gravida, a pellentesque lectus volutpat. Praesent accumsan ornare eros in imperdiet. Sed vel urna nisi. Vestibulum sit amet sapien varius, rhoncus nisi suscipit, feugiat sapien. Ut ornare venenatis aliquet. Integer ut tempus justo, a fringilla ante. Ut vehicula molestie turpis in condimentum.
Maecenas eu volutpat nibh. Etiam mattis convallis enim sit amet dictum. Praesent pulvinar urna at posuere aliquam. Morbi ut ex ullamcorper, vestibulum lectus et, elementum arcu. Suspendisse tristique mi lacus, ac lobortis neque fermentum eget. Etiam ac urna in enim dapibus eleifend vel non urna. Sed sed libero in sapien sodales euismod. Cras sed risus laoreet lacus ullamcorper gravida eu lobortis est. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec eu lectus augue. Nullam gravida, nibh sit amet imperdiet consectetur, orci nibh accumsan lectus, eget pharetra diam tortor eget massa.
Quisque tincidunt eu eros a eleifend. Cras a risus bibendum, porta justo vitae, sagittis ex. In elementum purus quis eros lacinia, sit amet commodo tellus accumsan. Mauris a suscipit nisi, ac finibus magna. Pellentesque rhoncus rutrum consequat. Donec hendrerit feugiat varius. Donec nisi nulla, mollis et justo et, mattis molestie lacus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur vitae rhoncus risus. Fusce ut lorem non ex ornare commodo ut eget massa. "$
	
	Private Root As B4XView
	Private xui As XUI
	Private CustomListView1 As CustomListView
	Private MadeWithLove1 As MadeWithLove
	Private RTCS As ResizingTextComponent
	Private Button1 As B4XView
	Private B4XImageView1 As B4XImageView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	Root.Color = Colors.LightGray
	CustomListView1.asview.Color = Colors.Transparent
	B4XImageView1.Load(File.DirAssets,"digitwell_logo.png")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub  button1_click
	FillCLV(False)

End Sub

private Sub button2_click
	FillCLV(True)
End Sub

private Sub FillCLV(fallbacklinespacing As Boolean)
	CustomListView1.Clear
	
	Private txt As String
	For i = 0 To 5
		txt =CreateRandomString
		Private p As B4XView =CreateSizingItem(CustomListView1.AsView.Width,txt,fallbacklinespacing)
		CustomListView1.Add(p,0)
	Next
	
End Sub



private Sub CreateSizingItem(wid As Int, txt As Object,fls As Boolean) As B4XView
	Private p As B4XView = xui.CreatePanel("")
	'    The height in Addview is unimportant as it will automatically resize
	Root.AddView(p,0,0,wid,300dip)

	p.LoadLayout("RTCSSingle")
	p.RemoveViewFromParent
    
	RTCS.FallbackLineSpacing = fls
	
	' Set up some other stuff
	RTCS.SetPadding(20dip,10dip,20dip,10dip)
	RTCS.SetBackColor(Colors.White)
	RTCS.SetCorners(10dip)

	'randomize the font
	Select Rnd(0,3)
		Case 0
			RTCS.SetTextFont(xui.CreateFont(Typeface.LoadFromAssets("montserrat-extrabold.ttf"),Rnd(10,20)))
		Case 1
			RTCS.SetTextFont(xui.CreateFont(Typeface.LoadFromAssets("montserrat-medium.ttf"),Rnd(10,20)))
		Case 2
			RTCS.SetTextFont(xui.CreateFont(Typeface.LoadFromAssets("montserrat-semibold.ttf"),Rnd(10,20)))		
	End Select

	RTCS.Text = txt
    
	' Resize the containing panel
	p.Height = RTCS.GetHeight
	Return p
End Sub


private Sub CreateRandomString As String
	Dim text As String = $"0، 1، 2، 3، 4، 5، 6، 7، 8، 9، 10، 11، 12، 13، 14، 15، 16، 17، 18، 19، 20، 21، 22، 23، 24، 25، 26، 27، 28، 29، 30، 31، 32، 33، 34، 35، 36، 37، 38، 39، 40، 41، 42، 43، 44، 45، 46، 47، 48، 49، 50، 51، 52، 53، 54، 55، 56، 57، 58، 59، 60، 61، 62، 63، 64، 65، 66، 67، 68، 69، 70، 71، 72، 73، 74، 75، 76، 77، 78، 79، 80، 81، 82، 83، 84، 85، 86، 87، 88، 89، 90، 91، 92، 93، 94، 95، 96، 97، 98، 99، 100. "$
	
	Dim myStrings As List
	myStrings.Initialize
	myStrings.Add($"First Line...${CRLF}Second"$)
'	myStrings.Add(text & CRLF & CRLF & text & CRLF & CRLF & text & CRLF & CRLF & CRLF & CRLF & CRLF)
'	myStrings.Add(text & CRLF & CRLF & text & CRLF & CRLF & text & CRLF & CRLF & text & CRLF & CRLF & text)
'	myStrings.Add(text & text)
	myStrings.Add(text & CRLF & CRLF & text)
	
	Return myStrings.Get(1)
	
'	Return 	Loremipsum.SubString2(0,Rnd(10,Loremipsum.Length))
		
End Sub