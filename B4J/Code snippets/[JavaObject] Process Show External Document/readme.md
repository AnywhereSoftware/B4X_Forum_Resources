### [JavaObject] Process Show External Document by T201016
### 06/08/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171204/)

An Example of processing external documents in the full screen setting or represented by the parent screen:  
  

```B4X
'Use:  
Dim FileName As String = "eProper.b4j"  
Dim FileNameDesign As String = FileName.Replace(".b4j","") & Chr(32) &"-"& Chr(32) & "B4J"  
If Not(ProcessShowExternalDocument(FileNameDesign)) Then  
    fx.ShowExternalDocument(File.GetUri(Folder,FileName))  
Else  
    cutils.ShowNotification3("Message","Show External Document.", cutils.ICON_INFORMATION, Null, "CENTER", 2000)  
End If  
  
  
Public Sub ProcessShowExternalDocument(FindTitleInB4J As String) As Boolean  
    Dim FindTitle As List  
     
    FindTitle.Initialize  
    FindTitle.AddAll(Array As String(FindTitleInB4J))     'Edit in B4J.exe  
    '  
    'Just to see the title formats  
    '  
    Dim windowUtils As JavaObject  
    windowUtils.InitializeStatic("com.sun.jna.platform.WindowUtils")  
    Dim Jo As JavaObject  
    Dim Instance As JavaObject = Jo.InitializeStatic("com.sun.jna.platform.win32.User32").GetField("INSTANCE")  
    Dim Lwnd As List = windowUtils.RunMethod("getAllWindows",Array(False))  
    For Each Window As JavaObject In Lwnd  
        Dim Title As String = Window.RunMethod("getTitle",Null)  
        For Each Suffix As String In FindTitle  
            If Title.EndsWith(Suffix) Then  
                Dim Hwnd As JavaObject = Window.RunMethod("getHWND",Null)  
                If Initialized(Hwnd) Then  
                    Instance.RunMethod("ShowWindow",Array(Hwnd,Instance.GetField("SW_RESTORE")))  
                    Instance.RunMethod("SetForegroundWindow",Array(Hwnd))  
                    windowUtils.InitializeStatic("com.sun.jna.platform.WindowUtils")  
                    '  
                    'Represents the primary screen  
                    '  
'                    Dim awtrect As JavaObject = windowUtils.RunMethod("getWindowLocationAndSize", Array(Hwnd))  
'                    Dim xpos As Int = awtrect.GetField("x")            '< Move the window horizontally by X pixels >  
'                    Dim ypos As Int = awtrect.GetField("y")            '< Move the window vertically by Y pixels >  
'                    Dim xmax As Int = awtrect.GetField("width")  
'                    Dim ymax As Int = awtrect.GetField("height")  
                    '  
                    'Set FullScreen  
                    '  
                    Dim xpos As Int = 0  
                    Dim ypos As Int = 0  
                    Dim xmax As Int = fx.PrimaryScreen.MaxX            '< Returns a screen object that represents the primary screen >  
                    Dim ymax As Int = fx.PrimaryScreen.MaxY            '< Returns a screen object that represents the primary screen >  
                    '  
                    'Set Window Position  
                    '  
                    Instance.RunMethod("SetWindowPos", Array(Hwnd, Null, xpos, ypos, xmax, ymax, 0))  
                End If  
                Return True  
            End If  
        Next  
    Next  
    Return False  
End Sub
```