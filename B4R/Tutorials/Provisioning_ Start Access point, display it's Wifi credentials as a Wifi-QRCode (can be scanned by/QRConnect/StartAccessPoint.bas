B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Private AP As ESP8266WiFi
	Public APWiFiPassword(8) As Byte
	Public APNameAdd(8) As Byte
	Private bc As ByteConverter

End Sub


Public Sub StartAP

	For i=0 To 7
		APWiFiPassword(i)=Rnd(97,123) 'some random lowercase chars
	Next
		
	Log(APWiFiPassword)
	For i=0 To 7
		APNameAdd(i)=Rnd(97,123)'some random lowercase chars
	Next
	Log(APNameAdd)
	
	Dim APName As String=JoinStrings(Array As String("ESP32",bc.StringFromBytes(APNameAdd)))
	AP.StartAccessPoint2(APName,bc.StringFromBytes(APWiFiPassword))
	Display.DrawTextAt("AP-Name: ",2,5,200)
	Display.DrawTextAt(APName,2,120,200)
	Display.DrawTextAt("Wifi-Passwort: ",2,5,220)
	Display.DrawTextAt(bc.StringFromBytes(APWiFiPassword),2,120,220)
	Display.DrawTextAt("My IP: ",2,5,240)
	Display.DrawTextAt(AP.AccessPointIp,2,120,240)
			
	
End Sub



