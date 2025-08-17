###  A B4XPages Class for Displaying a Flexible Horizontal Tree by William Lancee
### 03/03/2024
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/159614/)

The specs for this class are flexible and simple to define.  
It works on B4J and B4A.  
It is a significant expansion of the proof of concept posted [Here](https://www.b4x.com/android/forum/threads/tree-list.159549/post-979570)  
The class is included in the attached. Please use and/or modify for your purposes.  
  
  
![](https://www.b4x.com/android/forum/attachments/151347)  
Use:  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
   
    Private targetPanel As B4XView = xui.CreatePanel("")  
    targetPanel.SetLayoutAnimated(0, 0dip, 0dip, Root.width, Root.height)  
    Private styles As Map = CreateMap()  
    'targetPanel.SetColorAndBorder(xui.Color_Transparent, 1, xui.Color_RGB(220, 220, 220), 0)  
  
    styles.Put("Title", CreateMap("text": "A Flexible Horizontal Tree Chart", "textColor": xui.Color_RGB(0, 160, 0), "textSize": 25, "align": "center"))  
    styles.Put("Notes", CreateMap("noteHeight": 25, "lines": CreateList(Array( _  
            CreateMap("text": "Note 1: Red on gray are 'Special'", "textColor": xui.Color_RGB(100, 100, 100), "textSize": 15, "align": "left"), _  
            CreateMap("text": "Note 2: Others are defaults", "textColor": xui.Color_RGB(100, 100, 100), "textSize": 15, "align": "left") _  
    ))))  
    styles.Put("Connectors", CreateMap("color": xui.Color_RGB(160, 160, 160), "width": 2))  
    styles.Put("Default", CreateMap("color": xui.Color_Blue, "bold": False, "textSize": 18, "borderColor": xui.Color_Blue))  
    styles.Put("StyleA", CreateMap("color": xui.Color_Red, "bold": True, "textSize": 20, _  
    "backgroundColor": xui.Color_RGB(200, 200, 200), "borderColor": xui.Color_Black, "borderWidth": 2, "borderRadius": 5))  
       
    'Column index = level = number of leading tabs; | specifies row position; styles see above  
    Dim spec As String = $"  
Item 1|10, StyleA  
    Item 1-1|8  
        Item 1-1-1|3  
        Item 1-1-2|4  
    Item 1-2|9  
        Item 1-2-1|9  
        Item 1-2-2|10, StyleA  
    Item 1-3|10  
        Item 1-3-1|15  
    "$  
  
    'The width of the panel and number of columns determine the width of each box  
    'The height of the panel and number of rows determine the height of each box  
    htree.Initialize(targetPanel, 17, 4, False, styles, spec)  
    B4XPages.AddPageAndCreate("htree", htree)  
    Sleep(0)  
    B4XPages.ShowPage("htree")  
  
    'grab and resize chart   
#if B4J   
    Dim im As ImageView  
    im.Initialize("")  
    Root.AddView(im, 100, 100, 600, 400)  
    im.SetImage(htree.getBitmap)  
#End if  
  
End Sub
```