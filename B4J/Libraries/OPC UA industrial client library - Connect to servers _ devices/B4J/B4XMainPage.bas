B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

'Public OPC UA test servers:
'https://github.com/node-opcua/node-opcua/wiki/publicly-available-OPC-UA-Servers-and-Clients

'netstat -ano | find "4840"

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI

	Private Opc As OPCUAClient

	Private Endpoint As String = "opc.tcp://localhost:4840/"
	'Private Endpoint As String = "opc.tcp://opcua.123mc.com:4840/"
	'Private Endpoint As String = "opc.tcp://opcua.machinetool.app:4840/"
	'Private Endpoint As String = "opc.tcp://opcua.demo-this.com:51210/UA/SampleServer/"
End Sub

Public Sub Initialize
	'B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.SetTitle(Me, "OPC UA - Client")

	Log("Starting OPC UA test harness")

	Opc.Initialize("OpcUa")
	Opc.FireOnlyOnChange = False
	Opc.SuppressDuplicateValues = True
End Sub

Private Sub BtnAppConnect_Click
	Log("Connecting to: " & Endpoint)

	'SELECT THE CONNECTION TYPE THAT YOU REQUIRE:
	Connect_NoAuth
	'Connect_Auth
	'Connect_Anonymous_With_Certificate
	'Connect_Auth_With_Certificate
	'Connect_AutoSecure_With_Certificate
End Sub

Private Sub BtnAppDisconnect_Click
	If Opc.IsConnected Then
		Log("Disconnecting")
		Opc.Disconnect
	End If
End Sub

Private Sub BtnBrowse_Click
	Opc.BrowseFull("ns=0;i=2268")
End Sub

Private Sub BtnRead_Click
	Opc.Read("ns=0;i=2258")
	Opc.Read("i=2255")
	Opc.Read("ns=2;s=MyInt")
	Opc.Read("ns=2;s=MyDouble")
	Opc.Read("ns=2;s=MyHex")
End Sub

Private Sub BtnReadMulti_Click
	Dim LstMR As List = Array As String ("ns=0;i=2258", "i=2255", "ns=2;s=MyInt", "ns=2;s=MyDouble", "ns=2;s=MyHex")
	Opc.ReadMultiple(LstMR)
End Sub

Private Sub BtnReadWrite_Click
	Opc.ReadWrite("ns=2;s=MyInt", 1395)
	Opc.ReadWrite("ns=2;s=MyDouble", 6.3)
End Sub

Private Sub BtnWrite_Click
	Opc.Write("ns=2;s=MyInt", 771)
	Opc.Write("ns=2;s=MyDouble", 123.45)
End Sub

Private Sub BtnWriteMulti_Click
	Dim Ids As List
		Ids.Initialize
		Ids.Add("ns=2;s=MyInt")
		Ids.Add("ns=2;s=MyDouble")
		Ids.Add("ns=2;s=MyBoolean")

	Dim Vals As List
		Vals.Initialize
		Vals.Add(1395)
		Vals.Add(6.3)
		Vals.Add(False)

	Opc.WriteMultiple(Ids, Vals)
End Sub

Private Sub BtnSubscribe_Click
'	Log("Subs: " & Opc.ListSubscriptions)
'	Log("Items: " & Opc.ListMonitoredItems("ns=0;i=2258")) 'Server status, current time...

	Opc.Subscribe("ns=0;i=2258", 1000) 'Server status, current time...
	Log("After Subscribe: " & Opc.DebugDump)

'	Log("Subs: " & Opc.ListSubscriptions)
'	Log("Items: " & Opc.ListMonitoredItems("ns=0;i=2258")) 'Server status, current time...
End Sub

Private Sub BtnSubscribeOnce_Click
	Opc.SubscribeOnce("ns=0;i=2258", 1000) 'Server status, current time...
	Log("After SubscribeOnce: " & Opc.DebugDump)
End Sub

Private Sub BtnHasSubscription_Click
	Dim Exists As Boolean = Opc.HasSubscription("ns=0;i=2258") 'Server status, current time...
	Log("HasSubscription: " & Exists)
End Sub

Private Sub BtnHasMonitoredItem_Click
	Dim Exists As Boolean = Opc.HasMonitoredItem("ns=0;i=2258") 'Server status, current time...
	Log("HasMonitoredItem: " & Exists)
End Sub

Private Sub BtnUnsubscribe_Click
	Opc.UnSubscribe("ns=0;i=2258") 'Server status, current time...
	Log("After UnSubscribe: " & Opc.DebugDump)
End Sub

Private Sub BtnUnsubscribeAll_Click
	Opc.UnsubscribeAll
	Log("After UnSubscribe All: " & Opc.DebugDump)
End Sub

Private Sub BtnWriteAndVerify_Click
	Opc.WriteAndVerify("ns=2;s=MyDouble", 123.45)
End Sub

Private Sub BtnDebugDumpDetailed_Click
	Dim dump As Map = Opc.DebugDumpDetailed
	Log("DebugDumpDetailed: " & dump)
End Sub

Sub Connect_NoAuth
	Log(Endpoint)
	Opc.Connect(Endpoint)
End Sub

Sub Connect_Auth
	Dim Username As String = "operator" '""
	Dim Password As String = "op123" '""
	Dim Policy As String = "None" '"Basic256Sha256"
	Dim Mode As String = "None" '"SignAndEncrypt"

	Opc.ConnectAuth(Endpoint, Username, Password, Policy, Mode)
End Sub

Sub Connect_Anonymous_With_Certificate
	Dim p12 As String = File.Combine(File.DirApp, "clientcert.p12")
	Dim password As String = "1234"

	Opc.ConnectWithCertificate(Endpoint, p12, password)
End Sub

Sub Connect_Auth_With_Certificate
	Dim Username As String = "operator" '""
	Dim Password As String = "op123" '""
	Dim Policy As String = "Basic256Sha256" '"None"
	Dim Mode As String = "SignAndEncrypt" '"None"

	Dim p12 As String = File.Combine(File.DirApp, "clientcert.p12")
	Dim p12pass As String = "1234"

	Opc.ConnectAuthWithCertificate(Endpoint, Username, Password, Policy, Mode, p12, p12pass)
End Sub

Sub Connect_AutoSecure_With_Certificate
	Dim p12Path As String = File.Combine(File.DirApp, "clientcert.p12")
	Dim p12Password As String = "1234"

	Opc.ConnectAutoSecureWithCertificate(Endpoint, p12Path, p12Password)
End Sub

Sub OpcUa_Connected
	Log("Connected")
End Sub

Sub OpcUa_ConnectionError(Error As String)
	Log("ConnectionError: " & Error)
End Sub

Sub OpcUa_Disconnected
	Log("Disconnected")
End Sub

Sub OpcUa_BrowseResult(Nodes As List)
	Log("BrowseResult: " & Nodes.Size & " items")
	For Each n As Object In Nodes
		Log(n)
	Next
End Sub

Sub OpcUa_ReadResult(NodeId As String, Value As Object, Status As String)
	Log("ReadResult: " & NodeId & " Status: " & Status)

	If Value = Null Then Return

	Dim t As String = GetType(Value)
	Log("Type: " & t)

	If Value.As(String).Contains("Ljava.lang.String") Then 'Case 1: It is an string array
		Dim Arr() As Object = Value
		For i = 0 To Arr.Length - 1
			Log("Item " & i & ": " & Arr(i))
		Next
	Else If Value Is Map Then 'Case 2: It is a Map
		Dim m As Map = Value
		For Each k As String In m.Keys
			Log(k & " = " & m.Get(k))
		Next
	Else 'Case 3: Single value or custom object
		Log("Single value: " & Value)
	End If
End Sub

Sub OpcUa_ReadWriteResult(NodeId As String, OldValue As Object, NewValue As Object, Success As Boolean)
	Log("ReadWriteResult: " & NodeId & " old=" & OldValue & " new=" & NewValue & " success=" & Success)
End Sub

Sub OpcUa_WriteResult(NodeId As String, Success As Boolean)
	Log("WriteResult: " & NodeId & " success=" & Success)
End Sub

Sub OpcUa_SubscriptionValueChanged(NodeId As String, Value As Object, Timestamp As Long)
	Log("SubscriptionValueChanged: " & NodeId & " = " & Value & " @ " & Timestamp)
End Sub

Sub OpcUa_SubscribeOnceResult(NodeId As String, Success As Boolean)
	Log("SubscribeOnceResult: " & NodeId & " success=" & Success)
End Sub

Sub OpcUa_HasSubscriptionResult(NodeId As String, Exists As Boolean)
	Log("HasSubscriptionResult: " & NodeId & " exists=" & Exists)
End Sub

Sub OpcUa_HasMonitoredItemResult(NodeId As String, Exists As Boolean)
	Log("HasMonitoredItemResult: " & NodeId & " exists=" & Exists)
End Sub

Sub OpcUa_DebugDumpDetailedResult(Dump As Map)
	Log("DebugDumpDetailedResult: " & Dump)
End Sub

Sub OpcUa_WriteVerified(NodeId As String, Success As Boolean)
	Log("WriteVerified: " & NodeId & " success=" & Success)
End Sub
