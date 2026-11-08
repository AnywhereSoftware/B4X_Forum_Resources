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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Label1 As Label
	Private oldOffset As Int
	Private Panel1, pnlGrid As Panel
	Private btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn0, btnDel, btnClear As Button
	
	Private PinDots As List
	Private Pin As String = ""
	Private MaxPin As Int = 6
	Private CorrectPin As String = "123456"
	Private HaloColor As Int = Colors.ARGB(100, 255, 255, 255)  ' Warna halo
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Dim oldOffset As Int = DateTime.GetTimeZoneOffsetAt(DateTime.Now)
	Log("Old Timezone: " & oldOffset)
	
	DateTime.DateFormat = "dd-MM-yyyy"
	DateTime.TimeFormat = "HH:mm:ss"
	DateTime.SetTimeZone(7)
	
	' 🔥 UPDATE LABEL SETIAP 1 DETIK
	Label1.Typeface	= Typeface.LoadFromAssets("digital.ttf")
	Label1.TextSize	= 60
	UpdateClock
	
	RoundButtons
	btnPosition
	SetButtonTags
	AddRippleToAllButtons
	CreatePinDots
End Sub


Private Sub AddRippleToAllButtons
	Dim ripple As RippleView
	Dim btns As List = Array As B4XView(btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn0, btnDel, btnClear)
    
	For Each btn As B4XView In btns
		ripple.Initialize(btn, Colors.White, 300, True)
	Next
End Sub

' ✅ CREATE 6 CIRCLE PIN
Private Sub CreatePinDots
    PinDots.Initialize
    Dim size As Int = 40dip
    Dim gap As Int = 15dip
    Dim totalWidth As Int = size * 6 + gap * 5
    Dim startX As Int = (Root.Width - totalWidth) / 2
    Dim startY As Int = 170dip
    
    For i = 0 To MaxPin - 1
        Dim pnl As Panel
        pnl.Initialize("")
        pnl.SetLayout(startX + i * (size + gap), startY, size, size)
        
        ' 🔥 CIRCLE
        Dim gd As GradientDrawable
        gd.Initialize("TOP_BOTTOM", Array As Int(Colors.White, Colors.LightGray))
        gd.CornerRadius = size / 2
        pnl.Background = gd
        
        ' 🔥 LABEL (tanda ● / ○)
        Dim lbl As Label
        lbl.Initialize("")
        lbl.SetLayout(0, 0, size, size)
        lbl.Gravity = Gravity.CENTER
        lbl.Text = "○"
        lbl.TextSize = 20
        lbl.TextColor = Colors.Black
        pnl.AddView(lbl, 0, 0, size, size)
        
        Panel1.AddView(pnl, startX + i * (size + gap), startY, size, size)
        PinDots.Add(pnl)
    Next
End Sub


Private Sub UpdateClock
	Label1.Text = DateTime.Time(DateTime.Now)
	'Label1.Text = DateTime.Time(DateTime.Now) & " " & DateTime.Date(DateTime.Now)
	Sleep(1000)
	UpdateClock
End Sub

Private Sub SetButtonTags
	btn1.Tag = "1"
	btn2.Tag = "2"
	btn3.Tag = "3"
	btn4.Tag = "4"
	btn5.Tag = "5"
	btn6.Tag = "6"
	btn7.Tag = "7"
	btn8.Tag = "8"
	btn9.Tag = "9"
	btn0.Tag = "0"
	btnDel.Tag = "del"
	btnClear.Tag = "clear"	
End Sub

Private Sub btnPosition
	Dim screenWidth As Int = 100%x
	Dim btnWidth As Int = 70dip
	Dim gap As Int = 100dip
    
	btn2.Left = (screenWidth - btnWidth) / 2 'Center
	btn2.Top = 100dip
    	
	btn1.Left = btn1.Left - btnWidth - gap
	btn1.Top = 100dip
    	
	btn3.Left = btn2.Left + btnWidth + gap
	btn3.Top = 100dip
	
	btn5.Left = btn2.Left 'Center
	btn5.Top = 230dip
		
	btn4.Left = btn1.Left
	btn4.Top = 230dip
    
	btn6.Left = btn3.Left
	btn6.Top = 230dip
	
	btn8.Left = btn2.Left 'Center
	btn8.Top = 360dip
	
	btn7.Left = btn1.Left
	btn7.Top = 360dip
    
	btn9.Left = btn3.Left
	btn9.Top = 360dip
	
	btn0.Left = btn2.Left 'Center
	btn0.Top = 490dip
	
	btnDel.Left = btn3.Left 'Center
	btnDel.Top = 490dip	
	btnDel.TextSize = 26
	
	btnClear.Left = btn1.Left
	btnClear.Top  = 490dip
	btnClear.TextSize = 26	
End Sub

Private Sub RoundButtons
	For i = 0 To pnlGrid.NumberOfViews - 1
		Dim v As View = pnlGrid.GetView(i)
        
		If v Is Button Then
			Dim btn As Button = v
			Dim gd As GradientDrawable		
			
			gd.Initialize("TOP_BOTTOM", Array As Int( _
    		Colors.ARGB(255, 60, 60, 60), _
    		Colors.ARGB(255, 30, 30, 30)))
			
			'Variant
			'gd.Initialize("TOP_BOTTOM", Array As Int( _
    		'Colors.ARGB(200, 255, 255, 255), _
    		'Colors.ARGB(100, 240, 240, 240)))			
			
			gd.CornerRadius = 55dip
			btn.Background 	= gd
			btn.TextSize 	= 45
			btn.TextColor	= Colors.White
		Else
			' ⏭️ SKIP (EditText, Label, etc)
			Log("Skip: " & GetType(v))
		End If		
	Next
End Sub

' ✅ UPDATE PIN DOTS
Private Sub UpdatePinDots
	For i = 0 To MaxPin - 1
		Dim pnl As Panel = PinDots.Get(i)
		Dim lbl As Label = pnl.GetView(0)  
		If i < Pin.Length Then
			lbl.Text = "●" 
			lbl.TextColor = Colors.Black
		Else
			lbl.Text = "○"
			lbl.TextColor = Colors.Gray
		End If
	Next
End Sub

' ✅ CHECK PIN
Private Sub CheckPin
	If Pin.Length = MaxPin Then
		If Pin = CorrectPin Then
			Log("✅ CORRECT!")
			xui.MsgboxAsync("PIN Correct!", "Success")
			Pin = ""
			UpdatePinDots
		Else
			Log("❌ WRONG PIN!")
			xui.MsgboxAsync("Wrong PIN!", "Error")
			Pin = ""
			UpdatePinDots
		End If
	End If
End Sub

Private Sub B4XPage_Disappear
	'DateTime.SetTimeZone(oldOffset)
End Sub

Private Sub Btn_Click
	Dim btn As Button = Sender
	Dim digit As String = btn.Text
    
	'CreateHaloSimple(btn, btn.Width / 2, btn.Height / 2)
	' 🔥 CHECK BUTTON CLICK
	If btn.Tag = "del" Then
		If Pin.Length > 0 Then
			Pin = Pin.SubString2(0, Pin.Length - 1)
			UpdatePinDots
		End If
	Else If btn.Tag = "clear" Then
		Pin = ""
		UpdatePinDots
	Else
		'0-9
		If Pin.Length < MaxPin Then
			Pin = Pin & digit
			UpdatePinDots
			CheckPin
		End If
	End If
End Sub
