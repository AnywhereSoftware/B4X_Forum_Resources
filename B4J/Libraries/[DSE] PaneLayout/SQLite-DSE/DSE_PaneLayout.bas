B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#Event: Clicked(Lbl as B4xView)
#Event: Action(TF as B4xView)
#Event: CheckedChange(CMB as ComboBox)
Sub Class_Globals
	Dim XUI As XUI
	
	Public Const VIEW_CHECKBOX As String = "checkbox"
	Public Const VIEW_COMBOBOX As String = "combobox"
	Public Const VIEW_LABEL As String = "label"
	Public Const VIEW_TEXTFIELD As String = "textfield"
	
	Private mCount As Int = 1
	Private mWidths() As Double
	Private mTypes() As String
	Private mEventNames() As String
	Private mLeftMargin As Int = 5
	Private mSpacing As Int = 0
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Reset
	mCount = 1
	mLeftMargin = 5
	mSpacing = 0
	Dim mWidths() As Double
	Dim mTypes() As String
	Dim mEventNames() As String
End Sub

'Number of labels to add
Public Sub setCount(Count As Int)
	mCount = Count
End Sub

'There should be as many entries in the Widths array as you set in count.
Public Sub setWidths(Widths() As Double)
	mWidths = Widths
End Sub

'There should be as many entries in the types array as you set in count.
Public Sub setTypes(Types() As String)
	mTypes = Types	
End Sub

'There should be as many entries in the EventNames array as you set in count.
'Entries should be "" if not required
Public Sub setEventNames(EventNames() As String)
	mEventNames = EventNames
End Sub

'Default = 0
Public Sub setSpacing(Spacing As Int)
	mSpacing = Spacing
End Sub

'Default = 5
Public Sub setLeftMargin(LeftMargin As Int)
	mLeftMargin = LeftMargin
End Sub

'DSE_Layout.Create(Pane1)
Public Sub Create(DesignerArgs As DesignerArgs)
	'In case Eventnames are not set
	If mEventNames.Length = 0 Then
		Dim mEventNames(mCount) As String
	End If
	
	'In case Types are not set
	If mTypes.Length = 0 Then
		Dim mTypes(mCount) As String
	End If
	
	'In case Widths are not set, set evenly spaced Labels
	If mWidths.Length = 0 Then
		Dim mWidths(mCount) As Double
		Dim Width As Double = DesignerArgs.Parent.As(B4XView).Width / mCount
		For i = 0 To mCount - 1
			mWidths(i) = Width
		Next
	End If
	
	Dim P As B4XView = DesignerArgs.GetViewFromArgs(0)
	If DesignerArgs.FirstRun Then
		Dim Left As Double = mLeftMargin
		For i = 0 To mCount - 1
			Dim Width As Double = mWidths(i)

			Select mTypes(i)
				Case VIEW_COMBOBOX
					Dim CMB As ComboBox
					If mEventNames(i) <> ""  Then
						CMB.Initialize("CMB")
						CMB.Tag = CreateMap("Module":DesignerArgs.LayoutModule,"EventName":mEventNames(i),"Color":0)
					Else
						CMB.Initialize("")
					End If
					P.AddView(CMB,Left,0,Width,P.Height)
					
				Case VIEW_CHECKBOX
					Dim CB As CheckBox
					If mEventNames(i) <> ""  Then
						CB.Initialize("CB")
						CB.Tag = CreateMap("Module":DesignerArgs.LayoutModule,"EventName":mEventNames(i),"Color":0)
					Else
						CB.Initialize("")
					End If
					P.AddView(CB,Left,0,Width,P.Height)
					
				Case VIEW_LABEL,""
					Dim Lbl As Label
					If mEventNames(i) <> ""  Then
						Lbl.Initialize("Lbl")
						Dim BXLbl As B4XView = Lbl
						BXLbl.SetColorAndBorder(BXLbl.Color,2,XUI.Color_Transparent,0)
						Lbl.Tag = CreateMap("Module":DesignerArgs.LayoutModule,"EventName":mEventNames(i),"Color":BXLbl.color)
					Else
						Lbl.Initialize("")
					End If
					P.AddView(Lbl,Left,0,Width,P.Height)
					
				Case VIEW_TEXTFIELD
					Dim TF As TextField
					If mEventNames(i) <> ""  Then
						TF.Initialize("TF")
						TF.Tag = CreateMap("Module":DesignerArgs.LayoutModule,"EventName":mEventNames(i),"Color":0)
					Else
						TF.Initialize("")
					End If
					P.AddView(TF,Left,0,Width,P.Height)
			End Select
			Left = Left + Width + mSpacing
		Next
	End If
End Sub

Public Sub Lbl_MouseClicked (EventData As MouseEvent)
	'Do not pass the click to the CLV
	EventData.Consume
	Dim Lbl As B4XView = Sender
	Dim M As Map = Lbl.Tag
	If SubExists(M.Get("Module"),M.Get("EventName") & "_Clicked") Then
		CallSubDelayed2(M.Get("Module"),M.Get("EventName").As(String) & "_Clicked",Lbl)
	
		'Visual click notifier
		Lbl.SetColorAndBorder(XUI.Color_White,2,XUI.Color_Blue,0)
		Sleep(300)
		Lbl.SetColorAndBorder(M.Get("Color"),0,XUI.Color_Transparent,0)
	End If
End Sub

'Visual mouseover notifier
Public Sub Lbl_MouseEntered (EventData As MouseEvent)
	Dim Lbl As B4XView = Sender
	Lbl.Color = 0xFFF0F0F0
End Sub

Public Sub Lbl_MouseExited (EventData As MouseEvent)
	Dim Lbl As B4XView = Sender
	Dim M As Map = Lbl.Tag
	Lbl.Color = M.Get("Color")
End Sub

Public Sub TF_Action
	Dim TF As B4XView = Sender
	Dim M As Map = TF.Tag
	If SubExists(M.Get("Module"),M.Get("EventName") & "_Action") Then
		CallSubDelayed2(M.Get("Module"),M.Get("EventName").As(String) & "_Action",TF)
	End If
End Sub

Public Sub CB_CheckedChange(Checked As Boolean)
	Dim CB As B4XView = Sender
	Dim M As Map = CB.Tag
	If SubExists(M.Get("Module"),M.Get("EventName") & "_CheckedChange") Then
		CallSubDelayed2(M.Get("Module"),M.Get("EventName").As(String) & "_CheckedChange",CB)
	End If
End Sub

Private Sub CMB_SelectedIndexChanged(Index As Int, Value As Object)
	Dim CMB As ComboBox = Sender
	Dim M As Map = CMB.Tag
	If SubExists(M.Get("Module"),M.Get("EventName") & "_SelectedIndexChanged") Then
		CallSubDelayed2(M.Get("Module"),M.Get("EventName").As(String) & "_SelectedIndexChanged",CMB)
	End If
End Sub