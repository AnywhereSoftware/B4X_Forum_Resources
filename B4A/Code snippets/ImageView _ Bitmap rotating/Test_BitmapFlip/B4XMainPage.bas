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

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Test_Bitmap.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	Private			sMDB_Frame						As Panel
	Private     		sMDB_CoverArt_Background	As ImageView		
	Private     		sMDB_CoverArt  				As ImageView	
	Private				sMDB_ForceFrame				As Panel
	
	Private 			Spinner1 					As Spinner
	
	Private 			Button1 					As Button
	Private 			Button2 					As Button
	Private 			Button3 					As Button
		
	Private Covers()								As Bitmap
	
	Private LastCover								As Int	= 0
	Private WhichCover								As Int	= 0
	
	
'	Private mNeedRotation										As Boolean  =  True
	
	
	Private mRotateImage							As cRotateImage
	
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
			Root = Root1
			Root.LoadLayout("MainPage")
	
			sMDB_CoverArt_Background.Top	= 2dip
			sMDB_CoverArt_Background.Left	= 2dip
			sMDB_CoverArt_Background.Width	= sMDB_Frame.Width 	- 4dip
			sMDB_CoverArt_Background.Height	= sMDB_Frame.Height	- 4dip

			sMDB_CoverArt.Top				= 2dip
			sMDB_CoverArt.Left				= 2dip
			sMDB_CoverArt.Width				= sMDB_Frame.Width 	- 4dip
			sMDB_CoverArt.Height			= sMDB_Frame.Height	- 4dip
			
			sMDB_ForceFrame.Top				= 0
			sMDB_ForceFrame.Left			= 0
			sMDB_ForceFrame.Width			= sMDB_Frame.Width
			sMDB_ForceFrame.Height			= sMDB_Frame.Height
			
			Covers = Array As Bitmap(LoadBitmap(File.DirAssets, "Cover1.jpg"), _
									 LoadBitmap(File.DirAssets, "Cover2.jpg"), _
									 LoadBitmap(File.DirAssets, "Cover3.jpg"), _
									 LoadBitmap(File.DirAssets, "Cover4.jpg"), _
									 LoadBitmap(File.DirAssets, "Cover5.jpg"), _
									 LoadBitmap(File.DirAssets, "Cover6.jpg"), _
									 LoadBitmap(File.DirAssets, "Cover7.jpg"))									 									 									 
									 
			mRotateImage.Initialize(sMDB_CoverArt_Background, sMDB_CoverArt)

			Spinner1.Add("<-- Pick a rotation -->")		
			Spinner1.AddAll(mRotateImage.NamesAsList)
			
			LastCover  = -1
			WhichCover = -1
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
			If  WhichCover = -1 Then
				WhichCover = 0
			Else
				WhichCover = WhichCover + 1
			
				If  WhichCover >= Covers.Length Then
					WhichCover = 0
				End If
			End If


			LastCover = WhichCover
			
			wait for (mRotateImage.RotateNext(Covers(WhichCover))) Complete(RC As Boolean)									
									
			SetSpinner			
End Sub

Private Sub Button2_Click
			If  LastCover = -1 Then
				Return
			End If
			
			wait for (mRotateImage.Rotate(Covers(LastCover))) Complete(RC As Boolean)
			
			SetSpinner
End Sub

Private Sub Button3_Click
'			wait for (mRotateImage.RotateRandom(Covers(WhichCover))) Complete(RC As Boolean)
'			
'			LastCover  = WhichCover
'			WhichCover = WhichCover + 1
'			
'			If  WhichCover >= Covers.Length Then
'				WhichCover = 0
'			End If	
'			
'			SetSpinner
'End Sub
'
'Private Sub Button3_LongClick
			ToastMessageShow("Starting Random Show", True)
			
			WhichCover = 0
			
			For i = 0 To 99
				If  i > 0 And (i Mod 10) = 0 Then
					ToastMessageShow($"${i} of 100 Done"$, True)					
				End If
				
				wait for (mRotateImage.RotateRandom(Covers(WhichCover))) Complete(RC As Boolean)

				LastCover  = WhichCover
				WhichCover = WhichCover + 1
			
				If  WhichCover >= Covers.Length Then
					WhichCover = 0
				End If	
			
				SetSpinner
			Next
			
			ToastMessageShow("Random Show Ended", True)			
End Sub


Private Sub Spinner1_ItemClick(Position As Int, Value As Object)
			If  Position > 0 Then
				Position = Position - 1
			End If
			
			If  WhichCover = -1 Then
				WhichCover = 0
				LastCover  = WhichCover
			Else
				WhichCover = WhichCover + 1
			
				If  WhichCover >= Covers.Length Then
					WhichCover = 0
				End If					
			End If
			
			wait for (mRotateImage.RotateUsing(Position, Covers(WhichCover))) Complete(RC As Boolean)
End Sub

Private Sub SetSpinner
			Spinner1.SelectedIndex = (mRotateImage.WhatRotation + 1)
End Sub


