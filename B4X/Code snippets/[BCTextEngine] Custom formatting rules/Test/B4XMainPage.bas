B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private TextEngine As BCTextEngine
	Private TextArea1 As B4XView
	Private BBCodeView1 As BBCodeView
	Private xlbl_Convert As B4XView
End Sub

Public Sub Initialize
	
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("frm_main")
	
	TextEngine.Initialize(Root)
	
	BBCodeView1.TextEngine = TextEngine
	
	xlbl_Convert.Left = Root.Width/2 - xlbl_Convert.Width/2
	
End Sub


Private Sub xlbl_Convert_MouseClicked (EventData As MouseEvent)
	BBCodeView1.Text = FormatText(TextArea1.Text)
End Sub


Private Sub FormatText(Text As String) As String
	' ***TextColor***
	' Define the BBCode for the text color based on the current theme
	Dim LeftText As String = $"[color=#${ColorToHex(xui.Color_Black)}]"$
	Dim RightText As String = "[/color]"

	' Initialize the result text builder
	Dim ResultText As StringBuilder
	ResultText.Initialize

	' Temporary variables
	Dim TempText As String = Text
	Dim IsInList As Boolean = False  ' Flag to track if we are inside a list

	' Split the input text into lines for line-by-line processing
	Dim Lines() As String = Regex.Split(CRLF, TempText)
	For Each Line As String In Lines
		' Check if the line is a list item (starts with "- ")
		If Line.Trim.StartsWith("- ") Then
			' Extract the list item content by removing "- " and trimming
			Dim ListItem As String = Line.Trim.SubString(2).Trim
			If IsInList = False Then
				' If not already in a list, start a new list
				ResultText.Append("[list]").Append(CRLF)
				IsInList = True
			End If
			' Append the list item to the result
			ResultText.Append("[*] ").Append(ListItem).Append(CRLF)
		Else
			' If the current line is not a list item, close any open list
			If IsInList Then
				ResultText.Append("[/list]").Append(CRLF)
				IsInList = False
			End If
			' Check for bold text within the current line
			Dim StartPos As Int = 0
			Do While StartPos < Line.Length
				' Find the start of bold text (indicated by **)
				Dim BoldStart As Int = Line.IndexOf2("**", StartPos)
				If BoldStart = -1 Then
					' No more bold text; append the remaining line as plain text
					ResultText.Append("[Plain]").Append(Line.SubString(StartPos)).Append("[/Plain]")
					Exit
				End If

				' Append plain text before the bold text
				If BoldStart > StartPos Then
					ResultText.Append("[Plain]").Append(Line.SubString2(StartPos, BoldStart)).Append("[/Plain]")
				End If

				' Find the end of the bold text
				Dim BoldEnd As Int = Line.IndexOf2("**", BoldStart + 2)
				If BoldEnd = -1 Then
					' If no closing ** is found, treat the rest of the line as plain text
					ResultText.Append("[Plain]").Append(Line.SubString(BoldStart)).Append("[/Plain]")
					Exit
				End If

				' Append the bold text
				ResultText.Append("[b]").Append(Line.SubString2(BoldStart + 2, BoldEnd)).Append("[/b]")

				' Move the start position to the end of the bold text
				StartPos = BoldEnd + 2
			Loop
			' Append a line break after processing the current line
			ResultText.Append(CRLF)
		End If
	Next

    ' If there is an open list at the end of the text, close it
	If IsInList Then
		ResultText.Append("[/list]").Append(CRLF)
	End If

    ' Return the final formatted text wrapped with the color tags
	Return LeftText & ResultText.ToString & RightText
End Sub


Public Sub ColorToHex(clr As Int) As String
	Dim bc As ByteConverter
	Dim Hex As String = bc.HexFromBytes(bc.IntsToBytes(Array As Int(clr)))
	If Hex.Length > 6 Then Hex = Hex.SubString(Hex.Length - 6)
	Return Hex
End Sub