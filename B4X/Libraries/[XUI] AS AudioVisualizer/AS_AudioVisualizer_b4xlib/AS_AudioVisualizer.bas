B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.45
@EndOfDesignText@
#If Documentation
Updates
V1.00
	-Release
#End If

#DesignerProperty: Key: VisualizationType, DisplayName: Visualization Type, FieldType: String, DefaultValue: Spectrum, List: Spectrum|Waveform|FilledWave
#DesignerProperty: Key: NumberOfBars, DisplayName: Number of bars, FieldType: Int, DefaultValue: 32, MinRange: 1
#DesignerProperty: Key: RoundBars, DisplayName: Round Bars, FieldType: Boolean, DefaultValue: True, Description: If True then the bars are round
#DesignerProperty: Key: Sensitivity, DisplayName: Sensitivity, FieldType: String, DefaultValue: 1.0, List: 1.0|1.1|1.2|1.3|1.4|1.5|1.6|1.7|1.8|1.9|2.0 , Description: Determines how pronounced the amplitude spike is
#DesignerProperty: Key: BarColor, DisplayName: Bar Color, FieldType: Color, DefaultValue: 0xFFFFFFFF

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object

	Private xcvs As B4XCanvas
	Private FFT As xFFT
	
	Private m_VisualizationType As String
	Private m_NumberOfBars As Int = 32
	Private m_NoiseThreshold As Double = 0.01
	Private m_RoundBars As Boolean = True
	Private m_Sensitivity As Double = 1.0
	Private m_BarColor As Int
	Private m_SecondaryColor As Int
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me

	m_VisualizationType = Props.Get("VisualizationType")
	m_NumberOfBars = Props.Get("NumberOfBars")
	m_RoundBars = Props.Get("RoundBars")
	m_Sensitivity = Props.Get("Sensitivity")
	setBarColor(Props.Get("BarColor"))

	FFT.Initialize

	xcvs.Initialize(mBase)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	xcvs.Resize(Width, Height)
End Sub

Public Sub UpdateWithDB(dBValue As Double)
	Dim amplitude As Double = DBToAmplitude(dBValue)

	' FFT-Daten simulieren mit dem dB-Wert
	Dim fftData(m_NumberOfBars) As Double
	For i = 0 To m_NumberOfBars - 1
		fftData(i) = amplitude * (Rnd(50, 100) / 100) ' Leichte Variationen für Realismus
	Next

	' Zeichne die Balken mit dem umgerechneten Wert
	Draw(fftData)
End Sub

Private Sub DBToAmplitude(dB As Double) As Double
	' Hier wird die Sensitivität mit einbezogen:
	Dim amplitude As Double = 1.1 * Power(10, dB / 20) * m_Sensitivity
	amplitude = Max(0, Min(1, amplitude))
	Return amplitude
End Sub

Private Sub Draw(fftData() As Double)
	Select m_VisualizationType
		Case "Spectrum"
			DrawSpectrum(fftData)
		Case "Waveform"
			DrawWaveformBars(fftData)
		Case "FilledWave"
			DrawFilledWaveVisualizer(fftData)
	End Select
End Sub

#Region Visualizer

Private Sub DrawSpectrum(fftData() As Double)
	' Clear the entire canvas area.
	xcvs.ClearRect(xcvs.TargetRect)

	' Calculate the width of each bar.
	Dim barWidth As Float = mBase.Width / m_NumberOfBars
	' Determine the maximum amplitude (80% of the base height).
	Dim maxAmplitude As Float = mBase.Height * 0.8

	For i = 0 To m_NumberOfBars - 1
		' Map the bar index to the FFT data index.
		Dim index As Int = i * fftData.Length / m_NumberOfBars
		Dim sample As Double = fftData(index)

		' Filter out minor noise: if sample is below the noise threshold, set it to 0.
		If sample < m_NoiseThreshold Then
			sample = 0
		Else
			' Normalize the sample value above the noise threshold.
			sample = (sample - m_NoiseThreshold) / (1 - m_NoiseThreshold)
		End If

		' Apply a Gaussian multiplier for a more natural frequency distribution.
		Dim exponent As Double = -Power((2 * i / m_NumberOfBars - 1), 2) / 0.2
		Dim gaussianMultiplier As Double = Power(cE, exponent) ' cE represents Euler's number (~2.718)
		sample = sample * gaussianMultiplier

		' Calculate the height of the bar.
		Dim barHeight As Float = 10 + (maxAmplitude * sample)
		' Determine the left coordinate of the bar.
		Dim left As Float = i * barWidth
		' Calculate the top coordinate (bars build from the bottom up).
		Dim top As Float = mBase.Height - barHeight
		' Set the right coordinate (80% of the allocated bar width).
		Dim right As Float = left + barWidth * 0.8

		' Initialize the rectangle for the bar.
		Dim rect As B4XRect
		rect.Initialize(left, top, right, mBase.Height)

		' If rounded bars are enabled, draw a rounded rectangle; otherwise, draw a normal rectangle.
		If m_RoundBars Then
			Dim path As B4XPath
			path.InitializeRoundedRect(rect, 10dip) ' 10dip is the corner radius.
			xcvs.DrawPath(path, m_BarColor, True, 1dip)
		Else
			xcvs.DrawRect(rect, m_BarColor, True, 1dip)
		End If
	Next

	' Refresh the canvas.
	xcvs.Invalidate
End Sub


Private Sub DrawWaveformBars(fftData() As Double)
	' Clear the entire canvas area.
	xcvs.ClearRect(xcvs.TargetRect)

	' Calculate the width of each bar.
	Dim barWidth As Float = mBase.Width / m_NumberOfBars
	' Determine the maximum amplitude (80% of the base height).
	Dim maxAmplitude As Float = mBase.Height * 0.8
	' Find the vertical center of the canvas.
	Dim centerY As Float = mBase.Height / 2
	' Set a minimum bar height.
	Dim minBarHeight As Float = 4dip

	For i = 0 To m_NumberOfBars - 1
		' Map the bar index to the FFT data index.
		Dim index As Int = i * fftData.Length / m_NumberOfBars
		Dim sample As Double = fftData(index)

		' Filter out minor noise: if sample is below the noise threshold, set it to 0.
		If sample < m_NoiseThreshold Then
			sample = 0
		Else
			' Normalize the sample value above the noise threshold.
			sample = (sample - m_NoiseThreshold) / (1 - m_NoiseThreshold)
		End If

		' Apply a Gaussian multiplier for a natural frequency distribution.
		Dim exponent As Double = -Power((2 * i / m_NumberOfBars - 1), 2) / 0.2
		Dim gaussianMultiplier As Double = Power(cE, exponent)
		sample = sample * gaussianMultiplier

		' Calculate the bar height.
		Dim barHeight As Float = 10 + (maxAmplitude * sample)
		' Ensure the bar height is not below the minimum.
		If barHeight < minBarHeight Then
			barHeight = minBarHeight
		End If

		' Calculate half of the bar height for centered drawing.
		Dim halfBar As Float = barHeight / 2
		' Calculate the top and bottom coordinates to center the bar vertically.
		Dim top As Float = centerY - halfBar
		Dim bottom As Float = centerY + halfBar

		' Determine the left and right coordinates of the bar.
		Dim left As Float = i * barWidth
		Dim right As Float = left + barWidth * 0.8

		' Initialize the rectangle for the bar.
		Dim rect As B4XRect
		rect.Initialize(left, top, right, bottom)

		' If rounded bars are enabled, draw a rounded rectangle; otherwise, draw a normal rectangle.
		If m_RoundBars Then
			Dim path As B4XPath
			path.InitializeRoundedRect(rect, 10dip) ' 10dip is the corner radius.
			xcvs.DrawPath(path, m_BarColor, True, 1dip)
		Else
			xcvs.DrawRect(rect, m_BarColor, True, 1dip)
		End If
	Next

	' Refresh the canvas.
	xcvs.Invalidate
End Sub

Private Sub DrawFilledWaveVisualizer(fftData() As Double)
	' Clear the entire canvas area.
	xcvs.ClearRect(xcvs.TargetRect)
	Dim maxHeight As Float = mBase.Height
	Dim baseY As Float = mBase.Height   ' Base: bottom edge

	Dim Path As B4XPath
	' Initialize the path at the base (bottom) of the canvas.
	Path.Initialize(0, baseY)
	For i = 0 To m_NumberOfBars - 1
		Dim sample As Double = fftData(i)
		' Noise filtering and normalization.
		If sample < m_NoiseThreshold Then
			sample = 0
		Else
			sample = (sample - m_NoiseThreshold) / (1 - m_NoiseThreshold)
		End If
		' Apply Gaussian multiplier for a more natural curve.
		Dim exponent As Double = -Power((2 * i / m_NumberOfBars - 1), 2) / 0.2
		Dim gaussianMultiplier As Double = Power(cE, exponent)
		sample = sample * gaussianMultiplier

		Dim x As Float = i * (mBase.Width / m_NumberOfBars)
		' With no sound: y = baseY; with maximum sound: y = baseY - (maxHeight * 0.8)
		Dim y As Float = baseY - sample * (maxHeight * 0.8)
		Path.LineTo(x, y)
	Next
	' Close the path to fill the area under the wave.
	Path.LineTo(mBase.Width, baseY)
	Path.LineTo(0, baseY)
	' Draw the filled path and its outline.
	xcvs.DrawPath(Path, m_SecondaryColor, True, 0)
	xcvs.DrawPath(Path, m_BarColor, False, 2dip)
	xcvs.Invalidate
End Sub


#End Region

#Region Properties

Public Sub setVisualizationType(VisualizationType As String)
	m_VisualizationType = VisualizationType
End Sub

Public Sub getVisualizationType As String
	Return m_VisualizationType
End Sub

'Default: 32
Public Sub getNumberOfBars As Int
	Return m_NumberOfBars
End Sub

Public Sub setNumberOfBars(Number As Int)
	m_NumberOfBars = Number
End Sub

'If True then the bars are round
'Default: True
Public Sub getRoundBars As Boolean
	Return m_RoundBars
End Sub

Public Sub setRoundBars(RoundBars As Boolean)
	m_RoundBars = RoundBars
End Sub

'NoiseThreshold (0.01) filters out minor noise by setting any value below it to zero.
'Default: 0.01
Public Sub getNoiseThreshold As Double
	Return m_NoiseThreshold
End Sub

Public Sub setNoiseThreshold(NoiseThreshold As Double)
	m_NoiseThreshold = NoiseThreshold
End Sub

' Sensitivity determines how pronounced the amplitude spike is.
' Default: 1.0
Public Sub getSensitivity As Double
	Return m_Sensitivity
End Sub

Public Sub setSensitivity(Sensitivity As Double)
	m_Sensitivity = Sensitivity
End Sub

Public Sub getBarColor As Int
	Return m_BarColor
End Sub

Public Sub setBarColor(BarColor As Int)
	m_BarColor = BarColor
	Dim ThisArgb() As Int = GetARGB(m_BarColor)
	m_SecondaryColor = xui.Color_ARGB(152,ThisArgb(1),ThisArgb(2),ThisArgb(3))
End Sub

#End Region

#Region Functions

'int ot argb
Private Sub GetARGB(Color As Int) As Int()'ignore
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

#End Region