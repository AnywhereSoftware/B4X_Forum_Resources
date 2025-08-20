B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6.3
@EndOfDesignText@
#DesignerProperty: Key: ItemsBackgroundColor, DisplayName: Items Background, FieldType: Color, DefaultValue: 0xFFFFFFFF
#DesignerProperty: Key: ItemsTextColor, DisplayName: Items Text Color, FieldType: Color, DefaultValue: 0xFF0000FF
#DesignerProperty: Key: ItemsHighlightedTextColor, DisplayName: Items Highlight Color, FieldType: Color, DefaultValue: 0xFFFF0000
#DesignerProperty: Key: Hint, DisplayName: Text field hint, FieldType: String, DefaultValue: Hint

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private CLV As CustomListView
	Private prefixList As Map
	Private substringList As Map
	Private MIN_LIMIT = 2 As Int 'minimum
	Private MAX_LIMIT = 4 As Int 'doesn't limit the words length. Only the index.
	Private MeasurementCanvas As B4XCanvas
	Private fnt As B4XFont
	Private ItemsHeight As Int
	Private BaseLine As Int
	Private ItemsBackgroundColor As Int
	Private ItemsTextColor As Int
	Private ItemsHighlightedTextColor As Int
	Private Gap As Int = 7dip
	Type MSVItemData (State As Int, cvs As B4XCanvas, Item As String)
	Private STATE_EMPTY = 0, STATE_NEED_TO_CLEAR = 1, STATE_GOOD = 2 As Int
	Private ListCounter As Int
	Private SpaceWidth As Float 'ignore
	Public TextField As B4XFloatTextField
	Private AllItems As B4XSet
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	prefixList.Initialize
	substringList.Initialize
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 1dip, 1dip)
	MeasurementCanvas.Initialize(p)
	AllItems.Initialize
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	mBase.Color = xui.Color_Transparent
	Dim xlbl As B4XView = Lbl
	fnt = xlbl.Font
	ItemsBackgroundColor = xui.PaintOrColorToColor(Props.Get("ItemsBackgroundColor"))
	ItemsTextColor = xui.PaintOrColorToColor(Props.Get("ItemsTextColor"))
	ItemsHighlightedTextColor = xui.PaintOrColorToColor(Props.Get("ItemsHighlightedTextColor"))
	Sleep(0)
	mBase.LoadLayout("MiniSearchView")
	#if B4A
	Dim jo As JavaObject = TextField.TextField
	jo.RunMethod("setImeOptions", Array As Object(268435456)) 'disable the full screen mode in landscape
	#End If
	CLV.GetBase.Visible = False
	CLV.GetBase.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	CLV.sv.SetColorAndBorder(xui.Color_Transparent, 0, 0, 0)
	TextField.TextField.Font = xlbl.Font
	TextField.HintFont = xlbl.Font
	TextField.HintText = Props.GetDefault("Hint", "")
	TextField.Update
	Base_Resize(mBase.Width, mBase.Height)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
	If CLV.IsInitialized = False Then Return
	SpaceWidth = MeasurementCanvas.MeasureText("X X", fnt).Width - 2 * MeasurementCanvas.MeasureText("X", fnt).Width
	Dim s As String = "abcDEFGM"
	Dim r As B4XRect = MeasurementCanvas.MeasureText(s, fnt)
	ItemsHeight = r.Height + 20dip
	BaseLine = ItemsHeight / 2 - r.Height / 2 - r.Top
	Dim ScrollBarSize As Int
	If xui.IsB4J Then ScrollBarSize = 20dip Else ScrollBarSize = 2dip
	CLV.GetBase.Height = ItemsHeight + ScrollBarSize
	If xui.IsB4A Then
		CLV.Base_Resize(CLV.GetBase.Width, CLV.GetBase.Height)
	End If
	TextField.mBase.SetLayoutAnimated(0, 0, CLV.GetBase.Height, TextField.mBase.Width, Height - CLV.GetBase.Height)
End Sub

Private Sub CLV_ItemClick (Index As Int, Value As Object)
	Dim m As MSVItemData = Value
	TextField.Text = m.Item
	CLV.GetBase.Visible = False
End Sub

Private Sub TextField_TextChanged (Old As String, New As String)
	If New.Length < MIN_LIMIT Or getIsValid Then
		CLV.GetBase.Visible = False
		Return
	End If
	If CLV.GetBase.Visible = False Then CLV.GetBase.Visible = True
	Dim str1, str2 As String
	str1 = New.ToLowerCase
	If str1.Length > MAX_LIMIT Then
		str2 = str1.SubString2(0, MAX_LIMIT)
	Else
		str2 = str1
	End If
	ListCounter = -1
	AddItemsToList(prefixList.Get(str2), str1)
	AddItemsToList(substringList.Get(str2), str1)
	For i2 = CLV.Size - 1 To ListCounter + 1 Step -1
		CLV.RemoveAt(i2)
	Next
	CLV.Refresh
End Sub

Private Sub AddItemsToList(li As List, full As String)
	If li.IsInitialized = False Then Return
	For i = 0 To li.Size - 1
		Dim item As String = li.Get(i)
		Dim x As Int = item.ToLowerCase.IndexOf(full)
		If x = -1 Then Continue
		ListCounter = ListCounter + 1
		'Dim TextWidth As Int = item.Length * AverageLetterWidth + (item.Length - 1) * AverageSpaceBetweenLetters
		Dim TextWidth As Int = MeasurementCanvas.MeasureText(item, fnt).Width
		Dim Width As Int = TextWidth + Gap * 2
		If CLV.Size > ListCounter Then
			'can reuse
			Dim m As MSVItemData = CLV.GetValue(ListCounter)
			If m.State = STATE_GOOD Or m.State = STATE_NEED_TO_CLEAR Then m.State = STATE_NEED_TO_CLEAR
			m.Item = item
			If Width <> CLV.GetPanel(ListCounter).Width Then
				CLV.ResizeItem(ListCounter, Width)
			End If
			Continue
		End If
		Dim p As B4XView = xui.CreatePanel("")
		p.SetLayoutAnimated(0, 0, 0, Width , CLV.sv.Height)
		CLV.Add(p, CreateMSVItem(item))
	Next
	
End Sub

Private Sub CreateMSVItem(item As String) As MSVItemData
	Dim m As MSVItemData
	m.Initialize
	m.State = STATE_EMPTY
	m.Item = item
	Return m
End Sub

Private Sub CLV_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)
	Dim full As String = TextField.Text.ToLowerCase
	If full.Length = 0 Then Return
	Dim CenterY As Int = ItemsHeight / 2
	For i = FirstIndex To Min(CLV.Size - 1, LastIndex)
		Dim msv As MSVItemData = CLV.GetValue(i)
		If msv.State = STATE_GOOD Then Continue
		Dim p As B4XView = CLV.GetPanel(i)
		
		Dim item As String = msv.Item
		Dim x As Int = item.ToLowerCase.IndexOf(full)
		If x = -1 Then Continue
		Dim cvs As B4XCanvas
		If msv.State = STATE_NEED_TO_CLEAR Then
			cvs = msv.cvs
			If cvs.TargetRect.Width <> p.Width Then
				cvs.Resize(p.Width, p.Height)
			End If
			cvs.ClearRect(cvs.TargetRect)
		Else
			cvs.Initialize(p)
			msv.cvs = cvs
		End If
		msv.State = STATE_GOOD
		Dim r2 As B4XRect
		Dim RoundRect As B4XPath
		r2.Initialize(0, CenterY - ItemsHeight / 2, p.Width, CenterY + ItemsHeight / 2)
		RoundRect.InitializeRoundedRect(r2, 20dip)
		cvs.DrawPath(RoundRect, ItemsBackgroundColor, True, 0)
		Dim offset As Float = Gap
		If x > 0 Then
			Dim s As String = item.SubString2(0, x)
			offset = offset + DrawText(cvs, s, offset, ItemsTextColor)
			offset = offset + MeasurementCanvas.MeasureText(s, fnt).Width + SpaceBetweenTwoLetters(item.SubString2(x - 1, x + 1))
		End If
		Dim s As String = item.SubString2(x, x + full.Length)
		offset = offset + DrawText(cvs, s, Round(offset), ItemsHighlightedTextColor)
		offset = offset + MeasurementCanvas.MeasureText(s, fnt).Width
		If x + full.Length < item.Length Then
			offset = Round(offset + SpaceBetweenTwoLetters(item.SubString2(x + full.Length - 1, x + full.Length + 1)))
			Dim s As String = item.SubString(x + full.Length)
			DrawText(cvs, s, offset, ItemsTextColor)
		End If
		cvs.Invalidate
	Next
End Sub

Private Sub DrawText(cvs As B4XCanvas, text As String, offset As Float, clr As Int) As Float
	#if B4A or B4J
	cvs.DrawText(text, offset, BaseLine, fnt, clr, "LEFT")
	Return 0
	#else
	For i = 0 To text.Length - 1
		If text.CharAt(i) = " " Then 
			offset = offset + SpaceWidth
		Else
			Exit
		End If
	Next
	cvs.DrawText(text.Trim, offset, BaseLine, fnt, clr, "LEFT")
	offset = 0
	For i = text.Length - 1 To 0 Step - 1
		If text.CharAt(i) = " " Then
			offset = offset + SpaceWidth
		Else
			Exit
		End If
	Next
	Return offset
	#End If
	
End Sub
Private Sub SpaceBetweenTwoLetters(s As String) As Float
	s = s.Replace(" ", "x")
	Dim res As Float = MeasurementCanvas.MeasureText(s, fnt).Width - MeasurementCanvas.MeasureText(s.CharAt(0), fnt).Width _
		- MeasurementCanvas.MeasureText(s.CharAt(1), fnt).Width
	Return res
End Sub

Private Sub TextField_EnterPressed
	TextField_Action	
End Sub

Private Sub TextField_Action
	If CLV.GetBase.Visible And CLV.Size > 0 Then
		CLV_ItemClick(0, CLV.GetValue(0))
	End If
End Sub

'Returns true if the text is one of the preset items.
Public Sub getIsValid As Boolean
	Return AllItems.Contains(TextField.Text)
End Sub

'Returns the text if it is one of the preset items or empty string if not.
Public Sub getTextIfValid As String
	If getIsValid Then Return TextField.Text Else Return ""
End Sub


'Builds the index and returns an object which you can store as a process global variable
'in order to avoid rebuilding the index when the device orientation changes.
Public Sub SetItems(Items As List) As Object
	AllItems.Clear
	Dim startTime As Long
	startTime = DateTime.Now
	Dim noDuplicates As Map
	noDuplicates.Initialize
	prefixList.Clear
	substringList.Clear
	Dim m As Map
	Dim li As List
	For i = 0 To Items.Size - 1
		Dim item As String = Items.Get(i)
		AllItems.Add(item)
		item = item.ToLowerCase
		noDuplicates.Clear
		For start = 0 To item.Length
			Dim count As Int = MIN_LIMIT
			Do While count <= MAX_LIMIT And start + count <= item.Length
				Dim str As String
				str = item.SubString2(start, start + count)
				If noDuplicates.ContainsKey(str) = False Then
					noDuplicates.Put(str, "")
					If start = 0 Then m = prefixList Else m = substringList
					li = m.Get(str)
					If li.IsInitialized = False Then
						li.Initialize
						m.Put(str, li)
					End If
					li.Add(Items.Get(i)) 'Preserve the original case
				End If
				count = count + 1
			Loop
		Next
	Next
	Log("Index time: " & (DateTime.Now - startTime) & " ms (" & Items.Size & " Items)")
	Return Array As Object(prefixList, substringList)
End Sub
