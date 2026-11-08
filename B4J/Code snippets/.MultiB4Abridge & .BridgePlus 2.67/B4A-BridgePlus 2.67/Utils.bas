B4A=true
Group=Bridge
ModulesStructureVersion=1
Type=StaticCode
Version=7.3
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Private bc As ByteConverter
End Sub

Public Sub AddCommandToBytes(Command As Byte, Buffer() As Byte, Length As Int) As Byte()
	Dim B(Length + 1) As Byte
	B(0) = Command
	bc.ArrayCopy(Buffer, 0, B, 1, Length)
	Return B
End Sub
