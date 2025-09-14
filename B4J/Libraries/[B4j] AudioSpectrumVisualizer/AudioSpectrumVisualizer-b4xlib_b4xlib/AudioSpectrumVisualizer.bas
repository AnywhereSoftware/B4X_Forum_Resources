B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#DesignerProperty: Key: LineColor, DisplayName: Line Color, FieldType: Color, DefaultValue: 0xFF0000FF, Description: Line color
#DesignerProperty: Key: FillColor, DisplayName: Fill Color, FieldType: Color, DefaultValue: 0xFFADD8e6, Description: Fill color
#DesignerProperty: Key: BackColor, DisplayName: Background Color, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Background color
#DesignerProperty: Key: Grad, DisplayName: Use Gradient, FieldType: Boolean, DefaultValue: False, Description: Use Gradient
#DesignerProperty: Key: Color1, DisplayName: Grad Color1, FieldType: Color, DefaultValue: 0xFF0984df, Description: From Color
#DesignerProperty: Key: Color2, DisplayName: Grad Color2, FieldType: Color, DefaultValue: 0xFF00d8ff, Description: From Color 20%
#DesignerProperty: Key: Color3, DisplayName: Grad Color3, FieldType: Color, DefaultValue: 0xFFfff000, Description: From Color 40%
#DesignerProperty: Key: Color4, DisplayName: Grad Color4, FieldType: Color, DefaultValue: 0xFFff00FF, Description: From Color 80%
#DesignerProperty: Key: Color5, DisplayName: Grad Color5, FieldType: Color, DefaultValue: 0xFFff0000, Description: From Color
'https://victor-fx.blogspot.com/2017/08/audio-visualization-in-javafx.html

'TODO Look at width of display only 128 Bands, does it fill the view?
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Public Tag As Object
	Private Spectrum As JavaObject
	Private Series1 As JavaObject
	Private Series1Data As List
	Private Bands As Int
	Private Threshold As Int
	Private mMPJO As JavaObject
	Private Collections As JavaObject
	Private MPSet As Boolean
	Private mProps As Map
	Private Buffer() As Float
	Private mFreeze As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
	
	Collections.InitializeStatic("javafx.collections.FXCollections")
	
	Dim AxisX,AxisY As JavaObject
	AxisX.InitializeNewInstance("javafx.scene.chart.NumberAxis",Null)
	AxisY.InitializeNewInstance("javafx.scene.chart.NumberAxis",Null)
	
	Spectrum.InitializeNewInstance("javafx.scene.chart.AreaChart",Array(AxisX,AxisY))
	Spectrum.RunMethod("setCreateSymbols",Array(False))
	Spectrum.As(Node).Id = "areachart"
	Spectrum.RunMethod("setMinHeight",Array(10.0))
	
End Sub


'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mProps = Props
	
	Dim mForm As Form = Props.Get("Form")
	mForm.Stylesheets.Add(File.GetUri(File.DirAssets,"audiospectrumanalyser.css"))
		
	mBase.AddView(Spectrum,0,0,mBase.Width,mBase.Height)
	
	SetDisplay
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	Spectrum.As(B4XView).SetLayoutAnimated(0,0,0,Width,Height)
End Sub

Private Sub SetDisplay
	Dim LineColor As String = StrColorToCssRGBA(mProps.GetDefault("LineColor","0xFF0000FF"))
	Dim FillColor As String = StrColorToCssRGBA(mProps.GetDefault("FillColor","0xFFADD8e6"))
	Dim BackColor As String = StrColorToCssRGBA(mProps.GetDefault("BackColor","0xFFADD8e6"))

	Spectrum.As(Node).Style = $"CHART_COLOR_1: ${LineColor};CHART_COLOR_1_TRANS_20: ${FillColor};-fx-background-color:${BackColor};"$
	If Spectrum.As(Node).StyleClasses.IndexOf("area-chart") = -1 Then Spectrum.As(Node).StyleClasses.Add("area-chart")
	
	Dim CPB As Node = Spectrum.RunMethod("lookup",Array(".chart-plot-background"))
	CSSUtils.SetStyleProperty(CPB,"-fx-background-color",BackColor)
	
	If mProps.GetDefault("Grad",False) Then
'		Sleep(0)
		Dim AreaFill As JavaObject = Spectrum.RunMethod("lookup",Array("#areachart .series0.chart-series-area-fill"))
		If AreaFill.IsInitialized Then
			Dim Color1 As String = StrColorToCssRGBA(mProps.GetDefault("Color1","0xFF0984df"))
			Dim Color2 As String = StrColorToCssRGBA(mProps.GetDefault("Color2","0xFF0984df"))
			Dim Color3 As String = StrColorToCssRGBA(mProps.GetDefault("Color3","0xFF0984df"))
			Dim Color4 As String = StrColorToCssRGBA(mProps.GetDefault("Color4","0xFFff0000"))
			Dim Color5 As String = StrColorToCssRGBA(mProps.GetDefault("Color5","0xFFff0000"))
			
			AreaFill.RunMethod("setStyle",Array($"-fx-fill: linear-gradient(to top, ${Color1}, ${Color2} 20%, ${Color3} 50%, ${Color4} 80%, ${Color5})"$))
'		Else
'			Log("AreaFill not found")
		End If
	End If
End Sub

Public Sub SetMediaplayer(MP As MediaPlayer)
	mMPJO = MP
	If mMPJO.RunMethod("getAudioSpectrumListener",Null) = Null Then
		Dim O As Object = mMPJO.CreateEventFromUI("javafx.scene.media.AudioSpectrumListener","ASListener",Null)
		mMPJO.RunMethod("setAudioSpectrumListener",Array(O))
	End If
	SetData
End Sub

Public Sub SetData
	
	Series1.InitializeNewInstance("javafx.scene.chart.XYChart.Series",Null)
	Bands = mMPJO.As(JavaObject).RunMethod("getAudioSpectrumNumBands",Null)
	Threshold =  mMPJO.RunMethod("getAudioSpectrumThreshold",Null)
	
	Buffer = CreateFilledBuffer(Bands,Threshold)
	
	Dim Jo As JavaObject
	Dim SD(Bands) As Object
	Series1Data = Collections.RunMethod("observableArrayList",Array(SD))
	
	For i = 0 To Bands - 1
		Series1Data.set(i,Jo.InitializeNewInstance("javafx.scene.chart.XYChart.Data",Array(i + 1,0)))
		Series1.RunMethodJO("getData",Null).RunMethod("add",Array(Series1Data.Get(i)))
	Next
	Spectrum.RunMethodJO("getData",Null).RunMethod("clear",Null)
	Spectrum.RunMethodJO("getData",Null).RunMethod("add",Array(Series1))
	
	SetDisplay
	
	MPSet = True
End Sub

Private Sub CreateFilledBuffer(Size As Int,FillValue As Float) As Float()
	Dim F(Size) As Float
	Dim Arrays As JavaObject
	Arrays.InitializeStatic("java.util.Arrays")
	Arrays.RunMethod("fill",Array(F,FillValue))
	Return F
End Sub

Private Sub ASListener_Event (MethodName As String, Args() As Object)
	If mFreeze Then Return
	Dim Magnitudes() As Float = Args(2)
	For i = 0 To Magnitudes.Length - 1
'		If i > Magnitudes.Length - 4 Then Magnitudes(i) = 48
		If Magnitudes(i) >= Buffer(i) Then
			Buffer(i) = Magnitudes(i)
			Series1Data.get(i).As(JavaObject).RunMethod("setYValue",Array(Magnitudes(i) - Threshold))
		Else
			Series1Data.get(i).As(JavaObject).RunMethod("setYValue",Array(Buffer(i) - Threshold))
			Buffer(i) = Buffer(i) - 0.25
		End If
	Next
End Sub

'Animated reset
Public Sub Reset
	Dim Val As Float
	Dim TotVal As Float
	Do While True
		TotVal = 0
		For i = 0 To Series1Data.Size -1
			Val = Series1Data.get(i).As(JavaObject).RunMethod("getYValue",Null) - 1
			Val = Max(0,Val)
			Series1Data.get(i).As(JavaObject).RunMethod("setYValue",Array(Val))
			TotVal = TotVal + Val
		Next
		If TotVal = 0 Then Exit
		Sleep(0)
	Loop
	Buffer = CreateFilledBuffer(Bands,Threshold)
End Sub

Public Sub MediaPlayerSet As Boolean
	Return MPSet
End Sub

Public Sub StrColorToCssRGBA(colorStr As String) As String
	Dim Color As Int
	Dim BC As ByteConverter
	Color = BC.IntsFromBytes(BC.HexToBytes(colorStr.SubString(2)))(0)
	Dim ARGB() As Byte = BC.IntsToBytes(Array As Int(Color))
	Dim Alpha As Double = (Bit.And(ARGB(3),0XFF) / 255)
	Return $"rgba(${Bit.And(ARGB(0),0XFF)},${Bit.And(ARGB(1),0XFF)},${Bit.And(ARGB(2),0xFF)},${NumberFormat2(Alpha,1,2,2,False)})"$
End Sub

'Get/Set the number of displayed bands
'Set must be called after SetMediaPlayer
Public Sub getAudioSpectrumNumBands As Int
	If mMPJO.IsInitialized Then Return mMPJO.RunMethod("getAudioSpectrumNumBands",Null)
	Return -1
End Sub

Public Sub setAudioSpectrumNumBands(Number As Int)
	If mMPJO.IsInitialized Then 
		mMPJO.RunMethod("setAudioSpectrumNumBands",Array(Number))
		SetData
	End If
End Sub


Public Sub getAudioSpectrumInterval As Double
	If mMPJO.IsInitialized Then Return mMPJO.RunMethod("getAudioSpectrumInterval",Null)
	Return -1
End Sub
'Get/Set the audio Spectrum update interval in seconds. Default = 0.1 seconds
Public Sub setAudioSpectrumInterval(Interval As Double)
	If mMPJO.IsInitialized Then mMPJO.RunMethod("setAudioSpectrumInterval",Array(Interval))
End Sub

'Get/Set the threshold in db.  Default = -60.  Value must be <= 0
Public Sub getAudioSpectrumThreshold As Int
	If mMPJO.IsInitialized Then Return mMPJO.RunMethod("getAudioSpectrumThreshold",Null)
	Return -1
End Sub

Public Sub setAudioSpectrumThreshold(tThreshold As Int)
	If mMPJO.IsInitialized Then mMPJO.RunMethod("setAudioSpectrumThreshold",Array(tThreshold))
End Sub

'Freeze the spectrum display
Public Sub setFreeze(Freeze As Boolean)
	mFreeze = Freeze
End Sub

Public Sub getFreeze As Boolean
	Return mFreeze
End Sub