B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private cvs As B4XCanvas
	Private wScene As Int, hScene As Int, pColor As Int, bgColor As Int
	Private SX As Float, SY As Float
	Private pickN(120) As Int
	Private Tick As Timer
	
	Private Buffer() As Int
	Private BufferSize As Int
	Private BufferCh As Int
	
	' *** FFT ported from schismtracker.org (page.c, page_waterfall.c)
	Private Const FFT_BUFFER_SIZE_LOG As Int = 11
	Private Const FFT_BUFFER_SIZE As Int = 2048
	Private Const FFT_OUTPUT_SIZE As Int = 1024
	Private Const FFT_BANDS_SIZE As Int = 256
	
	Private Const inv_s_range As Float = 1 / 32768
	Private Const fft_inv_bufsize As Float = 1 / Bit.ShiftRight(FFT_BUFFER_SIZE, 2)
	Private Const fft_dbinv_bufsize As Float = 20 * Logarithm(fft_inv_bufsize, 10)
	
	Private Const noisefloor As Int = 72
	
	Private bit_reverse(FFT_BUFFER_SIZE) As Int
	Private window(FFT_BUFFER_SIZE) As Float
	Private precos(FFT_OUTPUT_SIZE) As Float
	Private presin(FFT_OUTPUT_SIZE) As Float
	Private fftlog(FFT_BANDS_SIZE) As Short
	Private state_real(FFT_BUFFER_SIZE) As Float
	Private state_imag(FFT_BUFFER_SIZE) As Float
	' *** FFT
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(P As B4XView, Color As Int, BColor As Int)
	SX = P.Width / 120
	SY = P.Height / 64
	
	wScene = P.Width
	hScene = P.Height
	pColor = Color
	bgColor = BColor

	FFT_Init
	cvs.Initialize(P)
	Tick.Initialize("Tick", 8)
	Tick.Enabled = True
End Sub

Public Sub GetBuf(Buf() As Int, Sz As Int, Ch As Int)
	Buffer = Buf
	If Sz > FFT_BUFFER_SIZE Then Sz = FFT_BUFFER_SIZE
	BufferSize = Sz
	BufferCh = Ch
End Sub

Private Sub Tick_Tick
	Dim sound(FFT_BUFFER_SIZE) As Int
	

	Dim j As Int
	For i = 0 To BufferSize * 2 - 1 Step 2
		sound(j) = Buffer(i + BufferCh)
		j = j + 1
	Next

	Dim pick(120) As Int
	pick = FFT_DataWork(sound)
	
	cvs.DrawLine(0, 0, wScene, hScene, bgColor, wScene)
	Dim j As Int
	For i = 0 To pick.Length - 1
		If pickN(i) > pick(i) Then pickN(i) = pickN(i) - 1
		If pickN(i) < pick(i) Then pickN(i) = pickN(i) + 1
		cvs.DrawLine(i * SX, hScene, i*SX, hScene - (pickN(i) * SY), pColor, Ceil(1 * SX))
	Next
	cvs.Invalidate
End Sub

' *** FFT ported from schismtracker.org (page.c, page_waterfall.c)
Private Sub FFT_Init
	For n = 0 To FFT_BUFFER_SIZE - 1
		bit_reverse(n) = reverse_bits(n)
		window(n) = 0.50f - 0.50f * Cos(2.0*cPI * n / (FFT_BUFFER_SIZE - 1))
	Next
	For n = 0 To FFT_OUTPUT_SIZE - 1
		Dim j As Float = (2.0*cPI) * n / FFT_BUFFER_SIZE
		precos(n) = Cos(j)
		presin(n) = Sin(j)
	Next
	Dim factor As Float = 8 / FFT_BANDS_SIZE
	Dim factor2 As Float = FFT_OUTPUT_SIZE / 256
	For n = 0 To FFT_BANDS_SIZE - 1
		fftlog(n) = (Power(2.0f, n * factor) - 1) * factor2
	Next
End Sub

Private Sub reverse_bits(in As Int) As Int
	Dim r As Int
	For nn = 0 To FFT_BUFFER_SIZE_LOG - 1
		r = Bit.ShiftLeft(r, 1)
		r = r + Bit.And(in, 1)
		in = Bit.ShiftRight(in, 1)
	Next
	Return r
End Sub

Private Sub pdB_s(noisefloor_ As Int, powers As Float, correction_dBs As Float) As Short
	Dim db As Float = (10 * Logarithm(powers, 10)) + correction_dBs
	Dim dbb As Int = (128 * (db + noisefloor_)) / noisefloor_
	If dbb < 0 Then dbb = 0
	If dbb > 127 Then dbb = 127
	Return dbb
End Sub


Private Sub FFT_DataWork(inp() As Int) As Int()
	Dim outp(FFT_OUTPUT_SIZE) As Short
	Dim outc(120) As Int
	Dim fr As Float, fi As Float
	Dim tr As Float, ti As Float
	Dim ex As Int, ff As Int, yp As Int
	Dim out As Float
	
	For n = 0 To FFT_BUFFER_SIZE - 1
		Dim nr As Int = bit_reverse(n)
		state_real(n) = inp(nr) * inv_s_range * window(nr)
		state_imag(n) = 0
	Next
	
	ex = 1
	ff = FFT_OUTPUT_SIZE
	For n = FFT_BUFFER_SIZE_LOG To 1 Step -1
		For k = 0 To ex - 1
			fr = precos(k * ff)
			fi = presin(k * ff)
			For y = k To FFT_BUFFER_SIZE - 1 Step Bit.ShiftLeft(ex, 1)
				yp = y + ex
				tr = fr * state_real(yp) - fi * state_imag(yp)
				ti = fr * state_imag(yp) + fi * state_real(yp)
				state_real(yp) = state_real(y) - tr
				state_imag(yp) = state_imag(y) - ti
				state_real(y) = state_real(y) + tr
				state_imag(y) = state_imag(y) + ti
			Next
		Next
		ex = Bit.ShiftLeft(ex, 1)
		ff = Bit.ShiftRight(ff, 1)
	Next

	For n = 0 To FFT_OUTPUT_SIZE - 1
		out = (state_real(n+1) * state_real(n+1)) + (state_imag(n+1) * state_imag(n+1))
		outp(n) = pdB_s(noisefloor, out+0.0000000001f, fft_dbinv_bufsize)
		
		outp(n) = Bit.ShiftRight(outp(n), 1)
	Next
	
	Dim j As Int, t As Int, a As Int
	For i = 0 To 119
		Dim afloat As Float = fftlog(t)
		Dim floora As Float = Floor(afloat)
		If afloat + 1 > fftlog(t+1) Then
			a = floora
			j = outp(a) + (outp(a+1)-outp(a)) * (afloat - floora)
			a = Floor(afloat + 0.5f)
		Else
			j = outp(a)
			Do While a <= afloat
				j = Max(j, outp(a))
				a = a + 1
			Loop
		End If
		outc(i) = j
		t = t + 2
	Next
	
	Return outc
End Sub

' *** FFT