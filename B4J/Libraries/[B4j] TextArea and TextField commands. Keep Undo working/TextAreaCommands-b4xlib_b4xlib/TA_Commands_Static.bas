B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Moves the caret position backward.
Public Sub Backward(Ta As Object)
	Ta.As(JavaObject).RunMethod("backward",Null)
End Sub
'If the field is currently being edited, this call will set text to the last commited value.
Public Sub CancelEdit(Ta As Object)
	Ta.As(JavaObject).RunMethod("cancelEdit",Null)
End Sub
'Clears the text.
Public Sub Clear(Ta As Object)
	Ta.As(JavaObject).RunMethod("clear",Null)
End Sub
'Commit the current text and convert it to a value.
Public Sub CommitValue(Ta As Object)
	Ta.As(JavaObject).RunMethod("commitValue",Null)
End Sub
'Transfers the currently selected range in the text to the clipboard, leaving the current selection.
Public Sub Copy(Ta As Object)
	Ta.As(JavaObject).RunMethod("copy",Null)
End Sub
'Transfers the currently selected range in the text to the clipboard, removing the current selection.
Public Sub Cut(Ta As Object)
	Ta.As(JavaObject).RunMethod("cut",Null)
End Sub
'Deletes the character that follows the current caret position from the text if there is no selection, or deletes the selection if there is one.
Public Sub DeleteNextChar(Ta As Object) As Boolean
	Return Ta.As(JavaObject).RunMethod("deleteNextChar",Null)
End Sub
'Deletes the character that precedes the current caret position from the text if there is no selection, or deletes the selection if there is one.
Public Sub DeletePreviousChar(Ta As Object) As Boolean
	Return Ta.As(JavaObject).RunMethod("deletePreviousChar",Null)
End Sub
'Removes a range of characters from the content.
Public Sub DeleteText(Ta As Object,Start As Int, TEnd As Int)
	Ta.As(JavaObject).RunMethod("deleteText",Array As Object(Start, TEnd))
End Sub
'Clears the selection.
Public Sub Deselect(Ta As Object)
	Ta.As(JavaObject).RunMethod("deselect",Null)
End Sub
'Moves the caret to after the last char of the text.
Public Sub End_(Ta As Object)
	Ta.As(JavaObject).RunMethod("end",Null)
End Sub
'Moves the caret to the end of the next word.
Public Sub EndOfNextWord(Ta As Object)
	Ta.As(JavaObject).RunMethod("endOfNextWord",Null)
End Sub
'This function will extend the selection to include the specified pos.
Public Sub ExtendSelection(Ta As Object,Pos As Int)
	Ta.As(JavaObject).RunMethod("extendSelection",Array As Object(Pos))
End Sub
'Moves the caret position forward.
Public Sub Forward(Ta As Object)
	Ta.As(JavaObject).RunMethod("forward",Null)
End Sub
'Gets the value of the property selectedText.
Public Sub GetSelectedText(Ta As Object) As String
	Return Ta.As(JavaObject).RunMethod("getSelectedText",Null)
End Sub
'Returns a subset of the text input's content.
Public Sub GetText(Ta As Object,Start As Int, TEnd As Int) As String
	Return Ta.As(JavaObject).RunMethod("getText",Array As Object(Start, TEnd))
End Sub
'Moves the caret to before the first char of the text.
Public Sub Home(Ta As Object)
	Ta.As(JavaObject).RunMethod("home",Null)
End Sub
'Inserts a sequence of characters into the content.
Public Sub InsertText(Ta As Object,Index As Int, Text As String)
	Ta.As(JavaObject).RunMethod("insertText",Array As Object(Index, Text))
End Sub
'Gets the value of the property redoable.
Public Sub IsRedoable(Ta As Object) As Boolean
	Return Ta.As(JavaObject).RunMethod("isRedoable",Null)
End Sub
'Gets the value of the property undoable.
Public Sub IsUndoable(Ta As Object) As Boolean
	Return Ta.As(JavaObject).RunMethod("isUndoable",Null)
End Sub
'Moves the caret to the beginning of next word.
Public Sub NextWord(Ta As Object)
	Ta.As(JavaObject).RunMethod("nextWord",Null)
End Sub
'Transfers the contents in the clipboard into this text, replacing the current selection.
Public Sub Paste(Ta As Object)
	Ta.As(JavaObject).RunMethod("paste",Null)
End Sub
'Positions the caret to the position indicated by pos.
Public Sub PositionCaret(Ta As Object,Pos As Int)
	Ta.As(JavaObject).RunMethod("positionCaret",Array As Object(Pos))
End Sub
'Moves the caret to the beginning of previous word.
Public Sub PreviousWord(Ta As Object)
	Ta.As(JavaObject).RunMethod("previousWord",Null)
End Sub
'If possible, redoes the last undone modification.
Public Sub Redo(Ta As Object)
	Ta.As(JavaObject).RunMethod("redo",Null)
End Sub
'Replaces the selection with the given replacement String.
Public Sub ReplaceSelection(Ta As Object,Replacement As String)
	Ta.As(JavaObject).RunMethod("replaceSelection",Array As Object(Replacement))
End Sub
'Replaces a range of characters with the given text.
Public Sub ReplaceText(Ta As Object,Start As Int, TEnd As Int, Text As String)
	Ta.As(JavaObject).RunMethod("replaceText",Array As Object(Start, TEnd, Text))
End Sub
'Moves the selection backward one char in the text.
Public Sub SelectBackward(Ta As Object)
	Ta.As(JavaObject).RunMethod("selectBackward",Null)
End Sub
'Moves the caret to after the last char of text.
Public Sub SelectEnd(Ta As Object)
	Ta.As(JavaObject).RunMethod("selectEnd",Null)
End Sub
'Moves the caret to the end of the next word.
Public Sub SelectEndOfNextWord(Ta As Object)
	Ta.As(JavaObject).RunMethod("selectEndOfNextWord",Null)
End Sub
'Moves the selection forward one char in the text.
Public Sub SelectForward(Ta As Object)
	Ta.As(JavaObject).RunMethod("selectForward",Null)
End Sub
'Moves the caret to before the first char of text.
Public Sub SelectHome(Ta As Object)
	Ta.As(JavaObject).RunMethod("selectHome",Null)
End Sub
'Moves the caret to the beginning of next word.
Public Sub SelectNextWord(Ta As Object)
	Ta.As(JavaObject).RunMethod("selectNextWord",Null)
End Sub
'Positions the caret to the position indicated by pos and extends the selection, if there is one.
Public Sub SelectPositionCaret(Ta As Object,Pos As Int)
	Ta.As(JavaObject).RunMethod("selectPositionCaret",Array As Object(Pos))
End Sub
'Moves the caret to the beginning of previous word.
Public Sub SelectPreviousWord(Ta As Object)
	Ta.As(JavaObject).RunMethod("selectPreviousWord",Null)
End Sub
'Positions the anchor and caretPosition explicitly
Public Sub SelectRange(Ta As Object,Anchor As Int, CaretPosition As Int)
	Ta.As(JavaObject).RunMethod("selectRange",Array As Object(Anchor, CaretPosition))
End Sub
'If possible, undoes the last modification.
Public Sub Undo(Ta As Object)
	Ta.As(JavaObject).RunMethod("undo",Null)
End Sub
