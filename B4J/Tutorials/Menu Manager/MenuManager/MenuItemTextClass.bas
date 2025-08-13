B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private TJO As JavaObject
	Private MI As MenuItem
	Private mModule As Object
	Private mEventName As String
	Private ReturnEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Module As Object,EventName As String,Text As String)
	mModule = Module
	mEventName = EventName
	MI.Initialize(Text,"MI")
	TJO = MI
End Sub

'Pass the menu action event to the calling module
Private Sub MI_Action
	If SubExists(mModule, mEventName & "_Action") Then CallSub(mModule,mEventName & "_Action")
End Sub

'Set a Graphic on this menu item
'Returns the menu item
Public Sub SetGraphic(Graphic As Node) As MenuItemTextClass
	TJO.RunMethod("setGraphic",Array(Graphic))
	Return Me
End Sub

'Get the graphic set on this menu item
Public Sub GetGraphic As Node
	Return TJO.RunMethod("getGraphic",Null)
End Sub

'Set a shortcut key for this menu item
'Returns the menu item
Public Sub SetShortCutKey(Combination() As String) As MenuItemTextClass
	Dim KC As JavaObject
	KC.InitializeStatic("javafx.scene.input.KeyCombination")
	Dim KCS As String
	For i = 0 To Combination.Length - 1
		If i > 0 Then KCS = KCS & "+"
		KCS = KCS & Combination(i)
	Next
	TJO.RunMethod("setAccelerator",Array(KC.RunMethod("keyCombination",Array(KCS))))
	Return Me
End Sub

'Set the enabled state for this menu item
'Returns the menu item
Public Sub SetEnabled(Enabled As Boolean) As MenuItemTextClass
	MI.Enabled = Enabled
	Return Me
End Sub

'Get the enabled state for this menu item
Public Sub GetEnabled As Boolean
	Return MI.Enabled
End Sub

'Set an alternate event name for this menu item
'Returns the menu item
Public Sub SetEventName (Name As String) As MenuItemTextClass
	ReturnEventName = Name
	Return Me
End Sub

'Get the alternate Event name for this menu item
Public Sub GetEventName As String
	Return ReturnEventName
End Sub

'Get / Set the text of the menu item
Sub getText As String
	Return TJO.RunMethod("getText",Null)
End Sub
Public Sub setText(Text As String)
	TJO.RunMethod("setText", Array(Text))
End Sub

Public Sub SetMnemonicParsing(value As Boolean) As MenuItemTextClass
	TJO.RunMethod("setMnemonicParsing",Array(value))
	Return Me
End Sub

Public Sub isMnemonicParsing As Boolean
	Return TJO.RunMethod("isMnemonicParsing",Null)
End Sub

'Get the list of style classes set on this menu item
Public Sub getStyleClass As List
	Return TJO.RunMethod("getStyleClass",Null)
End Sub

'Set a style class for this menu item, checks it is not already added
'Returns the menu item
Public Sub SetStyleClass(Class As String) As MenuItemTextClass
	Dim L As List = getStyleClass
	Dim Pos As Int = L.IndexOf(Class)
	If Pos = -1 Then L.Add(Class)
	Return Me
End Sub

'Set a tag for this menu item
'Returns the menu item
Public Sub SetTag(TTag As Object) As MenuItemTextClass
	MI.Tag = TTag
	Return Me
End Sub

'Get the tag for this menu item
Public Sub GetTag As Object
	Dim Tag As Object = TJO.RunMethod("getUserData",Null)
	If Tag = Null Then Tag = ""
	Return Tag
End Sub

'Get the native menu item as a Javaobject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub

'Get the native menu item as an object
Public Sub AsObject As Object
	Return TJO
End Sub