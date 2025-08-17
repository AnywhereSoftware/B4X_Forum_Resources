### [B4j] TextArea and TextField commands. Keep Undo working. by stevel05
### 09/21/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/152006/)

Have you ever noticed that the Javafx TextArea undo / redo seems pretty unreliable?  
  
It seems to be because when you set any text directly on the TextArea with Textarea1.Text = ??? it resets the Undo state. (I haven't been able to confirm this in any documentation as I can't find anything relevant).  
  
So how can we get around that? The TextArea API has many commands available to do regular tasks like insert text, replace text, replace selected text and many others. Using these commands instead of directly setting the text keeps the TextArea's Undo Manager in a state that is useful.  
  
The attached B4xLib contains the available commands and has 2 modules, A Code module which is a static version of the library to which you need to pass the target TextArea to every sub and a Class module which needs to be declared an initialized with the Target TextArea. It's up to you which version you try or use both. Most of the commands are used directly by the control to navigate, cut and paste etc, so you probably won't need to use them, but I added them for the occasions that you do.  
  
[SPOILER="Documentation"]  
**[SIZE=7]Class : [/SIZE]**TA\_Commands **[SIZE=7]ShortName : [/SIZE]** TA\_Commands  
  
[INDENT][SIZE=7]**Methods:**[/SIZE][/INDENT]  
  
[INDENT][/INDENT]  
[INDENT]**Initialize**(TA As TextArea)[/INDENT]  
[INDENT]Initializes the object. You can add parameters to this method if needed.[/INDENT]  
  
[INDENT]**Backward**[/INDENT]  
[INDENT]Moves the caret position backward.[/INDENT]  
  
[INDENT]**CancelEdit**[/INDENT]  
[INDENT]If the field is currently being edited, this call will set text to the last commited value.[/INDENT]  
  
[INDENT]**Clear**[/INDENT]  
[INDENT]Clears the text.[/INDENT]  
  
[INDENT]**CommitValue**[/INDENT]  
[INDENT]Commit the current text and convert it to a value.[/INDENT]  
  
[INDENT]**Copy**[/INDENT]  
[INDENT]Transfers the currently selected range in the text to the clipboard, leaving the current selection.[/INDENT]  
  
[INDENT]**Cut**[/INDENT]  
[INDENT]Transfers the currently selected range in the text to the clipboard, removing the current selection.[/INDENT]  
  
[INDENT]**DeleteNextChar** As Boolean[/INDENT]  
[INDENT]Deletes the character that follows the current caret position from the text if there is no selection, or deletes the selection if there is one.[/INDENT]  
  
[INDENT]**DeletePreviousChar** As Boolean[/INDENT]  
[INDENT]Deletes the character that precedes the current caret position from the text if there is no selection, or deletes the selection if there is one.[/INDENT]  
  
[INDENT]**DeleteText**(Start As Int, TEnd As Int)[/INDENT]  
[INDENT]Removes a range of characters from the content.[/INDENT]  
  
[INDENT]**Deselect**[/INDENT]  
[INDENT]Clears the selection.[/INDENT]  
  
[INDENT]**End\_**[/INDENT]  
[INDENT]Moves the caret to after the last char of the text.[/INDENT]  
  
[INDENT]**EndOfNextWord**[/INDENT]  
[INDENT]Moves the caret to the end of the next word.[/INDENT]  
  
[INDENT]**ExtendSelection**(Pos As Int)[/INDENT]  
[INDENT]This function will extend the selection to include the specified pos.[/INDENT]  
  
[INDENT]**Forward**[/INDENT]  
[INDENT]Moves the caret position forward.[/INDENT]  
  
[INDENT]**GetSelectedText** As String[/INDENT]  
[INDENT]Gets the value of the property selectedText.[/INDENT]  
  
[INDENT]**GetText**(Start As Int, TEnd As Int) As String[/INDENT]  
[INDENT]Returns a subset of the text input's content.[/INDENT]  
  
[INDENT]**Home**[/INDENT]  
[INDENT]Moves the caret to before the first char of the text.[/INDENT]  
  
[INDENT]**InsertText**(Index As Int, Text As String)[/INDENT]  
[INDENT]Inserts a sequence of characters into the content.[/INDENT]  
  
[INDENT]**IsRedoable** As Boolean[/INDENT]  
[INDENT]Gets the value of the property redoable.[/INDENT]  
  
[INDENT]**IsUndoable** As Boolean[/INDENT]  
[INDENT]Gets the value of the property undoable.[/INDENT]  
  
[INDENT]**NextWord**[/INDENT]  
[INDENT]Moves the caret to the beginning of next word.[/INDENT]  
  
[INDENT]**Paste**[/INDENT]  
[INDENT]Transfers the contents in the clipboard into this text, replacing the current selection.[/INDENT]  
  
[INDENT]**PositionCaret**(Pos As Int)[/INDENT]  
[INDENT]Positions the caret to the position indicated by pos.[/INDENT]  
  
[INDENT]**PreviousWord**[/INDENT]  
[INDENT]Moves the caret to the beginning of previous word.[/INDENT]  
  
[INDENT]**Redo**[/INDENT]  
[INDENT]If possible, redoes the last undone modification.[/INDENT]  
  
[INDENT]**ReplaceSelection**(Replacement As String)[/INDENT]  
[INDENT]Replaces the selection with the given replacement String.[/INDENT]  
  
[INDENT]**ReplaceText**(Start As Int, TEnd As Int, Text As String)[/INDENT]  
[INDENT]Replaces a range of characters with the given text.[/INDENT]  
  
[INDENT]**SelectBackward**[/INDENT]  
[INDENT]Moves the selection backward one char in the text.[/INDENT]  
  
[INDENT]**SelectEnd**[/INDENT]  
[INDENT]Moves the caret to after the last char of text.[/INDENT]  
  
[INDENT]**SelectEndOfNextWord**[/INDENT]  
[INDENT]Moves the caret to the end of the next word.[/INDENT]  
  
[INDENT]**SelectForward**[/INDENT]  
[INDENT]Moves the selection forward one char in the text.[/INDENT]  
  
[INDENT]**SelectHome**[/INDENT]  
[INDENT]Moves the caret to before the first char of text.[/INDENT]  
  
[INDENT]**SelectNextWord**[/INDENT]  
[INDENT]Moves the caret to the beginning of next word.[/INDENT]  
  
[INDENT]**SelectPositionCaret**(Pos As Int)[/INDENT]  
[INDENT]Positions the caret to the position indicated by pos and extends the selection, if there is one.[/INDENT]  
  
[INDENT]**SelectPreviousWord**[/INDENT]  
[INDENT]Moves the caret to the beginning of previous word.[/INDENT]  
  
[INDENT]**SelectRange**(Anchor As Int, CaretPosition As Int)[/INDENT]  
[INDENT]Positions the anchor and caretPosition explicitly[/INDENT]  
  
[INDENT]**Undo**[/INDENT]  
[INDENT]If possible, undoes the last modification.[/INDENT]  
[/SPOILER]  
  
**Update V0.2**   
[INDENT]Fixed erroneous comments[/INDENT]  
[INDENT]Changed type of passed TextControl to Object so it will work with TextField as well as TextArea.[/INDENT]  
  
I hope you find them useful.