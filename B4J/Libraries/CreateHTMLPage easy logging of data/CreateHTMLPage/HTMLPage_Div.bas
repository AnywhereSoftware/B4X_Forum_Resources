B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private mID As String
	Private mClass As String
	
	Private mIgnoreCSS As Boolean
	Private mContent As String
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Id(tId As String) As HTMLPage_Div
	mID = tId
	Return Me
End Sub

Public Sub Class(tClass As String) As HTMLPage_Div
	mClass = tClass
	Return Me
End Sub

Public Sub Content(tContent As String) As HTMLPage_Div
	mContent = tContent
	Return Me
End Sub

Public Sub getHTML As String
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append($"<div"$)
	If mID <> "" Then SB.Append($" id="${mID}""$)
	If mClass <> "" Then SB.Append($" class="${mClass}""$)
	SB.Append(">")
	SB.Append($"${mContent}</div>
"$)
Return SB.ToString
End Sub

Private Sub IgnoreCSS As Boolean
	Return mIgnoreCSS
End Sub

Public Sub IgnoreDefaultCSS As HTMLPage_Div
	mIgnoreCSS = True
	Return Me
End Sub

Private Sub DefaultCSS As String
	Return HTMLPage_Static.DivDefaultCSS
End Sub