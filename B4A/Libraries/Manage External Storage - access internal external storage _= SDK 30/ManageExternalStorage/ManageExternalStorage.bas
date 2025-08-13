B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
' Version 1.00
#Event: StorageAvailable
Sub Class_Globals
	Private ion As Object
	Private mCallback As Object
	Private mEventName As String
	
End Sub


' This pretty trivial class is modelled on (plagiarised from!) Erel's  ExternalStorage class
' It applies to devices implementing SDK30 and later 
' It allows apps to access the internal 'external' storage as was possible on earlier Android versions ussing traditional file I/O
' You must manually add 'AddPermission(android.permission.MANAGE_EXTERNAL_STORAGE)' to the manifest
' You must ensure that you provide the package name of your app in Sub GetPermission
' This class uses the MANAGE_APP_ALL_FILES_ACCESS_PERMISSION intent action to direct users to a system settings page
' They must enable the option on that page to give permission



'Initializes the object
Public Sub Initialize (Callback As Object, EventName As String)
	mCallback = Callback
	mEventName = EventName
End Sub


' Determine if the app already has MANAGE_EXTERNAL_STORAGE call Environment.isExternalStorageManager()
' Return True if this app already has MANAGE_EXTERNAL_STORAGE permission
Public Sub HasPermission As Boolean
	Dim has As Boolean	
	Dim jo As JavaObject
	jo.InitializeStatic("android.os.Environment")
	has = jo.RunMethod("isExternalStorageManager", Null)	
	Return has
End Sub

' Check whether this app has MANAGE_EXTERNAL_STORAGE permission
' If not show the user a dialog to enable MANAGE_EXTERNAL_STORAGE permission for this app
' Raises the StorageAvailable event in the calling activity when complete
Public Sub GetPermission
	If HasPermission Then
		RaiseEvent
		Return
	End If
	Dim in As Intent
	' Be sure to reference your app package name in "pakageg:xxx"
	in.Initialize("android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION", "package:b4a.example")
	StartActivityForResult(in)
End Sub


Private Sub RaiseEvent
	Log("Calling : " &  mEventName & "_StorageAvailable")
	CallSubDelayed(mCallback, mEventName & "_StorageAvailable")
End Sub


Private Sub ion_Event (MethodName As String, Args() As Object) As Object
	RaiseEvent
	Return Null
End Sub


Private Sub StartActivityForResult(i As Intent)
	Dim jo As JavaObject = GetBA
	ion = jo.CreateEvent("anywheresoftware.b4a.IOnActivityResult", "ion", Null)
	jo.RunMethod("startActivityForResult", Array As Object(ion, i))
End Sub

Private Sub GetBA As Object
	Dim jo As JavaObject = Me
	Return jo.RunMethod("getBA", Null)
End Sub

