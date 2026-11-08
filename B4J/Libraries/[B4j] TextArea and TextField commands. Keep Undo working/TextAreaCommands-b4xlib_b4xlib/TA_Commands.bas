B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private TJO As JavaObject
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(TA As Object)
	TJO = TA
End Sub
'Moves the caret position backward.
Public Sub Backward
	TJO.RunMethod("backward",Null)
End Sub
'If the field is currently being edited, this call will set text to the last commited value.
Public Sub CancelEdit
	TJO.RunMethod("cancelEdit",Null)
End Sub
'Clears the text.
Public Sub Clear
	TJO.RunMethod("clear",Null)
End Sub
'Commit the current text and convert it to a value.
Public Sub CommitValue
	TJO.RunMethod("commitValue",Null)
End Sub
'Transfers the currently selected range in the text to the clipboard, leaving the current selection.
Public Sub Copy
	TJO.RunMethod("copy",Null)
End Sub
'Transfers the currently selected range in the text to the clipboard, removing the current selection.
Public Sub Cut
	TJO.RunMethod("cut",Null)
End Sub
'Deletes the character that follows the current caret position from the text if there is no selection, or deletes the selection if there is one.
Public Sub DeleteNextChar As Boolean
	Return TJO.RunMethod("deleteNextChar",Null)
End Sub
'Deletes the character that precedes the current caret position from the text if there is no selection, or deletes the selection if there is one.
Public Sub DeletePreviousChar As Boolean
	Return TJO.RunMethod("deletePreviousChar",Null)
End Sub
'Removes a range of characters from the content.
Public Sub DeleteText(Start As Int, TEnd As Int)
	TJO.RunMethod("deleteText",Array As Object(Start, TEnd))
End Sub
'Clears the selection.
Public Sub Deselect
	TJO.RunMethod("deselect",Null)
End Sub
'Moves the caret to after the last char of the text.
Public Sub End_
	TJO.RunMethod("end",Null)
End Sub
'Moves the caret to the end of the next word.
Public Sub EndOfNextWord
	TJO.RunMethod("endOfNextWord",Null)
End Sub
'This function will extend the selection to include the specified pos.
Public Sub ExtendSelection(Pos As Int)
	TJO.RunMethod("extendSelection",Array As Object(Pos))
End Sub
'Moves the caret position forward.
Public Sub Forward
	TJO.RunMethod("forward",Null)
End Sub
'Gets the value of the property selectedText.
Public Sub GetSelectedText As String
	Return TJO.RunMethod("getSelectedText",Null)
End Sub
'Returns a subset of the text input's content.
Public Sub GetText(Start As Int, TEnd As Int) As String
	Return TJO.RunMethod("getText",Array As Object(Start, TEnd))
End Sub
'Moves the caret to before the first char of the text.
Public Sub Home
	TJO.RunMethod("home",Null)
End Sub
'Inserts a sequence of characters into the content.
Public Sub InsertText(Index As Int, Text As String)
	TJO.RunMethod("insertText",Array As Object(Index, Text))
End Sub
'Gets the value of the property redoable.
Public Sub IsRedoable As Boolean
	Return TJO.RunMethod("isRedoable",Null)
End Sub
'Gets the value of the property undoable.
Public Sub IsUndoable As Boolean
	Return TJO.RunMethod("isUndoable",Null)
End Sub
'Moves the caret to the beginning of next word.
Public Sub NextWord
	TJO.RunMethod("nextWord",Null)
End Sub
'Transfers the contents in the clipboard into this text, replacing the current selection.
Public Sub Paste
	TJO.RunMethod("paste",Null)
End Sub
'Positions the caret to the position indicated by pos.
Public Sub PositionCaret(Pos As Int)
	TJO.RunMethod("positionCaret",Array As Object(Pos))
End Sub
'Moves the caret to the beginning of previous word.
Public Sub PreviousWord
	TJO.RunMethod("previousWord",Null)
End Sub
'If possible, redoes the last undone modification.
Public Sub Redo
	TJO.RunMethod("redo",Null)
End Sub
'Replaces the selection with the given replacement String.
Public Sub ReplaceSelection(Replacement As String)
	TJO.RunMethod("replaceSelection",Array As Object(Replacement))
End Sub
'Replaces a range of characters with the given text.
Public Sub ReplaceText(Start As Int, TEnd As Int, Text As String)
	TJO.RunMethod("replaceText",Array As Object(Start, TEnd, Text))
End Sub
'Moves the selection backward one char in the text.
Public Sub SelectBackward
	TJO.RunMethod("selectBackward",Null)
End Sub
'Moves the caret to after the last char of text.
Public Sub SelectEnd
	TJO.RunMethod("selectEnd",Null)
End Sub
'Moves the caret to the end of the next word.
Public Sub SelectEndOfNextWord
	TJO.RunMethod("selectEndOfNextWord",Null)
End Sub
'Moves the selection forward one char in the text.
Public Sub SelectForward
	TJO.RunMethod("selectForward",Null)
End Sub
'Moves the caret to before the first char of text.
Public Sub SelectHome
	TJO.RunMethod("selectHome",Null)
End Sub
'Moves the caret to the beginning of next word.
Public Sub SelectNextWord
	TJO.RunMethod("selectNextWord",Null)
End Sub
'Positions the caret to the position indicated by pos and extends the selection, if there is one.
Public Sub SelectPositionCaret(Pos As Int)
	TJO.RunMethod("selectPositionCaret",Array As Object(Pos))
End Sub
'Moves the caret to the beginning of previous word.
Public Sub SelectPreviousWord
	TJO.RunMethod("selectPreviousWord",Null)
End Sub
'Positions the anchor and caretPosition explicitly
Public Sub SelectRange(Anchor As Int, CaretPosition As Int)
	TJO.RunMethod("selectRange",Array As Object(Anchor, CaretPosition))
End Sub
'If possible, undoes the last modification.
Public Sub Undo
	TJO.RunMethod("undo",Null)
End Sub
