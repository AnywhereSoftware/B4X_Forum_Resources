B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	
	Private pol, dpol As Polynomial
	Private guess As Complex
	
	Private TOLERANCE As Double
	Private MAXITER As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pol1 As Polynomial, guess1 As Complex)
		pol = pol1
		dpol = pol.derivative
		guess = guess1
		TOLERANCE = Power(10, -6)
		MAXITER = 100
	
End Sub


Private Sub nextGuess() As Double
    Dim nextGuess1 As Complex = guess.subtractComplex1(pol.evaluate(guess).divideComplex1(dpol.evaluate(guess)))
    Dim distance As Double = nextGuess1.euclideanDistance1(guess)
    guess = nextGuess1
    Return distance
End Sub

Public Sub getRootPoint() As RootPoint
    Dim diff As Double = 10
    Dim iter As Int = 0
    Do While(diff > TOLERANCE And iter < MAXITER)
        iter = iter + 1
        diff = nextGuess
    Loop

	Dim aa As RootPoint
	aa.Initialize(guess, iter)
    Return aa
End Sub
    
