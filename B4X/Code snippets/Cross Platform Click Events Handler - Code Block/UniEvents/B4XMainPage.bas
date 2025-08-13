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

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private dd As DDD
End Sub

Public Sub Initialize
	dd.Initialize
	xui.RegisterDesignerClass(dd)
End Sub

Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")			'button1 event = X_C	(X_C is cross-platform clicks)
End Sub

Private Sub Button1_NormalClick
	xui.MsgboxAsync("Hello World - Normal Click", "B4X")
End Sub

Private Sub Button1_ExtraClick		'Long (>300msec) or Right (B4J)
	xui.MsgboxAsync("Hello World - Extra Click", "B4X")
End Sub

#Region Crossplatform Click Handling - Normal and Extra (LongClick or RightClick for B4J)
'All Buttoviews with "X_C" as its event name will be handled by subs below - the target event is the ViewName_NormalClick and ViewName_ExtraClick  
'
#if B4J
Private Sub X_C_MouseClicked(eV As MouseEvent)
	Dim vdata As DDDViewData = dd.GetViewData(Sender)		'really fast: tested 4 msec per 100000 calls on B4J
	If eV.SecondaryButtonPressed Then CallSub(Me, vdata.name & "_ExtraClick") Else CallSub(Me, vdata.name & "_NormalClick")
End Sub
#Else If B4A Or B4i
Private Sub X_C_Click
	Dim vdata As DDDViewData = dd.GetViewData(Sender)
	CallSub(Me, vdata.Name & "_NormalClick")
End Sub
Private Sub X_C_LongClick
	Dim vdata As DDDViewData = dd.GetViewData(Sender)
	CallSub(Me, vdata.Name & "_ExtraClick")
End Sub
#End If
#End Region
