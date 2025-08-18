Type=Class
Version=5.2
ModulesStructureVersion=1
B4A=true
@EndOfDesignText@
'Class module
Sub Class_Globals
	Private mTarget As JavaObject	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Target As JavaObject)
	mTarget = Target
End Sub

'URI To access the File, which varies depending on the link Type specified when
'the Chooser was triggered
Sub GetLink As String															'ignore
	Return mTarget.RunMethodJO("getLink",Null).RunMethod("toString",Null)
End Sub
'URI to a 64px x 64px icon for the file based on the file's extension
Sub GetIcon As String															'ignore
	Return mTarget.RunMethodJO("getIcon",Null).RunMethod("toString",Null)
End Sub
'Name of the file
Sub GetName As String															'ignore
	Return mTarget.RunMethod("getName",Null)
End Sub
'Size of the file in bytes
Sub GetSize As Long																'ignore
	Return mTarget.RunMethod("getSize",Null)
End Sub
'Set of thumbnail URIs generated when the user selects images and videos. It
'returns three sizes with the keys: 64x64px, 200x200px, And 640x480px.
'If the user didn't select an image or video, no thumbnails will be included.
Sub GetThumbnails As Map														'ignore
	Dim M As Map
	M.Initialize
	Dim HashMap As JavaObject = mTarget.RunMethodJO("getThumbnails",Null)
	Dim Iterator As JavaObject = HashMap.RunMethodJO("entrySet",Null).RunMethod("iterator",Null)
	Do While Iterator.RunMethod("hasNext",Null)
		Dim MapEntry As JavaObject = Iterator.RunMethod("next",Null)
		M.Put(MapEntry.RunMethod("getKey",Null),MapEntry.RunMethod("getValue",Null))
	Loop
	Return M
End Sub