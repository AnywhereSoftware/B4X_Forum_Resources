B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.5
@EndOfDesignText@
' B4XPassword Generator Library by ThRuST
' v1.2 	2022-06-30	Corrected the ASCII table chars.
' v1.3 	2022-06-31 	The generator now uses a min and max value for varied lenght.
' Random lenght should work between the intervals now.

' Reference: https://hscboards.fandom.com/wiki/ASCII_Codes

' Shared with the B4X community.
' Play around with the GUI min and max to find the parameter you prefer.
' Have fun :-)

Sub Process_Globals
	Private fx As JFX
	
	Private Randy As Int
	Private RandChar1, RandChar2 , RandChar3, RandChar4, RandChar5 As Int
	Private PassStr(5000) As String
	Private MyPass As String
		
End Sub

' Randomize a password with min and max parameter.
' A randomized password between the min and max range will be generated.
' Example usage: string = B4XPassword.Randomize_Password(3,11)
' This will randomize a password with lenght between 3 and 10
Public Sub Randomize_Password(PassMin As Int, PassMax As Int)
	
	' Reset result string
	MyPass = ""
	' Randomize ASCII int
	Dim Randy As Int
	Dim PassLgt As Int = Rnd(PassMin, PassMax + 1)
	
	' Loop begins
	For i = 1 To PassLgt
		
		Randy = Rnd(1, 6)
		
		If Randy = 1 Then RandChar1 = Rnd(49, 58)
		If Randy = 2 Then RandChar2 = Rnd(69, 91)
		If Randy = 3 Then RandChar3 = Rnd(97, 123)
		If Randy = 4 Then RandChar4 = 45 ' -
		If Randy = 5 Then RandChar5 = 33 ' !
		
		If Randy = 1 Then PassStr(i) = Chr(RandChar1)
		If Randy = 2 Then PassStr(i) = Chr(RandChar2)
		If Randy = 3 Then PassStr(i) = Chr(RandChar3)
		If Randy = 4 Then PassStr(i) = Chr(RandChar4)
		If Randy = 5 Then PassStr(i) = Chr(RandChar5)
		
		' Store char array in string
		MyPass = MyPass & PassStr(i)
		 
	Next
	
	' Pass it back
	Return MyPass
	
End Sub