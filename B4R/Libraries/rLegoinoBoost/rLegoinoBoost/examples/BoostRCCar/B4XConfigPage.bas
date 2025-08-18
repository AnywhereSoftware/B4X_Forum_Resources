B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.1
@EndOfDesignText@
' Class: B4XConfigPage
' See list of page related events in the B4XPagesManager object. The event name is B4XPage.
Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI 'ignore
	Private tfBridgeIP As B4XView
	Private tfBridgePort As B4XView
	Private btnBridgeSettingsOK As B4XView
	Private tfHUBCommand As B4XView
	Private tfHUBPort As B4XView
	Private tfHUBValue As B4XView
	Private btnHUBSendCommand As B4XView
	' B4XPages accessed
	Private Mainpage As B4XMainPage
	' Helper
	Private bc As ByteConverter
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	' Get the mainpage to access methods
	Mainpage = B4XPages.GetPage(Constants.MAINPAGE_ID)
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	' Load the layout to Root
	Root.LoadLayout("ConfigPage")
	' Add some defaults in the editible fields
	tfBridgeIP.Text		= Constants.WIFI_DEFAULT_IP
	tfBridgePort.Text	= Constants.WIFI_DEFAULT_PORT
	tfHUBPort.Text		= 0
	tfHUBValue.Text		= 20
End Sub

' Update the mainpage socket IP and PORT
Private Sub btnBridgeSettingsOK_Click
	Mainpage.socketIP = tfBridgeIP.Text
	Mainpage.socketPORT = tfBridgePort.Text
End Sub

Private Sub btnHUBSendCommand_Click
	' Check if the cmd is given in HEX = convert to DEC
	Mainpage.Write_Set_Command3( _ 
		HEXPrefixToDEC(tfHUBCommand.Text), _ 
		HEXPrefixToDEC(tfHUBPort.Text), _ 
		tfHUBValue.Text)
End Sub

Private Sub tfHUBValue_Action
	btnHUBSendCommand_Click
End Sub

' HELPER
Private Sub HEXPrefixToDEC(HEXString As String) As String
	HEXString = HEXString.ToUpperCase
	If HEXString.StartsWith("0X") Then
		HEXString = HEXString.Replace("0X", "")
		HEXString = bc.HexToBytes(HEXString)(0)
	End If
	Return HEXString
End Sub