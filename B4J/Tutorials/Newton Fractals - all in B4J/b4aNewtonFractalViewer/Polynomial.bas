B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
	Public coefficients() As Double
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (coefficient() As Double) 
	
	coefficients = coefficient
	
End Sub

Public Sub derivative() As Polynomial
		
		If(coefficients = Null)  Then
			Return Null
		End If

		Dim newCoefficents(coefficients.length - 1) As Double
		
		For i = 0 To newCoefficents.length - 1
			newCoefficents(i) = (coefficients(i + 1)) * (i + 1)
		Next
		
		Dim aa As Polynomial
		aa.Initialize(newCoefficents)
		Return aa
		
		
End Sub

Public Sub evaluate(z As Complex) As Complex
	Dim result As Complex
	result.Initialize

	For i = 0 To coefficients.length - 1
		If(i = 0) Then
			result = result.addDouble(coefficients(0))
			Continue
		End If
		If (coefficients(i) = 0)  Then
			Continue
		End If

		result = result.addComplex1(z.powDouble(i).multiply(coefficients(i)))
	Next
	Return result
End Sub

