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

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private PnlBlack As Panel
	
	'cSliderMulti
	Private Slider1, Slider2 As cSliderMulti 'Horizontal
	Private Slider3, Slider4 As cSliderMulti 'Vertical

End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	'cSliderMulti
	Create_Slider1_2
	Create_Slider3_4
	
End Sub

'cSliderMulti
#Region Slider Multi
' Creating Horizontal Slider
Private Sub Create_Slider1_2
	Dim PanelWidth As Int = 300dip
	Dim PanelHeight As Int = 60dip

	' Creating Centered Horizontal Slider
	Dim SliderPanel1 As Panel
	SliderPanel1.Initialize("SliderPanel1")
	Root.AddView(SliderPanel1, 0, 25dip, PanelWidth, PanelHeight)
	Slider1.Initialize(SliderPanel1, Me, -1, "Slider1")
	Slider1.LineColor = Colors.LightGray
	Slider1.PointColor = Colors.Gray
	Slider1.CursorColor = Colors.RGB(0,120,255)
	Slider1.TextColor = Colors.Black
	Slider1.ActiveLineColor = Colors.RGB(0,120,255)
	Slider1.SetItems(Array As String("Min","3","Default","5","6","Max"), 2)

	' Creating Left-Aligned Horizontal Slider
	Dim SliderPanel2 As Panel
	SliderPanel2.Initialize("SliderPanel2")
	PnlBlack.AddView(SliderPanel2, 0, 25dip, PanelWidth, PanelHeight)
	Slider2.Initialize(SliderPanel2, Me, 90dip, "Slider2")
	Slider2.LineColor = Colors.LightGray
	Slider2.PointColor = Colors.Gray
	Slider2.CursorColor = Colors.RGB(0,120,255)
	Slider2.TextColor = Colors.White
	Slider2.ActiveLineColor = Colors.RGB(0,120,255)
	Slider2.SetItems(Array As String("2","3","4","5","6","7"), 4)
End Sub

' Creating Vertical Sliders
Private Sub Create_Slider3_4
	Dim PanelWidth As Int = 120dip
	Dim PanelHeight As Int = 300dip
	Dim Slider3_Left As Int = 80dip
	Dim Slider3_Top As Int = 240dip
	Dim Slider4_Left As Int = 180dip
	Dim Slider4_Top As Int = 340dip

	'Left vertical slider: Top -> Bottom
	Dim SliderPanel3 As Panel
	SliderPanel3.Initialize("SliderPanel3")
	Root.AddView(SliderPanel3,Slider3_Left,Slider3_Top,PanelWidth,PanelHeight)
	Slider3.Initialize(SliderPanel3,Me,Slider3_Left,"Slider3")
	Slider3.SetVertical(True)
	Slider3.SetReverseVertical(False)
	Slider3.LineColor = Colors.LightGray
	Slider3.PointColor = Colors.Gray
	Slider3.CursorColor = Colors.RGB(0,120,255)
	Slider3.TextColor = Colors.Black
	Slider3.ActiveLineColor = Colors.RGB(0,120,255)
	Slider3.SetItems(Array As String("Min","25","50","75","Max"),2)
	'disables touch selection
	Slider3.mTouchEnabled = False

	'Right vertical slider: Bottom -> Top
	Dim SliderPanel4 As Panel
	SliderPanel4.Initialize("SliderPanel4")
	Root.AddView(SliderPanel4,Slider4_Left,Slider4_Top,PanelWidth,PanelHeight)
	Slider4.Initialize(SliderPanel4,Me,Slider4_Left,"Slider4")
	Slider4.SetVertical(True)
	Slider4.SetReverseVertical(True)
	Slider4.LineColor = Colors.LightGray
	Slider4.PointColor = Colors.Gray
	Slider4.CursorColor = Colors.RGB(255,80,0)
	Slider4.TextColor = Colors.Black
	Slider4.ActiveLineColor = Colors.RGB(255,80,0)
	Slider4.SetItems(Array As String("Min","25","50","75","Max"),2)
End Sub

Sub Value_Changed(Data() As Object)
	Dim ID As String = Data(0)
	Dim Index As Int = Data(1)
	Dim Label As String = Data(2)
	Log(ID & " -> Index = " & Index & ", Valeur = " & Label)
End Sub

Private Sub SliderPanel1_Touch(Action As Int, X As Float, Y As Float)
	Slider1.Touch(Action, X, Y)
End Sub

Private Sub SliderPanel2_Touch(Action As Int, X As Float, Y As Float)
	Slider2.Touch(Action, X, Y)
End Sub

Private Sub SliderPanel3_Touch(Action As Int, X As Float, Y As Float)
	Slider3.Touch(Action,X,Y)
End Sub

Private Sub SliderPanel4_Touch(Action As Int, X As Float, Y As Float)
	Slider4.Touch(Action,X,Y)
End Sub
#End Region
