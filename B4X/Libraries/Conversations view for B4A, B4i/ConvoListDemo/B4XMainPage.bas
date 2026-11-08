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
	Private btnAddDummyData As B4XView
	Private btnMod As B4XView
	Private btnMod2 As B4XView
	
	Private clvConvoList1 As clvConvoList
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.


Private Sub btnAddDummyData_Click
	#if b4a
		Dim av As B4XBitmap = LoadBitmapSample (File.DirAssets, "richie.jpg", 40dip, 40dip)
	#else
	Dim av As B4XBitmap = LoadBitmapResize(File.DirAssets, "richie.jpg", 40dip, 40dip, False)
	#End If
	
	clvConvoList1.UpdateConversation ("1111", "Richie Richard", DateTime.Now - (1 * DateTime.TicksPerHour), 1, av.Resize (40dip,40dip,False))
	clvConvoList1.UpdateConversation ("2222", "Eddie", DateTime.Now - (2 * DateTime.TicksPerHour), 0, Null)
	clvConvoList1.UpdateConversation ("3333", "Dave Hedgehog", DateTime.Now - (3 * DateTime.TicksPerHour), 0, Null)
End Sub

Private Sub btnMod_Click
	clvConvoList1.UpdateConversation ("3333", "", DateTime.Now, 1, Null)
End Sub

Private Sub btnMod2_Click
	clvConvoList1.UpdateConversation ("4444", "Spudgun", DateTime.Now, 1, Null)
End Sub

Private Sub clvConvoList1_PreviewConversation (conv As convoEntry)
	clvConvoList1.SetMessagePreview (conv.id, "Well, I just got to finish my sprouts Mexicain, and we're all set!")
End Sub

private Sub clvConvoList1_DeleteConversations (ids As List)
	For Each s As String In ids
		clvConvoList1.RemoveConversation (s)
	Next
End Sub

Private Sub clvConvoList1_EditContact (id As String)
	Log ("Edit contact : - " & id)
End Sub