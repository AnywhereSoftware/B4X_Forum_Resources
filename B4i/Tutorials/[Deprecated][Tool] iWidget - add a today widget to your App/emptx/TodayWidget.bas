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
	
	Private Label1 As Label
End Sub

Private Sub Widget_Start(RP As Panel)
	Logger_Socket.Initialize("",0,0)
	RootPanel = RP
	
	WidgetContext.SetWidgetLargestAvailableDisplayMode(WidgetContext.Mode_Expanded)
	RootPanel.LoadLayout("1")
	DateTime.TimeFormat = "HH:mm"
	
	RootPanel.Color = Colors.Transparent
	Label1.Multiline = True
	
	WLog("START")
End Sub

Sub Widget_Appear
	WLog("APPEAR")
	UpdateContent
End Sub

Sub Widget_DisplayModeChanged (Mode As Int, MaxWidth As Float, MaxHeight As Float)
	WidgetContext.SetPreferredWidgetSize(MaxHeight,MaxWidth)
End Sub

Sub Widget_PerformUpdate As Int
	WLog("UPDATE")
	UpdateContent 'Our content is the time, so there is always new data
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

Sub UpdateContent
	Label1.Text = $"Hello world,${CRLF}it's ${DateTime.Time(DateTime.Now)}"$
End Sub
