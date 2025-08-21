B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.45
@EndOfDesignText@
'FFT Class module Fast Fourier Transform
'
'Version 1.2  2020.02.27
'renamed it to xFFT and made a B4X Library
'
'Version 1.1
'added precalculated Sin and Cos functions
'
'Version 1.0
'
Sub Class_Globals
	Private N, N2, N_2, N_21, NU As Int
	Private xReal(), xImag(), tReal, tImag, fReal(), fImag(), fAmpl(), fPhase(), mSin(), mCos() As Double
	Private mModeDegrees = True As Boolean
	Private mWindow = "NONE" As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Calculates the forward FFT (Fast Fourier Transformation)
'Real() = the real part of the time signal, the imaginary part is supposed to be 0 managed internally
'The length of Real must be a power of 2?
'Returns the amplitude of the frequencies
'Example code<code>
'FFTMagnitude = FFT1.Forward(Real)
'</code>
Public Sub Forward(Real() As Double) As Double()
	Private i As Int
	Private ld As Double

	N = Real.Length
	
	ld = Logarithm(N, 2)
	If ld - Floor(ld) > 0 Then
		Log("N must be a power of 2")
		Return fReal
	End If
	
	NU = ld
	N2 = N / 2
	N_2 = N2
	N_21 = N2 + 1
	Private xReal(N), xImag(N), fReal(N_21), fImag(N_21), fAmpl(N_21), fPhase(N_21), mSin(N_21), mCos(N_21) As Double
	
	'precalculates the sin and cos values
	Private arg As Double
	For i = 0 To N2
		arg = -2 * cPI * i / N
		mCos(i) = Cos(arg)
		mSin(i) = Sin(arg)
	Next
'	xReal = Real
	
	Select mWindow
		Case "NONE"
			For i = 0 To N - 1
				xReal(i) = Real(i)
				xImag(i) = 0
			Next
		Case "Hann"				
			Private w As Double
			w = 360 / N
			For i = 0 To N - 1
				xReal(i) = Real(i) * (1 - CosD(w * i))
				xImag(i) = 0
			Next
	End Select

	'First phase - calculation
	Private k, l, p, nu1 As Int
	Private c, s As Double
	
	nu1 = NU - 1
  k = 0
	For l = 1 To NU
		Do While k < N
			For i = 1 To N2
				p = BitReverse(Bit.ShiftRight(k, nu1))
				c = mCos(p)
				s = mSin(p)
				tReal = xReal(k + N2) * c + xImag(k + N2) * s
				tImag = xImag(k + N2) * c - xReal(k + N2) * s
				xReal(k + N2) = xReal(k) - tReal
				xImag(k + N2) = xImag(k) - tImag
				xReal(k) = xReal(k) + tReal
				xImag(k) = xImag(k) + tImag
				k = k + 1
			Next
			k = k + N2
		Loop
		k = 0
		nu1 = nu1 - 1
		N2 = N2 / 2
	Next

  'Second phase - recombination
	Private r As Int
	k = 0
	Do While k < N
	  r = BitReverse(k)
	  If r > k Then
			tReal = xReal(k)
			tImag = xImag(k)
			xReal(k) = xReal(r)
			xImag(k) = xImag(r)
			xReal(r) = tReal
			xImag(r) = tImag
	  End If
	  k = k + 1
	Loop
	
	If mModeDegrees = True Then
		For i = 0 To N_2
			fReal(i) = xReal(i) / N_2
			fImag(i) = xImag(i) / N_2
			fAmpl(i) = Sqrt(fReal(i) * fReal(i) + fImag(i) * fImag(i))
			fPhase(i) = ATan2D(xImag(i), xReal(i))
		Next
	Else
		For i = 0 To N_2
			fReal(i) = xReal(i) / N_2
			fImag(i) = xImag(i) / N_2
			fAmpl(i) = Sqrt(fReal(i) * fReal(i) + fImag(i) * fImag(i))
			fPhase(i) = ATan2(xImag(i), xReal(i))
		Next
	End If
		
	Return fAmpl
End Sub

'Calculates the inverse FFT (Fast Fourier Transformation)
'Real() = the real part of the frequency
'Imag() = the imaginary part of the frequency
'The length of Real and Imag must be a power of 2 + 1
'Returns the real values of the time signal
'Example code<code>
'TimeRealINV = FFT1.Inverse(Real, Imag)
'</code>
Public Sub Inverse(Real() As Double, Imag() As Double) As Double()
	Private i, j As Int
	Private ld As Double
	
	N = (Real.Length - 1) * 2
	
	ld = Logarithm(N, 2)
	If ld - Floor(ld) > 0 Then
		Log("N must be a power of 2")
		Return fReal
	End If
	
	NU = ld
	N2 = N / 2
	N_2 = N2
	N_21 = N2 + 1
	Private xReal(N), xImag(N), invReal(N), mSin(N_21), mCos(N_21) As Double
	
	xReal(0) = Real(0)
	xImag(0) = Imag(0)	
	For i = 1 To N2 - 1
		xReal(i) = Real(i)
		xImag(i) = Imag(i)	
		j = n - i
		xReal(j) = Real(i)
		xImag(j) = -Imag(i)
	Next
	xReal(N2) = Real(N2)
	xImag(N2) = Imag(N2)
	
	Private ang As Double
	For i = 0 To N2
		ang = 2 * cPI * i / N
		mCos(i) = Cos(ang)
		mSin(i) = Sin(ang)
	Next
	
	'First phase - calculation
	Private k, l, p, nu1 As Int
	Private c, s As Double
	
	nu1 = NU - 1
  k = 0
	For l = 1 To NU
		Do While k < N
			For i = 1 To N2
				p = BitReverse(Bit.ShiftRight(k, nu1))
				c = mCos(p)
				s = mSin(p)
				tReal = xReal(k + N2) * c + xImag(k + N2) * s
				tImag = xImag(k + N2) * c - xReal(k + N2) * s
				xReal(k + N2) = xReal(k) - tReal
				xImag(k + N2) = xImag(k) - tImag
				xReal(k) = xReal(k) + tReal
				xImag(k) = xImag(k) + tImag
				k = k + 1
			Next
			k = k + N2
		Loop
		k = 0
		nu1 = nu1 - 1
		N2 = N2 / 2
	Next

  'Second phase - recombination
	Private r As Int
	k = 0
	Do While k < N
	  r = BitReverse(k)
	  If r > k Then
			tReal = xReal(k)
			tImag = xImag(k)
			xReal(k) = xReal(r)
			xImag(k) = xImag(r)
			xReal(r) = tReal
			xImag(r) = tImag
	  End If
	  k = k + 1
	Loop
	
	For i = 0 To N - 1
		invReal(i) = xReal(i) / 2
	Next
		
	Return invReal
End Sub

Private Sub BitReverse(j As Int) As Int
	Private j1, j2, k As Int
	
	j1 = j
	k = 0
	For i = 1 To NU
		j2 = j1 / 2
		k = 2 * k + j1 - 2 * j2
		j1 = j2
	Next
	Return k
End Sub

'gets the FFT Real array
Public Sub getReal As Double()
	Return fReal
End Sub


'gets the FFT Imaginary array
Public Sub getImag As Double()
	Return fImag
End Sub

'gets the FFT Magnitude array
Public Sub getMagnitude As Double()
	Return fAmpl
End Sub

'gets the FFT Phase array in radian or degrees depending on ModeDegrees
Public Sub getPhase As Double()
	Return fPhase
End Sub

'gets or sets the Degree mode
'ModeDegrees = True reutuens the FFT Phase in degrees instead of radians
Public Sub getModeDegrees As Boolean
	Return mModeDegrees
End Sub

Public Sub setModeDegrees(ModeDegrees As Boolean)
	mModeDegrees = ModeDegrees
End Sub

'gets or sets the FFT window
'possible values "NONE", "Hann"
Public Sub getWindow As String
	Return mWindow
End Sub

Public Sub setWindow(Window As String)
	If Window = "NONE" Or Window = "Hann" Then
		mWindow = Window
	Else
		Log("Wrong window")
	End If
End Sub