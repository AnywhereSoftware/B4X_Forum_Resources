B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
Sub Class_Globals
End Sub

public Sub initialize
	
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
Public Sub PresentValue(myRate As Double, myNPer As Double, myPMT As Double, myFV As Double, myDue As Double) As Double
	' Calculates the Present Value Amount of a Regular Payment (e.g. Annuity), or of a Lump Sum (Future Value), or a combination of both 
	Dim result As Double = 0
	result = result+ (myFV / (Power((1+(myRate/myDue)),(myNPer * myDue))))			' PV of Lump Sum (FV)
	result = result + (myPMT * ( ( 1 - Power((1+myRate),-myNPer) ) / myRate ) )		' PV of Annuity (Payment)
	Return result
End Sub

'----------------------------------------------------------------------------------------------------------------------------------------
Public Sub FutureValue(myRate As Double, myNPer As Double, MyPmt As Double, myPV As Double, myDue As Double) As Double
	' Calculates the Future Value Amount of a Regulat Payment, a Lump Sum (Present Value), or a combination of both
	Dim result As Double = 0
	If(myRate <> 0) Then
		result = -MyPmt * (1 + myRate * myDue) * ( (Power((1+myRate), myNPer) - 1)/myRate) - myPV * Power((1 + myRate), myNPer)
	Else
		result = -(MyPmt * myNPer) - myPV
	End If
	Return result
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
public Sub RateOfReturnAnnuity(myFV As Double, myPV As Double, myTerm As Double) As Double
	' Calculates the Rate of Return of an investment (If myTerm is 1>1 then the annualised rate is returned
	Return(Power((myFV/myPV),(1/myTerm)) - 1)
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
public Sub RateOfReturnLoan(myPV As Double, myPmt As Double, myTerm As Double) As Double
	' Calculates the Rate of Return of a Loan
	Return(Power(((myPmt*myTerm)/myPV),(1/myTerm)) - 1)
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
Public  Sub Payment(myRate As Double, myNPer As Double, MyPV As Double, MyFV As Double, myDue As Double) As Double
	' Calculates Loan Payment Amount
	Dim PVal As Double = -MyPV
	Dim FVal As Double = -MyFV
	If (myNPer == 0) Then Return 0
    	
	Dim totalFutureVal As Double = 0
	Dim geometricSum As Double = 0
    
	If (myRate == 0) Then
		totalFutureVal = FVal + PVal
		geometricSum = myNPer
	else if (myDue == 0) Then
		Dim totalRate As Double = Power(myRate + 1, myNPer)
		totalFutureVal = FVal + PVal * totalRate
		geometricSum = (totalRate - 1) / myRate
	else if (myDue == 1) Then
		Dim totalRate1 As Double = Power(myRate + 1, myNPer)
		totalFutureVal = FVal + PVal * totalRate1
		geometricSum = ((1 + myRate) * (totalRate1 - 1)) / myRate
	End If
	Return (totalFutureVal) / geometricSum
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
public Sub SimpleInterest(myPrincipal As Double, myRate As Double, myTerm As Double) As Double
	' Calcualtes the Interest Amount earned on a loan or savings account where interest is not compounded (i.e. simple interest)
	Return(myPrincipal * myRate * myTerm)
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
Public Sub CompoundInterest(myPV As Double, myRate As Double, myNPer As Double, myWritedown As Int) As Double
	' Calculates the Interest Amount on a loan or a deposit, where interest is earned on both the original 
	' amount and any interest already earned on that amount
	Return (myPV*Power((1+(myRate/myWritedown)),(myNPer*myWritedown)))-myPV
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
public Sub NetPresentValue(myPV() As Double, myRate() As Double) As Double
	'Returns the Present Value of a series of payments (each with it's own associated Interest Rate) less the initial purchase price
	Private myResult As Double
	Private myCounter As Double
	Private myNPer As Int = myPV.Length
	
	If myPV.Length <> myRate.Length Then Return -999999999	' Investment amount and Rate arrays must match
	myResult = 0
	For myCounter = 0 To myNPer - 1
		myResult = myResult + (myPV(myCounter)/ Power((1+myRate(myCounter)), (myCounter+1)))
	Next
	Return myResult
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------
public Sub NumberPeriods(myPV As Double, myPmt As Double, myRate As Double, myWritedown As Double) As Double
	' Calculates the Number of Payments to service a loan
	Return(-Logarithm(1-(((myRate/myWritedown)*myPV)/myPmt),10)/(Logarithm(1+(myRate/myWritedown),10)))
End Sub
'----------------------------------------------------------------------------------------------------------------------------------------


