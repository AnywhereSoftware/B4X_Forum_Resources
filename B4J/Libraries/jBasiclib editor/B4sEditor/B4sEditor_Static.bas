B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Public Opts As Map
End Sub

Public Sub GetEvent As Event
	Dim Evt As JavaObject
	Dim TJO As JavaObject
	TJO.InitializeStatic("javafx.event.Event")
	Return Evt.InitializeNewInstance("javafx.event.Event",Array(TJO.GetField("ANY")))
End Sub

'Set a shortcut key for this menu item
'Returns the menu item
Public Sub SetShortCutKey(MI As JavaObject,Combination() As String) As MenuItem
	Dim KC As JavaObject
	KC.InitializeStatic("javafx.scene.input.KeyCombination")
	Dim KCS As String
	For i = 0 To Combination.Length - 1
		If i > 0 Then KCS = KCS & "+"
		KCS = KCS & Combination(i)
	Next
	MI.RunMethod("setAccelerator",Array(KC.RunMethod("keyCombination",Array(KCS))))
	Return MI
End Sub

Public Sub SaveFormMetrics(F As Form, Delim As String)
	If F.Title = "Form" Then
		Log(F.Title & " Cannot set form metrics for a form with an unmodified title")
		Return
	End If
	Dim FormName As String = F.Title
	If FormName.Contains(Delim) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(Delim)).Trim
	End If
	Opts.Put("FormPos" & FormName & "Left",F.WindowLeft)
	Opts.Put("FormPos" & FormName & "Top",F.WindowTop)
	Opts.Put("FormPos" & FormName & "Width",F.WindowWidth)
	Opts.Put("FormPos" & FormName & "Height",F.WindowHeight)
End Sub

Public Sub SetFormMetrics(F As Form,Delim As String)
	Dim FormName As String = F.Title
	If FormName.Contains(Delim) Then
		FormName = FormName.SubString2(0,FormName.IndexOf(Delim)).Trim
	End If
	If Opts.ContainsKey("FormPos" & FormName & "Left") Then
		F.WindowLeft = Opts.Get("FormPos" & FormName & "Left")
		F.WindowTop = Opts.Get("FormPos" & FormName & "Top")
		F.WindowWidth = Opts.Get("FormPos" & FormName & "Width")
		F.WindowHeight = Opts.Get("FormPos" & FormName & "Height")
	End If
End Sub