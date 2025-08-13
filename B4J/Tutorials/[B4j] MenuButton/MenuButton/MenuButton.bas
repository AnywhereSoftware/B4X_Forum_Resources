B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
#IgnoreWarnings:12
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'Creates a new empty menu button.
Public Sub Create
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.control.MenuButton",Null)
End Sub

'Creates a new empty menu button with the given text to display on the button.
Public Sub Create2(Text As String)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.control.MenuButton",Array As Object(Text))
End Sub

'Creates a new empty menu button with the given text and graphic to display on the button.
Public Sub Create3(Text As String, Graphic As Node)
	'If a JavaObject has been passed, you may need to create it here and remove the parameter
	TJO.InitializeNewInstance("javafx.scene.control.MenuButton",Array As Object(Text,Graphic))
End Sub

Public Sub asB4XView As B4XView
	Return TJO
End Sub

Public Sub AsNode As Node
	Return TJO
End Sub

'Returns the wrapped object as JavaObject
Public Sub AsJavaObject As JavaObject
	Return TJO
End Sub
'Gets the value of the property graphicTextGap.
Public Sub GetGraphicTextGap As Double
	Return TJO.RunMethod("getGraphicTextGap",Null)
End Sub
Public Sub SetGraphic(N As Node)
	TJO.RunMethod("setGraphic",Array(N))
End Sub

Public Sub GetGraphic As B4XView
	Return TJO.RunMethod("getGraphic",Null)
End Sub

'Sets the value of the property graphicTextGap.
Public Sub SetGraphicTextGap(Gap As Double)
	TJO.RunMethod("setGraphicTextGap",Array(Gap))
End Sub

Public Sub GetBorder As JavaObject
	Return TJO.RunMethod("getBorder",Null)
End Sub
Public Sub getPadding As JavaObject
	Return TJO.RunMethod("getPadding",Null)
End Sub

Public Sub SetPadding(LTRB As Double)
	Dim Insets As JavaObject
	Insets.InitializeNewInstance("javafx.geometry.Insets",Array(LTRB))
	If LTRB = 0 Then Insets = Insets.GetField("EMPTY")
	TJO.RunMethod("setPadding",Array(Insets))
End Sub

Public Sub SetPadding2(Left As Double,Top As Double, Right As Double, Bottom As Double)
	Dim Insets As JavaObject
	Insets.InitializeNewInstance("javafx.geometry.Insets",Array(Top,Right,Bottom,Left))
	If Left + Top + Right + Bottom = 0 Then Insets = Insets.GetField("EMPTY")
	TJO.RunMethod("setpadding",Array(Insets))
End Sub


'The items to show within this buttons menu.
Public Sub GetItems As List
	Return TJO.RunMethod("getItems",Null)
End Sub
'Returns the wrapped object as Object
Public Sub GetObject As Object
	Return TJO
End Sub
'Gets the value of the property popupSide.
Public Sub GetPopupSide As JavaObject
	Return TJO.RunMethod("getPopupSide",Null)
End Sub
'Hides the ContextMenu.
Public Sub Hide
	TJO.RunMethod("hide",Null)
End Sub
'*
Public Sub IsShowing As Boolean
	Return TJO.RunMethod("isShowing",Null)
End Sub
'Sets the value of the property popupSide.
Public Sub SetPopupSide(Value As JavaObject)
	TJO.RunMethod("setPopupSide",Array As Object(Value))
End Sub
'Shows the ContextMenu, assuming this MenuButton is not disabled.
Public Sub Show
	TJO.RunMethod("show",Null)
End Sub

Public Sub setStyle(Style As String)
	TJO.RunMethod("setStyle",Array(Style))
End Sub

Public Sub getStyle As String
	Return TJO.RunMethod("getStyle",Null)
End Sub

Public Sub getStyleClasses As List
	Return TJO.As(JavaObject).RunMethod("getStyleClass",Null)
End Sub

Public Sub setText(Text As String)
	TJO.RunMethod("setText",Array(Text))
End Sub
public Sub getText As String
	Return TJO.RunMethod("getText",Null)
End Sub
Public Sub setTooltipText(Text As String) As JavaObject
	Dim T As JavaObject
	T.InitializeNewInstance("javafx.scene.control.Tooltip",Array(Text))
	TJO.RunMethod("setTooltip",Array(T))
	Return T
End Sub

Public Sub setTextColor(Color As Int)
	TJO.As(B4XView).TextColor = Color
End Sub
Public Sub getTextColor As Int
	Return TJO.As(B4XView).TextColor
End Sub

Public Sub setTextSize(Size As Double)
	TJO.As(B4XView).TextSize = Size
End Sub

Public Sub getTextSize As Double
	Return TJO.As(B4XView).TextSize
End Sub

Public Sub setWrapText(Wrap As Boolean)
	TJO.RunMethod("setWrapText",Array(Wrap))
End Sub

Public Sub getWrapText As Boolean
	Return TJO.RunMethod("getWrapText",Null)
End Sub

'Comment if not needed
'Set the underlying Object, must be of correct type
Public Sub SetObject(Obj As Object)
	TJO = Obj
End Sub

'Set the Tag for this object
Public Sub SetTag(Tag As Object)
	TJO.RunMethod("setUserData",Array(Tag))
End Sub

'Get the Tag for this object
Public Sub GetTag As Object
	Dim Tag As Object = TJO.RunMethod("getUserData",Null)
	If Tag = Null Then Tag = ""
	Return Tag
End Sub

