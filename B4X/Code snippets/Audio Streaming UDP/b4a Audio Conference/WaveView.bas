B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#DesignerProperty: Key: AutoStart, DisplayName: Auto Start, FieldType: Boolean, DefaultValue: True

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	
	Type interpolation (speed As Float, amplitude As Float)
	Type cache (width As Float, height As Float, width2 As Float, height2 As Float, width4 As Float, heightMax As Float, interpolation As interpolation )
	Type siriwave (phase As Float, run As Boolean, container As B4XCanvas,canvas As B4XCanvas, width As Float, height As Float, ratio As Float  _
	, amplitude As Float, speed As Float, frequency As Float, speedInterpolationSpeed As Float, _
	 amplitudeInterpolationSpeed As Float, cache As cache, curves As List, color_r As Int, color_g As Int, color_b As Int )
	Type siriwavecurves(controller As siriwave, definition As Map)
	
	#if b4j
	Private fx As JFX
	#End If
	Private siriwavecurve_prototype_definition As List	
	
	Private siriwave As siriwave
	Private siriwavecurve_prototype_globAttenuationEquation_cache As Map
	Private refresh As Int = 20
	Private opt_canvas As B4XCanvas
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback

	siriwave.Initialize
	siriwavecurve_prototype_globAttenuationEquation_cache.Initialize
	
	siriwavecurve_prototype_definition = Array(CreateMap("attenuation":-2,"lineWidth":1,"opacity":25) _
	,CreateMap("attenuation":-6,"lineWidth":1,"opacity":51) _
	,CreateMap("attenuation":4,"lineWidth":1,"opacity":102) _
	,CreateMap("attenuation":2,"lineWidth":1,"opacity":153) _
	,CreateMap("attenuation":1,"lineWidth":1.5,"opacity":255))
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me 
	
	#If B4A
	Sleep(0)
	#end IF
	
	opt_canvas.Initialize(mBase)
	 
	Dim Au As Boolean = Props.Get("AutoStart")
	SiriWaveFunc(1,1,0.12,6,0.005,0.05,46,46,46,Au)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
End Sub

Public Sub setrefreshRate_milliseconds(value As Int)
	refresh=value
End Sub

Public Sub getrefreshRate_milliseconds As Int
	Return refresh
End Sub

Public Sub SiriWaveFunc (opt_ratio As Float, opt_amplitude As Float _
	, opt_speed As Float, opt_frequency As Float, opt_speedInterpolationSpeed As Float _
	, opt_amplitudeInterpolationSpeed As Float,opt_color_r As Int,opt_color_g As Int,opt_color_b As Int, opt_autostart As Boolean)
		
	siriwave.phase = 0
	siriwave.run = False
	siriwave.cache.Initialize
	siriwave.canvas = opt_canvas
	siriwave.width = mBase.Width
	siriwave.height = mBase.Height
	siriwave.ratio = opt_ratio
	
	siriwave.cache.width = siriwave.ratio * siriwave.width
	siriwave.cache.height = siriwave.ratio * siriwave.height
	siriwave.cache.height2 = siriwave.cache.height / 2
	siriwave.cache.width2 = siriwave.cache.width / 2
	siriwave.cache.width4 = siriwave.cache.width / 4
	siriwave.cache.heightMax = (siriwave.cache.height2) - 4

	siriwave.amplitude = opt_amplitude
	siriwave.speed = opt_speed
	siriwave.frequency = opt_frequency
	siriwave.color_r = opt_color_r
	siriwave.color_g = opt_color_g
	siriwave.color_b = opt_color_b
	
	siriwave.speedInterpolationSpeed = opt_speedInterpolationSpeed
	siriwave.amplitudeInterpolationSpeed = opt_amplitudeInterpolationSpeed

	siriwave.cache.interpolation.Initialize
	siriwave.cache.interpolation.speed = siriwave.speed
	siriwave.cache.interpolation.amplitude = siriwave.amplitude
	
	siriwave.curves.Initialize
	Dim i As Int = 0
	For i =0 To siriwavecurve_prototype_definition.Size-1
		Dim newSiriWaveCurve As siriwavecurves
		newSiriWaveCurve.Initialize
		newSiriWaveCurve.controller = siriwave
		Dim tempmap As Map = siriwavecurve_prototype_definition.Get(i)
		newSiriWaveCurve.definition.Initialize
		newSiriWaveCurve.definition.Put("attenuation",tempmap.Get("attenuation"))
		newSiriWaveCurve.definition.Put("lineWidth",tempmap.Get("lineWidth"))
		newSiriWaveCurve.definition.Put("opacity",tempmap.Get("opacity"))
		siriwave.curves.Add(newSiriWaveCurve)
	Next
	
	If opt_autostart Then
		siriwave_start
	End If
End Sub

Public Sub siriwave_start
	siriwave.phase = 0
	siriwave.run = True
	siriwave_startDrawingCycle
End Sub

Public Sub siriwave_stop
	siriwave.phase = 0
	siriwave.run = False
End Sub

Public Sub siriwave_setSpeed(v As Float)
	siriwave.cache.interpolation.speed = v
End Sub

Public Sub siriwave_setAmplitude(v As Float)
	siriwave.cache.interpolation.amplitude = Max(Min(v, 1), 0)
End Sub

#Region Function

Private Sub siriwave_startDrawingCycle
	If siriwave.run = False Then Return
	siriwave_clear
	
	siriwave_interpolate(0)
	siriwave_interpolate(1)
	
	siriwave_draw
	
	siriwave.phase = (siriwave.phase + cPI * siriwave.speed) Mod (2 * cPI)
	Sleep(refresh)
	siriwave_startDrawingCycle
End Sub

Private Sub siriwave_clear
	siriwave.canvas.ClearRect(siriwave.canvas.TargetRect)
	siriwave.canvas.Invalidate
End Sub

Private Sub siriwave_interpolate(property As Int)
	Dim increment As Float
	If property = 0 Then
		increment = siriwave.amplitudeInterpolationSpeed
		If Abs(siriwave.cache.interpolation.amplitude - siriwave.amplitude) <= increment Then
			siriwave.amplitude = siriwave.cache.interpolation.amplitude
		Else
			If siriwave.cache.interpolation.amplitude > siriwave.amplitude Then
				siriwave.amplitude = siriwave.amplitude + increment
			Else
				siriwave.amplitude = siriwave.amplitude - increment
			End If
		End If
	else if property = 1 Then
		increment = siriwave.speedInterpolationSpeed
		If Abs(siriwave.cache.interpolation.speed - siriwave.speed) <= increment Then
			siriwave.speed = siriwave.cache.interpolation.speed
		Else
			If siriwave.cache.interpolation.speed > siriwave.speed Then
				siriwave.speed = siriwave.speed + increment
			Else
				siriwave.speed = siriwave.speed - increment
			End If
		End If
	End If
End Sub

Private Sub siriwave_draw
	For i=0 To siriwave.curves.Size -1
		siriwaveCurve_prototype_draw(siriwave.curves.Get(i))
	Next
End Sub

Private Sub siriwaveCurve_prototype_draw(siriwavecurve As siriwavecurves)
	Dim can As B4XCanvas = siriwavecurve.controller.canvas
	Dim p_X As Float = 0
	Dim p_Y As Float = siriwavecurve.controller.height/2
	Dim i As Float = -2
	For j=0 To 399
		Dim y As Float = siriwavvecurve_prototype_ypos(i, siriwavecurve)
		If Abs(i) >= 1.90 Then y = siriwavecurve.controller.cache.height2
		Dim n_x As Float = siriwavvecurve_prototype_xpos(i, siriwavecurve)
		#if b4j
			can.DrawLine(p_X,p_Y,n_x,y,fx.Colors.To32Bit(fx.Colors.ARGB(siriwavecurve.definition.Get("opacity"),siriwave.color_r,siriwave.color_g,siriwave.color_b)),siriwavecurve.definition.Get("lineWidth"))
		#else
		can.DrawLine(p_X,p_Y,n_x,y,Colors.ARGB(siriwavecurve.definition.Get("opacity"),siriwave.color_r,siriwave.color_g,siriwave.color_b),siriwavecurve.definition.Get("lineWidth"))
		#end if
		can.Invalidate
		p_X = n_x
		p_Y = y
		i = i + 0.01
	Next
End Sub

Private Sub siriwavvecurve_prototype_xpos (i As Float, siriwavecurve As siriwavecurves) As Float
	Return siriwavecurve.controller.cache.width2 + i * siriwavecurve.controller.cache.width4
End Sub

Private Sub siriwavvecurve_prototype_ypos (i As Float, siriwavecurve As siriwavecurves) As Float
	Dim att As Float = (siriwavecurve.controller.cache.heightMax * siriwavecurve.controller.amplitude) / siriwavecurve.definition.Get("attenuation")
	Return siriwavecurve.controller.cache.height2 + siriwavvecurve_prototype_globAttenuationEquation(i) * att * Sin(siriwavecurve.controller.frequency * i - siriwavecurve.controller.phase)
End Sub
Private Sub siriwavvecurve_prototype_globAttenuationEquation (x As Float) As Float
	If Not(siriwavecurve_prototype_globAttenuationEquation_cache.ContainsKey(x)) Then
		siriwavecurve_prototype_globAttenuationEquation_cache.Put(x, Power(4 / (4 + Power(x,4)), 4))
	End If
	Return siriwavecurve_prototype_globAttenuationEquation_cache.Get(x)
End Sub

#End Region