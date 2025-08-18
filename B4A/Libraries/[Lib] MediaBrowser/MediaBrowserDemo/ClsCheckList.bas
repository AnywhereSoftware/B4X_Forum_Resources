Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=2.22
@EndOfDesignText@
' Class module
' CheckList v2.22
Sub Class_Globals
	' Public
	Public BackgroundColor As Int
	Public CheckedColor As Int
	Public DividerColor As Int
	Public ExtensionColor As Int
	Public FilterResult As Boolean
	' Private
	Private sv As ScrollView
	Private svHeight As Int
	Private ExtensionIndex As Int
	Private ExtensionView As View
	Private CallbackMod As Object
	Private sub_Check, sub_Click, sub_LongClick As String
	Private sub_Paint As String
	Private ModeCheck As Boolean
	Private BlockCheckEvent As Boolean
	Private PressedPanel As Panel
	Private PressedDrawable As Object
	Private OldBackground As Object
	Private DividerSize As Int
	' Drag & drop
	Private DragAndDrop, DragAndDropShadow As Panel
	Private OriginDDTop, LastY As Int
	Private sub_AfterDrop As String
	' Constants
	Private ChkBoxSize  As Int: ChkBoxSize  = 40dip
	Private BitmapSize As Int: BitmapSize = 50dip
	Private LabelHeight  As Int: LabelHeight  = 25dip
	Private PanelHeight As Int: PanelHeight = 2 * LabelHeight
	Private PAINT_DEFAULT As Int: PAINT_DEFAULT = 0
	Private PAINT_EXTENDED As Int: PAINT_EXTENDED = 1
	Private PAINT_CHECKED As Int: PAINT_CHECKED = 2
	Private PAINT_PRESSED As Int: PAINT_PRESSED = 4
	' Types
	Type typSortData(Index As Int, Value As Object)
End Sub

' Initializes the ScrollView.
' Module: Callback module (Me)
' svList: ScrollView used to display the list
' subCheck, subClick, subLongClick: Name of subs handling events (if subClick="", clicks on items check/uncheck the checkbox)
' DividerHeight: Height of the line separating items (0 = no line)
Public Sub Initialize(Module As Object, svList As ScrollView, subCheck As String, subClick As String, subLongClick As String, DividerHeight As Int)
	sv = svList
	For i = sv.Panel.NumberOfViews-1 To 0 Step -1
		sv.Panel.RemoveViewAt(i)
	Next
	sv.Panel.Height = 0
	svHeight = 0
	CallbackMod = Module
	sub_Check = subCheck
	sub_Click = subClick
	sub_LongClick = subLongClick
	ModeCheck = (sub_Click = "")
	BlockCheckEvent = False
	DividerSize = DividerHeight
	DividerColor = Colors.ARGB(128, 200, 200, 200)
	BackgroundColor = Colors.Transparent
	CheckedColor = Colors.Transparent
	ExtensionColor = Colors.Transparent
	ExtensionIndex = -1
	ExtensionView = Null
	Dim r As Reflector
	r.Target = r.GetContext
	r.Target = r.RunMethod("getResources")
	r.Target = r.RunMethod("getSystem")
	Dim ID_PressedDrawable As Int
	ID_PressedDrawable = r.RunMethod4("getIdentifier", Array As Object("list_selector_background_pressed", "drawable", "android"), _
																		Array As String("java.lang.String", "java.lang.String", "java.lang.String"))
	r.Target = r.GetContext
	r.Target = r.RunMethod("getResources")
	PressedDrawable = r.RunMethod2("getDrawable", ID_PressedDrawable, "java.lang.int")
	DragAndDrop = Null
End Sub

#Region Bitmaps
' Resizes the given picture
Private Sub CreateScaledBitmap(Original As Bitmap, Width As Int, Height As Int) As Bitmap
	Dim r As Reflector
	Dim b As Bitmap
	b = r.RunStaticMethod("android.graphics.Bitmap", "createScaledBitmap", _
			Array As Object(Original, Width, Height, True), _
			Array As String("android.graphics.Bitmap", "java.lang.int", "java.lang.int", "java.lang.boolean"))
	Return b
End Sub

' Resizes the bitmap to fit the given dimensions
Public Sub AdjustBitmap(bmp As Bitmap, Width As Int, Height As Int) As Bitmap
	Dim RatioBmp, RatioIV As Float
	RatioBmp = bmp.Width / bmp.Height
	RatioIV = Width / Height
	Dim Diviseur As Float
	If RatioIV > RatioBmp Then
		Diviseur = bmp.Height / Height
		bmp = CreateScaledBitmap(bmp, Round(bmp.Width / Diviseur / Density), Round(Height / Density))
	Else
		Diviseur = bmp.Width / Width
		bmp = CreateScaledBitmap(bmp, Round(Width / Density), Round(bmp.Height / Diviseur / Density))
	End If
	Return bmp
End Sub

' Returns a screenshot of the given view
Private Sub ViewToBmp(MyView As View) As Bitmap
	' Thanks to Stevel05 for this code
	Dim bmp As Bitmap
	Dim c As Canvas
	bmp.InitializeMutable(MyView.Width, MyView.Height)
	c.Initialize2(bmp)

	Dim r1, r2 As Reflector
	r1.Target = MyView
	r2.Target = c
	r2.Target = r2.GetField("canvas")

	Dim args(1) As Object
	Dim types(1) As String
	args(0) = r2.Target
	types(0) = "android.graphics.Canvas"
	r1.RunMethod4("draw", args, types)

	Return c.Bitmap
End Sub
#End Region

#Region Add items
' Adds a item (the created panel contains a checkbox, an optional bitmap and one or two labels)
' Set Text2 to "" if you don't want a second label and Image to Null if there's no bitmap
Public Sub AddItem(ID As Object, Checked As Boolean, Text1 As String, Text2 As String, Image As Bitmap)
	Dim pnl As Panel: pnl.Initialize("")
	Dim chk As CheckBox:	chk.Initialize("chbSV")
	pnl.Tag = ID
	pnl.AddView(chk, 0, 0, ChkBoxSize, PanelHeight)
	Dim LargeurLabel As Int, PosX As Int
	LargeurLabel = 150%x
	If Not(Image.IsInitialized) Then
		PosX = ChkBoxSize
	Else
		Dim iv As ImageView: iv.Initialize("")
		Dim bmp As Bitmap
		bmp = Image
		If NumberFormat(bmp.Width / bmp.Height, 1, 2) = NumberFormat(1, 1, 2) Then
			' Aspect ratio nearly equal -> filling
			iv.Gravity = Gravity.FILL
		Else
			' Different aspect ratio -> resizing
			bmp = AdjustBitmap(bmp, BitmapSize, BitmapSize)
			iv.Gravity = Gravity.NO_GRAVITY
		End If
		iv.Bitmap = bmp
		pnl.AddView(iv, ChkBoxSize, 0, BitmapSize, BitmapSize)
		PosX = ChkBoxSize + BitmapSize + 5dip
	End If
	Dim lbl1 As Label: lbl1.Initialize("")
	lbl1.Gravity = Gravity.CENTER_VERTICAL
	lbl1.Text = Text1
	lbl1.TextColor = Colors.White
	lbl1.TextSize = 18
	lbl1.Typeface = Typeface.DEFAULT_BOLD
	If Text2 = "" Then
		pnl.AddView(lbl1, PosX, 0, LargeurLabel, PanelHeight)
	Else
		pnl.AddView(lbl1, PosX, 0, LargeurLabel, LabelHeight)
		Dim lbl2 As Label: lbl2.Initialize("")
		lbl2.Gravity = Gravity.TOP
		lbl2.Text = Text2
		lbl2.TextColor = Colors.LightGray
		lbl2.TextSize = 16
		lbl2.Typeface = Typeface.DEFAULT
		pnl.AddView(lbl2, PosX, LabelHeight, LargeurLabel, LabelHeight)
	End If
	AddToSV(pnl, PanelHeight, True)
	BlockCheckEvent = True
	chk.Checked = Checked
	BlockCheckEvent = False
	PaintBackground(pnl, False)
End Sub

' Adds a item without checkbox (the created panel contains an optional bitmap and one or two labels)
' Set Text2 to "" if you don't want a second label and Image to Null if there's no bitmap
Public Sub AddItemNoChkbx(ID As Object, Text1 As String, Text2 As String, Image As Bitmap)
	Dim pnl As Panel: pnl.Initialize("")
	pnl.Tag = ID
	Dim LargeurLabel As Int, PosX As Int
	LargeurLabel = 150%x
	If Image.IsInitialized Then
		Dim iv As ImageView: iv.Initialize("")
		Dim bmp As Bitmap
		bmp = Image
		If NumberFormat(bmp.Width / bmp.Height, 1, 2) = NumberFormat(1, 1, 2) Then
			' Aspect ratio nearly equal -> filling
			iv.Gravity = Gravity.FILL
		Else
			' Different aspect ratio -> resizing
			bmp = AdjustBitmap(bmp, BitmapSize, BitmapSize)
			iv.Gravity = Gravity.NO_GRAVITY
		End If
		iv.Bitmap = bmp
		pnl.AddView(iv, 0, 0, BitmapSize, BitmapSize)
		PosX = BitmapSize + 5dip
	End If
	Dim lbl1 As Label: lbl1.Initialize("")
	lbl1.Gravity = Gravity.CENTER_VERTICAL
	lbl1.Text = Text1
	lbl1.TextColor = Colors.White
	lbl1.TextSize = 18
	lbl1.Typeface = Typeface.DEFAULT_BOLD
	If Text2 = "" Then
		pnl.AddView(lbl1, PosX, 0, LargeurLabel, PanelHeight)
	Else
		pnl.AddView(lbl1, PosX, 0, LargeurLabel, LabelHeight)
		Dim lbl2 As Label: lbl2.Initialize("")
		lbl2.Gravity = Gravity.TOP
		lbl2.Text = Text2
		lbl2.TextColor = Colors.LightGray
		lbl2.TextSize = 16
		lbl2.Typeface = Typeface.DEFAULT
		pnl.AddView(lbl2, PosX, LabelHeight, LargeurLabel, LabelHeight)
	End If
	AddToSV(pnl, PanelHeight, True)
	PaintBackground(pnl, False)
End Sub

' Adds a custom item (a panel holding your custom layout)
Public Sub AddCustomItem(ID As Object, pnl As Panel, pnlHeight As Int)
	If pnl.IsInitialized Then
		pnl.Tag = ID
		AddToSV(pnl, pnlHeight, True)
	End If
End Sub

' Adds a header
Public Sub AddHeader(Text As String)
	Dim pnlH As Panel: pnlH.Initialize("")
	Dim lblB As Label: lblB.Initialize("")
	Dim cdH As ColorDrawable
	cdH.Initialize(Colors.ARGB(100, 30, 30, 30), 10)
	lblB.Background = cdH
	lblB.Text = "   " & Text
	lblB.TextColor = Colors.Yellow
	lblB.TextSize = 18
	lblB.Typeface = Typeface.DEFAULT_BOLD
	lblB.Gravity = Gravity.CENTER_VERTICAL
	pnlH.AddView(lblB, 0, 0, getWidth, PanelHeight)
	AddToSV(pnlH, PanelHeight, False)
	PaintBackground(pnlH, False)
End Sub

Private Sub AddToSV(pnl As Panel, pnlHeight As Int, WithEvents As Boolean)
	' Ajout du séparateur
	If DividerSize > 0 Then
		Dim pnlDiv As Panel
		pnlDiv.Initialize("")
		pnlDiv.Color = DividerColor
		pnl.AddView(pnlDiv, 0, pnlHeight, getWidth, DividerSize)
		pnlHeight = pnlHeight + DividerSize
	End If

	' Ajout du panel et agrandissement de la hauteur du ScrollView
	sv.Panel.AddView(pnl, 0, svHeight, getWidth, pnlHeight)
	svHeight = svHeight + pnl.Height

	' Affectation des événements Touch, Click et LongClick
	If Not(WithEvents) Then Return
	Dim r As Reflector
	r.Target = pnl
	r.SetOnTouchListener("pnlSV_Touch")
	If sub_Click <> "" Then r.SetOnClickListener("pnlSV_Click")
	If sub_LongClick <> "" Then r.SetOnLongClickListener("pnlSV_LongClick")
End Sub
#End Region

' Resizes the ScrollView panel height
' (must be called when all items are added)
Public Sub ResizePanel()
	CollapseItem
	sv.Panel.Height = svHeight
End Sub

' Moves an item from StartPosition to EndPosition
' First position = 0
' Last position = NumberOfItems-1
' The final position is just before EndPosition. If you want to move an item after the last position, EndPosition must be set to NumberOfItems.
Public Sub MoveItem(StartPosition As Int, EndPosition As Int)
	If sv.IsInitialized AND StartPosition <> EndPosition Then
		If HasExtraContent Then CollapseItem
		StartPosition = Max(0, Min(StartPosition, NumberOfItems - 1))
		EndPosition = Max(0, Min(EndPosition, NumberOfItems))
		Dim pnlToMove As Panel
		pnlToMove = sv.Panel.GetView(StartPosition)
		Dim PnlHeight, NewTop As Int
		PnlHeight = pnlToMove.Height
		NewTop = pnlToMove.Top
		Dim MoveFollowingPanels As Boolean
		MoveFollowingPanels = False
		Dim pnl As Panel
		For i = 0 To NumberOfItems - 1
			pnl = sv.Panel.GetView(i)
			If i = StartPosition Then
				MoveFollowingPanels = (EndPosition > StartPosition)
				If Not(MoveFollowingPanels) Then Exit 'Move done
				PnlHeight = -PnlHeight 'Panels are moved upwards
			Else If i = EndPosition Then
				MoveFollowingPanels = (EndPosition < StartPosition)
				If Not(MoveFollowingPanels) Then Exit 'Move done
				NewTop = pnl.Top
				pnl.Top = pnl.Top + PnlHeight
			Else If MoveFollowingPanels Then
				If i = EndPosition - 1 Then NewTop = pnl.Top + pnl.Height + PnlHeight
				pnl.Top = pnl.Top + PnlHeight
			End If
		Next
		pnlToMove.Top = NewTop
		' When the item has been moved, the SV.Panel views are still in the previous order
		' We use BringToFront and SendToBack to reorder the views (BringToFront brings them to the top of the SV.Panel hierarchy,
		' i.e. the last position in the views enumeration; SendToBack does the contrary)
		Dim CptBtF, CptStB As Int
		CptBtF = sv.Panel.NumberOfViews - EndPosition - 1
		CptStB = EndPosition - 1
		If Abs(CptBtF) < Abs(CptStB) Then
			If StartPosition < EndPosition Then
				CptBtF = CptBtF + 1
				EndPosition = EndPosition - 1
			End If
			pnlToMove.BringToFront
			For i = 1 To CptBtF
				pnl = sv.Panel.GetView(EndPosition)
				pnl.BringToFront
			Next
		Else
			If StartPosition > EndPosition Then
				CptStB = CptStB + 1
				EndPosition = EndPosition + 1
			End If
			pnlToMove.SendToBack
			For i = 1 To CptStB
				pnl = sv.Panel.GetView(EndPosition - 1)
				pnl.SendToBack
			Next
		End If
	End If
End Sub

' Swaps the position of the given items
Public Sub SwapItems(PosItem1 As Int, PosItem2 As Int)
	If sv.IsInitialized AND PosItem1 <> PosItem2 Then
		If HasExtraContent Then CollapseItem
		Dim PosMin, PosMax As Int
		PosMin = Min(PosItem1, PosItem2)
		PosMax = Max(PosItem1, PosItem2)
		If PosMax > NumberOfItems - 1 Then
			Log("Error: position after the last item")
			Return
		End If
		Dim pMin, pMax, pnl As Panel
		pMin = sv.Panel.GetView(PosMin)
		pMax = sv.Panel.GetView(PosMax)
		Dim tmpTop As Int
		tmpTop = pMin.Top
		pMin.Top = pMax.Top
		pMax.Top = tmpTop

		' When the items have been swapped, the SV.Panel views are still in the previous order
		' We use BringToFront and SendToBack to reorder the views (BringToFront brings them to the top of the SV.Panel hierarchy,
		' i.e. the last position in the views enumeration; SendToBack does the contrary)
		If PosMax < NumberOfItems - PosMax Then
			pMin.SendToBack
			For i = PosMin + 1 To PosMax - 1
				pnl = sv.Panel.GetView(PosMax - 1)
				pnl.SendToBack
			Next
			pMax.SendToBack
			For i = 0 To PosMin - 1
				pnl = sv.Panel.GetView(PosMax)
				pnl.SendToBack
			Next
		Else
			pMax.BringToFront
			For i = PosMin + 1 To PosMax - 1
				pnl = sv.Panel.GetView(PosMin + 1)
				pnl.BringToFront
			Next
			pMin.BringToFront
			For i = PosMax + 1 To NumberOfItems - 1
				pnl = sv.Panel.GetView(PosMin)
				pnl.BringToFront
			Next
		End If

		' We adjust the panels top between the two positions if the item heights are different
		Dim Delta As Int
		If pMin.Height <> pMax.Height Then
			Delta = pMin.Height - pMax.Height
			For i = PosMin + 1 To PosMax
				pnl = sv.Panel.GetView(i)
				pnl.Top = pnl.Top - Delta
			Next
		End If
	End If
End Sub

' Replaces an item panel by another
' The new panel gets the position and ID of the replaced panel
' If NewHeight = -1, the panel height is unchanged.
Public Sub ReplaceItem(Position As Int, NewPanel As Panel, NewHeight As Int)
	' There's some room for optimization here
	If sv.IsInitialized AND NewPanel.IsInitialized Then
		If HasExtraContent Then CollapseItem
		Dim OldPnl As Panel
		OldPnl = sv.Panel.GetView(Position)
		NewPanel.Tag = OldPnl.Tag
		If NewHeight = -1 Then NewHeight = OldPnl.Height
		AddToSV(NewPanel, NewHeight, NewPanel.Tag <> Null)
		RemoveItemAt(Position)
		MoveItem(NumberOfItems - 1, Position)
	End If
End Sub

' Removes the item at the given position
' First position = 0
' Last position = NumberOfItems-1
Public Sub RemoveItemAt(Position As Int)
	If sv.IsInitialized AND Position < NumberOfItems Then
		Dim pnl As Panel
		pnl = sv.Panel.GetView(Position)
		If HasExtraContent AND ExtendedItemID = pnl.Tag Then
			ExtensionIndex = -1
			ExtensionView.RemoveView
			ExtensionView = Null
		End If
		Dim RemovedHeight As Int
		RemovedHeight = pnl.Height
		pnl.RemoveView
		For i = Position To sv.Panel.NumberOfViews - 1
			pnl = sv.Panel.GetView(i)
			pnl.Top = pnl.Top - RemovedHeight
		Next
		svHeight = svHeight - RemovedHeight
		sv.Panel.Height = svHeight
	End If
End Sub

' Removes the item with the given ID
Public Sub RemoveItemID(ID As Object)
	If sv.IsInitialized Then
		Dim pnl As Panel
		For i = 0 To sv.Panel.NumberOfViews - 1
			pnl = sv.Panel.GetView(i)
			If pnl.Tag = Null Then Continue
			If pnl.Tag = ID Then
				RemoveItemAt(i)
				Exit
			End If
		Next
	End If
End Sub

Private Sub IsEditText(MyView As View) As Boolean
	Return (GetType(MyView) = "android.widget.EditText")
End Sub

Private Sub IsLabel(MyView As View) As Boolean
	Return (GetType(MyView) = "android.widget.TextView")
End Sub

#Region Create lists
Private Sub MakeValuesListWith(ViewIndexInPanel As Int, FirstPosition As Int, LastPosition As Int, TypeListe As Int) As List
	Dim Liste As List: Liste.Initialize
	If sv.IsInitialized Then
		If LastPosition > NumberOfItems - 1 Then
			Log("LastPosition is beyond the last item")
			Return Liste
		End If
		Dim pnl As Panel, v As View
		Dim l As Label, e As EditText
		Dim entier As Int
		For i = FirstPosition To LastPosition
			pnl = sv.Panel.GetView(i)
			v = pnl.GetView(ViewIndexInPanel)
			If TypeListe = 0 Then
				' Add the view tag to the list
				Liste.Add(v.Tag)
			Else If TypeListe = 1 Then
				' Add the view content (text) to the list
				If Not(v.IsInitialized) Then
					Liste.Add("")
				Else If IsLabel(v) Then
					l = v
					Liste.Add(l.Text)
				Else If IsEditText(v) Then
					e = v
					Liste.Add(e.Text)
				End If
			Else
				' Add the view content (integer) to the list
				If Not(v.IsInitialized) Then
					Liste.Add(0)
				Else If IsLabel(v) Then
					l = v
					If IsNumber(l.Text) Then
						entier = Floor(l.Text)
						Liste.Add(entier)
					Else
						Liste.Add(0)
					End If
				Else If IsEditText(v) Then
					e = v
					If IsNumber(e.Text) Then
						entier = Floor(e.Text)
						Liste.Add(entier)
					Else
						Liste.Add(0)
					End If
				End If
			End If
		Next
	End If
	Return Liste
End Sub

' Creates a tag list with items between FirstPosition and LastPosition
' ViewIndexInPanel: indicates the view position in the item panel (first view = 0) from which the tag is read
Public Sub CreateTagList(ViewIndexInPanel As Int, FirstPosition As Int, LastPosition As Int) As List
	Return MakeValuesListWith(ViewIndexInPanel, FirstPosition, LastPosition, 0)
End Sub

' Creates a text list with items between FirstPosition and LastPosition
' ViewIndexInPanel: indicates the view position in the item panel (first view = 0) from which the text is read
Public Sub CreateTextList(ViewIndexInPanel As Int, FirstPosition As Int, LastPosition As Int) As List
	Return MakeValuesListWith(ViewIndexInPanel, FirstPosition, LastPosition, 1)
End Sub

' Creates an integer list with items between FirstPosition and LastPosition
' ViewIndexInPanel: indicates the view position in the item panel (first view = 0) from which the number is read
Public Sub CreateIntegerList(ViewIndexInPanel As Int, FirstPosition As Int, LastPosition As Int) As List
	Return MakeValuesListWith(ViewIndexInPanel, FirstPosition, LastPosition, 2)
End Sub

' Creates a checked state list (true/false) with items between FirstPosition and LastPosition
Public Sub CreateCheckedStateList(FirstPosition As Int, LastPosition As Int) As List
	Dim Liste As List: Liste.Initialize
	If sv.IsInitialized Then
		Dim pnl As Panel, v As View, c As CheckBox
		For i = FirstPosition To LastPosition
			pnl = sv.Panel.GetView(i)
			For p = 0 To pnl.NumberOfViews - 1
				v = pnl.GetView(p)
				If IsCheckBox(v) Then
					c = v
					Liste.Add(c.Checked)
					Exit
				End If
			Next
		Next
	End If
	Return Liste
End Sub
#End Region

' Sorts the items between FirstPosition and LastPosition
' ValuesToSort: a list containing the values to sort (numbers or strings). These values must be in the same order as their origin items.
' To sort all items: FirstPosition = 0 and LastPosition = NumberOfItems - 1
Public Sub SortItems(ValuesToSort As List, FirstPosition As Int, LastPosition As Int, AscendingOrder As Boolean)
	If ValuesToSort.Size < 2 OR FirstPosition = LastPosition Then Return
	If LastPosition - FirstPosition + 1 <> ValuesToSort.Size Then
		Log("Mismatch: " & ValuesToSort.Size & " values in ValuesToSort and " & (LastPosition - FirstPosition + 1) & " positions to sort")
		Return
	End If
	Dim SortList As List: SortList.Initialize
	For i = FirstPosition To LastPosition
		Dim SortData As typSortData
		SortData.Initialize
		SortData.Index = i
		SortData.Value = ValuesToSort.Get(i - FirstPosition)
		SortList.Add(SortData)
	Next
	SortList.SortType("Value", AscendingOrder)

	' On recherche le premier et le dernier index non ordonné
	' Ce faisant, on stocke les références des panneaux dans le bon ordre
	Dim FirstToSort, LastToSort As Int
	FirstToSort = -1
	LastToSort = -1
	Dim PanelList As List: PanelList.Initialize
	For i = 0 To FirstPosition - 1
		PanelList.Add(sv.Panel.GetView(i))
	Next
	For i = FirstPosition To LastPosition
		Dim SortData As typSortData
		SortData = SortList.Get(i - FirstPosition)
		If SortData.Index <> i Then
			If FirstToSort = -1 Then FirstToSort = i
			LastToSort = i
		End If
		PanelList.Add(sv.Panel.GetView(SortData.Index))
	Next
	If FirstToSort = -1 Then Return
	For i = LastPosition + 1 To NumberOfItems - 1
		PanelList.Add(sv.Panel.GetView(i))
	Next

	' On ordonne les tops des panneaux
	If HasExtraContent Then CollapseItem
	Dim TotalHeight As Int
	Dim pnl As Panel
	If FirstToSort > 0 Then
		pnl = sv.Panel.GetView(FirstToSort - 1)
		TotalHeight = pnl.Top + pnl.Height
	End If
	For i = FirstToSort To LastToSort
		pnl = PanelList.Get(i)
		pnl.Top = TotalHeight
		TotalHeight = pnl.Top + pnl.Height
	Next

	' On ordonne les vues dans la hiérarchie du sv.Panel
	If LastToSort < NumberOfItems - FirstToSort Then
		' On est plus proche du début
		For i = 0 To LastToSort
			pnl = PanelList.Get(LastToSort - i)
			pnl.SendToBack
		Next
	Else
		' On est plus proche de la fin
		For i = FirstToSort To NumberOfItems - 1
			pnl = PanelList.Get(i)
			pnl.BringToFront
		Next
	End If
End Sub

' Gets the ScrollView width
' In some containers, the width property returns -1, so this function uses a different method to get it
Public Sub getWidth As Int
	If sv.Width < 0 Then
		Dim r As Reflector, Largeur As Int
		r.Target = sv
		Largeur = r.RunMethod("getWidth")
		If Largeur = 0 Then
			DoEvents
			Largeur = r.RunMethod("getWidth")
		End If
		Return Largeur		
	Else
		Return sv.Width
	End If
End Sub

' Gets the ScrollView height
' In some containers, the height property returns -1, so this function uses a different method to get it
Public Sub getHeight As Int
	If sv.Height < 0 Then
		Dim r As Reflector, Hauteur As Int
		r.Target = sv
		Hauteur = r.RunMethod("getHeight")
		If Hauteur = 0 Then
			DoEvents
			Hauteur = r.RunMethod("getHeight")
		End If
		Return Hauteur		
	Else
		Return sv.Height
	End If
End Sub

' Returns the number of items
Public Sub NumberOfItems As Int
	If sv.IsInitialized Then
		Return sv.Panel.NumberOfViews
	Else
		Return 0
	End If
End Sub

' Returns the first label text found for the given ID
' Returns an empty string if not found
' You should not use this function repeatedly (e.g. in a loop) because it is quite slow with long lists.
Public Sub GetFirstText(ID As Object) As String
	Dim pnl As Panel
	For i = 0 To sv.Panel.NumberOfViews - 1
		pnl = sv.Panel.GetView(i)
		If pnl.Tag = Null Then Continue
		If pnl.Tag = ID Then
			For p = 0 To pnl.NumberOfViews - 1
				If IsLabel(pnl.GetView(p)) Then
					Dim lbl As Label
					lbl = pnl.GetView(p)
					Return lbl.Text
				End If
			Next
			Exit
		End If
	Next
	Return ""
End Sub

Private Sub GetParentPanel(MyView As View) As View
	Dim r As Reflector
	Dim v, Parent As View
	r.Target = MyView
	v = r.Target
	Parent = r.RunMethod("getParent")
	Do While Parent <> sv.Panel
		r.Target = Parent
		v = r.Target
		Parent = r.RunMethod("getParent")
	Loop
	Return v
End Sub

'Returns the panel containing the given view.
Public Sub FindPanelContaining(MyView As View) As Panel
	If sv.IsInitialized Then
		Return GetParentPanel(MyView)
	Else
		Return Null
	End If
End Sub

'Returns the panel with the given ID
'Returns Null if not found
'You should not use this function repeatedly (e.g. in a loop) because it is quite slow with long lists.
Public Sub FindPanelWithID(ID As Object) As Object
	If sv.IsInitialized Then
		For i = 0 To NumberOfItems - 1
			Dim pnl As Panel
			pnl = sv.Panel.GetView(i)
			If pnl.Tag = ID Then Return pnl
		Next
	End If
	Return Null
End Sub

#Region Jumps
Private Sub CommonJump(NewPosition As Int)
	' We remove a few dips for the fading edge
	NewPosition = Max(0, NewPosition - 5dip)

	' We wait until the scrolling animation ends
	Dim PreviousPosition As Int: PreviousPosition = -1
	Do Until PreviousPosition = sv.ScrollPosition
		PreviousPosition = sv.ScrollPosition
		sv.ScrollPosition = NewPosition
		DoEvents
	Loop
End Sub

' Scrolls the list to the given position
' Returns the panel found at that position
' First position = 0
' Last position = NumberOfItems-1
Public Sub JumpToPosition(Position As Int) As Panel
	If sv.IsInitialized Then
		Position = Max(Position, 0)
		Position = Min(Position, NumberOfItems - 1)
		Dim pnl As Panel
		pnl = sv.Panel.GetView(Position)
		CommonJump(pnl.Top)
		Return pnl
	End If
	Return Null
End Sub

' Scrolls the list to the item with the given ID
' Returns the panel of the item found
' This function is much slower than JumpToPosition or JumpToView.
Public Sub JumpToItem(ID As Object) As Panel
	If sv.IsInitialized Then
		Dim TotalHeight As Int
		For i = 0 To NumberOfItems - 1
			Dim pnl As Panel
			pnl = sv.Panel.GetView(i)
			If pnl.Tag <> Null Then
				If pnl.Tag = ID Then
					CommonJump(TotalHeight)
					Return pnl
				End If
			End If
			TotalHeight = TotalHeight + pnl.Height
		Next
	End If
	Return Null
End Sub

' Scrolls the list to the given view
' Returns the panel containing the view
Public Sub JumpToView(MyView As View) As Panel
	If sv.IsInitialized Then
		Dim pnl As Panel
		pnl = GetParentPanel(MyView)
		CommonJump(pnl.Top)
		Return pnl
	Else
		Return Null
	End If
End Sub
#End Region

#Region Checkboxes
Private Sub IsCheckBox(MyView As View) As Boolean
	Return (GetType(MyView) = "android.widget.CheckBox")
End Sub

Private Sub MakeCheckedList(ListType As Int) As List
	Dim ListeCoches As List
	ListeCoches.Initialize 
	If sv.IsInitialized Then
		For i = 0 To sv.Panel.NumberOfViews-1
			Dim pnl As Panel
			pnl = sv.Panel.GetView(i)
			For p = 0 To pnl.NumberOfViews - 1
				If IsCheckBox(pnl.GetView(p)) Then
					Dim chk As CheckBox
					chk = pnl.GetView(p)
					If chk.Checked Then
						If ListType = 0 Then
							ListeCoches.Add(pnl.Tag)
						Else
							ListeCoches.Add(pnl)
						End If
					End If
					Exit
				End If
			Next
		Next
	End If
	Return ListeCoches
End Sub

' Creates a list with ID of checked items
Public Sub CheckedList As List
	Return MakeCheckedList(0)
End Sub

' Creates a list with panels of checked items
Public Sub CheckedPanels As List
	Return MakeCheckedList(1)
End Sub

' Checks/unchecks all checkboxes
Public Sub CheckAllBoxes(Checked As Boolean)
	BlockCheckEvent = True 'We don't want to trigger a CheckedChange event for each checkbox
	Dim pnl As Panel, chb As CheckBox
	For i = 0 To sv.Panel.NumberOfViews - 1
		pnl = sv.Panel.GetView(i)
		For p = 0 To pnl.NumberOfViews - 1
			If IsCheckBox(pnl.GetView(p)) Then
				chb = pnl.GetView(p)
				chb.Checked = Checked
				Exit
			End If
		Next
	Next
	BlockCheckEvent = False
End Sub
#End Region

#Region Background
'Applies the new colors (BackgroundColor, CheckedColor, DividerColor, ExtensionColor) to the given item
Public Sub Repaint(pnlItem As Panel)
	Dim Extended As Boolean
	Extended = HasExtraContent AND ExtendedItemID = pnlItem.Tag
	PaintBackground(pnlItem, Extended)
	If DividerSize > 0 Then
		Dim pnlDivider As Panel
		If Extended Then
			pnlDivider = pnlItem.GetView(pnlItem.NumberOfViews - 2)
		Else
			pnlDivider = pnlItem.GetView(pnlItem.NumberOfViews - 1)
		End If
		pnlDivider.Color = DividerColor
	End If
End Sub

'Applies the new colors (BackgroundColor, CheckedColor, DividerColor, ExtensionColor) to all items
Public Sub RepaintAllItems
	For i = 0 To NumberOfItems - 1
		Repaint(sv.Panel.GetView(i))
	Next
End Sub

'Defines an event handler called every time the item background is repaint
'It must be declared like this: myCustomSub(pnlItem As Panel, State As Int)
'Once set, the callback sub must handle all background changes.
'Item state:<I>
'0 = Default (collapsed, not checked, not pressed)
'1 = Extended
'2 = Checked
'3 = Extended + Checked
'4 = Pressed</I>
Public Sub SetOnPaintListener(SubName As String)
	sub_Paint = SubName
End Sub

Private Sub PaintBackground(pnl As Panel, Extended As Boolean)
	Dim State As Int
	If Extended Then
		State = PAINT_EXTENDED
	Else
		State = PAINT_DEFAULT
	End If
	For p = 0 To pnl.NumberOfViews - 1
		If IsCheckBox(pnl.GetView(p)) Then
			Dim chk As CheckBox
			chk = pnl.GetView(p)
			If chk.Checked Then State = State + PAINT_CHECKED
			Exit
		End If
	Next
	If SubExists(CallbackMod, sub_Paint) Then
		CallSub3(CallbackMod, sub_Paint, pnl, State)
	Else
		Select State
			Case PAINT_EXTENDED
				pnl.Color = ExtensionColor
			Case PAINT_CHECKED
				pnl.Color = CheckedColor
			Case PAINT_CHECKED + PAINT_EXTENDED
				If CheckedColor = Colors.Transparent Then
					pnl.Color = ExtensionColor
				Else
					pnl.Color = CheckedColor
				End If
			Case Else
				pnl.Color = BackgroundColor
		End Select
	End If
End Sub
#End Region

#Region Extra content
' Adds an extra content (panel, label, edittext, imageview...) under an item
Public Sub ExtendItem(ItemID As Object, AddedContent As View, ContentHeight As Int)
	If AddedContent.IsInitialized Then
		If HasExtraContent Then CollapseItem
		Dim MoveFollowingPanels As Boolean
		MoveFollowingPanels = False
		Dim pnl As Panel
		For i = 0 To sv.Panel.NumberOfViews - 1
			pnl = sv.Panel.GetView(i)
			If MoveFollowingPanels Then
				pnl.Top = pnl.Top + ContentHeight
			Else If pnl.Tag = Null Then
				Continue ' It's a header
			Else If pnl.Tag = ItemID Then
				ExtensionIndex = i
				ExtensionView = AddedContent
				PaintBackground(pnl, True)
				If DividerSize > 0 Then
					' We move the divider down to the new panel bottom
					Dim pnlDivider As Panel
					pnlDivider = pnl.GetView(pnl.NumberOfViews - 1)
					pnlDivider.Top = pnl.Height + ContentHeight - DividerSize
				End If
				If IsCheckBox(pnl.GetView(0)) Then
					' If the first view is a checkbox, the extension panel is shifted to the right of this checkbox
					pnl.AddView(AddedContent, ChkBoxSize, pnl.Height - DividerSize, getWidth - ChkBoxSize, ContentHeight)
				Else
					pnl.AddView(AddedContent, 0, pnl.Height - DividerSize, getWidth, ContentHeight)
				End If
				pnl.Height = pnl.Height + ContentHeight
				svHeight = svHeight + ContentHeight
				sv.Panel.Height = svHeight

				Dim ContentBottom As Int
				ContentBottom = pnl.Top + pnl.Height
				If ContentBottom > sv.ScrollPosition + getHeight Then
					' If needed, we scroll to display the added content
					Dim NewPosition As Int
					DoEvents
					NewPosition = sv.ScrollPosition + Min(ContentBottom - sv.ScrollPosition - getHeight, getHeight) + 15dip
					CommonJump(NewPosition)
				End If

				AddedContent.RequestFocus
				MoveFollowingPanels = True
			End If
		Next
	End If
End Sub

' Removes the extra content
Public Sub CollapseItem
	If ExtensionIndex <> -1 Then 
		Dim ExtensionHeight As Int
		ExtensionHeight = ExtensionView.Height
		ExtensionView.RemoveView
		Dim pnl As Panel
		pnl = sv.Panel.GetView(ExtensionIndex)
		PaintBackground(pnl, False)
		pnl.Height = pnl.Height - ExtensionHeight
		If DividerSize > 0 Then
			' We move the divider up to the new panel bottom
			Dim pnlDivider As Panel
			pnlDivider = pnl.GetView(pnl.NumberOfViews - 1)
			pnlDivider.Top = pnl.Height - DividerSize
		End If
		svHeight = svHeight - ExtensionHeight
		sv.Panel.Height = svHeight
		For i = ExtensionIndex + 1 To sv.Panel.NumberOfViews - 1
			pnl = sv.Panel.GetView(i)
			pnl.Top = pnl.Top - ExtensionHeight
		Next
		ExtensionIndex = -1
	End If
	ExtensionView = Null
End Sub

' Checks if there is an item with extra content
Public Sub HasExtraContent As Boolean
	Return (ExtensionIndex <> -1)
End Sub

' Returns the ID of the item with extra content
' Returns Null if there's no such item
Public Sub ExtendedItemID As Object
	If ExtensionView.IsInitialized Then
		Dim pnl As Panel
		pnl = FindPanelContaining(ExtensionView)
		Return pnl.Tag
	Else
		Return Null
	End If
End Sub
#End Region

#Region Drag & drop
' Starts a drag&drop operation
' subAfterDrop = name of the sub handling the AfterDrop event
' This function should be called after a long click event.
Public Sub StartDragAndDrop(pnl As Panel, subAfterDrop As String)
	If Not(DragAndDrop.IsInitialized) Then
		If HasExtraContent Then CollapseItem
		DragAndDropShadow.Initialize("")
		DragAndDropShadow.Color = Colors.ARGB(128, 128, 128, 128)
		sv.Panel.AddView(DragAndDropShadow, pnl.Left, pnl.Top, pnl.Width, pnl.Height)
		DragAndDrop.Initialize("")
		DragAndDrop.SetBackgroundImage(ViewToBmp(pnl))
		sv.Panel.AddView(DragAndDrop, pnl.Left, pnl.Top, pnl.Width, pnl.Height)
		Dim r As Reflector
		r.Target = DragAndDrop
		r.SetOnTouchListener("pnlSV_Touch")
		OriginDDTop = pnl.Top
		sub_AfterDrop = subAfterDrop
	End If
End Sub

' Aborts the current drag&drop operation
Public Sub AbortDragAndDrop()
	If DragAndDrop.IsInitialized Then
		DragAndDrop.RemoveView
		DragAndDrop = Null
		DragAndDropShadow.RemoveView
		DragAndDropShadow = Null
	End If
End Sub

Private Sub MoveDDPanel(Y As Int)
	' Moves the Drag&Drop panel to follow the finger move
	Dim r As Reflector
	r.Target = sv
	r.RunMethod2("requestDisallowInterceptTouchEvent", True, "java.lang.boolean")
	DragAndDrop.Top = Min(Max(0, DragAndDrop.Top + Y - LastY), sv.Panel.Height - DragAndDrop.Height)
	If DragAndDrop.Top < sv.ScrollPosition Then sv.ScrollPosition = DragAndDrop.Top
	If DragAndDrop.Top + DragAndDrop.Height > sv.ScrollPosition + getHeight Then
		sv.ScrollPosition = DragAndDrop.Top + DragAndDrop.Height - getHeight
	End If
End Sub

Private Sub MoveToDropPosition(Y As Int)
	' Last move
	DragAndDrop.Top = Min(Max(0, DragAndDrop.Top + Y - LastY), sv.Panel.Height - DragAndDrop.Height)

	' Find the start and drop positions
	Dim StartPosition, EndPosition As Int
	StartPosition = -1
	EndPosition = -1
	Dim pnl As Panel
	For i = 0 To NumberOfItems - 1
		pnl = sv.Panel.GetView(i)
		If pnl.Top = OriginDDTop Then
			StartPosition = i
			If EndPosition <> -1 Then Exit
		End If
		If DragAndDrop.Top >= pnl.Top AND DragAndDrop.Top < pnl.Top + pnl.Height Then
			EndPosition = i
			If StartPosition <> -1 Then Exit
		End If
	Next

	' Move the item panel
	MoveItem(StartPosition, EndPosition)
	If EndPosition > StartPosition Then EndPosition = EndPosition - 1
	If SubExists(CallbackMod, sub_AfterDrop) Then CallSub3(CallbackMod, sub_AfterDrop, StartPosition, EndPosition)

	' Remove the Drag&Drop panel
	AbortDragAndDrop
End Sub
#End Region

#Region Events
Private Sub pnlSV_Touch(ViewTag As Object, Action As Int, X As Float, Y As Float, MotionEvent As Object) As Boolean
	Dim pnl As Panel
	pnl = Sender
	If Action <> 2 Then		' <> ACTION_MOVE
		If PressedPanel.IsInitialized Then
			PressedPanel.Background = OldBackground
			PressedPanel = Null
		End If
	End If
	If Action = 0 Then		' = ACTION_DOWN
		OldBackground = pnl.Background
		PressedPanel = pnl
		If SubExists(CallbackMod, sub_Paint) Then
			CallSub3(CallbackMod, sub_Paint, pnl, PAINT_PRESSED)
		Else
			PressedPanel.Background = PressedDrawable
		End If
	Else If Action = 1 Then	' = ACTION_UP
		If DragAndDrop.IsInitialized Then
			' End of D&D: find the drop position and move the panel
			MoveToDropPosition(Y)
		Else If ModeCheck Then
			' Check the box
			For p = 0 To pnl.NumberOfViews - 1
				If IsCheckBox(pnl.GetView(p)) Then
					Dim chb As CheckBox
					chb = pnl.GetView(p)
					chb.Checked = Not(chb.Checked)
					Exit
				End If
			Next
		End If
	Else If Action = 2 Then '= ACTION_MOVE
		If DragAndDrop.IsInitialized Then MoveDDPanel(Y)
	End If
	LastY = Y
	Return (sub_Click = "" AND sub_LongClick = "")
End Sub

Private Sub pnlSV_Click(ViewTag As Object) As Boolean
	Dim pnl As Panel
	pnl = Sender
	If SubExists(CallbackMod, sub_Click) Then CallSub3(CallbackMod, sub_Click, pnl, pnl.Tag)
	Return True
End Sub

Private Sub pnlSV_LongClick(ViewTag As Object) As Boolean
	Dim pnl As Panel
	pnl = Sender
	If SubExists(CallbackMod, sub_LongClick) Then CallSub3(CallbackMod, sub_LongClick, pnl, pnl.Tag)
	Return True
End Sub

Private Sub chbSV_CheckedChange(Checked As Boolean)
	Dim chb As CheckBox, pnl As Panel
	chb = Sender
	pnl = FindPanelContaining(chb)
	PaintBackground(pnl, HasExtraContent AND ExtendedItemID = pnl.Tag)
	If BlockCheckEvent Then Return
	If sub_Check <> "" Then
		If SubExists(CallbackMod, sub_Check) Then CallSub3(CallbackMod, sub_Check, chb, pnl.Tag)
	End If
End Sub
#End Region

#Region Filter
Private Sub MoveTopAfterFiltering(FirstPos As Int)
	' We move the panels to fill the holes created by the invisible items
	Dim pnl As Panel, NewTop As Int
	pnl = sv.Panel.GetView(FirstPos)
	If pnl.Visible Then
		NewTop = pnl.Top + pnl.Height
	Else
		NewTop = pnl.Top
	End If
	For i = FirstPos + 1 To NumberOfItems - 1
		pnl = sv.Panel.GetView(i)
		If pnl.Visible Then
			pnl.Top = NewTop
			NewTop = pnl.Top + pnl.Height
		End If
	Next
	svHeight = NewTop
	sv.Panel.Height = svHeight
End Sub

Private Sub Filter(ViewIndexInPanel As Int, ComparisonFunction As String, FilterType As Int) As Int
	' Filtering is a three-step process:
	' 1) Create the value list
	' 2) Evaluate each value with a custom comparison method
	' 3) Group the matching items
	If Not(SubExists(CallbackMod, ComparisonFunction)) Then
		Log(ComparisonFunction & " not found")
		Return 0
	End If
	Dim L As List
	If FilterType = 0 Then
		L = CreateTagList(ViewIndexInPanel, 0, NumberOfItems - 1)
	Else
		L = CreateTextList(ViewIndexInPanel, 0, NumberOfItems - 1)
	End If
	Dim FirstPos, Count As Int
	FirstPos = -1
	Dim S As String, pnl As Panel
	For i = 0 To L.Size - 1
		S = L.Get(i)
		pnl = sv.Panel.GetView(i)
		CallSub3(CallbackMod, ComparisonFunction, pnl.Tag, S)
		If FilterResult = True Then
			Count = Count + 1
			If pnl.Visible = False Then
				If FirstPos = -1 Then FirstPos = i
				pnl.Visible = True
			End If
		Else
			If FirstPos = -1 Then FirstPos = i
			pnl.Visible = False
		End If
	Next
	If FirstPos > -1 Then MoveTopAfterFiltering(FirstPos)
	Return Count
End Sub

' Filters the items and returns the number of matching items.
' ViewIndexInPanel: indicates the view position in the item panel (first view = 0) from which the tag is read
' ComparisonFunction: name of the sub in the calling module doing the comparison. The sub must be declared like this: myComparisonSub(ID As Object, Value As Object), and it must return True (keep the item) or False (hide the item) in FilterResult.
' The discarded items are made invisibles but they are still there, so don't try to reorder or alter the number of items while the list is filtered.
Public Sub FilterTag(ViewIndexInPanel As Int, ComparisonFunction As String) As Int
	Return Filter(ViewIndexInPanel, ComparisonFunction, 0)
End Sub

' Filters the items and returns the number of matching items.
' ViewIndexInPanel: indicates the view position in the item panel (first view = 0) from which the text is read
' ComparisonFunction: name of the sub in the calling module doing the comparison. The sub must be declared like this: myComparisonSub(ID As Object, Value As Object), and it must return True (keep the item) or False (hide the item) in FilterResult.
' The discarded items are made invisibles but they are still there, so don't try to reorder or alter the number of items while the list is filtered.
Public Sub FilterText(ViewIndexInPanel As Int, ComparisonFunction As String) As Int
	Return Filter(ViewIndexInPanel, ComparisonFunction, 1)
End Sub

' Returns True if the item at the given position is filtered (not visible)
Public Sub IsFiltered(Position As Int) As Boolean
	Return sv.Panel.GetView(Position).Visible
End Sub

' Cancels the filter and displays all items
Public Sub CancelFilter()
	Dim FirstPos As Int, pnl As Panel
	FirstPos = -1
	For i = 0 To NumberOfItems - 1
		pnl = sv.Panel.GetView(i)
		If pnl.Visible = False Then
			If FirstPos = -1 Then FirstPos = i
			pnl.Visible = True
		End If
	Next
	If FirstPos > -1 Then MoveTopAfterFiltering(FirstPos)
End Sub
#End Region