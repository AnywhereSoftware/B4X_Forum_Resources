B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub

' These subs are not used but may be of assistance for min and max range calculations

' Returns the integer part of the number upped to the nearest 10,100,1000 etc
' So 1.36 to 1,, 136 t0 100 etc.. Ensure the low value is less than the data low value
Sub AdjustLimitLow(Val As Int) As Int
	If Val>0 Then
		Dim count As Int
		For i = 1 To 10000
			Val = Val/10
			count=count+1
			If Val<10 Then
				Exit
			End If
		Next
		Return Val *Power(10,count)
	Else
		Return 0
	End If
End Sub

' Returns first integer of the number+1 x1, x10, x100 etc
' Ensures that the high value is sensibly higher that the highest data value
Sub AdjustLimitHigh(Val As Float) As Int
	'Log("Val In  " & Val)
	Dim count As Int
	Dim ans As Int
	For i = 1 To 10000
		Val = Val/10
		count=count+1
		If Val<100 Then
			ans = Val       'converts to int
			Exit
		End If
	Next
	'Return (ans+1)*Power(10,count)      '' Use this to add space on RHS of graph
	Return (ans)*Power(10,count)
End Sub