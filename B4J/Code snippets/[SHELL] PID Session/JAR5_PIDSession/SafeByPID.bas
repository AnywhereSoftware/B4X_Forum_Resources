B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'PID Session.
'Author of the source: @T201016

Sub Class_Globals

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Public Sub Delete(fPath As String,fName As String) As ResumableSub
	Try
		If File.Exists(fPath, fName) Then
			Private raf As RandomAccessFile
			Dim sr As SecureRandom

			raf.Initialize(fPath,fName, False)

			Dim aesKey(64) As Byte '64 bytes = 4x128 bits
			Dim total As Long
			Do While (raf.CurrentPosition < raf.Size)
				Sleep(10)
				total = raf.Size

				sr.SetRandomSeed(total)
				sr.GetRandomBytes(aesKey)
				raf.WriteObject(aesKey, False, raf.CurrentPosition)
			Loop

			raf.Flush
			raf.Close
			File.Delete(fPath,fName)
		End If
		Return True
	Catch
		Return False
	End Try
End Sub

