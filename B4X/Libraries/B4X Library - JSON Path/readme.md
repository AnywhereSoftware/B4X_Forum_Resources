###  B4X Library - JSON Path by hatzisn
### 02/23/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170315/)

This library creates a new way to access json values. You literally create a path and get the value you want just by studying the expected JSON (if you get it from a request). The object is JSONPath and by getting the {JSONPath}.Instructions you will get the following code where you can easily understand how it works. The path can be constructed with statements or be set directly. The benefit from this is the following: If you create a program that processes a JSON, then if this JSON changes, just by updating (f.e. through the internet) the JSONPath to the new path you can get the required values directly again without any change in the code. In order to see how the path is constructed in order to set it afterwards see the [ICODE]Log(jsp.JSONPath)[/ICODE]. It works in all three IDEs (B4A, B4i, B4J).  
  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private jsp As JSONPath  
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    jsp.Initialize  
End Sub  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
Sub Button1_Click  
    Dim sJSON As String = $"{"mylists":[[{"mykey":"nikos1"},{"mykey":"george1"}],[{"mykey":"nikos2"},{"mykey":"george2"}],[{"mykey":"nikos3"},{"mykey":"george3"}]]}"$  
  
    jsp.BuildPath.GetJSONObjectValueWithTheKey("mylists").GetJSONArrayValueInPosition(2).GetJSONArrayValueInPosition(0).GetJSONObjectValueWithTheKey("mykey")  
    Log(jsp.JSONPath)  
  
    Log(jsp.GetValueAccordingToPath(sJSON))  
End Sub
```