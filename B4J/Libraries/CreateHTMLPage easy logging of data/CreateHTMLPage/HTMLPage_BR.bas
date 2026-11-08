B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Private Sub getHTML As String
	Return $"</br>
"$
End Sub

Private Sub DefaultCss As String
	Return HTMLPage_Static.BRDefaultCSS
End Sub

Private Sub IgnoreCSS As Boolean
	Return True
End Sub