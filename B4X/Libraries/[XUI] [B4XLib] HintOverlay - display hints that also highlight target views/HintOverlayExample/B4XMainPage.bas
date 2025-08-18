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
	Private Hints As HintOverlay
	
	Private lblTopLeft,lblTopRight As Label
	Private Button1,Button2,Button3 As Button
	Private lblBottomLeft,lblBottomRight,lblBottomMiddle As Label
	Private TextBox As B4XView
	Private pnlOptions As B4XView
	Private Selector3 As B4XView
	Private ImageView1 As ImageView
	Private CustomListView1 As CustomListView	

	Private InvisiblePanel1 As B4XView
	Private InvisiblePanel2 As B4XView
#If b4i	
	Private pnlTopBar As Panel 'Testing adjustments for when navbar is not visible
	Private lblTopbarLabel As Label
#End if	
#If b4a
	Private rp As RuntimePermissions
#End if

	Private iOSExtraAlpha As Int
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Hints.Initialize(Root)
	
	Root.LoadLayout("MainPage")
	Root.Color=xui.Color_Gray
	For i=1 To 20
		CustomListView1.AddTextItem("Item " & i,i)
	Next
	
	#if b4i
		iOSExtraAlpha=100 'iOS requires more dimming
	#End If
	
	Dim sDir As String=GetSaveDirectory
	If Not(File.Exists(sDir,"hints-viewed.txt")) Then
		File.WriteString(sDir,"hints-viewed.txt","viewed")
		Sleep(500)
		Hints.Show(Button1,"Tap buttons to display different styles of hint overlays.")
		Hints.Show(Button2,"Each button demonstrates different styling options.")
		Hints.Show(pnlOptions, "Select an option here")
		Hints.Show(Selector3, "Tap here if you're unsure what to select")
	End If
End Sub

Private Sub B4XPage_Resize (Width As Int, Height As Int)
	Hints.Base_Resize(Width,Height)
End Sub

Private Sub Button1_Click
	'White text on black semi-transparent background (red outline)
	Hints.BackgroundAlpha=80+iOSExtraAlpha
	Hints.CaptionColor=xui.Color_ARGB(120,0,0,0)
	Hints.TextColor=xui.Color_White
	Hints.OutlineColor=xui.Color_Red
	Hints.HighlightTargetView=True
'	Hints.TextSize=20
	
	Hints.Show(lblTopLeft, "The CaptionColor has been set to semi-transparent black.")
	Hints.Show(CustomListView1.GetBase, "This is a CustomListView." & CRLF & "Use '.GetBase' to parse it as a B4XView.")
	
	'Properties can be changed after 'Wait For'

	Wait For(Hints.Show(InvisiblePanel1, "LIST VIEW ITEM" & CRLF & "You can put an invisible panel anywhere to display an area that is unreachable.")) Complete (b As Boolean)
	
	Hints.HighlightTargetView=False	
	Hints.ClearTargetView=False
	Wait For(Hints.Show(InvisiblePanel2, "SMILEY FACE" & CRLF & "You can place an INVISIBLE panel anywhere to display a specific area.")) Complete (b As Boolean)
	
	Hints.HighlightTargetView=True
	Hints.ClearTargetView=True
	Hints.OutlineColor=xui.Color_Cyan
	Hints.Show(lblBottomRight, "This is the bottom-right label positioned INSIDE a panel")
	
	Hints.Show(lblBottomMiddle,"This is the bottom-middle label not postioned inside a panel")
	Hints.Show(lblTopRight, "RESET HINTS" & CRLF & "Tap here to reset the initial hint displayed when the app is started for the first time.")
End Sub

Private Sub Button2_Click
	'Dark grey text on grey background (green outline)
	Hints.BackgroundAlpha=50+iOSExtraAlpha
	Hints.CaptionColor=xui.Color_LightGray
	Hints.TextColor=xui.Color_DarkGray
	Hints.OutlineColor=xui.Color_Green
	Hints.HighlightTargetView=False

	Hints.Show(lblTopLeft, "Set HightlightTargetView to false if you don't want to display an outline around the target view.")
	Hints.Show(TextBox, "You can type text in this text box to do something really cool!")
	Hints.Show(pnlOptions, "Select an option here")
	Hints.Show(CustomListView1.GetBase, "This is a CustomListView." & CRLF & "Use '.GetBase' to parse it as a B4XView.")
	Hints.Show(lblBottomRight, "This is the bottom-right label (inside a panel)")
	Hints.Show(lblBottomMiddle,"This is the bottom-middle label (not in a panel)")
End Sub

Private Sub Button3_Click
	'White text on blue background (no outline)
	Hints.BackgroundAlpha=60+iOSExtraAlpha
	Hints.CaptionColor=xui.Color_Blue
	Hints.OutlineColor=xui.Color_Blue
	Hints.TextColor=xui.Color_White
	Hints.HighlightTargetView=True

#if b4i	
	Hints.Show(pnlTopBar,"TOP BAR")
	Hints.Show(lblTopbarLabel,"TOP BAR LABEL")
#end if
	Hints.Show(lblBottomLeft,"Set the CaptionColor and OutlineColor the same if you don't want an outline.")
	Hints.Show(lblBottomMiddle,"This hint demonstrates how the hint overlay automatically resizes multiple lines of text when required.")
	Hints.Show(lblBottomRight, "This is the bottom-right label positioned" & CRLF &  "~ INSIDE A PANEL ~")
	Hints.Show(ImageView1, "IMAGE VIEW" & CRLF & ":)")
	Hints.Show(CustomListView1.GetBase," CUSTOM LIST VIEW" & CRLF & "Headings can be used to make your hints easier to understand.")
	Hints.Show(Selector3,"OPTION 3" & CRLF & "The hint label is positioned either above or below the view, depending on which half of the screen the view is positioned in.")
End Sub

#if b4j
Private Sub lblTopRight_MouseClicked (EventData As MouseEvent)
#Else
Private Sub lblTopRight_Click
#End If	
	File.Delete(GetSaveDirectory,"hints-viewed.txt")
	xui.MsgboxAsync("Hints will be shown automatically on next startup", "Hints reset")
End Sub

Sub GetSaveDirectory As String
#if b4a
	Return rp.GetSafeDirDefaultExternal("")
#else if b4i
	Return File.DirDocuments
#else
	 Return File.DirData("Hint Overlay Example")
#end if
End Sub

#if b4i
'Hide/show navigation bar
Private Sub lblTopbarLabel_Click
	Main.NavControl.NavigationBarVisible=Not(Main.NavControl.NavigationBarVisible)
End Sub
#end if
