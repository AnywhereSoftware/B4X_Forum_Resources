B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=12
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private FullScreenView As SPlayerView
	Private lblFullscreenExit As B4XView
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("FullscreenLayout")
	
	fullscreenSwitch(Main.player1,Main.SPlayerView1,FullScreenView,True)
	CallSub3(Main,"PutLabelInVideoTopRightCorner",FullScreenView,lblFullscreenExit)

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)
	fullscreenSwitch(Main.player1,Main.SPlayerView1,FullScreenView,False)
End Sub

Sub fullscreenSwitch(CurrentPlayer As SPlayer,oldScreen As SPlayerView,newscreen As SPlayerView, FullscreenState As Boolean)
	If FullscreenState Then
		FullScreenView.SwitchPlayerView(CurrentPlayer,oldScreen,newscreen)
		Else
		FullScreenView.SwitchPlayerView(CurrentPlayer,newscreen,oldScreen)
	End If

End Sub


Private Sub lblFullscreenExit_Click
	Activity.Finish
End Sub