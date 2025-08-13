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
	
	Private Button1 As Button

	Private INPUT As Int
	Private LastINPUT As Int

	Private OUTPUT As Double
	Private LastOUTPUT As Double
	Private MEDIAN As Double
	Private LastMEDIAN As Double
	Private TOTAL As Double
	
	Private COEF As Double
	Private MAXCOEF As Double = 1.0
	Private FILTER As Double

	Private SampleAVG As Int
	Private NUM_SAMPLE_AVERAGE As Int

	Private Sample As Int = 0
	Private SampleTime As Int
	Private ScaleX As Int
	Private ScaleY As Int
	Private GRAPH_LASTOUT As Int
	Private GRAPH_OUT As Int
	Private GRAPH_LASTIN As Int
	Private GRAPH_IN As Int
	Private GRAPH_LASTMEDIAN As Int
	Private GRAPH_MEDIAN As Int
	Private FirstTime As Boolean
	Private NOISE, TEMP_NOISE As Int
	Private Paused As Boolean
	Private SEL As Boolean
	Private DW_LPF As Byte
	Private DW_MEDIAN As Byte
	
	Private Timer1 As Timer
	
	'--------------------
	
	Private Text1 As B4XView
	Private Text2 As B4XView
	Private Text3 As B4XView
	Private Text4 As B4XView
	Private Text5 As B4XView
	Private Text6 As B4XView
	Private Text7 As B4XView
	Private Text8 As B4XView
	Private Text9 As B4XView
	Private Text10 As B4XView
	Private Text11 As B4XView
	Private Text12 As B4XView
	Private Text13 As B4XView
	Private Text14 As B4XView
	Private Text15 As B4XView
	Private Text16 As B4XView
	Private Text17 As B4XView
	Private Text18 As B4XView
	Private Text20 As B4XView
	
	Private Check1 As B4XView
	Private Check2 As B4XView
	Private Check3 As B4XView
	Private Check4 As B4XView
	Private Check5 As B4XView
'	
	Private Slider1 As B4XView
	Private Slider2 As B4XView
	Private Slider3 As B4XView
	Private Slider4 As B4XView
	Private Slider5 As B4XView
	Private Slider6 As B4XView
	Private Slider7 As B4XView
	Private Slider8 As B4XView
	
	Private Option1 As B4XView
	Private Option2 As B4XView
	
	Private Panel1 As B4XView
	Private Canvas1 As B4XCanvas
	
	Private Label17 As B4XView
	Private Label18 As B4XView
	Private Label21 As B4XView
	Private Label22 As B4XView
	Private Label23 As B4XView
	Private Label26 As B4XView
	
	Private P4 As B4XView
	Private P5 As B4XView
	Private P3 As B4XView
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	Canvas1.Initialize(Panel1)
		
	B4XPages.SetTitle(B4XPages.MainPage, "LOW-PASS FILTER")
	Root.Color = xui.Color_RGB(220, 220, 220)
	
	Timer1.Initialize("Timer1", 1)
	Timer1.Enabled = True

	ClearCanvas ' Clear canvas
	
	Dim y As Float = (Canvas1.TargetRect.Height - OUTPUT * ScaleX) ' Draw first point
	Canvas1.DrawLine(Sample, y, Sample, y, xui.Color_Red, 1)
	
	ScaleY = 10
	FirstTime = False
	Paused = False
	SampleAVG = 0
	
	COEF = Slider2.As(Slider).Value / 1000
	Text3.Text = NumberFormat2(COEF, 1, 1, 3, False)
	
	SampleTime = Slider3.As(Slider).Value
	Text5.Text = SampleTime
	Timer1.Interval = SampleTime
	  
	ScaleX = Slider4.As(Slider).Value
	Text12.text = ScaleX
	  	  
	NUM_SAMPLE_AVERAGE = Slider7.As(Slider).Value.As(Int)
	Text18.Text = NUM_SAMPLE_AVERAGE
	
	DW_LPF = Slider5.As(Slider).Value
	Text13.Text = DW_LPF
	
	DW_MEDIAN = Slider8.As(Slider).Value
	Text17.Text = DW_MEDIAN
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	If Button1.Text = "PAUSE" Then
		Button1.Text = "PAUSED"
		Paused = True
	Else
		Button1.Text = "PAUSE"
		Paused = False
	End If
End Sub

Private Sub ClearCanvas
	Dim rect As B4XRect = Canvas1.TargetRect
	Canvas1.DrawRect(rect, xui.Color_Black, True, 1)
	Canvas1.Invalidate
End Sub

Sub B4XPage_Resize (Width As Int, Height As Int)
	Resize
End Sub

Sub Resize 
'	Log("RESIZE")
	Canvas1.Resize(Panel1.Width, Panel1.Height)
	ClearCanvas
End Sub

Sub B4XPage_CloseRequest As ResumableSub
	Log("CLOSE")
	Return True
End Sub

Private Sub Slider2_ValueChange (Value As Double)	
	COEF = Value / 1000
	Text3.Text = NumberFormat2(COEF, 1, 1, 3, False)
End Sub

Private Sub Slider3_ValueChange (Value As Double)
	SampleTime = Value.As(Int)
	Text5.Text = SampleTime
	Timer1.Interval = SampleTime
End Sub

Private Sub Slider4_ValueChange (Value As Double)
	ScaleX = (Value).As(Int)
	Text12.Text = ScaleX
End Sub

Private Sub Slider5_ValueChange (Value As Double)  ' LPF draw width
	DW_LPF = Value
	Text13.Text = DW_LPF
End Sub

Private Sub Slider7_ValueChange (Value As Double)
	NUM_SAMPLE_AVERAGE = Value.As(Int)
	Text18.Text = NUM_SAMPLE_AVERAGE
End Sub

Private Sub Slider8_ValueChange (Value As Double)  ' MEDIAN draw width
	DW_MEDIAN = Value
	Text17.Text = DW_MEDIAN
End Sub

Private Sub Option2_SelectedChange(Selected As Boolean)
	If Selected Then
		Check1.Checked = False
		Check1.Visible = False
	Else
		Check1.Visible = True
	End If
End Sub

Private Sub Timer1_Tick

	If Label23.Text <> ("The time here is " & DateTime.Time(DateTime.Now)) Then
		Label23.Text = "The time here is " & DateTime.Time(DateTime.Now)
	End If
	
	If Paused = False Then
	
		Text6.Text = Sample / ScaleX 
	
		Sample = Sample + ScaleX
		
		If Sample >= Canvas1.TargetRect.Width Then
			Sample = 0
			ClearCanvas
			Canvas1.DrawCircle(Sample, Canvas1.TargetRect.Height- OUTPUT * ScaleY, 0.5, xui.Color_Red, True, 0)
		End If
	
		' (INPUT) HERE WE USE INTEGER INPUT, BUT FLOATING POINT CAN BE USED INSTEAD
		If Option1.Checked Then
			INPUT = Slider1.As(Slider).Value.As(Int)
		Else
			INPUT = Rnd(0, 1024)  
		End If
	
		If Check1.Checked Then
			Slider6.Visible = True
			Label17.Visible = True
			Text14.Visible = True
			Text15.Visible = True
		 
			TEMP_NOISE = Rnd(0, 2) 
		
			NOISE = Slider6.As(Slider).Value
			Text14.Text = NOISE
		 
			NOISE = Rnd(0, (NOISE + 1)) 
			Text15.Text = NOISE 
		
			If TEMP_NOISE = 0 Then
				INPUT = INPUT + NOISE
			Else
				INPUT = INPUT - NOISE
			End If
		
			If INPUT < 0 Then INPUT = 0
			If INPUT > 1023 Then INPUT = 1023
		Else
			Slider6.Visible = False: Label17.Visible = False: Text14.Visible = False: Text15.Visible = False
		End If
		
		Text1.Text = INPUT  ' INPUT
		
		Dim TMP_INPUT As Int = INPUT  ' We save the original input for future use before use it on LPF calculations
		
		'////////////////// THIS IS THE MOST IMPORTANT PART OF THIS CODE /////////////////
		
		' LOW-PASS FILTER	
		INPUT = INPUT * 1000
		FILTER = Ceil((INPUT * COEF) + (FILTER * (MAXCOEF - COEF)))  
		OUTPUT = FILTER / 1000
		
		'/////////////////////////////////////////////////////////////////////////////////
				
		Text9.Text = INPUT
		Text10.Text = FILTER
		Text11.Text = NumberFormat2(OUTPUT, 4, 4 ,4, False)
		Text20.Text = OUTPUT.As(Int)  ' <<<<<<<<<< WE SHOW AS INTEGER, BUT WE CAN GET FLOATING POINT
		Text2.Text = INPUT
		Text4.Text = NumberFormat2(COEF, 1, 1, 3, False)
		Text7.Text = FILTER
		Text8.Text = NumberFormat2(MAXCOEF - COEF, 1, 1, 3, False)

		INPUT = TMP_INPUT  ' Return back to original input (saved before)

		Dim tHeight As Float = Canvas1.TargetRect.Height - 0.5  ' I subtract here 0.5 offset to remove aliasing on Canvas
	
		GRAPH_LASTOUT = MapDouble(LastOUTPUT, 0, 1023, tHeight, 0)
		GRAPH_OUT = MapDouble(OUTPUT, 0, 1023, tHeight, 0)
		
		If Check4.Checked = False Then ' DRAW LPF OUTPUT
			Canvas1.DrawLine(Sample - ScaleX, GRAPH_LASTOUT + 0.5, Sample, GRAPH_OUT + 0.5, xui.Color_Red, DW_LPF)    ' I add here 0.5 Y offset to remove aliasing on Canvas
		Else
			Canvas1.DrawCircle(Sample, GRAPH_OUT + 0.5, (DW_LPF*0.5), xui.Color_Red, True, 0)   ' I add here 0.5 Y offset to remove aliasing on Canvas
		End If
	
		GRAPH_LASTIN = MapDouble(LastINPUT, 0, 1023, tHeight, 0)
		GRAPH_IN = MapDouble(INPUT, 0, 1023, tHeight, 0)
	
		If Check5.Checked = False Then  ' DRAW INPUT
			Canvas1.DrawLine(Sample - ScaleX, GRAPH_LASTIN + 0.5, Sample, GRAPH_IN + 0.5, xui.Color_Green, 1)   ' I add here 0.5 offset to remove aliasing on Canvas
		Else
			DrawPoint(Sample, GRAPH_IN, xui.Color_Green)
		End If
	
		' MEDIAN FILTER (Average)
		If Check2.Checked Then
			TOTAL = TOTAL + INPUT
			SampleAVG = SampleAVG + 1
	
			Text16.Text = MEDIAN
			
			P3.Visible = True
			Label18.Visible = True
			Label22.Visible = True
			Text16.Visible = True
			Label21.Visible = True
			Label26.Visible = True
			Slider7.Visible = True
			Slider8.Visible = True
			Text17.Visible = True
			Text18.Visible = True
			Check3.Visible = True
	
			If SampleAVG Mod NUM_SAMPLE_AVERAGE = 0 Then
				MEDIAN = (TOTAL / NUM_SAMPLE_AVERAGE).As(Int)
				'Log("MEDIAN")
				SampleAVG = 0
				TOTAL = 0
				SEL = True
			End If
		Else
			P3.Visible = False
			Label18.Visible = False
			Label22.Visible = False
			Text16.Visible = False
			Label21.Visible = False
			Label26.Visible = False
			Slider7.Visible = False
			Slider8.Visible = False
			Text17.Visible = False
			Text18.Visible = False
			Check3.Visible = False
			
			FirstTime = False
					
			If SEL Then
				LastMEDIAN = MEDIAN
				SEL = False
				FirstTime = True
			End If
			
			If FirstTime = False Then MEDIAN = INPUT  ' Just for first value
		End If
	
		GRAPH_LASTMEDIAN = MapDouble(LastMEDIAN, 0, 1023, tHeight, 0)
		GRAPH_MEDIAN = MapDouble(MEDIAN, 0, 1023, tHeight, 0)
	
	    ' Draw Median
		If SEL Then
			If Check3.Checked = False Then
				Canvas1.DrawLine(Sample - (ScaleX * NUM_SAMPLE_AVERAGE), GRAPH_LASTMEDIAN + 0.5, Sample, GRAPH_MEDIAN + 0.5, xui.Color_Yellow, DW_MEDIAN)
				Canvas1.DrawCircle(Sample, GRAPH_MEDIAN + 0.5, 0.5, xui.Color_Yellow, True, DW_MEDIAN)
			Else
				Canvas1.DrawCircle(Sample, GRAPH_MEDIAN + 0.5, (DW_MEDIAN*0.5), xui.Color_Yellow, True, 0)
			End If
			SEL = False
		End If
	
		If OUTPUT <> LastOUTPUT Then
			P4.Visible = False
			P5.Visible = True
		Else
			P4.Visible = True
			P5.Visible = False
		End If
	
		LastOUTPUT = OUTPUT
		LastINPUT = INPUT
		LastMEDIAN = MEDIAN
	End If
End Sub

Public Sub DrawPoint(X As Float, Y As Float, Color As Int)
	Canvas1.DrawLine(X, Y + 0.5, X+1, Y + 0.5, Color, 1) ' I add here 0.5 Y offset to remove aliasing on Canvas
End Sub

'Re-maps a Integer number from one range to another.
Public Sub MapInt(Value As Int, fromLow As Int, fromHigh As Int, toLow As Int, toHigh As Int) As Int
	Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )
End Sub

'Re-maps a Float number from one range to another.      
Public Sub MapFloat(Value As Float, fromLow As Float, fromHigh As Float, toLow As Float, toHigh As Float) As Float
	Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )
End Sub

'Re-maps a Double number from one range to another.	
Public Sub MapDouble(Value As Double, fromLow As Double, fromHigh As Double, toLow As Double, toHigh As Double) As Double
	Return ( (Value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow) + toLow )
End Sub
