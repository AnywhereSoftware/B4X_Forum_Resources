B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: MenuButtonAction(MI As MenuItem)
#DesignerProperty: Key: usestylesheet, DisplayName: Use Stylesheet, FieldType: Boolean, DefaultValue: False, Description: Select if you want to style with your own stylesheet. Removes styles from the label. "menu-button-cv" "menu-button-lbl" and "menu-button-iv" will be added To the MenuButton Graphic Label and buttons ImageView styleclasses regardless
#DesignerProperty: Key: imgname, DisplayName: Image File Name, FieldType: String, DefaultValue: , Description: Image to display on the button
#DesignerProperty: Key: imageratio, DisplayName: Image Preserve Ratio, FieldType: Boolean, DefaultValue: True, Description: Preserve ration for the button image.
#DesignerProperty: Key: hidearrow, DisplayName: Hide Arrow, FieldType: Boolean, DefaultValue: False, Description: Hide the dropdown arrow.
#DesignerProperty: Key: menutext, DisplayName: Menu Items, FieldType: String, DefaultValue: , Description: Menu items as a JSON string.
#DesignerProperty: Key: fontfamily, DisplayName: Menu Item Font family, FieldType: String, DefaultValue: System, Description: Font family for menu items. This is only applied if not using a stylesheet.
#DesignerProperty: Key: textsize, DisplayName: Menu items Text Size, FieldType: Int, DefaultValue: 14, MinRange: 5, MaxRange: 50, Description: Text size for menu items. This is only applied if not using a stylesheet. 
#DesignerProperty: Key: ttfontfamily, DisplayName: Tooltip Font Family, FieldType: String, DefaultValue: System, Description: Font family for menubutton tooltip. This is only applied if not using a stylesheet.

#If Version
V1.01 	Initial release												17-Sep-2023
V1.02 	Removed Logs and added comments.							17-Sep-2023
		Added Image for the button.
		Added Shortcut - Accelerator keys
#End If

Sub Class_Globals
	Private fx As JFX
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private mLbl As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private ButtonCV As MenuButton
	Private EventNameMap As Map
	Private IVBackground As B4XView
	Private IV As ImageView
	Private IVPadd As B4XRect
	Private Target As Node
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	ButtonCV.Initialize
	EventNameMap.Initialize
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mLbl = Lbl
	
	Dim ImageName As String = Props.GetDefault("imgname","")
	If ImageName = "" Then
		Target = mLbl
	Else
		IVBackground = xui.CreatePanel("")
		IVBackground.SetLayoutAnimated(0,0,0,mBase.Width,mBase.Height)
		IV.Initialize("")
		Dim Img As Image
		Img.Initialize(File.DirAssets,ImageName)
		IV.SetImage(Img)
		IV.PreserveRatio = Props.GetDefault("imageratio",True)
		IV.As(B4XView).Width = mBase.Width
		IV.As(B4XView).Height = mBase.Width
		IVBackground.AddView(IV,0,0,IV.Width,IV.Height)
		Target = IVBackground
	End If
	
	
	'Use the label as a graphic for the menubutton. all it's styles will be retained unless using a stylesheet.
	'If using a stylesheet, do all the styling in the stylesheet as some may not overwrite that created in code or the designer.
	ButtonCV.Create3("",Target)
	
	'Add the buttonMenu to mBase
	mBase.AddView(ButtonCV.GetObject,0,0,mBase.Width,mBase.Height)
	
	'Get and parse the JSON string representing the menu items to be added.
	Dim MenuText As String = Props.GetDefault("menutext","")
	If MenuText <> "" Then
		ButtonCV.GetItems.AddAll(ParseJSONMenu(MenuText))
	End If
	
	'Hide the arrow and set padding to 0 on the ButtonLabel
	If Props.GetDefault("hidearrow",False) Then
		mBase.As(JavaObject).RunMethod("getStylesheets",Null).As(List).Add(File.GetUri(File.DirAssets,"menubuttonlayout.css"))
	End If
	
	'Adjust for default padding if required
	If mBase.As(Node).Style.Contains("-fx-padding") Then
		Dim Padding As String = CSSUtils.GetStyleProperty(mBase,"-fx-padding")
		'ImageView does not have a setPadding method
		If IV.IsInitialized Then
			RemoveInlineStyle(mBase,"-fx-padding")
			IVPadd = PaddingToRect(Padding)
			Base_Resize(mBase.Width,mBase.Height)
		Else
			SetPadding(Lbl,Padding)
			RemoveInlineStyle(mBase,"-fx-padding")
		End If
	End If

	'Move any border css to the Target.
	If mBase.As(Node).Style.Contains("-fx-border-color") Then
		Dim BorderColor As String = CSSUtils.GetStyleProperty(mBase,"-fx-border-color")
		Dim BorderWidth As String = CSSUtils.GetStyleProperty(mBase,"-fx-border-width")
		RemoveInlineStyle(mBase,"-fx-border-color")
		RemoveInlineStyle(mBase,"-fx-border-width")
		CSSUtils.SetStyleProperty(Target,"-fx-border-color",BorderColor)
		CSSUtils.SetStyleProperty(Target,"-fx-border-width",BorderWidth)
	End If
	'Move any radius  css to the Target.
	If mBase.As(Node).Style.Contains("-fx-border-radius") Then
		Dim BorderRadius As String = CSSUtils.GetStyleProperty(mBase,"-fx-border-radius")
		Dim BackgroundRadius As String = CSSUtils.GetStyleProperty(mBase,"-fx-background-radius")
		RemoveInlineStyle(mBase,"-fx-border-radius")
		RemoveInlineStyle(mBase,"-fx-background-radius")
		CSSUtils.SetStyleProperty(Target,"-fx-border-radius",BorderRadius)
		CSSUtils.SetStyleProperty(Target,"-fx-background-radius",BackgroundRadius)
	End If
	
	
	'Add Styleclasses for CSS files
	ButtonCV.StyleClasses.Add("menu-button-cv")
	Lbl.StyleClasses.Add("menu-button-lbl")
	If IV.IsInitialized Then IV.StyleClasses.Add("menu-button-iv")

	'If wishing to style using a stylesheet then remove styles from the button and label
	If Props.GetDefault("usestylesheet",False) Then
		mBase.as(Node).Style = ""
		Target.Style = ""
	Else
		'Move background color to the Target
		If mBase.Color <> 0 Then
			Target.As(B4XView).Color = mBase.Color
			mBase.Color = 0
		End If
		
		'Set the font family and text size provided in the designer.
		Dim TextSize As Int = Props.GetDefault("textsize",14)
		Dim Fontfamily As String = Props.GetDefault("fontfamily","System")
		Dim ttFontFamily As String = Props.GetDefault("ttfontfamily","System")
		ButtonCV.Style = $"-fx-font-family:${Fontfamily};-fx-font-size:${TextSize};"$
		
		'Move any tooltip text to the MenuButton
		If Lbl.TooltipText <> "" Then
			Dim tt As JavaObject = ButtonCV.SetTooltipText(Lbl.TooltipText)
			Dim F As Font = fx.CreateFont(ttFontFamily,TextSize,False,False)
			tt.RunMethod("setFont",Array(F))
			mLbl.As(JavaObject).RunMethod("setTooltip",Array(Null))
		End If
	End If
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	ButtonCV.asB4XView.SetLayoutAnimated(0,0,0,Width,Height)
	If IV.IsInitialized Then
		Dim R As B4XRect
		R.Initialize(IVPadd.Left,IVPadd.Top,Width - IVPadd.Right,Height - IVPadd.Bottom)
		IV.SetLayoutAnimated(0,R.Left,R.Top,R.Width,R.Height)
	Else
		ButtonCV.SetPadding(0)
	End If
End Sub

#Region Wrapper subs

Public Sub getItems As List
	Return ButtonCV.GetItems
End Sub

Public Sub getMenuButton As MenuButton
	Return ButtonCV
End Sub

Private Sub ButtonCV_Action
	Dim MI As MenuItem = Sender
	Dim EventName As String = EventNameMap.GetDefault(Sender,mEventName)
	If SubExists(mCallBack,EventName & "_MenuButtonAction") Then
		CallSubDelayed2(mCallBack,EventName & "_MenuButtonAction",MI)
	End If
End Sub

#End Region Wrapper subs

#Region Parse Menu

Private Sub ParseJSONMenu(Text As String) As List
	Dim L As List
	Try
		Dim Parser As JSONParser
		Parser.Initialize(Text)
	Catch
		Log(LastException.Message)
		Return L
	End Try
	
	L.Initialize
	
	L = Parser.NextArray
	
	Return ParseJSONImpl(L)
End Sub

Private Sub ParseJSONImpl(L As List) As List
	Dim OutList As List
	OutList.Initialize
	For Each Item As Object In L
		If Item Is Map Then
			Dim ItemMap As Map = Item
			'CheckboxMenuItem
			If ItemMap.ContainsKey("Selected") Then
				Dim CMI As CheckMenuItem
				Dim MenuText As String = ItemMap.GetDefault("Text","")
				Dim EventName As String = "ButtonCV"
				CMI.Initialize(MenuText,EventName)
				Dim AltEventName As String = ItemMap.GetDefault("EventName","")
				If AltEventName <> "" Then
					EventNameMap.Put(CMI,AltEventName)
				End If
				CMI.Enabled = ItemMap.GetDefault("Enabled",True)
				CMI.Tag = ItemMap.GetDefault("Tag","")
				Dim ImageURI As String = ItemMap.GetDefault("Image","")
				If ImageURI <> "" Then
					Dim Img As Image
					Img.Initialize(File.DirAssets,ImageURI)
					CMI.Image = Img
				End If
				Dim Shortcut As Map = ItemMap.GetDefault("Shortcut",CreateMap())
				If Shortcut.Size > 0 Then
					SetKeyComb(CMI,Shortcut)
				End If
				OutList.Add(CMI)
			Else
				Dim MenuText As String = ItemMap.GetDefault("Text","")
				Dim EventName As String = "ButtonCV"
				'Menu
				If ItemMap.ContainsKey("Children") Then
					Dim MU As Menu
					MU.Initialize(MenuText,EventName)
					Dim AltEventName As String = ItemMap.GetDefault("EventName","")
					If AltEventName <> "" Then
						EventNameMap.Put(MU,AltEventName)
					End If
					MU.Tag = ItemMap.GetDefault("Tag","")
					MU.MenuItems.AddAll(ParseJSONImpl(ItemMap.Get("Children")))
					Dim ImageURI As String = ItemMap.GetDefault("Image","")
					If ImageURI <> "" Then
						Dim Img As Image
						Img.Initialize(File.DirAssets,ImageURI)
						Dim IV As ImageView
						IV.Initialize("")
						IV.SetImage(Img)
						MU.As(JavaObject).RunMethod("setGraphic",Array(IV))
					End If
					Dim Shortcut As Map = ItemMap.GetDefault("Shortcut",CreateMap())
					If Shortcut.Size > 0 Then
						SetKeyComb(MU,Shortcut)
					End If
					OutList.Add(MU)
				Else
					'MenuItem
					Dim MenuText As String = ItemMap.GetDefault("Text","")
					Dim EventName As String = "ButtonCV"
					Dim MI As MenuItem
					MI.Initialize(MenuText,EventName)
					Dim AltEventName As String = ItemMap.GetDefault("EventName","")
					If AltEventName <> "" Then
						EventNameMap.Put(MI,AltEventName)
					End If
					MI.Enabled = ItemMap.GetDefault("Enabled",True)
					MI.Tag = ItemMap.GetDefault("Tag","")
					Dim ImageURI As String = ItemMap.GetDefault("Image","")
					If ImageURI <> "" Then
						Dim Img As Image
						Img.Initialize(File.DirAssets,ImageURI)
						CMI.Image = Img
					End If
					Dim Shortcut As Map = ItemMap.GetDefault("Shortcut",CreateMap())
					If Shortcut.Size > 0 Then
						SetKeyComb(MI,Shortcut)
					End If
					OutList.Add(MI)
				End If
			End If
				
		Else If Item Is List Then
			'Another list of menus
			OutList.Add(ParseJSONImpl(Item))
		Else
			'Menu items not wrapped in a map
			If Item = "-" Then
				OutList.Add(MenuSeparatorItem)
			Else
				Dim MI As MenuItem
				MI.Initialize(Item,"ButtonCV")
				OutList.Add(MI)
			End If
		End If
	Next
	
	Return OutList
End Sub

Private Sub SetKeyComb(MI As JavaObject, ShortCut As Map)
	Dim KeyCombStr As String
	Dim Key As String = ShortCut.Get("Key")
	Dim Modifier As Object = ShortCut.GetDefault("Modifier","")
	If "" <> Modifier Then
		If Modifier Is List Then
			Dim Modlist As List = Modifier
			Dim Sb As StringBuilder
			Sb.Initialize
			For i = 0 To Modlist.Size - 1
				Sb.Append(Modlist.Get(i))
				Sb.Append("+")
			Next
			Sb.Append(Key)
			KeyCombStr = Sb.ToString
		Else
			KeyCombStr = Modifier & "+" & Key
		End If
		KeyCombStr = KeyCombStr.Replace("SHORTCUT","Shortcut").Replace("CONTROL","Shortcut").Replace("SHIFT","Shift").Replace("ALT","Alt")
	Else
		KeyCombStr = Key
	End If
	Dim KeyComb As JavaObject
	KeyComb.InitializeStatic("javafx.scene.input.KeyCombination")
	MI.RunMethod("setAccelerator",Array(KeyComb.RunMethod("keyCombination",Array(KeyCombStr))))
End Sub


Private Sub ParseJSONContextMenu(Text As String) As Menu			'Ignore
	Dim Output As Menu
	
	Try
		Dim Parser As JSONParser
		Parser.Initialize(Text)
	Catch
		Log(LastException.Message)
		Return Output
	End Try
	
	Output.Initialize("","")
	
	Dim L As List = Parser.NextArray
	
	Output.MenuItems.AddAll(ParseJSONImpl(L))
	
	Return Output
End Sub

#End Region Parse Menu

#Region Utility Subs
'Utility subs
Private Sub SetPadding(N As Node,Padding As String)
	Dim Pattern As String = IIf(Padding.IndexOf(",") > -1,","," ")
	Dim Pads As List = Regex.Split(Pattern,Padding)
	Dim Insets As JavaObject
	If Pads.Size = 1 Then
		Insets.InitializeNewInstance("javafx.geometry.Insets",Array(Pads.Get(0).As(Double)))
		If 0 = Pads.Get(0) Then Insets = Insets.GetField("EMPTY")
	Else
		Insets.InitializeNewInstance("javafx.geometry.Insets",Array(Pads.Get(0).As(Double),Pads.Get(1).As(Double),Pads.Get(2).As(Double),Pads.Get(3).As(Double)))
		If 0 = Pads.Get(0) + Pads.Get(1) + Pads.Get(2) + Pads.Get(3) Then Insets = Insets.GetField("EMPTY")
	End If
	N.As(JavaObject).RunMethod("setPadding",Array(Insets))
End Sub

Public Sub RemoveInlineStyle(N As Node,Property As String)
	Dim SB As StringBuilder
	SB.Initialize
	If N.Style.Contains(Property) Then
		Dim Props As List = Regex.Split(";",N.Style)
		For Each S As String In Props
			Dim p As String = S.SubString2(0,S.IndexOf(":")).Trim
			If P = Property Then Continue
			SB.Append(S)
			SB.Append(";")
		Next
	End If
	N.Style = SB.ToString
End Sub

Public Sub MenuSeparatorItem As JavaObject
	Dim TJO As JavaObject
	TJO.InitializeNewInstance("javafx.scene.control.SeparatorMenuItem",Null)
	Return TJO
End Sub

Private Sub PaddingToRect(Padding As String) As B4XRect
	Dim Pattern As String = IIf(Padding.IndexOf(",") > -1,","," ")
	Dim Pads As List = Regex.Split(Pattern,Padding)
	Dim R As B4XRect
	If Pads.Size = 1 Then
		R.Initialize(Pads.Get(0),Pads.Get(0),Pads.Get(0),Pads.Get(0))
	Else
		R.Initialize(Pads.Get(3),Pads.Get(0),Pads.Get(1),Pads.Get(2))
	End If
	Return R
End Sub

#End Region Utils Subs