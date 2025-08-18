### [SMM] Top sites example by Erel
### 10/07/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/134898/)

This example uses SimpleMediaManager to show a list of 400 top sites, based on Alexa dataset.  
  
![](https://www.b4x.com/android/forum/attachments/119991)  
  
Each item is made of two panels and a label:  
- Panel for the favicon.  
- Panel for the WebView  
- Label with the site name.  
  
Almost complete code:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Dim su As StringUtils  
    Sites.Initialize  
    For Each row() As String In su.LoadCSV(File.DirAssets, "topsites.txt", ",")  
        Sites.Add(row(1))  
    Next  
    smm.Initialize  
    smm.AddLocalMedia(smm.KEY_DEFAULT_LOADING, File.ReadBytes(File.DirAssets, "loading.gif"), "image/gif")  
    For Each s As String In Sites  
        Dim base As B4XView = xui.CreatePanel("")  
        base.SetLayoutAnimated(0, 0, 0, Root.Width, 300dip)  
        base.Color = xui.Color_White  
        CustomListView1.Add(base, s)  
    Next  
End Sub  
  
Private Sub CustomListView1_VisibleRangeChanged (FirstIndex As Int, LastIndex As Int)  
    For i = 0 To CustomListView1.Size - 1  
        Dim IsVisible As Boolean = i >= FirstIndex - 2 And i <= LastIndex + 2  
        Dim base As B4XView = CustomListView1.GetPanel(i)  
        If IsVisible Then  
            If base.NumberOfViews = 0 Then  
                base.LoadLayout("Item")  
                Dim site As String = CustomListView1.GetValue(i)  
                smm.SetMedia(base.GetView(0), $"https://www.${site}/favicon.ico"$)  
                smm.SetMedia(base.GetView(2), $"https://${site}"$)  
                base.GetView(1).Text = site  
            End If  
        Else  
            If base.NumberOfViews > 0 Then  
                smm.ClearMedia(base.GetView(2)) 'immediately stop WebView.  
            End If  
            base.RemoveAllViews  
        End If  
    Next  
End Sub
```

  
  
Most of the work is done by SMM.  
We explicitly call ClearMedia when an item is no longer visible to avoid holding busy WebViews.  
  
It depends on SMM v1.05 with the image4j jar (B4J only) and B4XGifView for the animated loading indicator.  
  
**Warning:** some of the sites are adult sites.