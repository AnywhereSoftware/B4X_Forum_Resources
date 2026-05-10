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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private fspJson As spJson
	Private fB4XSeekBarItemHeight As B4XSeekBar
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.AddMenuItem(Me,"Load")
	B4XPages.SetTitle(Me,"Json viewer")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

private Sub B4XPage_menuclick(atag As Object)
	CallSub(Me,"menu_"&atag)
End Sub

Private Sub menu_load
	Dim cc As ContentChooser
	cc.Initialize("cc")
	cc.Show("application/json","Open Json File")
	wait for cc_result(aSuccess As Boolean, aDir As String, aFile As String)
	If Not(aSuccess) Then
		Return
	End If
	wait for (fspJson.load(File.ReadString(aDir,aFile))) complete (rb As Boolean)
	ToastMessageShow(IIf(rb,"Json File loaded","Error while loading file"),False)
End Sub

Private Sub fspJson_click(anode As spJsonNode)
	If anode.g_hasValue Then
		xui.MsgboxAsync(anode.g_Value,$"${anode.g_Type} | ${anode.g_Name}"$)
	Else
		xui.MsgboxAsync(anode.g_name,anode.g_Type)
	End If
End Sub

Private Sub fspJson_longclick(anode As spJsonNode)
	xui.MsgboxAsync(anode.g_path,"Path")
End Sub

Private Sub fB4XSeekBarItemHeight_ValueChanged (Value As Int)
	fspJson.s_itemHeight(fB4XSeekBarItemHeight.Value)
End Sub