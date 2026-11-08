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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private Busy As xBusy
	
	Private clv As CustomListView
	Private lblPreview As B4XView
	Private imgPreview As B4XView
	Private lblSelectTextColor, lblSelectCustomSpinner As B4XView
	Private lblTest1, lblTest2, lblTest3 As B4XView
	Private B4XSwitch1 As B4XSwitch
	Private lblBackgroundStatus As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"Loading xBusy Demo")
	Busy.Initialize(Root)
	ShowSplashScreen
'	Busy.TapToClose=True 'Should only be used during development.
End Sub

Private Sub B4XPage_Appear
	If Not(Busy.IsActive) Then 'Don't show if splash screen is active
		Busy.ShowWithText("Loading xBusy demo")
			UpdatePreview
			Wait For(ProcessData) Complete (b As Boolean)
		Busy.Hide
	End If
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	Busy.Base_Resize(Width, Height)
End Sub

Private Sub ShowSplashScreen
	Busy.BackgroundImage=xui.LoadBitmap(File.DirAssets,"sky.png")
	Busy.ShowWithText("Loading xBusy demo")
		UpdatePreview
		Sleep(3000)
	Busy.Hide
	Busy.BackgroundImage=Null'Reset to no background image
End Sub

Private Sub ProcessData As ResumableSub
	Log("processing data")
	Sleep(3000)
	Return True
End Sub

' ************************* GENERAL USAGE *************************
#if b4j
Private Sub lblTest1_MouseClicked (EventData As MouseEvent)
#Else
Private Sub lblTest1_Click
#End If
	Busy.Show
		Wait For(ProcessData) Complete (b As Boolean)
	Busy.Hide
End Sub
#if b4j
Private Sub lblTest2_MouseClicked (EventData As MouseEvent)
#Else
Private Sub lblTest2_Click
#End If
	Busy.ShowWithText("loading data")
		Wait For(ProcessData) Complete (b As Boolean)
	Busy.Hide
End Sub
#if b4j
Private Sub lblTest3_MouseClicked (EventData As MouseEvent)
#Else
Private Sub lblTest3_Click
#End If
	Busy.ShowWithText("loading data 0%")
	For i=0 To 100
		Busy.UpdateText($"loading data ${i}%"$)
		Sleep(20)
	Next
	Busy.Hide
End Sub

Private Sub B4XSwitch1_ValueChanged (Value As Boolean)
	Busy.BackgroundImage=IIf(Value,xui.LoadBitmap(File.DirAssets,"sky.png"),Null)
	Busy.ShowWithText(IIf(Value,"setting background image to sky.png", "clearing background image"))
	UpdatePreview
	Wait For (ProcessData) Complete (b As Boolean)
	Busy.Hide
End Sub
'****************************************************************

#Region User Interface
Private Sub UpdatePreview
	lblPreview.Color=xui.Color_ARGB(Busy.BackgroundAlpha,0,0,0)
	lblPreview.TextColor=Busy.TextColor
	imgPreview.SetBitmap(Busy.SpinnerImage.Resize(imgPreview.Width,imgPreview.Height,True))
	lblBackgroundStatus.Text="xbusy.BackgroundImage=" & IIf(B4XSwitch1.Value,"""sky.png""","null")
End Sub

#if b4j
Private Sub lblSelectTextColor_MouseClicked (EventData As MouseEvent)
#Else
Private Sub lblSelectTextColor_Click
#End If
	Busy.ShowWithText("loading icon colors...")
		lblPreview.Text=""
		clv.AsView.Tag="color"
		clv.Clear
		clv.AsView.Visible=True
		clv.AddTextItem("White (default)",xui.Color_White)
		clv.AddTextItem("Light Gray",xui.Color_LightGray)
		clv.AddTextItem("Red",xui.Color_Red)
		clv.AddTextItem("Green",xui.Color_Green)
		clv.AddTextItem("Blue",xui.Color_Cyan)
		clv.AddTextItem("Yellow",xui.Color_Yellow)
		clv.AddTextItem("Pink",xui.Color_ARGB(255,255,20,220))
		Sleep(800)
	Busy.Hide
End Sub

#if b4j
Private Sub lblSelectCustomSpinner_MouseClicked (EventData As MouseEvent)
#Else
Private Sub lblSelectCustomSpinner_Click
#End If
	Busy.ShowWithText("loading custom images...")
		lblPreview.Text=""
		clv.AsView.Tag="custom"
		clv.Clear
		clv.AsView.Visible=True
		For i=1 To 7
			clv.AddTextItem($"xspinner-0${i}.png"$, $"xspinner-0${i}.png"$)
		Next
		Sleep(800)
	Busy.Hide
End Sub

Private Sub clv_ItemClick (Index As Int, Value As Object)
	clv.AsView.Visible=False
	If clv.AsView.Tag="color" Then
		Busy.TextColor=Value
		Busy.ShowWithText("updating with new text color...")
	Else if clv.AsView.Tag="custom" Then
		Busy.SpinnerImage=xui.LoadBitmap(File.DirAssets,Value)
		Busy.ShowWithText(Value)
	End If
	Sleep(2000)
	UpdatePreview
	Busy.Hide
End Sub
#End Region