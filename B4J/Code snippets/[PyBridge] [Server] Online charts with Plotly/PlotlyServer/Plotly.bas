B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'WebSocket class
Sub Class_Globals
	Private ws As WebSocket
	Private BtnTreemap As JQueryElement
	Private Result As JQueryElement
	Private ValidTargets As B4XSet
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	ValidTargets = B4XCollections.CreateSet2(Array("treemap", "icicle", "sunburst", "scatter"))
End Sub

Private Sub Btn_Click (Params As Map)
	Dim req As GraphRequest
	req.Initialize
	req.GraphType = Params.Get("target")
	If ValidTargets.Contains(req.GraphType) = False Then Return
	req.Callback = Me
	Result.SetHtml("Creating graph...")
	CallSubDelayed2(Main.PyWorker, "Show_Graph", req)
	Wait For Graph_Response (Html As String)
	Result.SetHtml(Html)
	ws.Flush
End Sub

Private Sub WebSocket_Disconnected

End Sub