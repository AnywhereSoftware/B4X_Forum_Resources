### [SOURCE]  MyProgressDialogShow + Shell + FileWatcher by T201016
### 09/22/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168743/)

Here is the refined source code,  
which will allow you to terminate the message, only after all the Shell processes launched in the loop.  
  
I relied on the example of the conversion of. Media to the .mp4 format (in the nested directory structure)  
using the included file: Script\_converting.cmd  
  

```B4X
Sub Process_Globals  
    Dim shl As Shell  
    Dim shl_Success  As Boolean  
    Private taRemixing As Label  
    Private kvs As KeyValueStore  
    Private teFolder = File.DirTemp, teFile = "KeyValueStore.dat" As String  
    Private const work As String = "H:\TMP"  
    Private const pswd As String = "……" 'Secure Password  
     
    Type MyType1 (Source As String, Target As String, Index As Int, isDirectory, IsWorkingDirectory, InWorkingDirectory As List)  
    Dim Dialog As MyType1  
     
    Dim fw As FileWatcher  
     
    …  
End Sub    
  
Sub AppStart (Form1 As Form, Args() As String)  
  
    fd.Initialize  
    fd.Title = "Choose a media source folder"  
    Dialog.Source = fd.Show(MainForm)  
     
    If Dialog.Source = "" Then  
        Return  
    Else  
        Dialog.Index = 0  
        Dialog.isDirectory.Initialize  
        Dialog.IsWorkingDirectory.Initialize  
        Dialog.InWorkingDirectory.Initialize  
        Dialog.InWorkingDirectory = File.ListFiles(Dialog.Source)  
     
        watchers.Initialize  
        isWatchingTerminated = False  
     
        If Not(File.Exists(teFolder,teFile)) Then  
            kvs.Initialize(teFolder,teFile)  
            kvs.PutEncrypted("target", work, pswd)  
            Dialog.Target = work  
        Else  
            kvs.Initialize(teFolder,teFile)  
            Dialog.Target = kvs.GetEncrypted("target", pswd)  
        End If  
     
        MyProgressDialogShow("Converts Media",$"The conversion process has started, ${CRLF}   please wait for the work to end."$)  
        Sleep(100)  
         
        shl_Success = True  
             
        Dialog.InWorkingDirectory = File.ListFiles(Dialog.Source)  
        Continue_Converts(Dialog.Source, Dialog.Target)  
    End If  
     
    …  
End Sub  
  
#Region Continue_Converts(s)  
Private Sub Continue_Converts (Source As String, Target As String)  
    Dim script As String = File.Combine(File.DirApp, "Script_converting.cmd")  
  
    Try  
        For Each f As String In Dialog.InWorkingDirectory  
         
            If File.IsDirectory(Source, f) Then  
                Dialog.isDirectory.Add(File.Combine(Source,f))  
                Dialog.IsWorkingDirectory.Add(File.Combine(Target,f))  
                File.MakeDir(Target, f) : Dialog.Target = File.Combine(Target, f)  
            Else  
                If isMedia(f) Then  
                    mp4 = isExistMedia(Dialog.Target & "\" & f.Replace(".media",".mp4"))  
                    media = Source & "\" & f  
  
                    Try  
                        start_cmd(script & " 3 " & media & " " & mp4) 'Windows command script (with command interpreter 'cmd.exe')  
                        …  
         
                        Dim n As Long = DateTime.Now + 1000  
                        Do Until DateTime.Now < n  
                            Sleep(100)  
                        Loop  
                    Catch  
                        shl_Success = False  
                        #If Debug  
                        Log(LastException.Message)  
                        #End If  
                    End Try  
                End If  
            End If  
        Next  
         
        Dialog.Index = Dialog.Index + 1 'goto next Directory.  
  
        If Dialog.isDirectory.Size > 0 And (Dialog.Index <= (Dialog.isDirectory.Size)) Then  
            Dialog.Source = Dialog.isDirectory.Get(Dialog.Index-1)  
            Dialog.Target = Dialog.IsWorkingDirectory.Get(Dialog.Index-1)  
            Dialog.InWorkingDirectory.Initialize  
            Dialog.InWorkingDirectory = File.ListFiles(Dialog.Source)  
         
            Continue_Converts(Dialog.Source, Dialog.Target)  
        Else  
            watchers.Initialize  
            For Each f As String In Dialog.IsWorkingDirectory  
                Dim fw As FileWatcher  
                fw.Initialize("fw").SetWatchList(Array As String(f)).StartWatching 'Initialize with the event name | Set the current dir to be watched | Start Watching  
                watchers.Add(fw)  
            Next  
        End if  
         
        Dialog.Initialize  
        Dialog.isDirectory.Initialize  
        Dialog.IsWorkingDirectory.Initialize  
        Dialog.InWorkingDirectory.Initialize  
         
    Catch  
        #If Debug  
            Log("Upss! something went wrong.")  
        #End If  
        Dialog.Initialize  
        Dialog.isDirectory.Initialize  
        Dialog.IsWorkingDirectory.Initialize  
        Dialog.InWorkingDirectory.Initialize  
    End Try  
End Sub  
#End Region  
  
  
Sub MyProgressDialogShow(title As String, text As String)  
    Dim w As Int = (MainForm.Width/100) * 70  
    Dim h As Int = 150  
    Dim p As B4XView = xi.CreatePanel("")  
    p.SetLayoutAnimated(0, 0, 0, w, h)  
    p.LoadLayout("ProgressDialogShow")  
    lblTitle.Text = title  
    lblText.Text = text  
    lblText.SetTextAlignment("TOP","CENTER")  
    B4XDialogShow.BackgroundColor = xi.Color_Transparent  
    B4XDialogShow.BorderWidth = 0  
    B4XDialogShow.ButtonsHeight = 0  
     
    Wait For (B4XDialogShow.ShowCustom(p, "", "", "Cancel")) Complete (res As Int)  
  
    #If Debug  
    If res = -3 Then  
        MyProgressDialogHide  
    End If  
    #End If  
End Sub  
  
Private Sub isMedia(f As String) As String  
    If f.ToLowerCase.EndsWith(".media") Then  
        Return True  
    Else  
        Return False  
    End If  
End Sub  
  
Private Sub isVideo(f As String) As String  
    If f.ToLowerCase.EndsWith(".mp4") Then  
        Return True  
    Else  
        Return False  
    End If  
End Sub  
  
  
#Region Script_converting  
Private Sub start_cmd(fScript As String)  
    shl.Initialize("shl", "cmd.exe", Array As String("/c", fScript))  
    shl.WorkingDirectory = Dialog.Target  
    shl.Run(-1)  
End Sub  
  
Private Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success = True And ExitCode = 0 Then  
        #If Debug  
        Log("SHL Process, Success") 'The Windows command script has completed.  
        #End If  
    End If  
End Sub  
#End Region  
  
#Region File Watching  
Sub fw_CreationDetected(FileName As String)  
    #If Debug  
    Log("CreationDetected: " & FileName)            'Logs the creation of a new file or folder  
    #End If  
End Sub  
  
Sub fw_DeletionDetected(FileName As String)  
    #If Debug  
    Log("DeletionDetected: " & FileName)            'Logs the deletion of a file or folder  
    #End If  
End Sub  
  
Sub fw_ModificationDetected(FileName As String)  
    If isVideo(FileName) Then  
        #If Debug  
        Log("ModificationDetected: " & FileName)    'Logs the modification of a file or folder  
        #End If  
        Dim fw As FileWatcher = Sender  
        Dim wt As FileWatcher = watchers.Get(watchers.Size-1) 'The last catalog viewed on the list (watchers)  
        If fw = wt And isWatchingTerminated = False Then  
            For Each fw As FileWatcher In watchers  
                fw.StopWatching    
            Next  
        End If  
    End If  
End Sub  
  
Sub fw_Overflow  
    #If Debug  
    Log("Overflow")  
    #End If  
End Sub  
  
Sub fw_WatchingTerminated                        'Logs the termination of the FileWatcher  
    If isWatchingTerminated = False Then  
        #If Debug  
        Log("WatchingTerminated")                'The FileWatcher can still be used, it just has to be started again.  
        #End If  
        isWatchingTerminated = True  
        If kvs.IsInitialized Then Dialog.Target = kvs.GetEncrypted("target", pswd) 'Restore the original directory  
         
        If shl_Success = True Then  
            'This is where the message is quenched (–MyProgressDialogHide–).  
            MyProgressDialogHide  
            taRemixing.Text = "The Windows command script has completed, the process was successful."  
        Else  
            'This is where the message is quenched (–MyProgressDialogHide–).  
            MyProgressDialogHide  
            taRemixing.Text = "The Windows command script has completed, the process was not successful."  
        End If  
    End If  
End Sub  
#End Region
```