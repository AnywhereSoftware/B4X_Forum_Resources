B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private clvcommands As CustomListView
	Private lblmessages As Label
	Private fchoose As FileChooser
	' folders
	Public commandfilesfolder As String
	Public commandlist As List
	Private commandcnt As Int
	Private filename As String
	' shell
	Private sh As Shell
	' clvcommands
	Private btnlaunch As Button
	Private sbtnadd As SwiftButton
	Private sbtnload As SwiftButton
	Private sbtnsave As SwiftButton
	Private sbtnclear As SwiftButton
	Private taexecutable As TextArea
	Private taarguments As TextArea
	Private taworkingdir As TextArea
	Private btndelete As Button
	Private devwidth As Int
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"ShellCommands")
	' folders
	xui.SetDataFolder("ShellCommands")
	File.MakeDir(xui.DefaultFolder,"Commandfiles")
	commandfilesfolder = File.DirData("ShellCommands") & "\Commandfiles"
	commandlist.Initialize
	commandcnt = 0
	fchoose.Initialize
	filename = ""
End Sub
Private Sub B4XPage_Appear
	devwidth = B4XPages.GetNativeParent(B4XPages.MainPage).RootPane.Width
	fill_clvcommands
End Sub
Private Sub B4XPage_Resize (Width As Int, Height As Int)
	devwidth = B4XPages.GetNativeParent(B4XPages.MainPage).RootPane.Width
	sbtnclear_Click
	If commandlist.Size > 0 Then
		reload_from_commandlist
	End If
End Sub

Private Sub fill_clvcommands
	Dim pn As Pane = set_clvcommands_item(commandcnt)
	clvcommands.Add(pn,commandcnt)
End Sub
Private Sub set_clvcommands_item(cnt As Int) As Pane
	Dim p As B4XView = xui.CreatePanel("")
	If devwidth < 682dip Then
		p.SetLayoutAnimated(0, 0dip, 0dip, 681dip,212dip)
	Else
		p.SetLayoutAnimated(0, 0dip, 0dip, 1300dip,72dip)
	End If
	p.LoadLayout("clvcommandsitem_layout")
	btnlaunch.Tag = cnt
	btndelete.Tag = cnt
	Return p
End Sub
Private Sub clvcommands_ItemClick (Index As Int, Value As Object)
End Sub
Private Sub sbtnadd_Click
	Dim pn As Pane = set_clvcommands_item(commandcnt)
	clvcommands.InsertAt(0,pn,0)
	For i = 0 To clvcommands.Size - 1
		clvcommands.GetPanel(i).GetView(3).Tag = i		
		clvcommands.GetPanel(i).GetView(4).Tag = i
	Next
	If devwidth < 682dip Then
		clvcommands.sv.ScrollViewContentHeight = ((i+1) * 210) + 120dip
	Else
		clvcommands.sv.ScrollViewContentHeight = ((i+1) * 70) + 120dip
	End If
End Sub
Private Sub sbtnload_Click
	sbtnclear_Click
	fill_clvcommands_from_list
End Sub
Private Sub sbtnsave_Click
	commandlist.Clear
	For i = 0 To clvcommands.Size - 1
		Dim lst As List
		lst.Initialize
		Dim strexec As String = clvcommands.GetPanel(i).GetView(0).Text
		If clvcommands.Size = 1 And strexec = "" Then
			xui.MsgboxAsync("Nothing to save","Save")
			Return
		End If
		Dim strworkdir As String = clvcommands.GetPanel(i).GetView(1).Text
		Dim strargum As String = clvcommands.GetPanel(i).GetView(2).Text
		strexec = strexec.Replace("\","\\")			' escape backslash
		strworkdir = strworkdir.Replace("\","\\")
		strargum = strargum.Replace("\","\\")
		If strexec.StartsWith("""") = False Then
			strexec = """" & strexec & """"
		End If
		If strworkdir.StartsWith("""") = False Then
			strworkdir = """" & strworkdir & """"
		End If
		If strargum.StartsWith("""") = False Then
			strargum = """" & strargum & """"
		End If				
		lst.Add(strexec)
		lst.Add(strworkdir)
		lst.Add(strargum)
		commandlist.Add(lst.As(JSON))			
	Next
	'Log(commandlist)
	filename = fchoose.ShowSave(B4XPages.GetNativeParent(B4XPages.MainPage))
	Log(filename)
	If filename <> "" Then
		Dim path As String = filename.SubString2(0,filename.LastIndexOf("\")+1)
		Dim fname As String = filename.SubString(filename.LastIndexOf("\")+1)
		File.WriteList(path,fname,commandlist)
		lblmessages.Text = " File: " & fname & " is saved in folder: " & path	
	Else
		Dim conf As Object = xui.Msgbox2Async("Replace COMMANDS.TXT default file?","Replace","Yes","Cancel","No",Null)
		Wait For (conf) Msgbox_Result (Result As Int)
		If Result = xui.DialogResponse_Positive Then
			File.WriteList(commandfilesfolder,"commands.txt",commandlist)
			lblmessages.Text = " File: " & "commands.txt" & " is saved."
		End If			
	End If
End Sub
Private Sub sbtnclear_Click
	lblmessages.Text = ""
	clvcommands.Clear
	fill_clvcommands
End Sub
Private Sub btndelete_Click
	Dim btn As Button = Sender
	Log(btn.Tag)
	clvcommands.RemoveAt(btn.Tag)
	For i = 0 To clvcommands.Size - 1
		clvcommands.GetPanel(i).GetView(4).Tag = i
	Next
	commandcnt = i
End Sub
Private Sub btnlaunch_Click
	For i = 0 To clvcommands.Size - 1
		clvcommands.GetPanel(i).Color = xui.Color_ARGB(255,255,255,255)
	Next
	Dim btn As Button = Sender
	Log(btn.Tag)
	Dim strexec As String = clvcommands.GetPanel(btn.tag).GetView(0).Text
	Dim strworkdir As String = clvcommands.GetPanel(btn.tag).GetView(1).Text
	Dim strargum As String = clvcommands.GetPanel(btn.tag).GetView(2).Text
	If is_file_or_folder(strexec) = False Then
		xui.MsgboxAsync("The executable is not found!","Executable")
		Return
	End If
	' shell
	Try
		Private arguments() As String = Array As String(strargum)
		sh.Initialize("shl", strexec, arguments)
		sh.WorkingDirectory = strworkdir
		sh.Run(-1)
		lblmessages.Text = " Command is launched."
		clvcommands.GetPanel(btn.tag).Color = xui.Color_ARGB(255,135,255,146)
	Catch
		Log(LastException)
		B4XPage_Appear
	End Try
End Sub
Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	If Success And ExitCode = 0 Then
		lblmessages.Text = " Command is launched with success!"
		Log("Success")
	Else
		lblmessages.Text = " The launch failed because: " & StdErr
		Log("Error: " & StdErr)
	End If
End Sub
Private Sub is_file_or_folder(fname As String) As Boolean
	Dim path As String = fname.SubString2(0,fname.LastIndexOf("\")+1)
	Dim fname As String = fname.SubString(fname.LastIndexOf("\")+1)
	If File.Exists(path,fname) Then
		Return True
	End If
	Return False
End Sub
Private Sub fill_clvcommands_from_list
	commandlist.Clear
	clvcommands.Clear
	filename = fchoose.ShowOpen(B4XPages.GetNativeParent(B4XPages.MainPage))
	If filename <> "" Then
		Dim path As String = filename.SubString2(0,filename.LastIndexOf("\")+1)
		Dim fname As String = filename.SubString(filename.LastIndexOf("\")+1)
		commandlist = File.ReadList(path,fname)
		lblmessages.Text = " File: " & fname & " is loaded from folder: " & path
	Else
		commandlist = File.ReadList(commandfilesfolder,"commands.txt")
		lblmessages.Text = " File: " & "commands.txt" & " is loaded."
	End If
	If commandlist.Size = 0 Then
		xui.MsgboxAsync("There are no commands to load from the file.","Load")
	End If
	commandcnt = 0
	For i = 0 To commandlist.Size - 1
		Dim pn As Pane = set_clvcommands_item(commandcnt)
		Dim lst As List = commandlist.Get(i).As(JSON).ToList
		taexecutable.Text = lst.Get(0)
		taworkingdir.Text = lst.Get(1)
		taarguments.Text = lst.Get(2)
		clvcommands.Add(pn,commandcnt)
		commandcnt = commandcnt + 1
	Next
	If devwidth < 682dip Then
		clvcommands.sv.ScrollViewContentHeight = ((i+1) * 210) + 120dip
	Else
		clvcommands.sv.ScrollViewContentHeight = ((i+1) * 70) + 120dip
	End If
End Sub
Private Sub reload_from_commandlist
	clvcommands.Clear
	If commandlist.Size > 0 Then
		commandcnt = 0
		For i = 0 To commandlist.Size - 1
			Dim pn As Pane = set_clvcommands_item(commandcnt)
			Dim lst As List = commandlist.Get(i).As(JSON).ToList
			taexecutable.Text = lst.Get(0)
			taworkingdir.Text = lst.Get(1)
			taarguments.Text = lst.Get(2)
			clvcommands.Add(pn,commandcnt)
			commandcnt = commandcnt + 1
		Next
		If devwidth < 682dip Then
			clvcommands.sv.ScrollViewContentHeight = ((i+1) * 210) + 120dip
		Else
			clvcommands.sv.ScrollViewContentHeight = ((i+1) * 70) + 120dip
		End If
	End If
End Sub