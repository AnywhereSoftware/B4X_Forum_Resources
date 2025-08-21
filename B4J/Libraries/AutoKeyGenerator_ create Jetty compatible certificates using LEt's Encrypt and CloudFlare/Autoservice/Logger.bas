B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
Sub Class_Globals
	Private pFileName As String
	Private pOutputStream As OutputStream
	Private pFileDate As String
	Private pLock As Lock
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (aFileName As String)
	pFileName = aFileName

	pFileDate = ""
	pOutputStream = Null

	pLock.Initialize(False)
End Sub

public Sub Write (msg As String)
	pLock.Wait
	Try
		Log (msg)
		Dim currentDate As String = GetCurrentDate
		If currentDate <> pFileDate Then
			If (pOutputStream.IsInitialized) And (pOutputStream <> Null) Then Close
			pFileDate = currentDate
			pOutputStream  = File.OpenOutput(File.GetFileParent(pFileName), File.GetName(pFileName).Replace("%", pFileDate), True)
		End If
	
		Dim logString As String = "[" & GetCurrentTime & "]: " & msg & Chr(13) & Chr(10)
		Dim logBytes() As Byte = logString.GetBytes("UTF8")

		pOutputStream.WriteBytes(logBytes, 0, logBytes.Length)
		pOutputStream.Flush
		pLock.Unlock
	Catch
		pLock.Unlock
	End Try
End Sub

public Sub Close
	pLock.Wait
	Try
		pOutputStream.Flush
		pOutputStream.Close
		pLock.Unlock
	Catch
		pLock.Unlock
	End Try
End Sub

private Sub GetCurrentDate As String
	DateTime.DateFormat = "yyyyddMM"
	Return DateTime.Date (DateTime.Now)
End Sub

private Sub GetCurrentTime As String
	DateTime.TimeFormat = "HH:mm:ss"
	Return DateTime.Time(DateTime.Now)
End Sub