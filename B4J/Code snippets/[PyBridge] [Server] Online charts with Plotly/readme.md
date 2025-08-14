### [PyBridge] [Server] Online charts with Plotly by Erel
### 07/29/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/167983/)

![](https://www.b4x.com/android/forum/attachments/165642)  
  
Porting of this desktop example: <https://www.b4x.com/android/forum/threads/pybridge-visualization-of-hierarchical-data-with-plotly.167965/> to jServer.  
PyBridge runs with a background worker and the interaction with this worker is done with CallSubDelayed. This ensures that the code will be executed with the correct thread.  
  

```B4X
Private Sub Btn_Click (Params As Map)  
    Dim req As GraphRequest  
    req.Initialize  
    req.GraphType = Params.Get("target")  
    If ValidTargets.Contains(req.GraphType) = False Then Return  
    req.Callback = Me  
    Result.SetHtml("Creating graph…")  
    CallSubDelayed2(Main.PyWorker, "Show_Graph", req)  
    Wait For Graph_Response (Html As String)  
    Result.SetHtml(Html)  
    ws.Flush  
End Sub
```

  
  
See the dependencies in the desktop example. I recommend using a global Python runtime: <https://www.b4x.com/android/forum/threads/pybridge-the-very-basics.165654/#post-1018942>  
  
Note that unlike with the desktop example, the generated html doesn't include the engine JavaScript. It is instead loaded as part of the page, making the generated html much smaller.  
The example uses bootstrap and is mobile friendly.