###  [XUI] Scrolling Label by Erel
### 11/03/2021
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/85516/)

**Don't use this.  
Latest version is included in XUI Views.**  
For rich text, use <https://www.b4x.com/android/forum/threads/b4x-bbscrollinglabel-rich-text-scrolling-label.114310/#content>  
  
  
![](https://www.b4x.com/android/forum/attachments/61087)  
  
A custom view with a label that scrolls automatically when the text is wider than the label.  
The class is supported by B4A, B4i and B4J. It depends on XUI v1.46+.  
  
Note that in B4A, if not using B4XPages, you should add this code to Activity\_Resume:  

```B4X
Sub Activity_Resume  
   For Each v As View In Activity.GetAllViewsRecursive  
     If v.Tag Is ScrollingLabel Then  
       Dim sl As ScrollingLabel = v.Tag  
       sl.Text = sl.Text 'this will cause the labels to scroll  
     End If  
   Next  
End Sub
```

  
  
A B4J example is attached. The class is inside the zip.  
  
V1.10 - Text color can be set in the designer (under Text properties).