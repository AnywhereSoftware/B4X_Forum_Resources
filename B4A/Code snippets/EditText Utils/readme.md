### EditText Utils by klaus
### 05/21/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/43479/)

**Subject: Routines for selecting text and cursor management.**  
  
The result of these routines is visible only if the EditText has the focus !  
  
Reminder of existing methods:  
  
**EditText.RequestFocus :** Tries to set the focus to this view. Returns True if the focus was set.  
**EditText.SelectAll :** Selects the entire text of EditText  
**EditText.SelectionStart :** Gets or sets the selection start position (or the cursor position).  
Returns -1 if there is no selection or cursor.  
  
**Sub: setCursorVisible**   
Description: Sets the cursor visible or hides it.  

```B4X
'Sets the cursor visible or hides it  
Sub setCursorVisible(edt As EditText, Visible As Boolean)  
    Dim jo = edt As JavaObject  
    jo.RunMethod("setCursorVisible", Array As Object(Visible))  
End Sub
```

  
  
**Sub: setTextIsSelectable**   
Description: Sets the text selectable or not selectable.  

```B4X
'Sets the text selectable or not selectable  
Sub setTextIsSelectable(edt As EditText, Selectable As Boolean)  
    Dim jo = edt As JavaObject  
    jo.RunMethod("setTextIsSelectable", Array As Object(Selectable))  
End Sub
```

  
  
**Sub: setSelection**   
Description: Selects the text between the two indexes.  

```B4X
'Selects the text between the two indexes.  
Sub setSelection(edt As EditText, StartIndex As Int, EndIndex As Int)  
    Dim jo = edt As JavaObject  
    jo.RunMethod("setSelection", Array As Object(StartIndex, EndIndex))  
End Sub
```

  
  
**Sub: getSelectionStart**  
Description: Returns selection start index.  

```B4X
'Gets the selection start index  
Sub getSelectionStart(edt As EditText) As Int  
    Dim jo = edt As JavaObject  
    Return jo.RunMethod("getSelectionStart", Null)  
End Sub
```

  
  
**Sub: getSelectionEnd**  
Description: Returns the selection end index.  

```B4X
'Gets the selection end index  
Sub getSelectionEnd(edt As EditText) As Int  
    Dim jo = edt As JavaObject  
    Return jo.RunMethod("getSelectionEnd", Null)  
End Sub
```

  
  
**Sub: setHighlightColor**  
Description:Sets the highlight color.  

```B4X
'Sets the highlight color  
Sub setHighLightColor(edt As EditText, Color As Int)  
   Private joEdt = edt As JavaObject  
   joEdt.RunMethod("setHighlightColor", Array(Color))  
End Sub
```

  
  
**Sub: getHighlightColor**  
Description: Gets the highlight color.  

```B4X
'Gets the highlight color  
Sub getHighLightColor(edt As EditText) As Int  
   Private joEdt = edt As JavaObject  
   Return joEdt.RunMethod("getHighlightColor", Null)  
End Sub
```

  
  
**Sub GetXYCursor**  
Description: Gets the x and y coordinates, in pixels, of the cursor in an EditText view.  

```B4X
'gets the x and y coordinates, in pixels, of the cursor in an EditText view  
'the Y coordinate is at the base line, on top or on bottom of the line  
'retuens an array of Ints  
'X = xy(0) and Y = xy(1)  
'the reference is the top left corner of the EditText  
'YPosition can be "BaseLine", "TopOfLine", "BottomOfLine"  
Private Sub GetXYCursor(edt As EditText, YPosition As String) As Int()  
    Private joEditText, joLayout As JavaObject  
    Private PaddingLeft, PaddingTop, ScrollY, Pos, Line, LineBaseline, LineTop, LineBottom As Int  
    Private xy(2) As Int  
  
    joEditText = edt  
    PaddingLeft = joEditText.RunMethod("getPaddingLeft", Null)  
    PaddingTop = joEditText.RunMethod("getPaddingTop", Null)  
    ScrollY = joEditText.RunMethod("getScrollY", Null)  
'    pos = edt.SelectionStart  
    Pos = joEditText.RunMethod("getSelectionStart", Null)  
    joLayout = joEditText.RunMethod("getLayout", Null)  
    Line = joLayout.RunMethod("getLineForOffset", Array As Object(Pos))    'line numbsr  
    LineBaseline = joLayout.RunMethod("getLineBaseline", Array As Object(Line))  
    LineTop = joLayout.RunMethod("getLineTop", Array As Object(Line))  
    LineBottom = joLayout.RunMethod("getLineBottom", Array As Object(Line))  
   
    xy(0) = joLayout.RunMethod("getPrimaryHorizontal", Array As Object(Pos)) + PaddingLeft ' X coordinate  
    Select Case YPosition  
        Case "BaseLine"  
            xy(1) = LineBaseline + PaddingTop - ScrollY    'base line    Y coordinate  
        Case "TopOfLine"  
            xy(1) = LineTop + PaddingTop - ScrollY    'top of the line     Y coordinate  
        Case "BottomOfLine"  
            xy(1) = LineBottom + PaddingTop - ScrollY 'text bottom line  
    End Select  
    Return xy  
End Sub
```

  
  
**Sub: CopyToClipboard**  
Description: Copies the selected text in the given EditText view to the clipboard.  
Needs the Clipboard library.  
[FONT=Courier New]Dim clip As BClipboard[/FONT] can be moved from the routine to Globals.  

```B4X
'Copies the selected text from the given EditText view to the Clipboard  
Sub CopyToClipboard(edt As EditText)  
    Dim txt As String  
    Dim i1, i2 As Int  
    Dim clip As BClipboard  
    Dim jo = edt As JavaObject  
    i1 = jo.RunMethod("getSelectionStart", Null)  
    i2 = jo.RunMethod("getSelectionEnd", Null)  
    txt = edt.Text.SubString2(i1, i2)  
    clip.setText(txt)  
End Sub
```

  
  
**Sub SelectLine**  
Description: Selects a line and highlights it.  

```B4X
'Selects the current line  
'CursorPosition = text cursor position  
'LineIndex = index of the line where the cursor is positioned  
'LineStart = text cursor position of the first character in the line  
'LineVisibleEnd = text cursor position of the last visible character in the line  
Private Sub SelectLine  
    Private joEditText, joLayout As JavaObject  
    Private CursorPosition, LineIndex, LineStart, LineVisibleEnd As Int  
     
    joEditText = edtTest  
    joLayout = joEditText.RunMethod("getLayout", Null)  
     
    CursorPosition = joEditText.RunMethod("getSelectionStart", Null)  
    LineIndex = joLayout.RunMethod("getLineForOffset", Array As Object(CursorPosition))  
    LineStart = joLayout.RunMethod("getLineStart", Array As Object(LineIndex))  
    LineVisibleEnd = joLayout.RunMethod("getLineVisibleEnd", Array As Object(LineIndex))  
    joEditText.RunMethod("setSelection", Array As Object(LineStart, LineVisibleEnd))  
End Sub
```

  
  
The JavaObject routines can also be used without a sub like below or like in the CopyToClipboard routine above:  

```B4X
Dim jo = edt As JavaObject  
  
jo.RunMethod("setTextIsSelectable", Array As Object(True))  
jo.RunMethod("setCursorVisible", Array As Object(True))  
jo.RunMethod("setSelection", Array As Object(5, 10))
```

  
Dependencies: JavaObject library, Clipboard library (only for CopyToClipboard)  
  
Tags: EditText, selection, setSelection, text, setTextIsSelectable, cursor, setCursorVisible, copy, clipboard, getHighlightColor, setHighlightColor, CopyTpClipboard  
  
Attached a small test program.  
  
EDIT: 2020.06.09  
Added the GetXYCursor routine  
  
EDIT: 2019.04.03  
Added getHighlightColor and setHighlightColor routines.  
  
EDIT: 2016.06.27  
Amended two errors. The methods getSelectionStart and getSelectionEnd didn't return a value.  
  
EDIT: 2014.08.04  
Added the getSelectionStart, getSelectionEnd and CopyToClipboard routines.