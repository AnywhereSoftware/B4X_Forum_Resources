B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Dim re As Double
	Dim im As Double
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	re = 0
	im = 0
	
End Sub

Public Sub Initialize2(re1 As Double, im1 As Double)
	re = re1
	im = im1
	
End Sub

Public Sub getRe() As Double
	Return re
End Sub

Public Sub getIm() As Double
	Return im
End Sub

Public Sub setRe(re1 As Double) {
	re = re1
End Sub

Public Sub setIm(im1 As Double) {
	im = im1
End Sub

Public Sub getAbs() As Double
	Return getAbs1(Me)
End Sub

Public  Sub getArg() As Double
	Return getArg1(Me)
End Sub

Public Sub addDouble(n As Double) As Complex
	Dim aa As Complex = Me
	aa.re = n + re
	aa.im = im
	Return aa
End Sub

Public Sub multiply(n As Double) As Complex
	Dim aa As Complex = Me
	aa.re = n * re
	aa.im = n * im
	Return aa
End Sub

Public Sub powDouble(n As Double) As Complex
	Return powComplex(Me, n)
End Sub

Public Sub addComplex1(z As Complex) As Complex
	Return addComplex2(Me, z)
End Sub

Public Sub subtractComplex1(z As Complex) As Complex
	Return subtractComplex2(Me, z)
End Sub

Public Sub divideComplex1(z As Complex) As Complex
	Return divideComplex2(Me, z)
End Sub

Public Sub addComplex2(z1 As Complex, z2 As Complex) As Complex
	Dim aa As Complex
	aa.Initialize
	aa.re = z1.re + z2.re
	aa.im = z1.im + z2.im
	Return aa
End Sub

Public Sub subtractComplex2(z1 As Complex, z2 As Complex) As Complex
	Dim aa As Complex
	aa.Initialize
	aa.re = z1.re - z2.re
	aa.im = z1.im - z2.im
	Return aa
End Sub

Public Sub divideComplex2(z1 As Complex, z2 As Complex) As Complex
	Dim k As Double = Power(z2.im, 2) + Power(z2.re, 2)
	Dim aa As Complex
	aa.Initialize
	aa.re = (z1.re * z2.re + z1.im * z2.im) / k
	aa.im = (z1.im * z2.re - z1.re * z2.im) / k
	Return aa
						  
End Sub

Public Sub getAbs1(z As Complex) As Double
	Return Sqrt(Power(z.re, 2) + Power(z.im, 2))
End Sub


Public Sub getArg1(z As Complex) As Double
	Return ATan2(z.im, z.re)
End Sub

Public Sub powComplex(z1 As Complex, z2 As Double) As Complex
	Dim r As Double = Power(z1.Abs, z2)
	Dim theta As Double = z2 * z1.Arg
	Dim aa As Complex
	aa.Initialize
	aa.re = Cos(theta) * r
	aa.im = Sin(theta) * r
	Return aa
End Sub

Public Sub equals2(z1 As Complex, z2 As Complex, tolerance As Double) As Boolean
	Return (euclideanDistance2(z1, z2) <= tolerance)
End Sub


Public Sub equals1(z As Complex, tolerance As Double) As Boolean
	Return equals2(Me, z, tolerance)
End Sub


Public Sub euclideanDistance1(z As Complex) As Double
	Return euclideanDistance2(Me, z)
End Sub

Public Sub euclideanDistance2(z1 As Complex, z2 As Complex) As Double
	Return Sqrt(Power(z1.re - z2.re, 2) + Power(z1.im - z2.im, 2))
End Sub

Public Sub toString() As String
	Return "(" + re + "," + im + ")"
End Sub
