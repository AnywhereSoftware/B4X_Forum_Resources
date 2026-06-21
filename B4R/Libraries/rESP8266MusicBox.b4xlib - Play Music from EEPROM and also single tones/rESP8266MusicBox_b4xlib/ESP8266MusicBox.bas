B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.31
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Private freq As ULong
	Private dur As ULong
	
	Private uiMusicNote(90) As ULong
		
End Sub

Sub Play(P As Pin, Frequency As ULong, Duration As ULong)
	freq = Frequency
	dur = Duration
	RunNative("playtone", P.PinNumber)
	Delay(Duration)
End Sub

Sub InitializeMusicBox
	uiMusicNote(47) = 440
	'Calculate lower notes
	For ii = 0 To 45
		uiMusicNote(46-ii) = Ceil(Power(2, (-1 - ii)/12) * 440)
	Next
	'Calculate upper notes
	For ii = 0 To 41
		uiMusicNote(48+ii) = Ceil(Power(2, (1 + ii)/12) * 440)
	Next
	Log("MusicBox Initialized")
End Sub

Sub CheckIfThereIsMusic(positionInEeprom As UInt) As Boolean
	Dim bLength(2) As Byte
	Dim eeprom As EEPROM
	Dim bc As ByteConverter
	bc.ArrayCopy(eeprom.ReadBytes(positionInEeprom, 2), bLength)
	Dim iLength As UInt
	iLength = bLength(0) * 255 + bLength(1)
	If iLength <> 0 Then 
		Return True
	Else
		Return False
	End If
End Sub

Sub PlayMusic(positionInEeprom As UInt, P As Pin)
	Dim bLength(2) As Byte
	Dim eeprom As EEPROM
	Dim bc As ByteConverter
	bc.ArrayCopy(eeprom.ReadBytes(positionInEeprom, 2), bLength)
	Dim iLength As UInt
	iLength = bLength(0) * 255 + bLength(1)
	Delay(0)
	PlayMusicFromByteArray(eeprom.ReadBytes(positionInEeprom + 2, iLength), P)
End Sub

Sub PlayMusicFromByteArray(bMusic() As Byte, P As Pin)
	For ii = 0 To bMusic.Length - 2 Step 2
		If bMusic(ii) = 0 Then
			Delay(40*bMusic(ii+1))
		Else
			Delay(0)
			Play(P, uiMusicNote(bMusic(ii)), bMusic(ii+1) * 40)
		End If
	Next
End Sub

#if C
void playtone (B4R::Object* o) {
   tone(o->toULong(), b4r_esp8266musicbox::_freq, b4r_esp8266musicbox::_dur);
}
#End if