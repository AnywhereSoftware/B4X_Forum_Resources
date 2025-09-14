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


	'************************************NOTES**************************************
	'*******************************************************************************
	'***********         FROM  rTone library by Johan Schoeman         *************
	'*******************************************************************************
	'*******************************************************************************
	
	'/**
	'*Frequency = 30
	'*/
	Dim NOTE_B0 As ULong =  31
	'/**
	'*Frequency = 33
	'*/
	Dim NOTE_C1 As ULong =  33
	'/**
	'*Frequency = 35
	'*/
	Dim NOTE_CS1 As ULong = 35
	'/**
	'*Frequency = 37
	'*/
	Dim NOTE_D1 As ULong =  37
	'/**
	'*Frequency = 39
	'*/
	Dim NOTE_DS1 As ULong = 39
	'/**
	'*Frequency = 41
	'*/
	Dim NOTE_E1 As ULong =  41
	'/**
	'*Frequency = 44
	'*/
	Dim NOTE_F1 As ULong =  44
	'/**
	'*Frequency = 46
	'*/
	Dim NOTE_FS1 As ULong = 46
	'/**
	'*Frequency = 49
	'*/
	Dim NOTE_G1 As ULong =  49
	'/**
	'*Frequency = 52
	'*/
	Dim NOTE_GS1 As ULong = 52
	'/**
	'*Frequency = 55
	'*/
	Dim NOTE_A1 As ULong =  55
	'/**
	'*Frequency = 58
	'*/
	Dim NOTE_AS1 As ULong = 58
	'/**
	'*Frequency = 62
	'*/
	Dim NOTE_B1 As ULong =  62
	'/**
	'*Frequency = 65
	'*/
	Dim NOTE_C2 As ULong =  65
	'/**
	'*Frequency = 69
	'*/
	Dim NOTE_CS2 As ULong = 69
	'/**
	'*Frequency = 73
	'*/
	Dim NOTE_D2 As ULong =  73
	'/**
	'*Frequency = 78
	'*/
	Dim NOTE_DS2 As ULong = 78
	'/**
	'*Frequency = 82
	'*/
	Dim NOTE_E2 As ULong =  82
	'/**
	'*Frequency = 87
	'*/
	Dim NOTE_F2 As ULong =  87
	'/**
	'*Frequency = 93
	'*/
	Dim NOTE_FS2 As ULong = 93
	'/**
	'*Frequency = 98
	'*/
	Dim NOTE_G2 As ULong =  98
	'/**
	'*Frequency = 104
	'*/
	Dim NOTE_GS2 As ULong = 104
	'/**
	'*Frequency = 110
	'*/
	Dim NOTE_A2 As ULong =  110
	'/**
	'*Frequency = 117
	'*/
	Dim NOTE_AS2 As ULong = 117
	'/**
	'*Frequency = 123
	'*/
	Dim NOTE_B2 As ULong =  123
	'/**
	'*Frequency = 131
	'*/
	Dim NOTE_C3 As ULong =  131
	'/**
	'*Frequency = 139
	'*/
	Dim NOTE_CS3 As ULong = 139
	'/**
	'*Frequency = 147
	'*/
	Dim NOTE_D3 As ULong =  147
	'/**
	'*Frequency = 156
	'*/
	Dim NOTE_DS3 As ULong = 156
	'/**
	'*Frequency = 165
	'*/
	Dim NOTE_E3 As ULong =  165
	'/**
	'*Frequency = 175
	'*/
	Dim NOTE_F3 As ULong =  175
	'/**
	'*Frequency = 185
	'*/
	Dim NOTE_FS3 As ULong = 185
	'/**
	'*Frequency = 196
	'*/
	Dim NOTE_G3 As ULong =  196
	'/**
	'*Frequency = 208
	'*/
	Dim NOTE_GS3 As ULong = 208
	'/**
	'*Frequency = 220
	'*/
	Dim NOTE_A3 As ULong =  220
	'/**
	'*Frequency = 233
	'*/
	Dim NOTE_AS3 As ULong = 233
	'/**
	'*Frequency = 247
	'*/
	Dim NOTE_B3 As ULong =  247
	'/**
	'*Frequency = 262
	'*/
	Dim NOTE_C4 As ULong =  262
	'/**
	'*Frequency = 277
	'*/
	Dim NOTE_CS4 As ULong = 277
	'/**
	'*Frequency = 294
	'*/
	Dim NOTE_D4 As ULong =  294
	'/**
	'*Frequency = 311
	'*/
	Dim NOTE_DS4 As ULong = 311
	'/**
	'*Frequency = 330
	'*/
	Dim NOTE_E4 As ULong =  330
	'/**
	'*Frequency = 349
	'*/
	Dim NOTE_F4 As ULong =  349
	'/**
	'*Frequency = 370
	'*/
	Dim NOTE_FS4 As ULong = 370
	'/**
	'*Frequency = 392
	'*/
	Dim NOTE_G4 As ULong =  392
	'/**
	'*Frequency = 415
	'*/
	Dim NOTE_GS4 As ULong = 415
	'/**
	'*Frequency = 440
	'*/
	Dim NOTE_A4 As ULong =  440
	'/**
	'*Frequency = 466
	'*/
	Dim NOTE_AS4 As ULong = 466
	'/**
	'*Frequency = 494
	'*/
	Dim NOTE_B4 As ULong =  494
	'/**
	'*Frequency = 523
	'*/
	Dim NOTE_C5 As ULong =  523
	'/**
	'*Frequency = 554
	'*/
	Dim NOTE_CS5 As ULong = 554
	'/**
	'*Frequency = 587
	'*/
	Dim NOTE_D5 As ULong =  587
	'/**
	'*Frequency = 622
	'*/
	Dim NOTE_DS5 As ULong = 622
	'/**
	'*Frequency = 659
	'*/
	Dim NOTE_E5 As ULong =  659
	'/**
	'*Frequency = 698
	'*/
	Dim NOTE_F5 As ULong =  698
	'/**
	'*Frequency = 740
	'*/
	Dim NOTE_FS5 As ULong = 740
	'/**
	'*Frequency = 784
	'*/
	Dim NOTE_G5 As ULong =  784
	'/**
	'*Frequency = 831
	'*/
	Dim NOTE_GS5 As ULong = 831
	'/**
	'*Frequency = 880
	'*/
	Dim NOTE_A5 As ULong =  880
	'/**
	'*Frequency = 932
	'*/
	Dim NOTE_AS5 As ULong = 932
	'/**
	'*Frequency = 988
	'*/
	Dim NOTE_B5 As ULong =  988
	'/**
	'*Frequency = 1047
	'*/
	Dim NOTE_C6 As ULong =  1047
	'/**
	'*Frequency = 1109
	'*/
	Dim NOTE_CS6 As ULong = 1109
	'/**
	'*Frequency = 1175
	'*/
	Dim NOTE_D6 As ULong =  1175
	'/**
	'*Frequency = 1245
	'*/
	Dim NOTE_DS6 As ULong = 1245
	'/**
	'*Frequency = 1319
	'*/
	Dim NOTE_E6 As ULong =  1319
	'/**
	'*Frequency = 1397
	'*/
	Dim NOTE_F6 As ULong =  1397
	'/**
	'*Frequency = 1480
	'*/
	Dim NOTE_FS6 As ULong = 1480
	'/**
	'*Frequency = 1568
	'*/
	Dim NOTE_G6 As ULong =  1568
	'/**
	'*Frequency = 1661
	'*/
	Dim NOTE_GS6 As ULong = 1661
	'/**
	'*Frequency = 1760
	'*/
	Dim NOTE_A6 As ULong =  1760
	'/**
	'*Frequency = 1865
	'*/
	Dim NOTE_AS6 As ULong = 1865
	'/**
	'*Frequency = 1976
	'*/
	Dim NOTE_B6 As ULong =  1976
	'/**
	'*Frequency = 2093
	'*/
	Dim NOTE_C7 As ULong =  2093
	'/**
	'*Frequency = 2217
	'*/
	Dim NOTE_CS7 As ULong = 2217
	'/**
	'*Frequency = 2349
	'*/
	Dim NOTE_D7 As ULong =  2349
	'/**
	'*Frequency = 2489
	'*/
	Dim NOTE_DS7 As ULong = 2489
	'/**
	'*Frequency = 2637
	'*/
	Dim NOTE_E7 As ULong =  2637
	'/**
	'*Frequency = 2794
	'*/
	Dim NOTE_F7 As ULong =  2794
	'/**
	'*Frequency = 2960
	'*/
	Dim NOTE_FS7 As ULong = 2960
	'/**
	'*Frequency = 3136
	'*/
	Dim NOTE_G7 As ULong =  3136
	'/**
	'*Frequency = 3322
	'*/
	Dim NOTE_GS7 As ULong = 3322
	'/**
	'*Frequency = 3520
	'*/
	Dim NOTE_A7 As ULong =  3520
	'/**
	'*Frequency = 3729
	'*/
	Dim NOTE_AS7 As ULong = 3729
	'/**
	'*Frequency = 3951
	'*/
	Dim NOTE_B7 As ULong =  3951
	'/**
	'*Frequency = 4186
	'*/
	Dim NOTE_C8 As ULong =  4186
	'/**
	'*Frequency = 4435
	'*/
	Dim NOTE_CS8 As ULong = 4435
	'/**
	'*Frequency = 4699
	'*/
	Dim NOTE_D8 As ULong =  4699
	'/**
	'*Frequency = 4978
	'*/
	Dim NOTE_DS8 As ULong = 4978
End Sub

Sub Play(P As Pin, Frequency As ULong, Duration As ULong)
	freq = Frequency
	dur = Duration
	RunNative("playtone", P.PinNumber)
	Delay(Duration)
End Sub

#if C
void playtone (B4R::Object* o) {
   tone(o->toULong(), b4r_esp8266tone::_freq, b4r_esp8266tone::_dur);
}
#End if