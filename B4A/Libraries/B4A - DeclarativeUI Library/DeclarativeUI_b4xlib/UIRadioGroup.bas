B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13.62
@EndOfDesignText@
Sub Class_Globals
	Private mOptions As List
	Private mSelectedValue As String
	Private mSelectedState As UIState
	Private mTarget As Object
	Private mEventName As String
	Private mTheme As UITheme
	Private mBaseView As B4XView
	Private mParent As B4XView
	Private mLeft, mTop, mWidth, mHeight As Int
	Private mSpacing As Int
End Sub

Public Sub Initialize As UIRadioGroup
	mOptions.Initialize
	mSelectedValue = ""
	mSelectedState = Null
	mTarget = Null
	mEventName = ""
	Dim defaultTheme As UITheme
	defaultTheme.Initialize
	mTheme = defaultTheme
	mBaseView = Null
	mParent = Null
	mLeft = 0
	mTop = 0
	mWidth = 0
	mHeight = 0
	mSpacing = 0
	Return Me
End Sub

Public Sub AddOption(OptionValue As String, OptionText As String) As UIRadioGroup
	Dim option As UIRadioButton
	option.Initialize.Value(OptionValue).Text(OptionText).AttachGroup(Me).ApplyTheme(mTheme)
	mOptions.Add(option)
	If mSelectedValue = "" Then
		mSelectedValue = OptionValue
		option.SetSelectedFromGroup(True)
	End If
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

Public Sub AddButton(Option As UIRadioButton) As UIRadioGroup
	If Option = Null Then Return Me
	If Option.IsInitialized = False Then Return Me
	Option.AttachGroup(Me)
	mOptions.Add(Option)
	If mSelectedValue = "" Then
		mSelectedValue = Option.GetValue
		Option.SetSelectedFromGroup(True)
	End If
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

Public Sub Spacing(SpacingValue As Int) As UIRadioGroup
	mSpacing = Max(0, SpacingValue)
	Return Me
End Sub

Public Sub Selected(SelectedValue As String) As UIRadioGroup
	UnbindSelected
	SelectValue(SelectedValue, True)
	Return Me
End Sub

Public Sub GetSelected As String
	Return mSelectedValue
End Sub

Public Sub BindSelected(State As UIState) As UIRadioGroup
	UnbindSelected
	mSelectedState = State
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then
			mSelectedValue = StateText(mSelectedState.GetState)
			mSelectedState.Subscribe(Me, "SelectedState_Changed")
			SelectValue(mSelectedValue, False)
		End If
	End If
	Return Me
End Sub

Public Sub UnbindSelected As UIRadioGroup
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
	End If
	mSelectedState = Null
	Return Me
End Sub

' Callback signature: Sub EventName(Value As String)
Public Sub OnSelected(Target As Object, EventName As String) As UIRadioGroup
	mTarget = Target
	mEventName = EventName
	Return Me
End Sub

Public Sub ApplyTheme(Theme As UITheme) As UIRadioGroup
	If Theme = Null Then Return Me
	If Theme.IsInitialized = False Then Return Me
	mTheme = Theme
	For Each option As UIRadioButton In mOptions
		option.ApplyTheme(Theme)
	Next
	If mParent <> Null Then
		If mParent.IsInitialized Then Render
	End If
	Return Me
End Sub

Public Sub SetParent(Parent As B4XView)
	mParent = Parent
End Sub

Public Sub SetPosition(Left As Int, Top As Int)
	mLeft = Left
	mTop = Top
End Sub

Public Sub SetSize(Width As Int, Height As Int)
	mWidth = Max(0, Width)
	mHeight = Max(0, Height)
End Sub

Public Sub Render
	If mParent = Null Then Return
	If mParent.IsInitialized = False Then Return
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then
			mSelectedValue = StateText(mSelectedState.GetState)
			mSelectedState.Subscribe(Me, "SelectedState_Changed")
			SelectValue(mSelectedValue, False)
		End If
	End If
	Dim needsCreate As Boolean = False
	If mBaseView = Null Then
		needsCreate = True
	Else If mBaseView.IsInitialized = False Then
		needsCreate = True
	End If
	If needsCreate Then
		Dim panel As Panel
		panel.Initialize("")
		mBaseView = panel
		mBaseView.Color = Colors.Transparent
		mParent.AddView(mBaseView, mLeft, mTop, mWidth, mHeight)
	End If
	mBaseView.SetLayoutAnimated(0, mLeft, mTop, mWidth, mHeight)

	Dim y As Int = 0
	For Each option As UIRadioButton In mOptions
		Dim size As List = option.GetContentSize(mWidth, mHeight)
		Dim optionHeight As Int = mTheme.ControlHeight
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then optionHeight = size.Get(1)
			End If
		End If
		option.SetParent(mBaseView)
		option.SetPosition(0, y)
		option.SetSize(mWidth, optionHeight)
		option.Render
		y = y + optionHeight + mSpacing
	Next
End Sub

Private Sub SelectValue(SelectedValue As String, Notify As Boolean)
	Dim found As Boolean = False
	For Each option As UIRadioButton In mOptions
		Dim isMatch As Boolean = option.GetValue = SelectedValue And SelectedValue <> ""
		If isMatch Then found = True
		option.SetSelectedFromGroup(isMatch)
	Next
	If found = False And mOptions.Size > 0 Then
		Dim first As UIRadioButton = mOptions.Get(0)
		first.SetSelectedFromGroup(True)
		mSelectedValue = first.GetValue
	Else
		mSelectedValue = SelectedValue
	End If
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then mSelectedState.SetState(mSelectedValue)
	End If
	If Notify Then DispatchSelected
End Sub

Public Sub RadioButtonSelected(Option As UIRadioButton)
	If Option = Null Then Return
	SelectValue(Option.GetValue, True)
End Sub

Private Sub DispatchSelected
	If mTarget = Null Then Return
	If mEventName.Trim = "" Then Return
	If SubExists(mTarget, mEventName) Then CallSub2(mTarget, mEventName, mSelectedValue)
End Sub

Private Sub SelectedState_Changed(State As UIState)
	If State = Null Then Return
	If State.IsInitialized = False Then Return
	mSelectedValue = StateText(State.GetState)
	SelectValue(mSelectedValue, False)
End Sub

Private Sub StateText(InputValue As Object) As String
	If InputValue = Null Then Return ""
	Return "" & InputValue
End Sub

Public Sub Unmount
	For Each option As UIRadioButton In mOptions
		option.Unmount
	Next
	If mSelectedState <> Null Then
		If mSelectedState.IsInitialized Then mSelectedState.Unsubscribe(Me, "SelectedState_Changed")
	End If
	If mBaseView <> Null Then
		If mBaseView.IsInitialized Then mBaseView.RemoveViewFromParent
	End If
	mBaseView = Null
	mParent = Null
End Sub

Public Sub GetView As B4XView
	If mBaseView = Null Then Return Null
	If mBaseView.IsInitialized = False Then Return Null
	Return mBaseView
End Sub

Public Sub GetContentSize(MaxWidth As Int, MaxHeight As Int) As List
	Dim result As List
	result.Initialize
	Dim safeMaxWidth As Int = MaxWidth
	Dim safeMaxHeight As Int = MaxHeight
	If safeMaxWidth <= 0 Then safeMaxWidth = 10000
	If safeMaxHeight <= 0 Then safeMaxHeight = 10000
	Dim maxWidth As Int = 0
	Dim totalHeight As Int = 0
	For Each option As UIRadioButton In mOptions
		Dim size As List = option.GetContentSize(safeMaxWidth, safeMaxHeight)
		If size <> Null Then
			If size.IsInitialized Then
				If size.Size >= 2 Then
					maxWidth = Max(maxWidth, size.Get(0))
					totalHeight = totalHeight + size.Get(1)
				End If
			End If
		End If
	Next
	If mOptions.Size > 1 Then totalHeight = totalHeight + mSpacing * (mOptions.Size - 1)
	result.Add(Min(maxWidth, safeMaxWidth))
	result.Add(Min(totalHeight, safeMaxHeight))
	Return result
End Sub