B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private TextArea1 As B4XView
	Private B4XFloatTextField1 As B4XFloatTextField
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me, "Number Format Lakh")
	B4XFloatTextField1.SmallLabelTextSize = 6
	B4XFloatTextField1.HintLabelSmallOffsetX = 10
	TestNumberFormatLakh
End Sub

Public Sub TestNumberFormatLakh
	ShowText("SAMPLES ROUND 2 DECIMALS")
	ShowText("")
	ShowText("- NumberFormat B4X Normal -")
	ShowText(NumberFormat(123456.6789, 0, 2))
	ShowText(NumberFormat(-123456.6789, 0, 2))
	ShowText(NumberFormat(123456, 8, 0))
	ShowText(NumberFormat(123456, 1, 2))
	ShowText(NumberFormat(250000, 1, 2))
	
	ShowText("- NumberFormat Lakh -")
	ShowText(NumberFormatLakh(123456.6789, 0, 2)) 
	ShowText(NumberFormatLakh(-123456.6789, 0, 2)) 
	ShowText(NumberFormatLakh(123456, 8 ,0)) 
	ShowText(NumberFormatLakh(123456, 1, 2)) 
	ShowText(NumberFormatLakh(250000, 1, 2))
	
End Sub

Private Sub B4XFloatTextField1_TextChanged (Old As String, New As String)
	If New = "" Or Not(IsNumber(New)) Then Return
	TextArea1.Text = NumberFormatLakh(New, 1, 2)
End Sub

Private Sub B4XFloatTextField1_EnterPressed
	ShowText(B4XFloatTextField1.Text)
End Sub

Private Sub ShowText( t As String)
	TextArea1.Text = TextArea1.Text & CRLF & t
End Sub

'Converts the specified number to a string in "Lakh" format.
'The string will include at least Minimum Integers and at most Maximum Fractions digits.
'Example:
'Log(NumberFormatLakh(123456.6789, 0, 2)) '"1,23,456.68"
'Log(NumberFormatLakh(123456, 7 ,0)) '"01,23,456"
Public Sub NumberFormatLakh(Number As Double, MinimumIntegers As Int, MaximumFractions As Int) As String
	Dim value() As String = Regex.Split("\.",SetFormmatter(Number, MinimumIntegers, MaximumFractions))
	Dim sb As StringBuilder
	sb.Initialize
	Dim sw As Boolean
	For i = value(0).Length - 1 To 0 Step - 1
		If (sb.ToString.Length < 3) Then
			sb.Append(value(0).CharAt(i))
			Continue
		End If
		If Not(sw Or value(0).CharAt(i) = "-") Then
			sb.Append(",").append(value(0).CharAt(i))
			sw = True
		Else
			sb.append(value(0).CharAt(i))
			sw = False
		End If
	Next
	Dim result As StringBuilder
	result.Initialize
	For i = sb.Length - 1 To 0 Step - 1
		result.Append(sb.ToString.CharAt(i))
	Next
	If value.Length > 1 Then
		result.Append(".").Append(value(1))
	End If
	Return result
End Sub

Public Sub SetFormmatter(iNumber As Double, iMinimumIntegers As Int, iMaximumFractions As Int) As String
	Dim Formatter As B4XFormatter
	Formatter.Initialize
	Formatter.GetDefaultFormat.GroupingCharacter = ""
	Formatter.GetDefaultFormat.DecimalPoint = "."
	Formatter.GetDefaultFormat.MinimumIntegers  = iMinimumIntegers
	Formatter.GetDefaultFormat.MaximumFractions = iMaximumFractions
	Formatter.GetDefaultFormat.MinimumFractions = iMaximumFractions
	Formatter.GetDefaultFormat.FractionPaddingChar = "0"
	Return Formatter.Format(iNumber)
End Sub