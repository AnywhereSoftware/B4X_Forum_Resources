### TextArea - Moving Focus after pressing TAB by gregchao
### 12/13/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/125516/)

Here is a fairly simple solution to solving the TAB issue in TextArea. Currently, instead of moving to the next node, tabbing stays within the TextArea. To fix this, I used a combination of the jgameviewhelper library to capture the TAB keypress and additional code to get the current focus (post entitled- "Get last object focused" by stevel05 & Daestrum). Note that you must use the tag feature in order for you to identify the TextArea.  
  

```B4X
Sub Process_Globals  
Private GameViewHelper As GameViewHelper  
End sub  
  
Sub AppStart (Form1 As Form, Args() As String  
   GameViewHelper.AddKeyListener("GVH", MainForm)  
End Sub  
  
Sub GVH_KeyPressed (KeyCode As String) As Boolean  
    Log(KeyCode)  
    Dim FormJO As JavaObject = MainForm  
    Dim Scene As JavaObject = FormJO.GetField("scene")  
    Dim selectedNode As Node  
    Try  
        selectedNode = Scene.RunMethod("getFocusOwner",Null)  
        Log(selectedNode.Tag) ' all node methods available  
    Catch  
        Log("no node has focus")  
    End Try  
  
    If KeyCode = "Tab" And selectedNode.Tag = "TextAreaSendText" Then  
        ButtonSendText.RequestFocus  'insert here where you want the focus to go  
        Return True  'consume the keypress  
    End If  
    Return False  'do not consume the keypress  
End Sub
```