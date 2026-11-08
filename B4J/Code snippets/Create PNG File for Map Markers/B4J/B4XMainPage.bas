B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=WriteOnImage.zip

Sub Class_Globals
'	Private Root As B4XView
'	Private xui As XUI
'	Private pnDraw As B4XView
'	Private ImageView1 As B4XView
'	Private TextField1 As B4XView
'	Private btnWrite As B4XView
'	Private mCanvas As B4XCanvas
	Private mCanvas As Canvas
	
'	Private mRect As B4XRect
'	Private plist As List
	
	Private fx As JFX
'	Private MainForm As Form
	Type TextMetric (Width As Double,Height As Double)
	
End Sub

Public Sub Initialize

End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	'Root = Root1
'	Root.LoadLayout("MainPage")
	
'	pnDraw = xui.CreatePanel("")
	'Root.AddView(pnDraw,   ImageView1.Left, ImageView1.Top, ImageView1.Width, ImageView1.Height)
'	Root.AddView(pnDraw,   ImageView1.Left, ImageView1.Top, ImageView1.Width, ImageView1.Height)
'	Root.AddView(pnDraw,   ImageView1.Left+28dip, ImageView1.Top+1dip, 180dip, 32dip)
'	mCanvas.Initialize(  pnDraw)
'	mRect.Initialize(0, 0, ImageView1.Width, ImageView1.Height)
'	mCanvas.DrawBitmap( ImageView1.Snapshot, mRect)
'	plist.Initialize
'	plist = File.ReadList(File.DirApp,"places.csv")
''	For i = 0 To plist.Size-1
''		Log(" Name: "&plist.Get(i))
''		
''	Next
'	ImageView1.Color = xui.Color_Transparent
'	btnWrite_Click

	File.MakeDir(File.DirApp,"tmplbl")
	
	Dim rand As Int = Rnd(1,5000)
	Dim t As String = " Spd: "&rand&"  Time: "&DateTime.Time(DateTime.Now)&" Truck #: ( "&(rand+376)&" )"
    Dim ret As String = Makelabel(t,rand)	
	
	Log(" File created: "&ret)

	ExitApplication2(0)
	
	
	
End Sub


Sub Makelabel(t As String, rand As Int) As String
	
	mCanvas.Initialize("")
	Dim fs As Double = 16
	
	Dim TM As TextMetric = MeasureText(t,fx.DefaultFont( fs))

	Log(" Height: "&TM.Height & "   Width: " & TM.Width)

	Dim width, height As Double
	width = TM.Width + 6
	height = TM.Height + 1
	
	mCanvas.SetSize(width,height)
	mCanvas.DrawRect( 0  , 0,  width, height,  fx.Colors.White,  True,  1) 'check size
	mCanvas.DrawText2(t,   1, 16 ,fx.DefaultFont(fs),fx.Colors.Black,"LEFT",TM.Width)
	
	
	Dim fn As String = rand&"_"&DateTime.Now
	Dim Dir As String
	Dir = File.DirApp&"\tmplbl"
	Dim Out As OutputStream
	Out = File.OpenOutput(Dir, fn&".png", False)
	
	mCanvas.Snapshot.WriteToStream(Out)
	Out.Close
	Return fn&".png"
	
End Sub


Sub MeasureText(Text As String,TFont As Font) As TextMetric
	Dim TB,Bounds As JavaObject
	Dim TM As TextMetric

	TB.InitializeStatic("javafx.scene.text.TextBuilder")
	Bounds = TB.RunMethodJO("create",Null).RunMethodJO("text",Array(Text)).RunMethodJO("font",Array(TFont)).RunMethodJO("build",Null).RunMethodJO("getLayoutBounds",Null)

	TM.Width = Bounds.RunMethod("getWidth",Null)
	TM.Height = Bounds.RunMethod("getHeight",Null)
	Return TM
End Sub



'Sub btnWrite_Click
'	
''	For i = 0 To 0 'plist.Size-1
'    
'	mCanvas.Initialize("")
'
'
''	mCanvas.ClearRectClearRect(mCanvas.TargetRect)
''	TextField1.Text = " Spd: "&("100")&"  Time: "&DateTime.Time(DateTime.Now) 'plist.Get(i)
'	'Dim inTexts() As String = SplitRows(TextField1.Text)
''	Dim ln As Int = TextField1.Text.Length
'	Dim fs As Double = 16
'	
'	Dim t As String = " Spd: "&("100")&"  Time: "&DateTime.Time(DateTime.Now)&" Truck #: 74212"
'	Dim TM As TextMetric = MeasureText(t,fx.DefaultFont( fs))
'
'	Log(" Height: "&TM.Height & "   Width: " & TM.Width)
'
'    #region measure text size
'
'		Dim width, height As Double
'		width = TM.Width + 6
'		height = TM.Height + 1
'
''		Dim FontHeight As Float
''		FontHeight = fs
'
'	'	For Each t As String In inTexts
''			FontHeight = Max( FontHeight , mCanvas.meMeasureText( t, xui.CreateDefaultBoldFont(DipToCurrent(fs))).Height + 1dip) 'max. text row height
'	'	Next
'
'	'	For Each t As String In inTexts
''			width = Max(width , mCanvas.MeasureText(t, xui.CreateDefaultBoldFont(DipToCurrent(fs))).Width) 'maximal with
'			'width = width + 12dip
'			'height = height + FontHeight 
'	'	Next
'
'    #end region
'	
'	
'	
'    #region draw text
'
''		Dim Rect1 As B4XRect
''		mCanvas.DrawRect(
'	'	mCanvas.ClearRect(Rect1)
'		
''		Rect1.Initialize( pnDraw.Width / 2.0 - width / 2.0,  pnDraw.Height / 2.0 - height / 2.0,   pnDraw.Width / 2.0 + width / 2.0,   pnDraw.Height / 2.0 + (height+1dip) / 2.0)
'	    mCanvas.SetSize(width,height)
'
'		mCanvas.DrawRect( 0  , 0,  width, height,  fx.Colors.White,  True,  1) 'check size
'	mCanvas.DrawText2(t,   1, 16 ,fx.DefaultFont(fs),fx.Colors.Black,"LEFT",TM.Width)
'	'	mCanvas.DrawRect(Rect1,  xui.Color_Black,  False, 1dip) 'check size
'		'pnDraw.Width = Rect1.Width+15dip
'		'pnDraw.Height = Rect1.Height+10dip
'		
'    
''	lblWidth.Text = Round(Rect1.Width)
''	lblHeight.Text = Round(Rect1.Height)
'	
''		Dim y As Float = Rect1.Top
''		Dim h As Float = 0
'    
'	'	For Each t As String In inTexts
''			h = FontHeight
''			y = y + h
''			mCanvas.DrawText(t,  Rect1.Left, y - FontHeight * 0.1, xui.CreateDefaultBoldFont(fs), xui.Color_Black, "LEFT")
''			Sleep(500)
''			Log(" each t: "&t)
'		
'	'	Next
'	
''	Select ln
''			Case 1,2,3,4,5
''				fs = 15
''			Case 6,7,8,9,10,11
''				fs = 15
''			Case Else 
''				fs = 10
''			
''	End Select
'	
''	If ln > 10 Then
''		fs = 10
'		'mRect.Initialize(0, 0, ImageView1.Width+20dip, ImageView1.Height-10dip)
'		
''	End If
'	' ******************************
'	'mCanvas.DrawBitmap(ImageView1.Snapshot,  Rect1)
'		
''		If TextField1.Text.Contains("M M") Then
''			mCanvas.DrawRect(mRect,xui.Color_Yellow,True, 1.0)
''		
''		Else
''			mCanvas.DrawRect(mRect,xui.Color_LightGray,True, 1.0)
''			
''		End If
''		If TextField1.Text.Contains("BRIDGE") Or TextField1.Text.Contains("BRG")  Then
''			mCanvas.DrawRect(mRect,xui.Color_Cyan,True, 1.0)
''		End If
''
''		If TextField1.Text.Contains("PULL") Then
''			mCanvas.DrawRect(mRect,xui.Color_White,True, 1.0)
''		End If
'			
'			
''	mCanvas.DrawRect(mRect,xui.Color_Yellow,True, 1.0)
'
'	'************************
'	''mCanvas.DrawText(TextField1.Text.ToUpperCase, mRect.Width / 2, mRect.Height / 1.7, xui.CreateDefaultBoldFont(fs ), xui.Color_Blue, "CENTER")
'	
''	mCanvas.DrawRect(mRect,xui.Color_Black,False, 2.0)
'	btnSave_Click("T2")
''	Sleep(500)
''	Next
'	
'	
'End Sub
'
'Sub TextField1_TextChanged (Old As String, New As String)
''	btnWrite.Visible = (New.Length > 0)
'End Sub
'
'Sub btnSave_Click(fn As String)
'	Dim Dir As String
'	#If B4J
'		Dir = File.DirApp&"\spdmark"
'	#Else If B4A Then
'		Dir = File.DirInternal
'	#End If
'	Dim Out As OutputStream
'	Out = File.OpenOutput(Dir, fn&".png", False)
'	
'	mCanvas.Snapshot.WriteToStream(Out) 
'	Out.Close
'
'	#If B4J
'	Log(" Wrote file: "&fn&".png")
'		'xui.MsgboxAsync("Saved in the object folder", "")
'	#Else If B4A Then
'		xui.MsgboxAsync("Saved in the DirInternal", "")
'	#End If
'End Sub
'
