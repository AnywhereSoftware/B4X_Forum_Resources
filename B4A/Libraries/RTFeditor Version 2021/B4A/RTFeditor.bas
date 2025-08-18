B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.7
@EndOfDesignText@
'###############################################
' Custom View: RTF editor
'-----------------------------------------------
' Name:			RTFeditor (B4xLib, Designerable)
' Version:		3
' State:		()WIP ()Release
' Depend Libs:	IME, Reflection, SMMRichEditor,
'				XUI, XUIViews, Phone
' Depend Mod.:	mod1
' Depend Class:	-
' Layout:		-
' Files:		editor.html, normalize.css,sytle.css, rich_editor.js
' Database:		-
' Other:		-
'-----------------------------------------------
' (C) TECHDOC G. Becker
'###############################################

#region --- Designer Properties ---
#DesignerProperty: Key:HintText, DisplayName:Hint, FieldType: String, DefaultValue: Insert Text here..., Description:Hint Text

#DesignerProperty: Key:EditorHeight, DisplayName:Editor Height, FieldType: Int, MinRange=10, DefaultValue: 10, Description:Height of insert area >= 10

#DesignerProperty: Key:EditorZoomSize, DisplayName:Editor Zoomlevel, FieldType: String, List: 1|2|3|4|5, DefaultValue: 2, Description:Level 1-5 to zoom all Text

#DesignerProperty: Key:EditorBackColor, DisplayName:Editor Backcolor, FieldType: Color, DefaultValue: 0xFFF2EDED, Description:Editor Background color 

#DesignerProperty: Key:EditorEnabled, DisplayName:Editor enabled, FieldType: Boolean, DefaultValue: True, Description:False if viewer


#DesignerProperty: Key:HeaderVisible, DisplayName:Header visible, FieldType: Boolean, DefaultValue: True, Description:False if hidden

#DesignerProperty: Key:HeaderButtonColor, DisplayName:Button Backcolor, FieldType: Color, DefaultValue: 0xFF000000, Description: Button Background color

#DesignerProperty: Key:HeaderButtonTextColor, DisplayName:Button Textcolor, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Button Textcolor
#end region

'###############################################

#region --- custom view events ---
#Event: HTMLchanged (New as string)
#end region

'###############################################

#region --- Globals ---
Sub Class_Globals
	
	Public Tag As Object
	Public mBase As B4XView
	Public LocalStrings As Map
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private xui As XUI 'ignore
	Private IME As IME
	Private SMM As SMMRichEditor
	Private pnlHeader(5) As B4XView
	Private mProps As Map
	Private ZoomState As String
	Private Dialog As B4XDialog
	Private ColorTemplate As B4XColorTemplate
	Private CC As ContentChooser
	Private scvHeaderH As HorizontalScrollView
	Private scvVertical As ScrollView
	Private pnlEditorEnd As Panel
	Private pnlEditorStart As Panel
	
	' Buttons Header panel 1
	Private btBold As Button
	Private btItalic As Button
	Private btUnderline As Button
	Private btAlignLeft As Button
	Private btAlignCenter As Button
	Private btAlignRight As Button
	Private btHeader1 As Button
	' Buttons Header panel 2
	Private btStrikethrough As Button
	Private btSuperscript As Button
	Private btSubscript As Button
	Private btIndent As Button
	Private btOutdent As Button
	Private btSpare1 As Button
	Private btHeader2 As Button
	'buttons Header panel 3
	Private btH1 As Button
	Private btH2 As Button
	Private btH3 As Button
	Private btH4 As Button
	Private btH5 As Button
	Private btH6 As Button
	Private btHeader3 As Button
	'Buttons Header panel 4
	Private btBullets As Button
	Private btNumbers As Button
	Private btImage As Button
	Private btCheckBox As Button
	Private btBlock As Button
	Private btSpare2 As Button
	Private btHeader4 As Button
	'Buttons Header panel 5
	Private btZoomIn As Button
	Private btZoomOut As Button
	Private btTextColor As Button
	Private btTextBackColor As Button
	Private btUndo As Button
	Private btRedo As Button
	Private btHeader5 As Button
End Sub
#end region

'###############################################

#region --- View ---
' 1st step creating view
Public Sub Initialize (Callback As Object, EventName As String)
	' set basic view values
	mEventName = EventName
	mCallBack = Callback
	
	' Initialize objects
	SMM.Initialize("SMM")
	IME.Initialize("IME")
	CC.Initialize("CC")
	ColorTemplate.Initialize
	
	' Initialize globals
	mProps.Initialize
	LocalStrings.Initialize
End Sub

' 2n Step creating view
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	' publish base and tag object
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	
	' make props values public
	mProps = Props
	
	' Add IME Eventhandler
	IME.AddHeightChangedEvent
	
	' set default language values
	LocalStrings.Put("TitleColorDlg","Choose Color")
	LocalStrings.Put("TitleImageDlg","Choose Image")
	LocalStrings.Put("ButtonCancel","Cancel")
	LocalStrings.Put("ErrorHeight","Height to small!")
	LocalStrings.Put("InfoMsg","<Spare> Not used!")

	' Add Header, Start panel = header 1
	scvHeaderH.Initialize(mBase.Width,"scvHeader")
	scvHeaderH.Height= 62dip
	Dim minHeaderWidth As Int = IntToDIP(320)
	If mBase.Width >= minHeaderWidth Then
		scvHeaderH.Panel.Width = mBase.Width
	Else
		scvHeaderH.Panel.Width = minHeaderWidth
	End If
	scvHeaderH.Panel.Height=scvHeaderH.height
	createHeader
	scvHeaderH.Panel.AddView(pnlHeader(0),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.Height)
	' add scrollview to base
	mBase.AddView(scvHeaderH,0,0,mBase.width,scvHeaderH.Height)
	
	' Add vertical scrolling editor
	scvVertical.Initialize(mBase.Height - scvHeaderH.Height)
	If mBase.Height > scvHeaderH.Height Then
		scvVertical.Height = mBase.Height - scvHeaderH.Height - 5dip
		scvVertical.Width = mBase.Width
		scvVertical.Panel.Width = mBase.Width
		scvVertical.Panel.height = 2 * Props.Get("EditorHeight") + 10dip
		scvVertical.Padding=Array As Int (10dip,50dip,5dip,5dip)
		scvVertical.Panel.Color=Props.Get("EditorBackColor")
		scvVertical.Color=Props.Get("EditorBackColor")	
		' add editor start panel
		pnlEditorStart.Initialize("EditorStart")
		pnlEditorStart.Height=5dip: pnlEditorStart. width = scvVertical.panel.width-15dip
		pnlEditorStart.Color=Colors.Black
		scvVertical.Panel.AddView(pnlEditorStart,0, _
			0,pnlEditorStart.Width,pnlEditorStart.height)
		' add smmrichtexteditor to scrollview
		SMM.Width = scvVertical.Panel.Width
		SMM.Height = Props.Get("EditorHeight")
		SMM.Placeholder = Props.Get("HintText")
		SMM.EditorHeight=Props.Get("EditorHeight")
		SMM.Placeholder = Props.Get("HintText")
		SMM.EditorFontColor=Colors.Black
		SMM.EditorBackgroundColor=Props.Get("EditorBackColor")
		Zoom(Props.Get("EditorZoomSize"))
		ZoomState=Props.Get("EditorZoomSize")
		scvVertical.Panel.AddView(SMM,0dip,10dip,SMM.Width-40dip,scvVertical.Panel.Height-50dip)
		
		' add end of editor
		
		pnlEditorEnd.Initialize("EditorEnd")
		pnlEditorEnd.Height=5dip: pnlEditorEnd. width = scvVertical.panel.width-15dip
		pnlEditorEnd.Color=Colors.Black
		scvVertical.Panel.AddView(pnlEditorEnd,0, _
			SMM.Height+5dip,pnlEditorEnd.Width,pnlEditorEnd.height)
		
		' add scrollview to base
		mBase.AddView(scvVertical,0,scvHeaderH.Height+5dip,scvVertical.Width,scvVertical.Height)
		
		' scroll to top
		scvVertical.ScrollPosition=0
		
		' set Header and Editor state
		scvHeaderH.Visible = Props.Get("HeaderVisible")
		SMM.Enabled = Props.Get("EditorEnabled")
	Else
		xui.Msgbox2Async(LocalStrings.get("ErrorHeight"),"RTFeditor","OK","","",Null)
	End If	
End Sub

Sub Base_Resize (Width As Double, Height As Double)

End Sub
#end region

'###############################################

#region --- Click Panel sliding ---
' short click next panel, long click previous panel
Private Sub btHeader1_Click
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(1),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader2_Click
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(2),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader3_Click
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(3),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader4_Click
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(4),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader5_Click
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(0),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader1_LongClick
	' add Header panel 1 as start panel to scrollview
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(4),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader2_LongClick
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(0),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader3_LongClick
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(1),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader4_LongClick
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(2),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub

Private Sub btHeader5_LongClick
	scvHeaderH.Panel.RemoveAllViews
	scvHeaderH.Panel.AddView(pnlHeader(3),0,0,scvHeaderH.Panel.Width,scvHeaderH.Panel.height)
End Sub
#end region

'###############################################

#region --- Click Button Panel 1 ---
' set bold
private Sub btBold_Click
	SMM.setBold
End Sub

'set italic
private Sub btItalic_Click
	SMM.setItalic
End Sub

' set underline
private Sub btUnderline_Click
	SMM.setUnderline
End Sub

' set align left
private Sub btAlignLeft_Click
	SMM.setAlignLeft
End Sub

' set align center
private Sub btAlignCenter_Click
	SMM.setAlignCenter
End Sub

' set align right
private Sub btAlignRight_Click
	SMM.setAlignRight
End Sub
#end region

#region --- Click Button Panel 2 ---
' set strikethrough
private Sub btStrikethrough_Click
	SMM.setStrikeThrough
End Sub

' set superscript
private Sub btSuperscript_Click
	SMM.setSuperscript
End Sub

' set subscript
private Sub btSubscript_Click
	SMM.setSubscript
End Sub

' set text indent
private Sub btIndent_Click
	SMM.setIndent
End Sub

' set text outdent
private Sub btOutdent_Click
	SMM.setOutdent
End Sub

' not used yet
private Sub btSpare1_Click
	ToastMessageShow(LocalStrings.get("InfoMsg"),False)
End Sub
#end region

#region --- Click Button Panel 3 ---
private Sub btH1_Click
	SMM.Heading=1
End Sub

private Sub btH2_Click
	SMM.Heading=2
End Sub

private Sub btH3_Click
	SMM.Heading=3
End Sub

private Sub btH4_Click
	SMM.Heading=4
End Sub

private Sub btH5_Click
	SMM.Heading=5
End Sub

private Sub btH6_Click
	SMM.Heading=6
End Sub
#end region

#region --- Click Button Panel 4 ---
' set unordered list with bullets
private Sub btBullets_Click
	IME.HideKeyboard
	SMM.setBullets
End Sub

' set ordered list with numbers
private Sub btNumbers_Click
	IME.HideKeyboard
	SMM.setNumbers
End Sub

' insert image
private Sub btImage_Click
	CC.Show("image/*", LocalStrings.Get("TitleImageDlg"))
	Wait For CC_Result (Success As Boolean, Dir As String, FileName As String)
	If Success = True Then
		SMM.insertImage(FileName,"GB")
	End If
End Sub

' insert checkbox -working-
private Sub btCheckbox_Click
	IME.HideKeyboard
	SMM.insertTodo
End Sub

' insert blockquote
private Sub btBlock_Click
	IME.HideKeyboard
	SMM.setBlockquote
End Sub

' not used yet
private Sub btSpare2_Click
	ToastMessageShow(LocalStrings.get("InfoMsg"),False)
End Sub
#end region

#region --- Click Button Panel 5 ---
' Zoom in (1-5)
private Sub btZoomIn_Click
	Select ZoomState
		Case "1"
			ZoomState="2"
		Case "2"
			ZoomState="3"
		Case "3"
			ZoomState="4"
		Case "4"
			ZoomState="5"
	End Select
	setEditorZoom(ZoomState)
End Sub

' zoom out (1-5)
private Sub btZoomOut_Click
	Select ZoomState
		Case "2"
			ZoomState="1"
		Case "3"
			ZoomState="2"
		Case "4"
			ZoomState="3"
		Case "5"
			ZoomState="4"
	End Select
	setEditorZoom(ZoomState)
End Sub

' set selected Text Textcolor
private Sub btTextColor_Click
	IME.HideKeyboard
	If Dialog.IsInitialized = False Then Dialog.Initialize(mBase.Parent)
	Wait For (Dialog.ShowTemplate(ColorTemplate, "OK", "", _
		 LocalStrings.Get("ButtonCancel"))) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		SMM.TextColor=ColorTemplate.SelectedColor
		SMM.RequestFocus
		SMM.focusEditor
	End If
End Sub

' set selected Text Backcolor
private Sub btTextBackColor_Click
	IME.HideKeyboard
	If Dialog.IsInitialized = False Then Dialog.Initialize(mBase.Parent)
	Wait For (Dialog.ShowTemplate(ColorTemplate, "OK", "", _
		LocalStrings.get("ButtonCancel"))) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		SMM.TextBackgroundColor=ColorTemplate.SelectedColor
		SMM.RequestFocus
		SMM.focusEditor
	End If
End Sub

' undo last action
private Sub btUndo_click
	SMM.undo
End Sub

' redo last action
private Sub btRedo_Click
	SMM.redo
End Sub
#end region

#region --- Click scroll buttons ---
' scroll one page up
private Sub ScrollButton_Click
	Dim pg As Int = scvVertical.Height/2
	scvVertical.ScrollPosition=scvVertical.ScrollPosition - pg
End Sub

' scroll to buttom
private Sub ScrollButton_LongClick
	scvVertical.FullScroll(True)
End Sub

' scroll to top editor end
private Sub EditorEnd_Click
	scvVertical.ScrollPosition=0
	IME.HideKeyboard
End Sub

' scroll to bottom editor top
private Sub EditorStart_Click
	scvVertical.FullScroll(True)
	IME.HideKeyboard
End Sub
#end region

'###############################################

#region --- ime ---
' modify editor height if keyboard is shown
Private Sub IME_HeightChanged (NewHeight As Int, OldHeight As Int)
End Sub

' handle keayboard action, not used yet
Private  Sub IME_HandleAction As Boolean
	'Dim e As EditText
	'e = Sender
	'If e.Text.StartsWith("a") = False Then
	'	ToastMessageShow("Text must start with 'a'.", True)
	'	'Consume the event.
	'	'The keyboard will not be closed
	'	Return True
	'Else
	'	Return False 'will close the keyboard
	'End If
	Return Null
End Sub
#end region

'###############################################

#region --- custom properties ---
' set Insert Area height
public Sub setEditorHeight( Height As Int)
	mProps.Put("EditorHeight",Height)
	SMM.EditorHeight = IntToDIP(Height)
	scvVertical.Panel.Height = 2 * IntToDIP(Height)
End Sub

' get current insert rea height
public Sub getCurrentEditorHeight As Int
	Return mProps.Get("EditorHeight")
End Sub

' set insert area hint text
public Sub setHint(Text As String)
	mProps.put("EditorHeight",Text)
	SMM.Placeholder = Text
End Sub

' get current insert area hint text
public Sub getCurrentHint As String
	Return mProps.Get("HintText")
End Sub

' set editor zoom level
' Level = "1" - "5"
public Sub setEditorZoom(Level As String)
	mProps.put("EditorZoomSize",Level)
	Zoom(mProps.Get("EditorZoomSize"))
End Sub

' get current editor zoom level
' Level = "1" - "5"
public Sub getCurrentEditorZoom As String
	Return mProps.Get("EditorZoomSize")
End Sub

' set insert area HTML code string
public Sub setEditorHTML(HTML As String)
	SMM.Html = HTML
	SMM.clearFocusEditor
	' call TextChanged Event
	SMM_TextChanged(SMM.Html)
	SMM.RequestFocus
	SMM.focusEditor
End Sub

' get current HTML code string
public Sub getCurrentEditorHTML As String
	Return SMM.html
End Sub

' set backcolor insert area
public Sub setEditorBackColor(color As Int)
	SMM.EditorBackgroundColor=color
	mProps.Put("EditorBackColor",color)
End Sub

' get currrent backcolor of insert area
public Sub getCurrentEditorBackColor As Int
	Return mProps.Get("EditorBackColor")
End Sub

' set insert area access state
' true=edit, false=view only
public Sub setEditorEnabled(Enabled As Boolean)
	SMM.enabled = Enabled
	mProps.Put("EditorEnabled",Enabled)
End Sub

' get current insert area access state
' true=edit, false=view only
public Sub getCurrentEditorEnabled As Boolean
	Return mProps.Get("EditorEnabled")
End Sub

' set state if toolbar is visible
public Sub setToolbarVisible(Visible As Boolean)
	mProps.Put("HeaderVisible",Visible)
	scvHeaderH.Visible=Visible
End Sub

' get current visiblity stae of toolbar
public Sub getCurrentToolbarVisible As Boolean
	Return mProps.Get("HeaderVisible")
End Sub

' set all toolbar button colors
public Sub setToolbarButtonColor(color As Int)
	mProps.Put("HeaderButtonColor",color)
	' Buttons Header panel 1
	btBold.Color = color
	btItalic.Color  = color
	btUnderline.Color  = color
	btAlignLeft.Color  = color
	btAlignCenter.Color  = color
	btAlignRight.Color  = color
	btHeader1.Color  = color
	' Buttons Header panel 2
	btStrikethrough.Color  = color
	btSuperscript.Color  = color
	btSubscript.Color  = color
	btIndent.Color  = color
	btOutdent.Color  = color
	btSpare1.Color  = color	
	btHeader2.Color  = color
	'buttons Header panel 3
	btH1.Color  = color
	btH2.Color  = color
	btH3.Color  = color
	btH4.Color  = color
	btH5.Color  = color
	btH6.Color  = color
	btHeader3.color = color
	'Buttons Header panel 4
	btBullets.Color  = color
	btNumbers.Color  = color
	btImage.Color =  color
	btCheckBox.Color  = color
	btBlock.Color  = color
	btSpare2.Color  = color
	btHeader4.Color  = color
	'Buttons Header panel 5
	btZoomIn.Color  = color
	btZoomOut.Color  = color
	btTextColor.Color  = color
	btTextBackColor.Color  = color
	btUndo.Color  = color
	btRedo.Color  = color
	btHeader5.Color  = color
End Sub

' get current toolbar button color
public Sub getCurrentToolbarButtonColor As Int
	Return mProps.Get("HeaderButtonColor")
End Sub

' set all toolbar buttons text color
public Sub setToolbarButtonTextColor(color As Int)
	mProps.Put("HeaderButtonTextColor",color)
	' Buttons Header panel 1
	btBold.TextColor = color
	btItalic.TextColor  = color
	btUnderline.TextColor  = color
	btAlignLeft.TextColor  = color
	btAlignCenter.TextColor  = color
	btAlignRight.TextColor  = color
	btHeader1.TextColor  = color
	' Buttons Header panel 2
	btStrikethrough.TextColor  = color
	btSuperscript.TextColor  = color
	btSubscript.TextColor  = color
	btIndent.TextColor  = color
	btOutdent.TextColor  = color
	btSpare1.TextColor  = color
	btHeader2.TextColor  = color
	'buttons Header panel 3
	btH1.TextColor  = color
	btH2.TextColor  = color
	btH3.TextColor  = color
	btH4.TextColor  = color
	btH5.TextColor  = color
	btH6.TextColor  = color
	btHeader3.textcolor = color
	'Buttons Header panel 4
	btBullets.TextColor  = color
	btNumbers.TextColor  = color
	btImage.TextColor =  color
	btCheckBox.TextColor  = color
	btBlock.TextColor  = color
	btSpare2.TextColor  = color
	btHeader4.TextColor  = color
	'Buttons Header panel 5
	btZoomIn.TextColor  = color
	btZoomOut.TextColor  = color
	btTextColor.TextColor  = color
	btTextBackColor.TextColor  = color
	btUndo.TextColor  = color
	btRedo.TextColor  = color
	btHeader5.TextColor  = color
End Sub

' get toolbar buttons text color
public Sub getCurrentToolbarButtonTextColor As Int
	Return mProps.Get("HeaderButtonTextColor")
End Sub

' get raw text of insert area
' all HTML formatting codes are stripped off
public Sub getCurrentEditorRawText As String
	' get current HTML from Editor
	Dim str As String = SMM.Html
	Dim inputC As String = ""
	Dim inputCode As String = ""
	Dim flag As Boolean = False	
	' strip off all formatting codes
	For x = 0 To str.Length-1
		' get char
		inputC = str.SubString2(x,x+1)
		' strip of format code parts
		If inputC = "<" Then 
			flag = True
		else if inputC = ">" Then
			flag = False
		else if flag = False Then
			inputCode = inputCode & inputC
		End If
	Next
	' strip off space
	inputCode.Replace("&nbsp;","")
	Return inputCode
End Sub

#end region

'###############################################

#region --- TextChanged Editor ---
' editor rtf text is changed
Private Sub SMM_TextChanged(New As String)	
	If xui.SubExists(mCallBack,mEventName & "_HTMLchanged",0) Then
		CallSub2(mCallBack,mEventName & "_HTMLchanged",New)
	End If
End Sub
#end region

'###############################################

#region --- Helpers --- 
' Create Header panels
Private Sub createHeader
	Dim btbackcolor As Int = mProps.get("HeaderButtonColor")
	Dim bttxtcolor As Int = mProps.get("HeaderButtonTextColor")
	For x = 0 To 4
		pnlHeader(x) = xui.CreatePanel("Header" & x)
		pnlHeader(x).Width = scvHeaderH.Panel.width
		pnlHeader(x).Height = scvHeaderH.height
		pnlHeader(x).SetColorAndBorder(Colors.White,2dip,Colors.black,5dip)
		Dim btTotalwidth As Int = 7 * 42
		Dim freeSpace As Int = pnlHeader(x).Width - btTotalwidth
		Dim gap As Int = freeSpace / 8
		Select x
			Case 0 ' Header panel 1
				btBold = createButton(btBold,"btBold",btbackcolor _
					,5,1,Colors.White,18,"",0xF032)
				pnlHeader(x).AddView(btBold,gap,10dip,42dip,42dip)
				btItalic=createButton(btItalic,"btItalic",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF033)
				pnlHeader(x).AddView(btItalic,2*gap+42,10dip,42dip,42dip)
				btUnderline=createButton(btUnderline,"btUnderline",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF0CD)
				pnlHeader(x).AddView(btUnderline,3*gap+84,10dip,42dip,42dip)
				btAlignLeft=createButton(btAlignLeft,"btAlignLeft",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF036)
				pnlHeader(x).AddView(btAlignLeft,4*gap+126,10dip,42dip,42dip)
				btAlignCenter=createButton(btAlignCenter,"btAlignCenter",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF037)
				pnlHeader(x).AddView(btAlignCenter,5*gap+168,10dip,42dip,42dip)
				btAlignRight=createButton(btAlignRight,"btAlignRight",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF038)
				pnlHeader(x).AddView(btAlignRight,6*gap+210,10dip,42dip,42dip)
				btHeader1=createButton(btHeader1,"btHeader1",0xFF708090,21,2, _
					bttxtcolor,14,"1",0) 'SlateGray
				pnlHeader(x).AddView(btHeader1,7*gap+252,10dip,42dip,42dip)
			Case 1 ' Header panel 2
				btStrikethrough = createButton(btStrikethrough,"btStrikethrough",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF0CC)
				pnlHeader(x).AddView(btStrikethrough,gap,10dip,42dip,42dip)
				btSuperscript=createButton(btSuperscript,"btSuperscript",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF12B)
				pnlHeader(x).AddView(btSuperscript,2*gap+42,10dip,42dip,42dip)
				btSubscript=createButton(btSubscript,"btSubscript",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF12C)
				pnlHeader(x).AddView(btSubscript,3*gap+84,10dip,42dip,42dip)
				btIndent=createButton(btIndent,"btIndent",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF03C)
				pnlHeader(x).AddView(btIndent,4*gap+126,10dip,42dip,42dip)
				btOutdent=createButton(btOutdent,"btOutdent",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF03B)
				pnlHeader(x).AddView(btOutdent,5*gap+168,10dip,42dip,42dip)
				btSpare1 = createButton(btSpare1,"btSpare1",btbackcolor _
					,5,2,bttxtcolor,18,"",0)
				pnlHeader(x).AddView(btSpare1,6*gap+210,10dip,42dip,42dip)
				btHeader2=createButton(btHeader2,"btHeader2",0xFF708090,21,2, _
					bttxtcolor,14,"2",0) 'SlateGray
				pnlHeader(x).AddView(btHeader2,7*gap+252,10dip,42dip,42dip)
			Case 2 ' Header panel 3
				btH1 = createButton(btH1,"btH1",btbackcolor _
					,5,2,bttxtcolor,14,"A",0)
				pnlHeader(x).AddView(btH1,gap,10dip,42dip,42dip)
				btH2=createButton(btH2,"btH2",btbackcolor _
					,5,2,bttxtcolor,14,"B",0)
				pnlHeader(x).AddView(btH2,2*gap+42,10dip,42dip,42dip)
				btH3=createButton(btH3,"btH3",btbackcolor _
					,5,2,bttxtcolor,14,"C",0)
				pnlHeader(x).AddView(btH3,3*gap+84,10dip,42dip,42dip)
				btH4=createButton(btH4,"btH4",btbackcolor _
					,5,2,bttxtcolor,14,"D",0)
				pnlHeader(x).AddView(btH4,4*gap+126,10dip,42dip,42dip)
				btH5=createButton(btH5,"btH5",btbackcolor _
					,5,2,bttxtcolor,14,"E",0)
				pnlHeader(x).AddView(btH5,5*gap+168,10dip,42dip,42dip)
				btH6=createButton(btH6,"btH6",btbackcolor _
					,5,2,bttxtcolor,14,"F",0)
				pnlHeader(x).AddView(btH6,6*gap+210,10dip,42dip,42dip)
				btHeader3=createButton(btHeader3,"btHeader3",0xFF708090,21,2, _
					bttxtcolor,14,"3",0) 'SlateGray
				pnlHeader(x).AddView(btHeader3,7*gap+252,10dip,42dip,42dip)
			Case 3 ' Header panel 4
				btBullets = createButton(btBullets,"btBullets",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF0CA)
				pnlHeader(x).AddView(btBullets,gap,10dip,42dip,42dip)
				btNumbers=createButton(btNumbers,"btNumbers",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF0CB)
				pnlHeader(x).AddView(btNumbers,2*gap+42,10dip,42dip,42dip)
				btImage=createButton(btImage,"btImage",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF03E)
				pnlHeader(x).AddView(btImage,3*gap+84,10dip,42dip,42dip)
				btCheckBox=createButton(btCheckBox,"btCheckBox",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF046)
				pnlHeader(x).AddView(btCheckBox,4*gap+126,10dip,42dip,42dip)
				btBlock = createButton(btBlock,"btBlock",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF00A)
				pnlHeader(x).AddView(btBlock,5*gap+168,10dip,42dip,42dip)
				btSpare2 = createButton(btSpare2,"btSpare2",btbackcolor _
					,5,2,bttxtcolor,18,"",0)
				pnlHeader(x).AddView(btSpare2,6*gap+210,10dip,42dip,42dip)
				btHeader4=createButton(btHeader4,"btHeader4",0xFF708090,21,2, _
					bttxtcolor,14,"4",0) 'SlateGray
				pnlHeader(x).AddView(btHeader4,7*gap+252,10dip,42dip,42dip)
			Case 4 ' Header  panel 5
				btZoomIn=createButton(btZoomIn,"btZoomIn",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF196)
				pnlHeader(x).AddView(btZoomIn,gap,10dip,42dip,42dip)
				btZoomOut=createButton(btZoomOut,"btZoomOut",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF147)
				pnlHeader(x).AddView(btZoomOut,2*gap+42,10dip,42dip,42dip)
				btTextColor = createButton(btTextColor,"btTextColor",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF1FC)
				pnlHeader(x).AddView(btTextColor,3*gap+84,10dip,42dip,42dip)
				btTextBackColor = createButton(btTextBackColor,"btTextBackColor",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF219)
				pnlHeader(x).AddView(btTextBackColor,4*gap+126,10dip,42dip,42dip)
				btUndo=createButton(btUndo,"btUndo",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF112)
				pnlHeader(x).AddView(btUndo,5*gap+168,10dip,42dip,42dip)
				btRedo=createButton(btRedo,"btRedo",btbackcolor _
					,5,1,bttxtcolor,18,"",0xF064)
				pnlHeader(x).AddView(btRedo,6*gap+210,10dip,42dip,42dip)
				btHeader5=createButton(btHeader5,"btHeader5",0xFF708090,21,2, _
					bttxtcolor,14,"5",0) 'SlateGray
				pnlHeader(x).AddView(btHeader5,7*gap+252,10dip,42dip,42dip)
		End Select
	Next
End Sub

' create Button
' textFont: 1=Awesome, 2=Default
' textChr: char value
Private Sub createButton ( _
	button As Button, _
	buttonName As String, _
	buttonColor As Int, _
	buttonCorner As Int, _
	textFont As Int, _
	textColor As Int, _
	textSize As Int, _
	text As String, _
	textChr As Int _
	) As Button
	
	button.Initialize(buttonName)
	Dim bt1 As B4XView = button
		
	Select textFont
		Case 1
			bt1.Font = xui.CreateFontAwesome(textSize)
			bt1.Text = Chr(textChr)
		Case 2
			bt1.Font = xui.CreateDefaultFont(textSize)
			bt1.Text = text
	End Select
	bt1.Height=42dip :	bt1.Width=42dip
	bt1.SetColorAndBorder(buttonColor,2dip,Colors.White,IntToDIP(buttonCorner))
	bt1.TextColor=textColor
	bt1.SetTextAlignment("CENTER","CENTER")
	button = bt1
	Return button
End Sub

' editor zoom in / out (1-5)
private Sub Zoom(level As String)
	Select level
		Case "1"
			SMM.EditorFontSize = 12
		Case "2"
			SMM.EditorFontSize = 18
		Case "3"
			SMM.EditorFontSize = 24
		Case "4"
			SMM.EditorFontSize = 30
		Case "5"
			SMM.EditorFontSize = 36
	End Select
End Sub

' convert integer to dip
Private Sub IntToDIP(Integer As Int) As Int
	Dim r As Reflector
	Dim scale As Float
	r.Target = r.GetContext
	r.Target = r.RunMethod("getResources")
	r.Target = r.RunMethod("getDisplayMetrics")
	scale = r.GetField("density")
  
	Dim DIP As Int
	DIP = Integer * scale + 0.5
	Return DIP
End Sub
#end region

'###############################################
'`(C) TECDOC G. Becker
'###############################################