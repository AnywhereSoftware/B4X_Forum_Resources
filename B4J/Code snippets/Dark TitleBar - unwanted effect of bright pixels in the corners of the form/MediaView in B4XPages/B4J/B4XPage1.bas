B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
Sub Class_Globals
	Private xui  As XUI
	Private Root As B4XView
	Private VideoURL As String
	Private pges As Form
	Public  MediaView1 As MediaView
	Public  MediaViewController1 As MediaViewController
	Public  pth, filename As String
	Public  pageclosed As Boolean = True
	Public  justinbackground As Boolean = False
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	B4XPages.GetManager.LogEvents = False
	B4XPages.GetManager.TransitionAnimationDuration = 100
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.RemoveAllViews
	Root.LoadLayout("MediaView")
	B4XPages.SetTitle(Me, "I'm palaying a song:  " & filename)
	
	pges.Initialize("pges",Root.Width, Root.Height)
	pges = B4XPages.GetNativeParent(B4XPages.MainPage.pg)
	pges.SetFormStyle("DECORATED")
	
	MediaViewController1.SetBackgroundColor = xui.Color_ARGB(190,0,0,0)
	MediaViewController1.SetTextIconColor = xui.Color_White
	
	MediaViewController1.SetOnMouseOverVideo = True
	
'	**************  MediaView *********************
	
	MediaView1.SetBackgroundColor = xui.Color_Black
	MediaView1.SetPreserveRatio = False

'	**************  Visualize *********************

	MediaViewController1.SetMediaView(MediaView1)
	
'	************  Video | Music *******************
	VideoURL = File.GetUri(pth,filename)

	MediaViewController1.SetMediaView(MediaView1)
	MediaView1.Source = VideoURL
End Sub

Private Sub B4XPage_Appear
	pageclosed = True
	If justinbackground = False Then 'LoadLayout
		B4XPages.SetTitle(Me, "I'm palaying a song:  " & filename)
		MediaView1.Dispose
		MediaView1.Source = File.GetUri(pth,filename)
		MediaView1.Play
	End If
End Sub

Private Sub B4XPage_Background
	pageclosed = False
	justinbackground = True
End Sub

Private Sub B4XPage_Disappear
	Sleep(0)
	If pageclosed = True Then
		justinbackground = False
		MediaView1.Dispose
		MediaView1.Source = File.GetUri(pth,filename)
		MediaView1.Stop
	End If
End Sub

Private Sub MediaView1_Error (Message As String)
	If MediaView1.IsInitialized Then MediaView1.Dispose
	#If Debug
	Log("ERROR: " & Message)
	#End If
End Sub

Private Sub MediaView1_Complete
	#If Debug
	Log("COMPLETE")
	#End If
End Sub

Private Sub MediaView1_StateChanged (State As String)
	#If Debug
	Log(State)
	#End If
End Sub
