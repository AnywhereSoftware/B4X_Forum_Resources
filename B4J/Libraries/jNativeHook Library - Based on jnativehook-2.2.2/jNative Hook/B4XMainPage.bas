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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

'https://github.com/kwhat/jnativehook

Sub Class_Globals
	Private Root As B4XView
	Private XUI As XUI
	
	Private NH As NativeHook	

	Private CtrlDown As Boolean
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")

	B4XPages.GetNativeParent(Me).RootPane.Visible = False

	'Initialize the object with the event prefix
	NH.Initialize("NH")

	'Register the hook and check the result
	Dim OK As Boolean = NH.RegisterHook
	Log("RegisterHook returned: " & OK)
	Log("IsRegistered: " & NH.IsRegistered)

	If OK = False Then
		Log("Failed to register native hook")
	Else
		Log("Native hook registered")
	End If
End Sub

'When shutting down the server or app
Sub B4XPage_CloseRequest As ResumableSub
	If NH.IsRegistered Then
		NH.UnregisterHook
		Log("Native hook unregistered safely.")
	End If
	Return True
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	XUI.MsgboxAsync("Hello world!", "B4X")
End Sub

' ============================
'       KEYBOARD EVENTS
' ============================

Sub NH_KeyPressed(EventData As Map)
	Log($"KeyPressed → ${EventData}"$)

	Dim code As Int = EventData.Get("KeyCode")
	If code = 29 Or code = 157 Then CtrlDown = True		'Left or Right Ctrl (These numbers are  scan codes)
End Sub

Sub NH_KeyReleased(EventData As Map)
	Log($"KeyReleased → ${EventData}"$)
	
	Dim code As Int = EventData.Get("KeyCode")
	If code = 29 Or code = 157 Then CtrlDown = False		'Left or Right Ctrl (These numbers are  scan codes)
End Sub

Sub NH_KeyTyped(EventData As Map)
'    Log($"KeyTyped → ${EventData}"$)
End Sub

' ============================
'       MOUSE EVENTS
' ============================

Sub NH_MouseClicked (EventData As Map)
	Log($"MouseClicked → ${EventData}"$)
End Sub


Private Sub NH_MousePressed(EventData As Map)
	Log($"MousePressed → ${EventData}"$)

	Dim MouBtn As Int = EventData.Get("Button")
	
	If CtrlDown And MouBtn = 1 Then
		Log("CTRL + LEFT CLICK detected at: " & EventData)
		Return
	End If

	If CtrlDown And MouBtn = 2 Then
		Log("CTRL + RIGHT CLICK detected at: " & EventData)
		Return
	End If
End Sub

Sub NH_MouseReleased(EventData As Map)
    Log($"MouseReleased → ${EventData}"$)
End Sub

Sub NH_MouseMoved(EventData As Map)
'    Log($"MouseMoved → ${EventData}"$)
End Sub

Sub NH_MouseDragged(EventData As Map)
    Log($"MouseDragged → ${EventData}"$)
End Sub

Sub NH_MouseWheel(EventData As Map)
    Log($"MouseWheel → ${EventData}"$)
End Sub

'In the example:
'29 = Left Ctrl
'E0 1D (157 decimal) = Right Ctrl

'Modifier Keys
'Key	Scan Code	Extended?
'Left Shift	42	No
'Right Shift	54	No
'Left Ctrl	29	No
'Right Ctrl	29	Yes (E0 prefix)
'Left Alt	56	No
'Right Alt (AltGr)	56	Yes (E0 prefix)
'Left Windows	91	Yes
'Right Windows	92	Yes
'Menu / Apps	93	Yes

'Letters (A–Z)
'Key	Scan Code
'A	30
'B	48
'C	46
'D	32
'E	18
'F	33
'G	34
'H	35
'I	23
'J	36
'K	37
'L	38
'M	50
'N	49
'O	24
'P	25
'Q	16
'R	19
'S	31
'T	20
'U	22
'V	47
'W	17
'X	45
'Y	21
'Z	44
