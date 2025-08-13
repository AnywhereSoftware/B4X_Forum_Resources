B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4.81
@EndOfDesignText@
'Code module

Sub Process_Globals
	Private Logger_Host As String = "YOUR IP"
	Private Logger_Port As Int = 54323
	Private Logger_Socket As UDPSocket
	Private RootPanel As Panel
End Sub

Private Sub Widget_Start(RP As Panel)
	Logger_Socket.Initialize("",0,0)
	RootPanel = RP
End Sub

Sub Widget_Appear
	
End Sub

Sub Widget_DisplayModeChanged (Mode As Int, MaxWidth As Float, MaxHeight As Float)
	
End Sub

Sub Widget_PerformUpdate As Int
	Return WidgetContext.Result_NewData
End Sub

Private Sub RootPanel_Resize(Width As Int, Height As Int)
	
End Sub

Sub WLog(S As String)
	Log(S)
	Dim Logger_Packet As UDPPacket
	Logger_Packet.Initialize(S.GetBytes("UTF8"),Logger_Host,Logger_Port)
	Logger_Socket.Send(Logger_Packet)
End Sub
