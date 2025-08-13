### [PyBridge] Pygal - nice charting library by Erel
### 02/20/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/165711/)

![](https://www.b4x.com/android/forum/attachments/161924)  
  
<https://www.pygal.org/en/latest/index.html>  
  
This library produces interactive SVG, which can be loaded with WebView.  
It has many features. Small example:  

```B4X
Dim PyGal As PyWrapper = Py.ImportModule("pygal")  
Dim PyGalStyle As PyWrapper = Py.ImportModule("pygal.style")  
Dim Chart As PyWrapper = PyGal.Run("StackedLine") _  
    .ArgNamed("style", PyGalStyle.GetField("CleanStyle")).ArgNamed("fill", True).ArgNamed("interpolate", "cubic")  
Chart.Run("add").Arg("A").Arg(Array(1, 3,  5, 16, 13, 3,  7))  
Chart.Run("add").Arg("B").Arg(Array(5, 2,  3,  2,  5, 7, 17))  
Chart.Run("add").Arg("C").Arg(Array(6, 10, 9,  7,  3, 1,  0))  
Chart.Run("add").Arg("D").Arg(Array(2,  3, 5,  9, 12, 9,  5))  
Chart.Run("add").Arg("E").Arg(Array(7,  4, 2,  1,  2, 10, 0))  
'Chart.SetField("title", "This is the title") 'uncomment with BETA #3+  
Wait For (Chart.Run("render").Fetch) Complete (Result As PyWrapper)  
File.WriteBytes(xui.DefaultFolder, "temp.svg", Result.Value)  
WebView1.LoadUrl(xui.FileUri(xui.DefaultFolder, "temp.svg"))
```

  
  
PyWrapper.SetField is a new method that will be added in the next beta.  
  
Dependencies:  
pip install pygal