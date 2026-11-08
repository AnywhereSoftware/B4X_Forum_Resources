B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
'PID Session.
'Author of the source: @T201016

Sub Class_Globals
	Private ByPID As List
	Private jo As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	ByPID.Initialize
End Sub

'Save the added PID to the list.
Public Sub SaveByPID2WriteList(lstPathname As String, lstFilename As String) As ResumableSub
	Try
		jo.InitializeStatic("java.lang.management.ManagementFactory")
		Dim PID As String = jo.RunMethodJO("getRuntimeMXBean",Null).RunMethod("getName",Null)
		PID = PID.SubString2(0,PID.IndexOf("@"))
	
		ByPID.Add(PID)
		File.WriteList(lstPathname, lstFilename, ByPID)
	Catch
		Return False
	End Try
	Return True
End Sub

'Kill Process By PID.
Public Sub KillByPID(MePID As String) As ResumableSub
	Try
		jo = Me
		jo.RunMethod("killProcessByPID", Array As Object(MePID)) ' Kill process by PID.
	Catch
		Return False
	End Try
	Return True
End Sub

'Kill process by PID  from the saved list on the disk.
'NOTE! The content list file will be deleted.
Public Sub KillByPIDFromListFile(lstPathname As String, lstFilename As String) As ResumableSub
	Try
		If File.Exists(lstPathname, lstFilename) Then
			ByPID = File.ReadList(lstPathname, lstFilename)
	
			If ByPID.IsInitialized And ByPID.Size > 0 Then
				For i = 0 To ByPID.Size -1
					If ByPID.Get(i).As(String).Length > 0 Then
						jo = Me
						jo.RunMethod("killProcessByPID", Array As Object(ByPID.Get(i))) ' Kill process by PID(s).
					End If
				Next
			Else
				Return False
			End If
		Else
			Return False
		End If
	Catch
		Return False
	End Try
	Return True
End Sub

#If java
import java.io.IOException;

	public static boolean killProcessByPID(String pid)
    {
        String cmd = "taskkill /F /PID " + pid;
        try {
            Runtime.getRuntime().exec(cmd);
            return true;
        } catch (IOException ex) {
            System.err.println("Failed to kill PID: " + pid);
            System.err.println(ex.getMessage());
            return false;
        }
    }
#End If
