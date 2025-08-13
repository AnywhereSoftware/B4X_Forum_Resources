B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=3.8
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private mPoints() As Float
	Private Interrupt As Boolean
	Private cv As Canvas
	Private cvJO As JavaObject = cv
	Private mForePaint As JavaObject
	Private Rect1 As Rect
	Private RectJO As JavaObject
	Private RectWidth As Int
	Private MinDrawWidth As Int
	Private RectHeight As Int
	Private CaptureSize As Int
	Private mZoom As Double
	Private ShowEveryn As Double
	Private TH As Thread
	Private mViz As Vizualizer
	Private mGain As Int = 32
	Private mPnl As Panel
	Private Buffer As SLByteArrayBuffer
	Private Updated As Boolean
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Viz As Vizualizer,Pnl As Panel)

	mViz = Viz
	mPnl = Pnl

'Setup the paint for the wavdraw
	mForePaint.InitializeNewInstance("android.graphics.Paint",Null)
	Dim StrokeWidth As Float = 1
	mForePaint.RunMethod("setStrokeWidth",Array As Object(StrokeWidth))
	mForePaint.RunMethod("setAntiAlias",Array As Object(True))
	mForePaint.RunMethod("setColor",Array As Object(Colors.White))
	
	Buffer.Initialize(1024)
	'Initialise the canvas
	cv.Initialize(mPnl)
	cvJO = cvJO.GetField("canvas")
	
	'Size of the view we want to dislay on
	Rect1.Initialize(0,0,Pnl.Width,Pnl.Height)
	RectJO = Rect1
	RectWidth = RectJO.RunMethod("width",Null)
	RectHeight = RectJO.RunMethod("height",Null)
	MinDrawWidth = Max(mViz.CaptureSize,RectWidth)
	CaptureSize = mViz.CaptureSize
	
	mZoom = 1
	
	Dim RequiredSamples As Double = mZoom * mViz.SamplingRate / 1000
	ShowEveryn = Max(1.0,RequiredSamples / RectWidth)
	
	TH.Initialise("TH")

End Sub
Sub Start
	TH.Initialise("TH")
	TH.Start(Me,"DrawWav",Null)
End Sub
Sub Stop
	Interrupt = True
End Sub
Sub Wave_Capture(Data() As Byte,SamplingRate As Int)
	'Resample the data to fit on the screen (if the panel size is larger than the sample size)
	If Buffer.length + (Data.Length / ShowEveryn) >= MinDrawWidth Then 
		Dim TempBuffer As SLByteArrayBuffer
		TempBuffer.Initialize(MinDrawWidth)
		Dim BL As Int = Buffer.length
		Dim Offset As Int = Min(MinDrawWidth - (Data.Length / ShowEveryn),Data.Length / ShowEveryn)
		TempBuffer.AppendByte(Buffer.ToByteArray,Offset,Min(BL - Offset,MinDrawWidth - Data.Length / ShowEveryn))
		Buffer.Clear
		Buffer.Initialize(MinDrawWidth)
		Buffer = TempBuffer
	End If
	For i = 0 To Data.Length - 1 Step ShowEveryn
		Buffer.AppendByte(Data,i,1)
	Next
	Updated = True

End Sub
Private Sub DrawWav
	
	Dim B As Byte
	Do While True
		If Interrupt Then Exit
		If Updated Then
			Dim Data() As Byte = Buffer.ToByteArray
			
			'Erase canvas
			cv.DrawRect( Rect1,Colors.black,True,5dip)
				
			If mPoints.length < Data.Length * 4 Then 
				Dim mPoints(Data.Length * 4) As Float
			End If
			'We may need to resample again to show a meaningful represntation on the Screen if the width of the panel provided is less than the
			'availble number of samples
			Dim Step1 As Double = 1
			If CaptureSize > RectWidth Then Step1 = CaptureSize / RectWidth
			Dim i As Int
			Dim j As Double
			For j = 0 To Data.Length - 2 Step Step1
			 	mPoints(i * 4) = Round(i)													'x1
				B = Data(j) + 128															'Convert Unsigned byte to signed byte
		        mPoints(i * 4 + 1) = RectHeight / 2 + B * (RectHeight / 2) / mGain			'y1
		        mPoints(i * 4 + 2) = Round(i) + 1											'x2
				B = Data(j + 1) + 128														'Convert Unsigned byte to signed byte
		        mPoints(i * 4 + 3) = RectHeight / 2 + B * (RectHeight / 2) / mGain			'y2
				i = i + 1
			Next
			
			cvJO.RunMethod("drawLines",Array As Object(mPoints,mForePaint))
				
			TH.RunOnGuiThread("Update",Null)
			Updated = False
		End If
	Loop
	Interrupt = False
End Sub
Private Sub Update
	mPnl.Invalidate
End Sub
Sub setZoom(Zoom As Float)
	mZoom = Zoom
	Dim RequiredSamples As Double = mZoom * mViz.SamplingRate / 1000
	ShowEveryn = Max(1.0,RequiredSamples / RectWidth)
End Sub
Sub getZoom As Float
	Return mZoom
End Sub
Sub setGain(Value As Int)
	mGain = Value
End Sub
Sub getGain As Int
	Return mGain
End Sub
Sub setColor(Color As Int)
	mForePaint.RunMethod("setColor",Array As Object(Color))
End Sub