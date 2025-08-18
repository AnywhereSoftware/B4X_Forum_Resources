B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private MainDiv As JQueryElement
	Private plog As JQueryElement
	Private buttonsText As Map
End Sub

Public Sub Initialize
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	buttonsText.Initialize
	Dim base As String = File.ReadString(File.DirAssets, "Dynamic.html")
	Dim sb As StringBuilder
	sb.Initialize
	For y = 0 To 9
		For x = 0 To 9
			Dim id As String = "btn" & (y * 10 + x)
			buttonsText.Put(id, 0)
			sb.Append(WebUtils.ReplaceMap(base, _
				CreateMap("ID": id, _
					"LEFT": x * 50, _
					"TOP": y * 50, _
					"TEXT": "0")))
		Next
	Next
	MainDiv.SetHtml(sb.ToString)
End Sub

Sub MainDiv_Click (Params As Map)
	'find the target element
	Dim target As String = Params.Get("target")
	If target.StartsWith("btn") Then
		plog.SetHtml(WebUtils.ReplaceMap("Button <i>$TARGET$</i> was clicked", CreateMap("TARGET": target)))
		Dim btn As JQueryElement = ws.GetElementById(target)
		'get the current value from the map.
		Dim counter As Int = buttonsText.Get(target) + 1
		btn.SetText(counter)
		buttonsText.Put(target, counter)
		btn.SetCSS("background-color", RandomCSSColor)
	End If
End Sub

Sub RandomCSSColor As String
	Return WebUtils.ReplaceMap("rgb($R$, $G$, $B$)", _
		CreateMap("R": Rnd(0, 256), "G": Rnd(0, 256), "B": Rnd(0, 256)))
End Sub

Private Sub WebSocket_Disconnected

End Sub