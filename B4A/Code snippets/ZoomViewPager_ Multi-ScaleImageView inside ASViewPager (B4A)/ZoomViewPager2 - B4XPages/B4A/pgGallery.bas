B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.4
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	
	' AppCompat interface components
	Private ACToolBarDark1 As ACToolBarDark
	Private ABHelper As ACActionBar
	
	' Gallery Layout Components (lyappcompat)
	Private ASViewPager1 As ASViewPager
	
	' Independent control variables
	Private currentIndex As Int = 0
	Private NumItems As Int
	
	' xui variable required For creating cross-platform panels
	Private xui As XUI
	
	Dim xml As XmlLayoutBuilder
End Sub


Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("lyAppCompat")
	
'	Log("pgGallery Page_Created called") ' Should NOT appear again after rotation
	
	' We obtain the number of images from your global list in the Main module
	NumItems = B4XPages.MainPage.lstFilenames.Size
	
	' Toolbar configuration
	ACToolBarDark1.SetAsActionBar
	ACToolBarDark1.InitMenuListener
	ABHelper.Initialize
	ABHelper.ShowUpIndicator = True
	
	' Apply your custom colors to the bar
	ToolBarColor
	
	
	ACToolBarDark1.Menu.Clear
'	Dim menus As List = B4XPages.GetManager.GetPageInfoFromRoot(Root).Parent.MenuItems
'	menus.Clear
	
	' Add menu items specific to this page
'	B4XPages.AddMenuItem(Me, "Save")
'	B4XPages.AddMenuItem(Me, "Configuration")
	
	' Before calling DrawableToBitmapPureB4A, Android detects the current mobile screen resolution and goes to the corresponding folder (e.g., drawable-xxhdpi),
	' takes the image from that folder, and automatically scales it if necessary to fit the device's actual pixels per inch.
	If NumItems > 1 Then
		Dim itemDelete As B4AMenuItem = B4XPages.AddMenuItem(Me, "Delete")
		itemDelete.AddToBar = True
		itemDelete.Bitmap = DrawableToBitmapPureB4A(xml.GetDrawable("ic_delete_white_24"))
	End If
	
	Dim itemRotate As B4AMenuItem = B4XPages.AddMenuItem(Me, "Rotate")
	itemRotate.AddToBar = True
	itemRotate.Bitmap = DrawableToBitmapPureB4A(xml.GetDrawable("ic_rotate_90_degrees_right_white"))
	
	Dim itemCrop As B4AMenuItem = B4XPages.AddMenuItem(Me, "Crop")
	itemCrop.AddToBar = True
	itemCrop.Bitmap = DrawableToBitmapPureB4A(xml.GetDrawable("ic_crop_white_24"))
	
	Dim itemCropAndRotate As B4AMenuItem = B4XPages.AddMenuItem(Me, "CropAndRotate")
	itemCropAndRotate.AddToBar = True
	itemCropAndRotate.Bitmap = DrawableToBitmapPureB4A(xml.GetDrawable("ic_crop_rotate_white_24"))
	

	' SIZE CONTROL AND BENCHMARKING LOG:
	#If DEBUG
		' Java Option:
		' Instantiate the resource reader
		Dim retrievedDrawable As Object = xml.GetDrawable("ic_delete_white_24") ' Returns a Drawable

		' We use JavaObject to execute the conversion function
		Dim jo As JavaObject = Me
		Dim nativeBmp As Object = jo.RunMethod("drawableToBitmap", Array(retrievedDrawable))

		' We assign it to a B4XBitmap (so you can use it in any view or class)
		Dim myBitmap As B4XBitmap = nativeBmp
		
		Log($"Icon: ic_delete_white_24"$)
	    Log($"Dimensions calculated by Java: ${myBitmap.Width} x ${myBitmap.Height} px"$)
	    Log($"Current screen density (Scale): ${xui.Scale}"$)
	#End If
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub B4XPage_Appear
'	LogColor("B4XPage_Appear - Restarting Gallery", xui.Color_Magenta)
	
	' 1. We reset the control variables to their initial state
	currentIndex = 0
	NumItems = B4XPages.MainPage.lstFilenames.Size
	
	' 2. If the ViewPager has already been Initialized, we clear it And reconfigure it
	If ASViewPager1.IsInitialized Then
		ASViewPager1.Clear ' <--- Clears all previous pages loaded into memory
		ConfigureViewPager ' <--- Recreate the panels and upload the images
	End If
End Sub


Private Sub ACToolBarDark1_NavigationItemClick
	currentIndex = 0 'We reset the photo index when going back
	B4XPages.ClosePage(Me)
End Sub

Sub ToolBarColor
	Dim ac As AppCompat
	If Root.Width > Root.Height Then
		ACToolBarDark1.Color = Colors.ARGB(60, 0, 0, 0)
	Else
		ACToolBarDark1.Color = ac.GetThemeAttribute("colorPrimary")
	End If
End Sub

Private Sub B4XPage_MenuClick (Tag As String)
	Select Tag
'		Case "Save"
'			Log("The user has pressed Save")
	
'		Case "Configuration"
'			Log("The user has pressed Configuration")
			
		Case "Delete"
			Log("The user has pressed Delete")
			RemoveImage(currentIndex)
			
		Case "Rotate"
			Log("The user has pressed Rotate")
			RotateCurrentImage
			
		Case "Crop"
			Log("The user has pressed Crop")
			
		Case "CropAndRotate"
			Log("The user has pressed CropAndRotate")
	End Select
End Sub


' The native Android method getIntrinsicWidth does not return a static, fixed size. It returns the actual width in pixels that Android calculated for that
' resource after loading and scaling it for the user's current screen
Sub DrawableToBitmapPureB4A(Drawable As Object) As B4XBitmap
	Dim joDrawable As JavaObject = Drawable
	
	' If it Is already a BitmapDrawable, we extract it directly
	Dim className As String = joDrawable.RunMethod("getClass", Null)
	If className.Contains("BitmapDrawable") Then
		Return joDrawable.RunMethod("getBitmap", Null)
	End If

	' If it is a Vector, we draw it onto an in-memory canvas
	Dim width As Int = joDrawable.RunMethod("getIntrinsicWidth", Null)
	Dim height As Int = joDrawable.RunMethod("getIntrinsicHeight", Null)
	
	' The code only uses the default value (100 pixels) as a fallback if the resource you are loading is a flat solid color that
	' mathematically has no dimensions (a "color without borders")
	If width <= 0 Then width = 100
	If height <= 0 Then height = 100

	' We initialize the Android classes to create the Bitmap
	Dim joBitmapClass As JavaObject
	joBitmapClass.InitializeStatic("android.graphics.Bitmap")
	Dim configClass As JavaObject
	configClass.InitializeStatic("android.graphics.Bitmap$Config")
	Dim configARGB As Object = configClass.GetField("ARGB_8888")

	' We create the mutable Bitmap
	Dim bmp As JavaObject = joBitmapClass.RunMethod("createBitmap", Array(width, height, configARGB))

	' We create the Android Canvas associated with that Bitmap
	Dim joCanvas As JavaObject
	joCanvas.InitializeNewInstance("android.graphics.Canvas", Array(bmp))

	' We draw the Drawable
	joDrawable.RunMethod("setBounds", Array(0, 0, width, height))
	joDrawable.RunMethod("draw", Array(joCanvas))

	Return bmp
End Sub



' --- GALLERY CONFIGURATION AND INITIALIZATION ---
Private Sub ConfigureViewPager
	' We ensure the ViewPager is empty before inserting new panels
	ASViewPager1.Clear
	
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
		Dim FileName As String = B4XPages.MainPage.lstFilenames.Get(c)
		ScaleImageView1.ImageFile = File.Combine(B4XPages.MainPage.ImagesFolder, FileName)
		
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
			B4XPages.ClosePage(Me)
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
	Log("Current image: " & index)
	
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



#If Java
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.BitmapDrawable;

public Bitmap drawableToBitmap(Drawable drawable) {
    if (drawable instanceof BitmapDrawable) {
        return ((BitmapDrawable)drawable).getBitmap();
    }
    
    // Si es un VectorDrawable (XML) u otro tipo, lo dibujamos en un lienzo Bitmap
    int width = drawable.getIntrinsicWidth();
    int height = drawable.getIntrinsicHeight();
    
    // Si el drawable no tiene dimensiones físicas (ej: color sólido), le asignamos un tamaño base
    if (width <= 0) width = 100;
    if (height <= 0) height = 100;
    
    Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
    Canvas canvas = new Canvas(bitmap);
    drawable.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
    drawable.draw(canvas);
    
    return bitmap;
}
#End If