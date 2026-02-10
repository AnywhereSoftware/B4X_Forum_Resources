### Drag and drop file into a B4XFloatTextField by Erel
### 02/05/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/170224/)

![](https://www.b4x.com/basic4android/images/java_jjD3H9Zne9.gif)  
  
Depends on DragAndDrop2: <https://www.b4x.com/android/forum/threads/jdraganddrop2-drag-and-drop.76168/#content>  
  

```B4X
'globals  
  
Private txtFile As B4XFloatTextField  
Private DragAndDrop1 As DragAndDrop  
Private AllowedExtensions As List = Array(".csv", ".xlsx", ".xls")  
  
'after the layout is loaded  
DragAndDrop1.Initialize(Me)  
DragAndDrop1.MakeDragTarget(txtFile.mBase, "DropTarget")  
txtFile.HintText = "Drop file (allowed extensions: csv, xlsx, xls)"  
txtFile.Update  
  
Sub DropTarget_DragEntered(e As DragEvent)  
    Log("DragEntered")  
    Dim clr As Int  
    If IsValidDropEvent(e) Then  
        clr = xui.Color_Green  
    Else  
        clr = xui.Color_Red  
    End If  
    txtFile.TextField.SetColorAndBorder(xui.Color_White, 4dip, clr, 0)  
End Sub  
  
Sub DropTarget_DragExited(e As DragEvent)  
    txtFile.TextField.SetColorAndBorder(xui.Color_White, 1dip, xui.Color_LightGray, 2dip)  
End Sub  
  
Sub DropTarget_DragOver(e As DragEvent)  
    If IsValidDropEvent(e) Then e.AcceptTransferModes(TransferMode.COPY)  
End Sub  
  
Sub IsValidDropEvent(e As DragEvent) As Boolean  
    If e.GetDragboard.HasFiles Then  
        Dim files As List = e.GetDragboard.GetFiles  
        Try  
            If files.Size = 1 And File.Exists(files.get(0), "") Then  
                Dim filename As String = files.Get(0)  
                For Each ext In AllowedExtensions 'comment if not relevant  
                    If filename.ToLowerCase.EndsWith(ext) Then Return True  
                Next  
            End If  
        Catch  
            Log(LastException)  
        End Try  
    End If  
    Return False  
End Sub
```