### [BANano] Quick and East TrendCharts by Mashiane
### 04/15/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166627/)

Hi Fam  
  
I recently ran into [TrendChart Elements,](https://weblogin.github.io/trendchart-elements/) looking very impressive.  
  
![](https://www.b4x.com/android/forum/attachments/163426)  
  
  
  
Here is as simple implementation. You can explore the demos they have for how to create other examples.  
  

```B4X
' HERE STARTS YOUR APP  
Sub BANano_Ready()  
    AddJavaScriptModuleURL("https://cdn.jsdelivr.net/npm/@weblogin/trendchart-elements@1.1.0/dist/index.js/+esm", True)  
      
    Private body As BANanoElement  
    body.Initialize("#body")  
    body.Append($"<tc-line values="[12,10,12,11,7,6,8,10,12]" style="padding:10px;margin:10px;"></tc-line>"$)  
    body.Append($"<tc-pie values="[35,68,22,16]" style="padding:10px;margin:10px;"></tc-pie>"$)  
    body.Append($"<tc-bar values="[11,7,6,8,10,12,8,10,12]" style="padding:10px;margin:10px;"></tc-bar>"$)  
    body.Append($"<tc-stack values="[24,18,19,7]" style="padding:10px;margin:10px;"></tc-stack>"$)  
End Sub  
  
Sub AddJavaScriptModuleURL(urlLink As String, bAsync As Boolean)  
    Dim tmpScriptElem As BANanoElement = BANano.CreateElement("script")  
    tmpScriptElem.SetAttr("type", "module")  
    tmpScriptElem.SetAttr("src", urlLink)  
    If bAsync Then tmpScriptElem.SetAttr("async", bAsync)  
    BANano.GetElement("head").Append(tmpScriptElem)  
End Sub
```