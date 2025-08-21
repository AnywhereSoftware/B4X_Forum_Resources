B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
	Public vue As BANanoVue
	Private BANAno As BANano
	Private modl As Object
	Private body As BANanoElement
	Private JQuery As BANanoObject
End Sub

'initialize the page
Public Sub Initialize(module As Object)
	vue.Initialize
	modl = module
	body = vue.body
	JQuery.Initialize("$")
End Sub

Sub CreateToggle(id As String) As WToggle
	Dim el As WToggle
	el.Initialize(vue, id)
	Return el
End Sub

Sub CreateTextArea(id As String) As WTextArea
	Dim el As WTextArea
	el.Initialize(vue, id)
	Return el 
End Sub

Sub CreateTabs(id As String) As WTabs
	Dim el As WTabs
	el.Initialize(vue, id)
	Return el 
End Sub

Sub GetStates(lst As List) As Map
	Return vue.GetStates(lst)
End Sub

'return if state exists
Sub HasState(k As String) As Boolean
	Return vue.HasState(k)	
End Sub


'set the state
Sub SetState(m As Map) As BANanoWired
	vue.SetState(m)
	Return Me
End Sub

Sub SetStateListValues(mapValues As List) As BANanoWired
	vue.SetStateListValues(mapValues)	
	Return Me
End Sub

'set state list
Sub SetStateList(mapKey As String, mapValues As List) As BANanoWired
	vue.SetStateList(mapKey, mapValues)
	Return Me
End Sub

'set state object
Sub SetStateMap(mapKey As String, mapValues As Map) As BANanoWired
	vue.SetStateMap(mapKey, mapValues)
	Return Me
End Sub

'set watches 
Sub SetWatch(k As String, bImmediate As Boolean, bDeep As Boolean, module As Object, methodName As String) As BANanoWired
	vue.SetWatch(k, bImmediate, bDeep, module, methodName)
	Return Me
End Sub


'set direct method
Sub SetMethod1(k As String, module As Object, methodName As String) As BANanoWired
	vue.SetMethod1(k, module, methodName)
	Return Me
End Sub

'set created
Sub SetCreated(k As String, module As Object, methodName As String) As BANanoWired
	vue.SetCreated(k, module, methodName)
	Return Me
End Sub


'set mounted
Sub SetMounted(k As String, module As Object, methodName As String) As BANanoWired
	vue.SetMounted(k, module, methodName)
	Return Me
End Sub



Sub ForceUpdate
	vue.ForceUpdate
End Sub

Sub SetFontFamily(ff As Object)
	vue.SetFontFamily(ff)
End Sub

Sub StateExists(stateName As String) As Boolean
	Return vue.StateExists(stateName)
End Sub

Sub ToggleState(stateName As String) As BANanoWired
	vue.ToggleState(stateName)
	Return Me
End Sub

Sub SetStateTrue(k As String) As BANanoWired
	vue.SetStateTrue(k)
	Return Me
End Sub

Sub SetStateFalse(k As String) As BANanoWired
	vue.SetStateFalse(k)
	Return Me
End Sub

Sub SetStateIncrement(k As String) As BANanoWired
	vue.SetStateIncrement(k)
	Return Me
End Sub

Sub SetStateDecrement(k As String) As BANanoWired
	vue.SetStateDecrement(k)
	Return Me
End Sub

Sub SetStateSingle(k As String, v As Object) As BANanoWired
	vue.SetStateSingle(k, v)
	Return Me
End Sub

Sub GetState(k As String, default As Object) As Object
	Dim res As Object = vue.GetState(k, default)
	Return res
End Sub

Sub CreateSpinner(id As String) As WSpinner
	Dim el As WSpinner
	el.Initialize(vue, id)
	Return el
End Sub

Sub CreateSlider(id As String) As WSlider
	Dim el As WSlider
	el.Initialize(vue, id)
	Return el
End Sub

Sub CreateRadioGroup(id As String) As WRadioGroup
	Dim el As WRadioGroup
	el.Initialize(vue, id)
	Return el
End Sub

Sub CreateProgress(id As String) As WProgress
	Dim el As WProgress
	el.Initialize(vue, id)
	Return el 
End Sub

Sub CreateIconButton(id As String) As WIconButton
	Dim el As WIconButton
	el.Initialize(vue, id)
	Return el 
End Sub

Sub CreateFAB(id As String) As WFab
	Dim el As WFab
	el.Initialize(vue, id)
	Return el 
End Sub

Sub CreateLabel(id As String) As WLabel
	Dim el As WLabel
	el.Initialize(vue, id)
	Return el 
End Sub

Sub CreateCard(id As String) As WCard
	Dim el As WCard
	el.Initialize(vue, id)
	Return el
End Sub

Sub CreateListBox(id As String) As WListBox
	Dim el As WListBox
	el.Initialize(vue, id)
	Return el
End Sub

Sub CreateInput(id As String) As WInput
	Dim el As WInput
	el.Initialize(vue,id)
	Return el
End Sub

Sub CreateCombo(id As String) As WCombo
	Dim el As WCombo
	el.Initialize(vue,id)
	Return el
End Sub


Sub CreateInputEmail(id As String) As WInput
	Dim el As WInput
	el.Initialize(vue,id).SetTypeEmail(True)
	Return el
End Sub

Sub CreateInputNumber(id As String) As WInput
	Dim el As WInput
	el.Initialize(vue,id).SetTypeNumber(True)
	Return el
End Sub

Sub CreateInputPassword(id As String) As WInput
	Dim el As WInput
	el.Initialize(vue,id).SetTypePassword(True)
	Return el
End Sub

Sub CreateInputSearch(id As String) As WInput
	Dim el As WInput
	el.Initialize(vue,id).SetTypeSearch(True)
	Return el
End Sub


Sub CreateInputTel(id As String) As WInput
	Dim el As WInput
	el.Initialize(vue,id).SetTypeTel(True)
	Return el
End Sub


Sub CreateButton(id As String) As WButton
	Dim el As WButton
	el.Initialize(vue,id)
	Return el
End Sub

Sub CreateRadio(id As String) As WRadio
	Dim el As WRadio
	el.Initialize(vue,id)
	Return el
End Sub


Sub CreateCheckBox(id As String) As WCheckBox
	Dim el As WCheckBox
	el.Initialize(vue,id)
	Return el
End Sub

'add break
Sub AddBR
	vue.Template.SetText("<br>")
End Sub

'add hr
Sub AddHR
	vue.Template.SetText("<hr>")
End Sub

'render the page
Sub UX
	vue.ux
End Sub