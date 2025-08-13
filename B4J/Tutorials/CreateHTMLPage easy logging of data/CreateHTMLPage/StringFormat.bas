B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Library created from project : CreateHTMLPage
'Format one or more strings format(String format, Object... args)
'Documentation: <link>DZone|https://dzone.com/articles/java-string-format-examples</link> / <link>Formatter|https://docs.oracle.com/javase/8/docs/api/java/util/Formatter.html</link>
'<code>StringFormat.FormatString("%x",Array(14))</code> / <code>FormatString("%X,%X",Array(14,15))</code>
'<code>Dim arr() As Object = Array(10,11,12,13,14,15)
'Dim FMT As String = StringFormat.RepeatString("0x%X"," , ",arr.Length - 1)
'Log(StringFormat.FormatString(FMT,arr))</code>
Public Sub FormatString(Format As String, args As Object) As String
	Dim Args1(1) As Object
	If GetType(args) = "[Ljava.lang.Object;" Then
		Args1 = args
	Else
		Args1(0) = args
	End If
	Return Format.As(JavaObject).RunMethod("format",Array(Format,Args1))
End Sub

'Returns a string of n copies of str, separated by seperator
Public Sub RepeatString(Str As String, Separator As String, Count As Int) As String
	Dim SB As StringBuilder
	SB.Initialize
	For i = 0 To Count - 1
		SB.Append(Separator)
		SB.Append(Str)
	Next
	Return SB.ToString.SubString(Separator.Length)
End Sub