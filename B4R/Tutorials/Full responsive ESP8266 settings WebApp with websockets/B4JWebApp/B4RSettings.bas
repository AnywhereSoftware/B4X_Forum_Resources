B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.18
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private ws As WebSocket
	
	'these variables will be set automatically.
	Private switch1 As JQueryElement
	Private switch2 As JQueryElement
	Private switch3 As JQueryElement
	Private hidsw1 As JQueryElement
	Private hidsw2 As JQueryElement
	Private hidsw3 As JQueryElement
	
	Private txtdate As JQueryElement
	Private txttime As JQueryElement
	
	Private txtusername As JQueryElement 'matches an element with id = "txtnumber"
	Private txtpassword As JQueryElement
	Private btnkeep As JQueryElement
	Private btnsave As JQueryElement
	
	Private hidloc As JQueryElement
	
	Private sID As String
End Sub

Public Sub Initialize
	
End Sub

Private Sub WebSocket_Connected (WebSocket1 As WebSocket)
	ws = WebSocket1
	
	sID = hidloc.GetVal.Value
	sID = sID.SubString(sID.IndexOf("id=") + 3)
	
	Log(sID)
End Sub

Private Sub WebSocket_Disconnected
	
End Sub


Sub btnsave_Click (Params As Map)
	
	Log(txtusername.GetVal.Value)
	Log(txtpassword.GetVal.Value)

	Dim m As Map
	m.Initialize
	m.Put("usr", txtusername.GetVal.Value)
	m.Put("pass", txtpassword.GetVal.Value)
	m.Put("action", "btnsave")
	
	Dim jg As JSONGenerator
	jg.Initialize(m)
	
	Main.mqtt.Publish(sID, jg.ToString.GetBytes("utf8"))
	
End Sub

Sub btnkeep_Click (Params As Map)
		
	Log(txtdate.GetVal.Value)
	Log(txttime.GetVal.Value)

	Dim m As Map
	m.Initialize
	m.Put("dat", txtdate.GetVal.Value)
	m.Put("tim", txttime.GetVal.Value)
	m.Put("action", "btnkeep")
	
	Dim jg As JSONGenerator
	jg.Initialize(m)
	
	Main.mqtt.Publish(sID, jg.ToString.GetBytes("utf8"))
	
End Sub


Sub btnswitches_Click (Params As Map)
	
	Log(hidsw1.GetVal.Value)
	Log(hidsw2.GetVal.Value)
	Log(hidsw3.GetVal.Value)
	
	Dim m As Map
	m.Initialize
	m.Put("sw1", hidsw1.GetVal.Value)
	m.Put("sw2", hidsw2.GetVal.Value)
	m.Put("sw3", hidsw3.GetVal.Value)
	m.Put("action", "btnswitches")
	
	Dim jg As JSONGenerator
	jg.Initialize(m)
	
	Main.mqtt.Publish(sID, jg.ToString.GetBytes("utf8"))
End Sub



