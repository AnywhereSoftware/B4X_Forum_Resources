B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.6
@EndOfDesignText@
' ################################################
' Custom View Rich Text Editor
' ------------------------------------------------
' Version:		1.3
' Name:			RTF_Editor
' Type:			B4Xlib - B4A
' Designer:		Yes
' Libs:			B4XCollections, Core, IME, XUI, XUI views
'				SMMRichEditor
' Files:		Editor.html, normalize.css, rich_editor.js
'				style.css
' Layout:		Layout, RTFEditor
' ------------------------------------------------
' (C)			SMMRichEditor: somed3v3loper
' (C)			TechDoc G. Becker
' NOTICE!		Free to use for Board menbers only!
' ################################################

#region --- Update Log ---
' 15.1.2021 1.0 Alpha 1st release
' 16.1.2021 1.1 Alpha
' 5.3.2021 1.3 Bad DefaultValue Prop corrected
'	- added editor to scrollview
#end region

' ################################################

#region --- Designer Properties & Events
#DesignerProperty: Key: EditorPanelHeight, DisplayName: Editor Panel height, FieldType: Int, DefaultValue: 200, Description: Height of the Editor Panel

#Event: TextChanged (HTML as string)

#end region

' ################################################

#region --- view basics
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private ime As IME
	Private ColorTemplate As B4XColorTemplate
	Private Dialog As B4XDialog
	Public EditorText As String
		
	Private pnlHeader As Panel
	Private btBold As SwiftButton
	Private btItalic As SwiftButton
	Private btTextColor As SwiftButton
	Private btFeatures As SwiftButton
	Private lblTextSize As B4XView
	Private btSizeList As SwiftButton
	Private clvSizeValues As ListView
	Private pnlSizeValues As B4XView
	Private pnlFeatures As Panel
	Private RTE As SMMRichEditor
	Private btUnderline As SwiftButton
	Private btStrike As SwiftButton
	Private btSuper As SwiftButton
	Private btSub As SwiftButton
	Private btALeft As SwiftButton
	Private btCenter As SwiftButton
	Private btRight As SwiftButton
	Private btIndent As SwiftButton
	Private btOutdent As SwiftButton
	Private btBullet As SwiftButton
	Private btNumbers As SwiftButton
	Private btCheck As SwiftButton
	
	Private OnOff(13) As Boolean
	Private iprops As Map
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	RTE.Initialize("RTE")
	iprops.initialize
	ColorTemplate.Initialize
	ime.Initialize("")
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	
	' copy props
	iprops = Props
	
	' wait until startup activities finished
	CallSubDelayed(Me, "AfterLoadLayout")
End Sub

Public Sub AfterLoadLayout()
	' load editor layout
	mBase.LoadLayout("RTFEditor")
	
	' set rte
	RTE.Width = mBase. width
	RTE.Height= mBase.Height-pnlHeader.height
	RTE.EditorHeight = 3 * mBase.height
	RTE.AddToParent(mBase,10dip, _
		pnlHeader.height+20dip,RTE.width-20,RTE.height-20dip)
	RTE.RequestFocus
	
	' set size value list1	
	clvSizeValues.SingleLineLayout.Label.TextSize=14
	clvSizeValues.Color=xui.Color_LightGray
	clvSizeValues.SingleLineLayout.Label.Textcolor=Colors.Black
	For x = 8 To 72 Step 2
		clvSizeValues.AddSingleLine(x)
	Next
	clvSizeValues.SetSelection(3)
	
	' set other parameter
	RTE.EditorFontSize=14
	RTE.focusEditor
	lblTextSize.Text=14
	
	For x = 0 To OnOff.length-1
		OnOff(x) = False
	Next
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)

End Sub
#end region
' ################################################

#region --- click ---

'switch button backgroundcolor green=activ, black = not active
private Sub switchButtonColor(lbl As B4XView, State As Boolean)

	If State = True Then
		lbl.SetColorAndBorder(Colors.Green,0,Colors.Transparent,0)	
		lbl.TextColor=Colors.black
	Else
		lbl.SetColorAndBorder(Colors.black,0,Colors.Transparent,0)
		lbl.TextColor=Colors.white
	End If
End Sub

' Header Buttons
Private Sub btBold_Click
	RTE.setBold
	OnOff(0) = Not(OnOff(0))
	switchButtonColor(btBold.xLBL,OnOff(0))
	Sleep(0)
	pnlFeatures.Visible=False
End Sub

Private Sub btSizeList_Click
	pnlSizeValues.Visible=Not(pnlSizeValues.visible)
End Sub


Private Sub btTextColor_Click
	ime.HideKeyboard
	If Dialog.IsInitialized = False Then Dialog.Initialize(mBase.Parent)
	Wait For (Dialog.ShowTemplate(ColorTemplate, "OK", "", "")) Complete (Result As Int)
	If Result = xui.DialogResponse_Positive Then
		RTE.EditorFontColor=ColorTemplate.SelectedColor
		RTE.focusEditor
	End If
	pnlFeatures.Visible=False
End Sub

Private Sub btUndo_Click
	RTE.undo
	RTE.focusEditor
End Sub

Private Sub btUnderline_Click
	RTE.setUnderline
	OnOff(1) = Not(OnOff(1))
	switchButtonColor(btUnderline.xLBL,OnOff(1))
	pnlFeatures.Visible=False
End Sub

Private Sub btItalic_Click
	RTE.setItalic
	OnOff(2) = Not(OnOff(2))
	switchButtonColor(btItalic.xLBL,OnOff(2))
	pnlFeatures.Visible=False
End Sub

Private Sub btFeatures_Click
	pnlFeatures.Visible=Not(pnlFeatures.Visible)
End Sub


' Features Buttons

Private Sub btSuper_Click
	RTE.setSuperscript
	OnOff(3) = Not(OnOff(3))
	switchButtonColor(btSuper.xLBL,OnOff(3))
	pnlFeatures.Visible=False
End Sub

Private Sub btSub_Click
	RTE.setSubscript
	OnOff(4) = Not(OnOff(4))
	switchButtonColor(btSub.xLBL,OnOff(4))
	pnlFeatures.Visible=False
End Sub

Private Sub btALeft_Click
	RTE.setAlignLeft
	OnOff(5) = Not(OnOff(5))
	switchButtonColor(btALeft.xLBL,OnOff(5))
	pnlFeatures.Visible=False
End Sub

Private Sub btCenter_Click
	RTE.setAlignCenter
	OnOff(6) = Not(OnOff(6))
	switchButtonColor(btCenter.xLBL,OnOff(6))
	pnlFeatures.Visible=False
End Sub

Private Sub btRight_Click
	RTE.setAlignRight
	OnOff(7) = Not(OnOff(7))
	switchButtonColor(btRight.xLBL,OnOff(7))
	pnlFeatures.Visible=False
End Sub

Private Sub btIndent_Click
	RTE.setIndent
	OnOff(8) = Not(OnOff(8))
	switchButtonColor(btIndent.xLBL,OnOff(8))
	pnlFeatures.Visible=False
End Sub

Private Sub btOutdent_Click
	RTE.setOutdent
	OnOff(9) = Not(OnOff(9))
	switchButtonColor(btOutdent.xLBL,OnOff(9))
	pnlFeatures.Visible=False
End Sub

Private Sub btStrike_Click
	RTE.setStrikeThrough
	OnOff(10) = Not(OnOff(10))
	switchButtonColor(btStrike.xLBL,OnOff(10))
	pnlFeatures.Visible=False
End Sub

Private Sub btCheck_Click
	RTE.insertTodo
	OnOff(11) = Not(OnOff(11))
	switchButtonColor(btCheck.xLBL,OnOff(11))
	pnlFeatures.Visible=False
End Sub

Private Sub btBullet_Click
	RTE.setBullets
	OnOff(12) = Not(OnOff(12))
	switchButtonColor(btBullet.xLBL,OnOff(12))
	pnlFeatures.Visible=False
End Sub

Private Sub btNumbers_Click
	RTE.setnumbers
	OnOff(13) = Not(OnOff(13))
	switchButtonColor(btNumbers.xLBL,OnOff(13))
	pnlFeatures.Visible=False
End Sub
Private Sub pnlHeader_Click
	ime.HideKeyboard
End Sub

' panel
Private Sub pnlFeatures_Click
	pnlFeatures.visible=False
End Sub
#end region

' ################################################

#region --- RTE ---
private Sub RTE_textchanged (new As String)
	EditorText = new
	If xui.SubExists(mCallBack, mEventName & "_TextChanged",0) Then
		CallSub2(mCallBack,mEventName & "_TextChanged",new)
	End If
End Sub

public Sub setEditorHTMLText(HTML As String)
	EditorText=HTML
	RTE.Html=HTML
End Sub

#end region

' ################################################

#region --- Listview ---
Private Sub clvSizeValues_ItemClick (Index As Int, Value As Object)
	RTE.EditorFontSize= Value
	lblTextSize.Text=Value
	pnlSizeValues.Visible=False
End Sub
#end region






