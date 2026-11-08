B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
	
	'Required for all activities that use AppCompat
	#Extends: android.support.v7.app.AppCompatActivity
#End Region

Sub Process_Globals
	' Since it is Public and located here, it does not initialize to 0 when the screen rotates.
	' It will retain the photo number the user was on.
	Public currentIndex As Int = 0
End Sub

Sub Globals
	' AppCompat interface components
	Private ACToolBarDark1 As ACToolBarDark
	Private ABHelper As ACActionBar
	Private itemDelete As ACMenuItem
	
	' Modern page-turning component
	Private ASViewPager1 As ASViewPager
	Private NumItems As Int
	
	' xui variable required For creating cross-platform panels
	Private xui As XUI
End Sub

Sub Activity_Create(FirstTime As Boolean)
	' We load the Main layout containing ASViewPager1
	Activity.LoadLayout("LayoutAppCompat")
	
	' Toolbar configuration
	ACToolBarDark1.SetAsActionBar
	ACToolBarDark1.InitMenuListener
	ABHelper.Initialize
	ABHelper.ShowUpIndicator = True
	
	' Apply your custom colors to the bar
	ToolBarColor

	' We obtain the number of images from your global list in the Main module
	NumItems = Main.lstFilenames.Size
	
	' We initialize And populate the image gallery
	ConfigureViewPager
End Sub

Sub Activity_Resume
	' If the activity returns to the foreground and page loading has completely finished
	If ASViewPager1.IsInitialized And ASViewPager1.Size = NumItems Then
		If currentIndex < ASViewPager1.Size Then
			ASViewPager1.CurrentIndex = currentIndex
		End If
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)
End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean
	' Clean handling of the device's physical back button
	If KeyCode = KeyCodes.KEYCODE_BACK Then
		currentIndex = 0
		Activity.Finish
		Return True
	End If
	Return False
End Sub

Sub Activity_CreateMenu(Menu As ACMenu)
	Dim item As ACMenuItem
	Dim xml As XmlLayoutBuilder
	Menu.Clear

	If NumItems > 1 Then
		itemDelete = ACToolBarDark1.Menu.Add2(10, 1, "Delete", xml.GetDrawable("ic_delete_white_24"))
		itemDelete.ShowAsAction = itemDelete.SHOW_AS_ACTION_ALWAYS
	End If
	
	item = ACToolBarDark1.Menu.Add2(11, 2, "Rotate", xml.GetDrawable("ic_rotate_90_degrees_right_white"))
	item.ShowAsAction = item.SHOW_AS_ACTION_ALWAYS
	
	item = ACToolBarDark1.Menu.Add2(12, 3, "Crop", xml.GetDrawable("ic_crop_white_24"))
	item.ShowAsAction = item.SHOW_AS_ACTION_ALWAYS
	
	item = ACToolBarDark1.Menu.Add2(13, 4, "CropAndRotate", xml.GetDrawable("ic_crop_rotate_white_24"))
	item.ShowAsAction = item.SHOW_AS_ACTION_ALWAYS
End Sub

Sub ACToolBarDark1_MenuItemClick (Item As ACMenuItem)
	' We verify that the gallery is initialized and contains at least one photo.
	If ASViewPager1.IsInitialized And ASViewPager1.Size > 0 Then
		
		Select Item.Title
			Case "Delete"
				' We call RemoveImage, passing it the index of the photo the user is currently viewing
				RemoveImage(currentIndex)
			Case "Rotate"
				ToastMessageShow("Rotated directly with ScaleImageView library by agraham ", False)
				RotateCurrentImage
			Case "Crop"
				ToastMessageShow("Function not available in this example. Use ResizeAndCrop7 by klaus to crop", False)
				' https://www.b4x.com/android/forum/threads/resize-And-crop-image.95001/
				
			Case "CropAndRotate"
				ToastMessageShow("Function not available in this example. Use xResizeAndCrop library by klaus to rotate and crop", True)
				' Or https://www.b4x.com/android/forum/threads/b4x-xui-xresizeandcrop.100109/#content
		End Select
	End If
End Sub

#If Java
public boolean _onCreateOptionsMenu(android.view.Menu menu) {
    if (processBA.subExists("activity_createmenu")) {
        processBA.raiseEvent2(null, true, "activity_createmenu", false, new de.amberhome.objects.appcompat.ACMenuWrapper(menu));
        return true;
    }
    return false;
}
#End If

Private Sub ACToolBarDark1_NavigationItemClick
	currentIndex = 0 'We reset the photo index when going back
	Activity.Finish
End Sub

Sub ToolBarColor
	Dim ac As AppCompat
	If Activity.Width > Activity.Height Then
		ACToolBarDark1.Color = Colors.ARGB(60, 0, 0, 0)
	Else
		ACToolBarDark1.Color = ac.GetThemeAttribute("colorPrimary")
	End If
End Sub




' --- GALLERY CONFIGURATION AND INITIALIZATION ---
Private Sub ConfigureViewPager
	' We wait a brief moment To ensure that the interface container has calculated its actual size
	Sleep(50)
	
	For c = 0 To NumItems - 1
		' 1. We created the xui-compatible container panel.
		Dim tmp_xpnl As B4XView = xui.CreatePanel("")
		
		' 2. We assign it the exact dimensions of the ASViewPager base
		tmp_xpnl.SetLayoutAnimated(0, 0, 0, ASViewPager1.Base.Width, ASViewPager1.Base.Height)
		
		' 3. We load the custom photo layout into the panel
		tmp_xpnl.LoadLayout("LayoutViewer")
		
		' 4. We extract the native image viewer from the layout and configure it
		Dim ScaleImageView1 As ScaleImageView = tmp_xpnl.GetView(0)
		ScaleImageView1.PanLimit = ScaleImageView1.PAN_LIMIT_INSIDE
		ScaleImageView1.DoubleTapZoomDuration = 250
		ScaleImageView1.Orientation = ScaleImageView1.ORIENTATION_USE_EXIF
		
		' 5. We hide the central circle
		ScaleImageView1.EnableCircle = False
		
		' 6. We assign the corresponding File path
		Dim FileName As String = Main.lstFilenames.Get(c)
		ScaleImageView1.ImageFile = File.Combine(Main.ImagesFolder, FileName)
		
		' 7. We add the full panel with the photo as a new page
		ASViewPager1.AddPage(tmp_xpnl, "")
	Next
	
	' --- TRICK HERE ---
	' We add a Sleep(0) right before moving the index.
	' This ensures the operating system has rendered the pages in the layout
	' before forcing the ViewPager to jump to the index of the photo stored in Process_Globals
	Sleep(0)
	
	' We position the gallery at the last recorded photo
	If currentIndex < ASViewPager1.Size Then
		ASViewPager1.CurrentIndex = currentIndex
	End If
End Sub




' --- CONTENT MANIPULATION ACTIONS ---

' Delete an image and show the next one:
Public Sub RemoveImage(Position As Int)
	If Position < ASViewPager1.Size Then
		' 1. We are deleting the page with the current photo
		ASViewPager1.RemovePage(Position)
		NumItems = ASViewPager1.Size
			
		' 2. If we delete the last photo in the list, we move the index back by one position
		If currentIndex >= NumItems And currentIndex > 0 Then
			currentIndex = currentIndex - 1
		End If
			
		' 3. Tip for AsViewPager: If the gallery is empty, we close the screen automatically
		If NumItems = 0 Then
			currentIndex = 0
			Activity.Finish
			Return
		End If
			
		ToastMessageShow("Image removed", False)
	End If
End Sub


' Method to rotate the current image 90 degrees to the right
Private Sub RotateCurrentImage
	If ASViewPager1.IsInitialized And ASViewPager1.Size > 0 Then
		' 1. We get the panel for the current page
		Dim tmp_xpnl As B4XView = ASViewPager1.GetPanel(currentIndex)
		' 2. We extract the ScaleImageView
		Dim siv As ScaleImageView = tmp_xpnl.GetView(0)
        
		' 3. We read the current orientation and add 90 degrees
		Dim newOrientation As Int = siv.Orientation + 90
		If newOrientation >= 360 Then newOrientation = 0
        
		' 4. We apply the new rotation (the library renders it instantly)
		siv.Orientation = newOrientation
	End If
End Sub




' --- NATIVE EVENTS ---

' This event triggers automatically when you switch photos by swiping
Sub ASViewPager1_PageChanged (index As Int)
	Log("Imagen actual: " & index)
	
	' We check whether we are coming from a valid page and whether it is different from the current one
	If currentIndex < ASViewPager1.Size And currentIndex <> index Then
		Try	' If a user starts flipping through the photos at high speed. Because ASViewPager is a dynamic component that creates and destroys
			' and recycles panels in the background to save RAM while the user quickly swipes through the gallery
			
			' 1. We obtain the base panel (B4XView) using the correct ASViewPager method: GetPanel
			Dim pnlPrevious As B4XView
			pnlPrevious = ASViewPager1.GetPanel(currentIndex)
			
			' 2. We extract your native ScaleImageView
			Dim siv As ScaleImageView = pnlPrevious.GetView(0)
			
			' 3. We zoom out to the minimum and automatically center the photo
			siv.ResetScaleAndCenter
			
			' 4. We reset the rotation to the initial angle (0 degrees)
			siv.Orientation = 0
		Catch
			Log("The scale could not be reset: " & LastException.Message)
		End Try
	End If
	
	' We update the index to the page where the user is currently located
	currentIndex = index
End Sub

Sub ScaleImageView1_Click
	ToastMessageShow($"Selected image (Position): ${currentIndex}"$, False)
End Sub

Sub ScaleImageView1_LongClick
	ToastMessageShow($"Long click on the image: ${currentIndex}"$, False)
End Sub