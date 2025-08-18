### KeyBoard Event,detect CTRL+X or etc... by behnam_tr
### 07/20/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/132742/)

```B4X
Private KEY_CTRL_PRESSED As Boolean = False  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Main") 'Load the layout file.  
    MainForm.Show  
      
    AddKeyPressedListener(MainForm)  
End Sub  
  
Sub AddKeyPressedListener(f As Form)  
    f.RootPane.RequestFocus  
    Dim r As Reflector  
    r.Target = f.RootPane  
    r.AddEventHandler("Main_KeyPressed", "javafx.scene.input.KeyEvent.KEY_PRESSED")  
    r.AddEventHandler("Main_KeyPressed", "javafx.scene.input.KeyEvent.KEY_RELEASED")  
End Sub  
  
Private Sub Main_KeyPressed_Event(e As Event)  
    Dim KE As Reflector  
    KE.Target = e 'e is a KeyEvent instance  
'    Dim KeyChar As String = KE.RunMethod("getCharacter")  
    Dim KeyCode As String = KE.RunMethod("getCode")  
'    Dim KeyText As String = KE.RunMethod("getText")  
    Dim EventType As String = KE.RunMethod("getEventType")  
      
    Log(EventType)  
      
    Select EventType  
          
        Case "KEY_PRESSED"  
            Select KeyCode  
                Case "ESCAPE"  
                    Log("ESC")  
                  
                Case "CONTROL"  
                    KEY_CTRL_PRESSED = True  
                Case "X"  
                    If KEY_CTRL_PRESSED Then  
                        Log("CTRL+X PRESSED")  
                          
                    End If  
            End Select  
          
      
        Case "KEY_RELEASED"  
            If KeyCode = "CONTROL" Then  
                KEY_CTRL_PRESSED = False  
            End If  
              
              
    End Select  
    e.Consume  
End Sub
```