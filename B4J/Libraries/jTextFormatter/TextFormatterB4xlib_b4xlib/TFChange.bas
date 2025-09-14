B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5.51
@EndOfDesignText@
'Class Module
Sub Class_Globals
  'Private fx As JFX ' Uncomment if required. For B4j only
  Private TJO As JavaObject

End Sub
'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub
'Class is a subclass with no constructor, we need to set the object on which JavaObject will operate.
Public Sub SetObject(Target As JavaObject)
  TJO = Target
End Sub

'Gets the new anchor.
Public Sub getAnchor As Int
  Return TJO.RunMethod("getAnchor",Null)
End Sub
'Gets the new caret position.
Public Sub getCaretPosition As Int
  Return TJO.RunMethod("getCaretPosition",Null)
End Sub
'Gets the control associated with this change.
Public Sub getControl As JavaObject
  Return TJO.RunMethod("getControl",Null)
End Sub
'Gets the current anchor position of the control.
Public Sub getControlAnchor As Int
  Return TJO.RunMethod("getControlAnchor",Null)
End Sub
'Gets the current caret position of the control.
Public Sub getControlCaretPosition As Int
  Return TJO.RunMethod("getControlCaretPosition",Null)
End Sub
'Gets the complete new text which will be used on the control after this change.
Public Sub getControlNewText As String
  Return TJO.RunMethod("getControlNewText",Null)
End Sub
'This is the full text that control has before the change.
Public Sub getControlText As String
  Return TJO.RunMethod("getControlText",Null)
End Sub
'Gets the end index into the TextInputControl.getText() for the modification.
Public Sub getRangeEnd As Int
  Return TJO.RunMethod("getRangeEnd",Null)
End Sub
'Gets the start index into the TextInputControl.getText() for the modification.
Public Sub getRangeStart As Int
  Return TJO.RunMethod("getRangeStart",Null)
End Sub
'Gets the selection of this change.
Public Sub getSelection As JavaObject
  Return TJO.RunMethod("getSelection",Null)
End Sub
'Gets the text used in this change.
Public Sub getText As String
  Return TJO.RunMethod("getText",Null)
End Sub
'Gets whether this change was in response to text being added.
Public Sub IsAdded As Boolean
  Return TJO.RunMethod("isAdded",Null)
End Sub
'The content change is any of add, delete or replace changes.
Public Sub IsContentChange As Boolean
  Return TJO.RunMethod("isContentChange",Null)
End Sub
'Gets whether this change was in response to text being deleted.
Public Sub IsDeleted As Boolean
  Return TJO.RunMethod("isDeleted",Null)
End Sub
'Gets whether this change was in response to text being replaced.
Public Sub IsReplaced As Boolean
  Return TJO.RunMethod("isReplaced",Null)
End Sub
'Sets the selection.
Public Sub SelectRange(NewAnchor As Int, NewCaretPosition As Int)
  TJO.RunMethod("selectRange",Array As Object(NewAnchor, NewCaretPosition))
End Sub
'Sets the anchor.
Public Sub setAnchor(NewAnchor As Int)
  TJO.RunMethod("setAnchor",Array As Object(NewAnchor))
End Sub
'Sets the caret position.
Public Sub setCaretPosition(NewCaretPosition As Int)
  TJO.RunMethod("setCaretPosition",Array As Object(NewCaretPosition))
End Sub
'A method assigning both the start and end values together, in such a way as to ensure they are valid with respect to each other.
Public Sub setRange(Start As Int, ThisEnd As Int)
  TJO.RunMethod("setRange",Array As Object(Start, ThisEnd))
End Sub
'Sets the text to use in this change.
Public Sub setText(Value As String)
  TJO.RunMethod("setText",Array As Object(Value))
End Sub

'Get the unwrapped object
Public Sub GetObject As Object
  Return TJO
End Sub

'Get the unwrapped object As a JavaObject
Public Sub GetObjectJO As JavaObject
  Return TJO
End Sub

