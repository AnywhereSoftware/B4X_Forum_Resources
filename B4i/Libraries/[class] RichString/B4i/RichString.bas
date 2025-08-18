Type=Class
Version=1.5
ModulesStructureVersion=1
B4i=true
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private s As NativeObject
	Private t As String
End Sub

Public Sub Initialize (Text As String)
	setText(Text)
End Sub

Public Sub getAttributedString As AttributedString
	Return s
End Sub

'Sets the text color in the given range.
Public Sub Color (clr As Int, Start As Int, EndIndex As Int) As RichString
	Return AddAttribute("NSColor", s.ColorToUIColor(clr), Start, EndIndex)
End Sub
'Sets the background color in the given range.
Public Sub BackgroundColor (clr As Int, Start As Int, EndIndex As Int) As RichString
	Return AddAttribute("NSBackgroundColor", s.ColorToUIColor(clr), Start, EndIndex)
End Sub
'Adds or removes a strikethrough effect in the given range.
Public Sub Strikethrough(Visible As Boolean, Start As Int, EndIndex As Int) As RichString
	Return AddAttribute("NSStrikethrough", Visible, Start, EndIndex)
End Sub
'Adds or removes an underline effect with the specified color in te given range.
Public Sub Underline(Visible As Boolean, Clr As Int, Start As Int, EndIndex As Int) As RichString
	AddAttribute("NSUnderline", Visible, Start, EndIndex)
	Return AddAttribute("NSUnderlineColor", s.ColorToUIColor(Clr), Start, EndIndex)
End Sub
'Sets the font used in the given range.
'Note that if the Label was added with the designer then the font size will be reset
'when AutoScaleAll is applied. This means that you need to set it again in Page_Resize event.
Public Sub SetFont(fnt As Font, Start As Int, EndIndex As Int) As RichString
	Return AddAttribute("NSFont", fnt, Start, EndIndex)
End Sub
'Sets the attributed string to the label.
Public Sub SetToLabel(lbl As Label)
	Dim no As NativeObject = lbl
	no.SetField("attributedText", s)
End Sub
'Returns the text.
Public Sub getText As String
	Return t
End Sub

Public Sub setText(text As String)
	s = s.Initialize("NSMutableAttributedString").RunMethod("alloc", Null) _
		.RunMethod("initWithString:", Array(text))
	t = text
End Sub

Private Sub AddAttribute(attr As String, value As Object, Start As Int, EndIndex As Int) As RichString
	s.RunMethod("addAttribute:value:range:", Array(attr, value, _
		s.MakeRange(Start, EndIndex - Start)))
	Return Me
End Sub