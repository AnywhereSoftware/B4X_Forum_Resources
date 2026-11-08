B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.8
@EndOfDesignText@
#DesignerProperty: Key: Padding, DisplayName: Padding, FieldType: Int, DefaultValue: 5, Description: Cell padding
#DesignerProperty: Key: Margin, DisplayName: Margin, FieldType: Int, DefaultValue: 5, Description: Cell margin
#DesignerProperty: Key: Rows, DisplayName: Rows, FieldType: Int, DefaultValue: 3, Description: Number of rows
#DesignerProperty: Key: Cols, DisplayName: Cols, FieldType: Int, DefaultValue: 3, Description: Number of columns
#Event: Click
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private fx As JFX
	Private mRowNumber As Int = 3
	Private mColNumber As Int = 3
	Private mPadding As Int = 5
	Private mMargin As Int = 5
	Private mPageIndex As Int = 0
	Private views As List
	Private mLabel As String = "Image {0}"
	Private mSelectedIndices As List
	Private Const LABEL_HEIGHT As Int = 25  ' Fixed label height
	Private kvs As KeyValueStore
	Private mThumbnailSize As Int = 128
	Private lastSelectedIndex As Int = -1
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	views.Initialize
	mSelectedIndices.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	' Read padding and margin values
	If Props.ContainsKey("Padding") Then
		mPadding = Props.Get("Padding")
	End If
	If Props.ContainsKey("Margin") Then
		mMargin = Props.Get("Margin")
	End If
	If Props.ContainsKey("Rows") Then
		mRowNumber = Props.Get("Rows")
	End If
	If Props.ContainsKey("Cols") Then
		mColNumber = Props.Get("Cols")
	End If
End Sub

private Sub CreateThumbnailBitmap(img As B4XBitmap) As B4XBitmap
	img = img.Resize(mThumbnailSize,mThumbnailSize,True)
	Return img
End Sub

Private Sub PutThumbnailBitmapInDataBase(key As String,img As B4XBitmap)
	If kvs.IsInitialized Then
		kvs.Put(key,ImageToBytes(img))
	End If
End Sub

Private Sub GetThumbnailBitmapFromDataBase(key As String) As B4XBitmap
	If kvs.IsInitialized Then
		If kvs.ContainsKey(key) Then
			Return BytesToImage(kvs.Get(key))
		End If
	End If
	Return Null
End Sub

public Sub EnableThumbnailDatabase(dir As String,filename As String)
	kvs.Initialize(dir,filename)
End Sub

Public Sub getPageIndex As Int
	Return mPageIndex
End Sub

Public Sub setPageIndex(value As Int)
	mPageIndex = value
End Sub

Public Sub getLabel As String
	Return mLabel
End Sub

Public Sub setLabel(value As String)
	mLabel = value
End Sub

' RowNumber property
Public Sub getRowNumber As Int
	Return mRowNumber
End Sub

Public Sub setRowNumber(value As Int)
	If value > 0 Then
		mRowNumber = value
		' If view is already loaded, re-layout
		If mBase.IsInitialized And views.Size > 0 Then
			UpdateLayout(mBase)
		End If
	End If
End Sub

' ColNumber property
Public Sub getColNumber As Int
	Return mColNumber
End Sub

Public Sub setColNumber(value As Int)
	If value > 0 Then
		mColNumber = value
		' If view is already loaded, re-layout
		If mBase.IsInitialized And views.Size > 0 Then
			UpdateLayout(mBase)
		End If
	End If
End Sub

' Padding property
Public Sub getPadding As Int
	Return mPadding
End Sub

Public Sub setPadding(value As Int)
	If value >= 0 Then
		mPadding = value
		' If view is already loaded, refresh all cells
		If mBase.IsInitialized And views.Size > 0 Then
			For Each p As Pane In views
				thumbnailCellPane_Resize2(p.Width, p.Height, p)
			Next
		End If
	End If
End Sub

' Margin property
Public Sub getMargin As Int
	Return mMargin
End Sub

Public Sub setMargin(value As Int)
	If value >= 0 Then
		mMargin = value
		' If view is already loaded, re-layout
		If mBase.IsInitialized And views.Size > 0 Then
			UpdateLayout(mBase)
		End If
	End If
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	If views.Size > 0 Then
		UpdateLayout(mBase)
	End If
End Sub

Private Sub GetThumbnailKey(filename As String, modificationDate As String) As String
	Return filename&"-"&modificationDate
End Sub

Private Sub LoadBitmapAsThumbnail(dir As String,filename As String) As B4XBitmap
	Dim img As B4XBitmap
	Dim modificationDate As String = File.LastModified(dir,filename)
	Dim key As String = GetThumbnailKey(filename,modificationDate)
	If kvs.IsInitialized Then
		If kvs.ContainsKey(key) Then
			img = GetThumbnailBitmapFromDataBase(key)
			Return img
		End If
	End If
	img = fx.LoadImage(dir,filename)
	img = CreateThumbnailBitmap(img)
	If kvs.IsInitialized Then
		PutThumbnailBitmapInDataBase(key,img)
	End If
	Return img
End Sub

Public Sub BytesToImage(bytes() As Byte) As Image
	Dim In As InputStream
	In.InitializeFromBytesArray(bytes, 0, bytes.Length)
	Dim bmp As Image
	bmp.Initialize2(In)
	In.Close
	Return bmp
End Sub

private Sub ImageToBytes(Image As B4XBitmap) As Byte()
	Dim out As OutputStream
	out.InitializeToBytesArray(0)
	Image.WriteToStream(out, 100, "JPEG")
	out.Close
	Return out.ToBytesArray
End Sub


Public Sub LoadThumbnails(dir As String,filenames As List)
	For Each n As Node In views
		n.RemoveNodeFromParent
	Next
	views.Initialize
	Dim totalPageIndex As Int = 0
	For i = 0 To mRowNumber - 1
		For j = 0 To mColNumber - 1
			totalPageIndex = totalPageIndex + 1
			If filenames.Size > 0 Then
				Dim filename As String = filenames.Get(0)
				Dim img As B4XBitmap = LoadBitmapAsThumbnail(dir,filename)
				Dim iv As ImageView = CreateImageView(img)
				Dim labelText As String
				If mLabel.Contains("{0}") Then
					labelText = mLabel.Replace("{0}",(mPageIndex*mRowNumber*mColNumber + totalPageIndex))
				Else
					labelText = mLabel
				End If
				If labelText.Contains("{filename}") Then
					labelText = labelText.Replace("{filename}",filename)
				End If
				Dim lbl As Label = CreateLabel(labelText)  ' Create label
				Dim p As Pane = CreateThumbnailCellPane(iv, lbl)
				mBase.AddView(p,0,0,0,0)
				views.Add(p)
				filenames.RemoveAt(0)
			Else
				UpdateLayout(mBase)
				Return
			End If
		Next
	Next
	UpdateLayout(mBase)
End Sub

Private Sub UpdateLayout(parent As Pane)
	' Calculate available space (subtract left and right margins)
	Dim availableWidth As Double = parent.Width - (mMargin * 4)  ' 2x margin on left and right
	Dim availableHeight As Double = parent.Height - (mMargin * 2) ' 1x margin on top and bottom
    
	' Total cell width = available width / number of columns
	Dim totalCellWidth As Double = availableWidth / mColNumber
	Dim totalCellHeight As Double = availableHeight / mRowNumber
    
	' Actual content width per cell = total width - (left and right margin)
	Dim contentWidth As Double = totalCellWidth - (mMargin * 2)
	Dim contentHeight As Double = totalCellHeight - (mMargin * 2)
    
	Dim index As Int = 0
	For i = 0 To mRowNumber - 1
		For j = 0 To mColNumber - 1
			If views.Size - 1 < index Then
				Return
			End If
			Dim p As Pane = views.Get(index)
            
			' Calculate cell top-left position
			' Left starting position = left margin + (column number * total cell width)
			Dim left As Double = (mMargin * 2) + (j * totalCellWidth) + mMargin
			Dim top As Double = (mMargin * 1) + (i * totalCellHeight) + mMargin
            
			' Set cell position and size (content area)
			p.SetLayoutAnimated(0, left, top, contentWidth, contentHeight)
			index = index + 1
		Next
	Next
End Sub

Private Sub CreateThumbnailCellPane(iv As ImageView, lbl As Label) As Pane
	Dim p As Pane
	p.Initialize("thumbnailCellPane")
	
	' Add Label first (at bottom)
	p.AddNode(lbl, 0, 0, -1, -1)
	' Then add ImageView (at top, needs to reserve label height and padding)
	p.AddNode(iv, mPadding, mPadding, -1, -1)
	
	CSSUtils.SetBorder(p, 1, fx.Colors.Black, 0)
	Return p
End Sub

Private Sub thumbnailCellPane_Resize (Width As Double, Height As Double)
	thumbnailCellPane_Resize2(Width, Height, Sender)
End Sub

Private Sub thumbnailCellPane_Resize2 (Width As Double, Height As Double, p As Pane)
	Dim iv As ImageView = p.GetNode(1)  ' Second node is ImageView
	Dim lbl As Label = p.GetNode(0)      ' First node is Label
	
	' Set Label position and size (bottom)
	Dim labelY As Int = Height - LABEL_HEIGHT
	lbl.SetLayoutAnimated(0, 0, labelY, Width, LABEL_HEIGHT)
	
	' Available space after subtracting padding and label height (for image)
	Dim availableWidth As Double = Width - (mPadding * 2)
	Dim availableHeight As Double = Height - (mPadding * 2) - LABEL_HEIGHT
	
	' Calculate and set only if image space is valid
	If availableWidth > 0 And availableHeight > 0 And iv.GetImage.IsInitialized Then
		Dim ratio As Double = iv.GetImage.Width / iv.GetImage.Height
		Dim controlRatio As Double = availableWidth / availableHeight
		Dim displayWidth As Double
		Dim displayHeight As Double
		Dim offsetX As Int = mPadding
		Dim offsetY As Int = mPadding
		
		'control ratio > ratio: use height
		If controlRatio > ratio Then
			displayHeight = availableHeight
			displayWidth = availableHeight * ratio
			offsetX = offsetX + (availableWidth - displayWidth) / 2
		Else
			displayWidth = availableWidth
			displayHeight = availableWidth / ratio
			offsetY = offsetY + (availableHeight - displayHeight) / 2
		End If
		
		iv.SetLayoutAnimated(0, offsetX, offsetY, displayWidth, displayHeight)
	End If
End Sub

Private Sub CreateImageView(img As B4XBitmap) As ImageView
	Dim iv As ImageView
	iv.Initialize("iv")
	iv.PreserveRatio = True
	iv.SetImage(img)
	Return iv
End Sub

Private Sub CreateLabel(text As String) As Label
	Dim lbl As Label
	lbl.Initialize("lbl")
	lbl.Text = text
	lbl.Alignment = "CENTER"
	lbl.Font = fx.DefaultFont(12)
	lbl.TextColor = fx.Colors.Black
	Return lbl
End Sub

' Modified thumbnailCellPane_MouseClicked method
Private Sub thumbnailCellPane_MouseClicked (EventData As MouseEvent)
	Dim p As B4XView = Sender
	Dim currentIndex As Int = views.IndexOf(p)
	Dim jo As JavaObject = EventData
	' Check if Ctrl key is pressed
	If jo.RunMethod("isControlDown",Null) Then
		' Ctrl multi-select: toggle current item's selection state
		If mSelectedIndices.IndexOf(currentIndex) >= 0 Then
			' If already selected, deselect
			mSelectedIndices.RemoveAt(mSelectedIndices.IndexOf(currentIndex))
			p.SetColorAnimated(0, xui.Color_Transparent, xui.Color_Transparent)
		Else
			' If not selected, add selection
			mSelectedIndices.Add(currentIndex)
			p.SetColorAnimated(250, xui.Color_Transparent, xui.Color_ARGB(120,0,0,255))
		End If
	Else If jo.RunMethod("isShiftDown",Null) And lastSelectedIndex >= 0 Then
		' Shift multi-select: select all items from lastSelectedIndex to currentIndex
		Dim startIndex As Int = Min(lastSelectedIndex, currentIndex)
		Dim endIndex As Int = Max(lastSelectedIndex, currentIndex)
        
		' Clear all selection states first
		For Each v As B4XView In views
			v.SetColorAnimated(0, xui.Color_Transparent, xui.Color_Transparent)
		Next
		mSelectedIndices.Clear
        
		' Select all items in range
		For i = startIndex To endIndex
			mSelectedIndices.Add(i)
			Dim view As B4XView = views.Get(i)
			view.SetColorAnimated(250, xui.Color_Transparent, xui.Color_ARGB(120,0,0,255))
		Next
	Else
		' Normal click: single select, clear other selections
		mSelectedIndices.Clear
		For Each v As B4XView In views
			v.SetColorAnimated(0, xui.Color_Transparent, xui.Color_Transparent)
		Next
		p.SetColorAnimated(250, xui.Color_Transparent, xui.Color_ARGB(120,0,0,255))
		mSelectedIndices.Add(currentIndex)
	End If
    
	' Update last selected index
	If jo.RunMethod("isShiftDown",Null) = False Then
		lastSelectedIndex = currentIndex
	End If
    
    
	' Trigger click event
	If SubExists(mCallBack, mEventName & "_Click") Then
		CallSub(mCallBack, mEventName & "_Click")
	End If
End Sub

' Modified getSelectedIndices method, returns actual indices (considering pagination)
public Sub getSelectedIndices As List
	Dim list1 As List
	list1.Initialize
	For Each index As Int In mSelectedIndices
		Dim realIndex As Int = mPageIndex * mRowNumber * mColNumber + index
		list1.Add(realIndex)
	Next
	Return list1
End Sub

' New: Get list of selected view objects
public Sub getSelectedViews As List
	Dim list1 As List
	list1.Initialize
	For Each index As Int In mSelectedIndices
		If index >= 0 And index < views.Size Then
			list1.Add(views.Get(index))
		End If
	Next
	Return list1
End Sub

' New: Clear all selection states
public Sub ClearSelection()
	mSelectedIndices.Clear
	For Each v As B4XView In views
		v.SetColorAnimated(0, xui.Color_Transparent, xui.Color_Transparent)
	Next
	lastSelectedIndex = -1
End Sub

' New: Select specified index (considering pagination)
public Sub SelectIndex(globalIndex As Int)
	' Calculate index on current page
	Dim pageFirstIndex As Int = mPageIndex * mRowNumber * mColNumber
	Dim pageLastIndex As Int = pageFirstIndex + (mRowNumber * mColNumber) - 1
    
	If globalIndex >= pageFirstIndex And globalIndex <= pageLastIndex Then
		Dim localIndex As Int = globalIndex - pageFirstIndex
		If localIndex >= 0 And localIndex < views.Size Then
			mSelectedIndices.Clear
			mSelectedIndices.Add(localIndex)
            
			' Update UI
			For Each v As B4XView In views
				v.SetColorAnimated(0, xui.Color_Transparent, xui.Color_Transparent)
			Next
			Dim p As B4XView = views.Get(localIndex)
			p.SetColorAnimated(250, xui.Color_Transparent, xui.Color_ARGB(120,0,0,255))
            
			lastSelectedIndex = localIndex
		End If
	End If
End Sub

' New: Get selected count
public Sub getSelectedCount As Int
	Return mSelectedIndices.Size
End Sub

' New: Check if specified index is selected
public Sub IsSelected(globalIndex As Int) As Boolean
	Dim pageFirstIndex As Int = mPageIndex * mRowNumber * mColNumber
	Dim localIndex As Int = globalIndex - pageFirstIndex
	Return mSelectedIndices.IndexOf(localIndex) >= 0
End Sub