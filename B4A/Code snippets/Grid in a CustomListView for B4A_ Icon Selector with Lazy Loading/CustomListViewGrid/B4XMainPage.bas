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
	Private CLV1 As CustomListView
	Private AR As AndroidResources		'Provides access to drawables in res/drawable
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
	'AR does not usually need to be initialized, but it is declared in Globals
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	' Monochrome vector icons stored in the AddResources/drawable folder
	Private resourcesNames  As List
	resourcesNames  = Array As String( _
        "ic_domain", "ic_emoji_emotions", "ic_emoji_objects", "ic_face_3", _
        "ic_group", "ic_interests", "ic_mood", "ic_notifications", _
        "ic_pages", "ic_precision_manufacturing", "ic_psychology", "ic_sign_language", _
		"ic_star_border", "ic_article", "ic_bookmark", "ic_browse_gallery", "ic_card_giftcard", _
		"ic_code", "ic_eco")

	FillGrid(CLV1, resourcesNames, 3)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.





' 1. FILL GRID
' Builds a grid inside a CustomListView using nested panels.
' Each CLV row holds [Columns] cell panels loaded from lyItemGrid.
' Layout hierarchy: pnlCell (dynamic) > pnlBase[0] > imgFoto[0]
'                                                   > lblName[1]
Public Sub FillGrid(clv As CustomListView, dataList As List, Columns As Int)
    clv.Clear

    Dim totalWidth  As Int = clv.AsView.Width
	Dim itemWidth   As Int = (totalWidth / Columns) - 2dip
	Dim itemHeight As Int = itemWidth * 1.2  ' Aspect ratio 1:1.2 (icon + label)  because the icon occupies 0.60 of the height and the label the rest
'	Dim itemHeight  As Int = 150dip		'fixed height
	Dim numRows     As Int = Ceil(dataList.Size / Columns)
    Dim margin      As Int = 4dip

	' Centering calculations for icon and label within the cell
    Dim cellWidth   As Int = itemWidth - (margin * 2)
    Dim photoSize    As Int = itemHeight * 0.60
	Dim photoLeft    As Int = (cellWidth - photoSize) / 2	' Horizontal center offset
	Dim lblHeight   As Int = itemHeight - photoSize

    For f = 0 To numRows - 1
		' Row panel: spans full CLV width
        Dim pRow As B4XView = xui.CreatePanel("")
        pRow.SetLayoutAnimated(0, 0, 0, totalWidth, itemHeight)

		For c = 0 To Columns - 1
			Dim dataIndex As Int = (f * Columns) + c
			If dataIndex >= dataList.Size Then Exit

			' pnlCell: dynamic container. LoadLayout adds pnlBase as child [0].
			' "Cell" is the event name → fires Cell_Click on tap.
            Dim pCell As B4XView = xui.CreatePanel("Cell")
			pCell.SetLayoutAnimated(0, margin, 0, cellWidth, itemHeight)  ' size first
			pCell.LoadLayout("lyItemGrid")                             ' then layout

			' Navigate fixed hierarchy to reach imgFoto and lblName
			Dim iv  As ImageView = pCell.GetView(0).GetView(0)	' pnlBase > ivPhoto
			Dim lbl As Label     = pCell.GetView(0).GetView(1)	' pnlBase > lblName
			
			' Apply centered layout to icon and label programmatically
			iv.SetLayoutAnimated( 0, photoLeft, 0,         photoSize,    photoSize)
			lbl.SetLayoutAnimated(0, 0,         photoSize, cellWidth,    lblHeight)

			' LoadLayout binds lblName to the module variable immediately.
			' Capture it before the next iteration overwrites the reference.
			Dim name As String = dataList.Get(dataIndex)
			lbl.Text      = name
'			iv.Background = Null	' Cleared; drawable loaded lazily in VisibleRangeChanged. If the Designer has any drawables in ivPhoto

			' Tag Map: data source for lazy loading and click handling.
			' "loaded" flag avoids reloading; profiles are few and vectors are lightweight
			' so loaded drawables are kept in memory for the session.
            Dim cellTag As Map
            cellTag.Initialize
			cellTag.Put("name",     name)	' keep if lazy-loading
            cellTag.Put("loaded",   False)
			pCell.Tag = cellTag

			pRow.AddView(pCell, c * itemWidth, 0, itemWidth, itemHeight)
        Next

        clv.Add(pRow, f)
    Next
End Sub



' 2. LAZY LOADING
' Triggered by the CLV as rows enter the visible range.
' Loads drawables from AddResources via AndroidResources.
' Skips already-loaded cells ("loaded" flag in Tag Map).
Sub CLV1_VisibleRangeChanged(FirstIndex As Int, LastIndex As Int)
	' Extend range by 1 on each side for smoother scrolling
	For i = Max(0, FirstIndex - 1) To Min(CLV1.Size - 1, LastIndex + 1)
		Dim pRow As B4XView = CLV1.GetPanel(i)
        
		' Iterate direct children (each is a cell panel, no recursion needed)
		For c = 0 To pRow.NumberOfViews - 1
			Dim pCell As B4XView = pRow.GetView(c)
            
			' Only process cells that have a resource name assigned
			If Not(pCell.Tag Is Map) Then Continue ' Skip slots without data
            
			Dim cellTag As Map = pCell.Tag
			If cellTag.Get("loaded") Then Continue  ' Already loaded this session
			
			' Fixed hierarchy: 
			' The hierarchy is navigated directly (known layout): pCell > pnlBase > ivPhoto
			Dim iv As ImageView = pCell.GetView(0).GetView(0)

			Try
				Dim dr As Object = AR.GetApplicationDrawable(cellTag.Get("name"))
				iv.Background = dr
				cellTag.Put("loaded", True) ' Map is ref type: update in place
			Catch
				Log("Failed to load drawable: " & cellTag.Get("name"))
			End Try
		Next
	Next
End Sub


' 3. CELL CLICK
' Sender is the pnlCell that received the tap (event name "Cell").
' Reads the Tag Map for the resource name, then briefly highlights
' the cell with a color animation as visual selection feedback.
Sub Cell_Click
	Dim pnlPulsed As B4XView = Sender
    
	Dim mapData As Map = pnlPulsed.Tag
	
'	Log(mapData)
    
	' Now you can distinguish which item it is
	Dim name As String = mapData.Get("name")
    
	Log("You have selected the icon: " & name)
	ToastMessageShow("You have selected the icon: " & name, False)
    
	' If you want to do something visual, like highlighting the cell:
	pnlPulsed.SetColorAnimated(200, Colors.LightGray, Colors.White)
End Sub
