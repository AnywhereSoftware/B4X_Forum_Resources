B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
#Region Code Module Info
' File:		WiFiMod.bas
' Brief:	WiFi methods.
' Notes:	There is a 15 seconds timeout in the synchronous Connect methods. This is implemented in the library code (rESP8266WiFi.cpp - line 33 - 41)
' 			There is no similar timeout in the async method. It simply polls the connection state.
#End Region

'These global variables will be declared once when the application starts.
'Public variables can be accessed from all modules.
Private Sub Process_Globals
	' WiFi
	Private SSID As String		= "****"
	Private PASSWORD As String	= "****"

	Public WiFi As ESP8266WiFi

	'HA server IP & port
	Public HA_URL As String 			= "http://NNN.NNN.NNN.NNN:1880/endpoint/solarinfo?data=all"
	
	' Public vars
	Public Connected As Boolean	= False
	Public Client As WiFiSocket
End Sub

' Connect to the WiFi network
' Return Boolean
' Retval True connected
' Retval False connection failed
Public Sub Connect As Boolean
	If WiFi.Connect2(SSID, PASSWORD) Then
		Log("[WiFiMod.Connect][I] OK, ip=", WiFi.LocalIp)
		Return True
	Else
		Log("[WiFiMod.Connect][E] Can not connect to the network.")
		Return False
	End If
End Sub
