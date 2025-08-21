B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private lvFiles As ListView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("LayoutFiles")

End Sub
Sub Loadfiles(filelist As List)
	lvFiles.Clear
	If filelist.IsInitialized And filelist.Size > 0 Then
		For i=0 To filelist.Size-1
			Dim f As SMBFile = filelist.Get(i)
			'FILE CanonicalPath = smb://192.168.192.168/GeoTIFs/koeln/ (0)
			Log($"FILE CanonicalPath = ${f.CanonicalPath} (${f.length})"$)
			lvFiles.AddTwoLines2(f.Name, f.CanonicalPath,f)
		Next
	End If
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub lvFiles_ItemClick (Position As Int, Value As Object)
	
End Sub