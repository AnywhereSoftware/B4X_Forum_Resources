B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3.5
@EndOfDesignText@


Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'Public variables can be accessed from all modules.
	
End Sub


Public Sub SetAnalogReadResolution(BitDepth As ULong)
	RunNative("sarr", BitDepth)
End Sub

Public Sub SetAnalogWriteResolution(BitDepth As ULong)
	RunNative("sawr", BitDepth)
End Sub

#if C
void sarr (B4R::Object* o) {
   analogReadResolution(o->toULong());
}

void sawr (B4R::Object* o) {
   analogWriteResolution(o->toULong());
}
#End if