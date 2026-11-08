B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'Settings
'Global settings including credentials.
'Ensure ti dfine as Public.

Sub Process_Globals
	Public PAGEHEADING As String = "SOLAR INFO PANEL"

	Public NETWORK_SSID As String		= "****"
	Public NETWORK_PASSWORD As String	= "****"

	Public MQTT_USERNAME As String		= "****"
	Public MQTT_PASSWORD As String		= "****"

	Public MQTT_IP() As Byte 			= Array As Byte(192, 168, 1, 23)
'	Public MQTT_IP() As Byte 			= Array As Byte(NNN, NNN, NNN, NNN)
	Public MQTT_PORT As Int 			= 1883
	Public MQTT_CLIENT_ID As String		= "SIP"	'sip = Solar Info Panel"

	Public MQTT_TOPIC_HOMEASSISTANT As String = "homeassistant/sensor/#"
	
	Public MSG_WAITING As String = "Waiting for data..."
	
End Sub