B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#DesignerProperty: Key: FocusTraversable, DisplayName: Focus Traversable, FieldType: Boolean, DefaultValue: False, Description Set whether the TextField obtains focus when tabbed onto
#DesignerProperty: Key: Editable, DisplayName: Make Editable, FieldType: Boolean, DefaultValue: True, Description Set whether the TextField can be edited.
#DesignerProperty: Key: LblPadding, DisplayName: Label left padding, FieldType: Int, DefaultValue: 9, Description: Left padding to set when displayed as a label. Default is 9 to match the textfields padding. Set it to 0 to match other labels.

#Event: Action
#Event: FocusChanged (HasFocus As Boolean)
#Event: MouseClicked (EventData As MouseEvent)
#Event: TextChanged (Old As String, New As String)

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private TF As TextField
	Public TextField1 As B4XView
	Private Editable As Boolean = True
	Private Insets,DefaultInsets As JavaObject
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	TF.Initialize("TFLabel")
	TextField1 = TF
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mBase.AddView(TextField1,0,0,mBase.Width,mBase.Height)
	TextField1.Text = Lbl.Text
	If Lbl.TooltipText <> "" Then TextField1.As(TextField).TooltipText = Lbl.TooltipText
	TextField1.TextSize = Lbl.TextSize
	Dim TextColor As Int = xui.PaintOrColorToColor(Lbl.TextColor)
	If TextColor <> 0xFF000000 Then TextField1.TextColor = TextColor
	Dim Alignment() As String = Regex.Split("_",Lbl.Alignment)
	If Alignment.Length = 1 Then
		TextField1.SetTextAlignment("CENTER","CENTER")
	Else
		TextField1.SetTextAlignment(Alignment(0),Alignment(1))
	End If
	TextField1.As(JavaObject).RunMethod("setFocusTraversable",Array(Props.GetDefault("FocusTraversable",False)))

	Dim LInset As Double = Props.GetDefault("LblPadding",9)
	Insets.InitializeNewInstance("javafx.geometry.Insets",Array(0.0,0.0,0.0,LInset))
	DefaultInsets.InitializeNewInstance("javafx.geometry.Insets",Array(0.0,0.0,0.0,9.0))
	
	'Need to call this before setting editable to display as label.
	ToggleTextFieldEditable
	Editable = Props.GetDefault("Editable",True)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	TextField1.SetLayoutAnimated(0,0,0,Width,Height)
End Sub

'CustomView Subs

Public Sub setText(Text As String)
	TextField1.Text = Text
End Sub

Public Sub getText As String
	Return TextField1.Text
End Sub

Private Sub TFLabel_MouseClicked (EventData As MouseEvent)
	ToggleTextFieldEditable
	If SubExists(mCallBack,mEventName & "_MouseClicked") Then CallSubDelayed2(mCallBack,mEventName & "_MouseClicked",EventData)
End Sub
Private Sub TFLabel_FocusChanged (HasFocus As Boolean)
	If HasFocus = False And Sender.As(TextField).Editable Then
		ToggleTextFieldEditable
	End If
	If SubExists(mCallBack,mEventName & "_FocusChanged") Then CallSubDelayed2(mCallBack,mEventName & "_FocusChanged",HasFocus)
End Sub
Private Sub TFLabel_Action
	ToggleTextFieldEditable
	If SubExists(mCallBack,mEventName & "_Action") Then CallSubDelayed(mCallBack,mEventName & "_Action")
End Sub

Public Sub ToggleTextFieldEditable
	If Editable = False Then Return
	Dim State As Boolean = Not(TF.Editable)
	If State = False Then
		TF.Editable = State
		StyleClassToggle(TF,"text-field-label","text-field")
		TF.As(JavaObject).RunMethod("setPadding",Array(Insets))
	Else
		TF.Editable = State
		StyleClassToggle(TF,"text-field","text-field-label")
		TF.As(JavaObject).RunMethod("setPadding",Array(DefaultInsets))
		TF.RequestFocus
	End If
End Sub

'Delegate other calls
Private Sub TFLabel_TextChanged (Old As String, New As String)
	If SubExists(mCallBack,mEventName & "_TextChanged") Then CallSubDelayed3(mCallBack,mEventName & "_TextChanged",Old,New)
End Sub

'Utils
Private Sub StyleClassToggle(V As Node, Add As String, Remove As String)
	StyleClassRemove(V,Remove)
	StyleClassAdd(V,Add)
End Sub

Private Sub StyleClassRemove(V As Node, Remove As String)
	Dim Pos As Int = V.StyleClasses.IndexOf(Remove)
	If Pos > -1 Then
		V.StyleClasses.RemoveAt(Pos)
	End If
End Sub

Private Sub StyleClassAdd(V As Node,add As String)
	Dim Pos As Int = V.StyleClasses.IndexOf(add)
	If Pos = -1 Then
		V.StyleClasses.Add(add)
	End If
End Sub