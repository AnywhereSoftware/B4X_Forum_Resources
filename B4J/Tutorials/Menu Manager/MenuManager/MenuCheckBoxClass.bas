B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private mModule As Object
	Private mEventName As String
	Private TJO As JavaObject
	Private ReturnEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Module As Object,Event_Name As String,Text As String)
	mModule = Module
	mEventName = Event_Name
	TJO.InitializeNewInstance("javafx.scene.control.CheckMenuItem",Array(Text))
	TJO.RunMethod("setSelected",Array(True))
	Dim Event As Object = TJO.CreateEventFromUI("javafx.beans.value.ChangeListener","CBChanged",False)
	TJO.RunMethodJO("selectedProperty",Null).RunMethod("addListener",Array(Event))
End Sub

'Checkbox Check Changed event pass back to creating module
Private Sub CBChanged_Event(MethodName As String,Args() As Object) As Object
	If SubExists(mModule,mEventName & "_SelectedChanged") Then CallSub2(mModule,mEventName & "_SelectedChanged",Me)
	Return True
End Sub

'Get the selected state for this menu item
Public Sub GetSelected As Boolean
	Return TJO.RunMethod("isSelected",Null)
End Sub

'Set the selected state for this menu item
'Returns the menu item
Public Sub SetSelected (Checked As Boolean) As MenuCheckBoxClass
	TJO.RunMethod("setSelected",Array(Checked))
	Return Me
End Sub

'Set a Graphic for this menu item
'Returns the menu item
Public Sub SetGraphic(Graphic As Node) As MenuCheckBoxClass
	TJO.RunMethod("setGraphic",Array(Graphic))
	Return Me
End Sub

'Get the graphic set on this menu item
Public Sub GetGraphic As Node
	Return TJO.RunMethod("getGraphic",Null)
End Sub

'Set a shortut key for this menu item
'Returns the menu item
Public Sub SetShortCutKey(Combination() As String) As MenuCheckBoxClass
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

'Set an alternate eventname
Public Sub SetEventName (Name As String) As MenuCheckBoxClass
	ReturnEventName = Name
	Return Me
End Sub

'get the alternate eventname
Public Sub GetEventName As String
	Return ReturnEventName
End Sub

'Get/Set the text on this menu item
Sub getText As String
	Return TJO.RunMethod("getText",Null)
End Sub
Public Sub setText(Text As String)
	TJO.RunMethod("setText", Array(Text))
End Sub

'Get the style class
Public Sub getStyleClass As List
	Return TJO.RunMethod("getStyleClass",Null)
End Sub

'Add a style class for this menuitem, checks it is not already added
'Returns the menu item
Public Sub SetStyleClass(Class As String) As MenuCheckBoxClass
	Dim L As List = getStyleClass
	Dim Pos As Int = L.IndexOf(Class)
	If Pos = -1 Then L.Add(Class)
	Return Me
End Sub

'Set the enabled state for the menu item.
'Returns the menu item
Public Sub SetEnabled(Enabled As Boolean) As MenuCheckBoxClass
	TJO.RunMethod("setEnabled",Array(Enabled))
	Return Me
End Sub

'Get the enabled state for the menu item
Public Sub GetEnabled As Boolean
	Return TJO.RunMethod("getEnabled",Null)
End Sub

'Set a tag for the menu item
'Returns the menu item
Public Sub SetTag(TTag As Object) As MenuCheckBoxClass
	TJO.RunMethod("setUserData",Array(TTag))
	Return Me
End Sub

'Set a tag for the menu item
Public Sub GetTag As Object
	Dim Tag As Object = TJO.RunMethod("getUserData",Null)
	If Tag = Null Then Tag = ""
	Return Tag
End Sub

'Get the underlying Native menuitem as a JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub

'Get the underlying Native menuitem as a JavaObject
Public Sub AsObject As Object
	Return TJO
End Sub