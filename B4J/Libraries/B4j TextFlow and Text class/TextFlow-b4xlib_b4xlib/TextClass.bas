B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.9
@EndOfDesignText@
#IgnoreWarnings:12
#Event: Clicked(Event As MouseEvent)
'Class Module
Sub Class_Globals
	'Private fx As JFX ' Uncomment if required. For B4j only

	Private TJO As JavaObject
	Private mModule As Object
	Private mEventName As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub

'Creates an empty instance of Text.
Public Sub Create As TextClass
	TJO.InitializeNewInstance("javafx.scene.text.Text",Null)
	Return Me
End Sub

'Creates an instance of Text containing the given string.
Public Sub Create2(Text As String) As TextClass
	TJO.InitializeNewInstance("javafx.scene.text.Text",Array As Object(Text))
	Return Me
End Sub
Public Sub ApplyCss
	TJO.RunMethod("applyCss",Null)
End Sub

'Gets the value of the property baselineOffset.
Public Sub GetBaselineOffset As Double
	Return TJO.RunMethod("getBaselineOffset",Null)
End Sub
'Gets the value of the property boundsType.
Public Sub GetBoundsType As String
	Return TJO.RunMethod("getBoundsType",Null)
End Sub
'Gets the value of the property fill.
Public Sub GetFill As Paint
	Return TJO.RunMethod("getFill",Null)
End Sub
'Gets the value of the property stroke.
Public Sub GetStroke As Paint
	Return TJO.RunMethod("getStroke",Null)
End Sub
'Gets the value of the property font.
Public Sub GetFont As Font
	Return TJO.RunMethod("getFont",Null)
End Sub
'Gets the value of the property fontSmoothingType.
Public Sub GetFontSmoothingType As String
	Return TJO.RunMethod("getFontSmoothingType",Null)
End Sub

Public Sub GetLayoutBounds As JavaObject
	Return TJO.RunMethod("getLayoutBounds",Null)
End Sub
'Sets the value of the property fill.
Public Sub SetFill(Value As Paint) As TextClass
	TJO.RunMethod("setFill",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property stroke.
Public Sub SetStroke(Value As Paint) As TextClass
	TJO.RunMethod("setStroke",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property smooth.
Public Sub SetSmooth(Value As Boolean) As TextClass
	TJO.RunMethod("setSmooth",Array As Object(Value))
	Return Me
End Sub
'Gets the value of the property lineSpacing.
Public Sub GetLineSpacing As Double
	Return TJO.RunMethod("getLineSpacing",Null)
End Sub
'Gets the value of the property text.
Public Sub GetText As String
	Return TJO.RunMethod("getText",Null)
End Sub
'Gets the value of the property textAlignment.
Public Sub GetTextAlignment As String
	Return TJO.RunMethod("getTextAlignment",Null)
End Sub
'Gets the value of the property textOrigin.
Public Sub GetTextOrigin As String
	Return TJO.RunMethod("getTextOrigin",Null)
End Sub
'Gets the value of the property wrappingWidth.
Public Sub GetWrappingWidth As Double
	Return TJO.RunMethod("getWrappingWidth",Null)
End Sub
'Gets the value of the property x.
Public Sub GetX As Double
	Return TJO.RunMethod("getX",Null)
End Sub
'Gets the value of the property y.
Public Sub GetY As Double
	Return TJO.RunMethod("getY",Null)
End Sub
'Gets the value of the property strikethrough.
Public Sub IsStrikethrough As Boolean
	Return TJO.RunMethod("isStrikethrough",Null)
End Sub
'Gets the value of the property underline.
Public Sub IsUnderline As Boolean
	Return TJO.RunMethod("isUnderline",Null)
End Sub
'Sets the value of the property boundsType.
'One of LOGICAL, VISUAL or LOGICAL_VERTICAL_CENTER
Public Sub SetBoundsType(Value As String) As TextClass
	TJO.RunMethod("setBoundsType",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property font.
Public Sub SetFont(Value As Font) As TextClass
	TJO.RunMethod("setFont",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property fontSmoothingType.
'One of GRAY, LCD
Public Sub SetFontSmoothingType(Value As String) As TextClass
	TJO.RunMethod("setFontSmoothingType",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property lineSpacing.
Public Sub SetLineSpacing(Spacing As Double) As TextClass
	TJO.RunMethod("setLineSpacing",Array As Object(Spacing))
	Return Me
End Sub
'Sets the value of the property strikethrough.
Public Sub SetStrikethrough(Value As Boolean) As TextClass
	TJO.RunMethod("setStrikethrough",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property text.
Public Sub SetText(Value As String) As TextClass
	TJO.RunMethod("setText",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property textAlignment.
'One of LEFT,CENTER,RIGHT or JUSTIFY
Public Sub SetTextAlignment(Value As String) As TextClass
	TJO.RunMethod("setTextAlignment",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property textOrigin.
'One of BASELINE, BOTTOM, CENTER or TOP
Public Sub SetTextOrigin(Value As String) As TextClass
	TJO.RunMethod("setTextOrigin",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property underline.
Public Sub SetUnderline(Value As Boolean) As TextClass
	TJO.RunMethod("setUnderline",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property wrappingWidth.
Public Sub SetWrappingWidth(Value As Double) As TextClass
	TJO.RunMethod("setWrappingWidth",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property x.
Public Sub SetX(Value As Double) As TextClass
	TJO.RunMethod("setX",Array As Object(Value))
	Return Me
End Sub
'Sets the value of the property y.
Public Sub SetY(Value As Double) As TextClass
	TJO.RunMethod("setY",Array As Object(Value))
	Return Me
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
	Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
	Return TJO
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

'Sets the value of the property onMouseClicked.
Public Sub SetOnMouseClicked(Module As Object, EventName As String) As Object
	mModule = Module
	mEventName = EventName
	Dim EventObject As Object = TJO.CreateEventFromUI("javafx.event.EventHandler", "Listener0" ,Null)
	TJO.RunMethod("setOnMouseClicked",Array As Object(EventObject))
	Return EventObject
End Sub
Private Sub Listener0_Event(MethodName As String,Args() As Object)
	If SubExists(mModule, mEventName & "_Clicked") Then CallSub2(mModule, mEventName & "_Clicked",Args(0).As(MouseEvent))
End Sub