B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=4
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim Opts As Map
End Sub
Sub Initialize
	Read
End Sub
Private Sub Read
	If File.Exists(File.DirDefaultExternal,"opts.map") Then
		Opts = File.ReadMap(File.DirDefaultExternal,"opts.map")
	Else
	Opts.Initialize
	End If
End Sub
Sub Save
	File.WriteMap(File.DirDefaultExternal,"opts.map",Opts)
End Sub
'Set Initial FilePath
Sub SetInitialFilePath (FP As String)
	Opts.Put("InitialFilePath",FP)
End Sub
'Get Initial FilePath
Sub GetInitialFilePath As String
	Return Opts.GetDefault("InitialFilePath","")
End Sub