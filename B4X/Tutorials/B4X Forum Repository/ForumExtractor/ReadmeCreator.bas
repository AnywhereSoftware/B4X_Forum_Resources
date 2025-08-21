B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Public Py As PyBridge
	Private BBCode As PyWrapper
	Private markdownify As PyWrapper
	Private BBCodeParser As PyWrapper
	
End Sub

Public Sub Initialize
End Sub

'This event will be called once, before the page becomes visible.
Public Sub Start As ResumableSub
	Py.Initialize(Me, "Py")
	Dim opt As PyOptions = Py.CreateOptions("D:/Python/python/python.exe")
	Py.Start(opt)
	Wait For Py_Connected (Success As Boolean)
	If Success = False Then
		LogError("Failed to start Python process.")
		Return False
	End If
	PrepareParser
	Return True
End Sub

Public Sub CreateReadme(Date As Long, Category As String, _
	Platform As String, Title As String, ThreadId As Int, Author As String, NodeId As Int, Message As String) As ResumableSub
	Dim sb As StringBuilder
	sb.Initialize
	sb.Append("### ").Append(Title).Append(" by ").Append(Author).Append(CRLF)
	sb.Append("### ").Append(DateTime.Date(Date)).Append(CRLF)
	sb.Append("[B4X Forum - ").Append(Platform).Append(" - ").Append(Category).Append($"](https://www.b4x.com/android/forum/threads/${ThreadId}/)"$).Append(CRLF).Append(CRLF)
	Wait For (BBCodeToMarkdown(Message)) Complete (Markdown As String)
	sb.Append(Markdown)
	Return sb.ToString
End Sub


Private Sub PrepareParser
	BBCode = Py.ImportModule("bbcode")
	markdownify = Py.ImportModuleFrom("markdownify", "markdownify")
	BBCodeParser = BBCode.Run("Parser")
	AddFormatters(BBCodeParser)
End Sub

Public Sub BBCodeToMarkdown (Text As String) As ResumableSub
	Dim html As PyWrapper = BBCodeParser.Run("format").Arg(Text)
	Dim md As PyWrapper = markdownify.Call.Arg(html).ArgNamed("heading_style", "ATX").ArgNamed("bullets", "-").ArgNamed("code_language", "B4X")
	Wait For (md.Fetch) Complete (md As PyWrapper)
	Return md.Value
End Sub

Private Sub AddFormatters (Parser As Object) As PyWrapper
	Py.RunNoArgsCode($"
from html import escape
def code_formatter(name, value, options, parent, context):
    return f"<pre><code>{value}</code></pre>"
def attach_formatter(name, value, options, parent, context):
	return f"<img src='https://www.b4x.com/android/forum/attachments/{value}'>"
def img_formatter(name, value, options, parent, context):
	return f"<img src='{value}'>"
"$)
	
	Dim Code As String = $"
def AddFormatters (parser):
	parser.add_formatter(
	'code',
	code_formatter,
	replace_links=False,
	swallow_trailing_newline=False,
	strip=False
	)
	parser.add_formatter(
	'attach',
	attach_formatter,
	replace_links=False,
	swallow_trailing_newline=False,
	strip=False
	)
	parser.add_formatter(
	'img',
	img_formatter,
	replace_links=False,
	swallow_trailing_newline=False,
	strip=False
	)
	return parser
"$
	Return Py.RunCode("AddFormatters", Array(Parser), Code)
End Sub

Private Sub Py_Disconnected
	Log("PyBridge disconnected")
End Sub