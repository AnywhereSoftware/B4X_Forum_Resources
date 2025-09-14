B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.9
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	Dim bc As ByteConverter
End Sub


Sub BP(WhatToLog As String)
	If WhatToLog <> Null Then
		Log(WhatToLog)
	End If
	
	RunNative("localloop", Null)
	
End Sub

Sub BP2(WhatToLog() As String)
	If WhatToLog.Length <> 0 Then
		
		Dim sLogMessage As String = ""
		'Dim b() As Byte
		For ii= 0 To WhatToLog.Length - 1
			If WhatToLog(ii) <> Null Then
				Dim sCurrentWord As String = WhatToLog(ii)
				sLogMessage  = JoinStrings(Array As String(sLogMessage, sCurrentWord))
				
				'Log(sCurrentWord)
			End If	
		Next
		
		Log(sLogMessage)
	End If
	
	
	
	
	RunNative("localloop", Null)
	
End Sub


#if C
void localloop (B4R::Object* o) {
  // reply only when you receive data:
  while (Serial.available() == 0) {
    // read the incoming byte:
    
    // say what you got:
  }
  if (Serial.available()>0){
        int incomingByte = 0; // for incoming serial data
        incomingByte = Serial.read();
        while (Serial.available()){
          char t= Serial.read();
        }
      }
}
#End If