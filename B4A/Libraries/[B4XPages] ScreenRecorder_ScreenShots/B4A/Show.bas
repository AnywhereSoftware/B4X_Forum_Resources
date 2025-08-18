B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private vv As VideoView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	GenerateVideoVievAndPlay
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Sub GenerateVideoVievAndPlay
	vv.Initialize("vv") 'we'll use a videoview to show the recording.
	Root.AddView(vv,0,0,100%x,100%y) 'Probably better to use a layout to fix the layout...
	vv.MediaControllerEnabled = True
	If File.Exists(Starter.rp.GetSafeDirDefaultExternal(""),"mytest1.mp4") Then
		vv.LoadVideo(Starter.rp.GetSafeDirDefaultExternal(""),"mytest1.mp4")
		vv.Play
	End If
End Sub