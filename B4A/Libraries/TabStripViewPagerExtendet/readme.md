### TabStripViewPagerExtendet by Alexander Stolte
### 04/10/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/88821/)

This is the TabStripViewPagerExtendet Class for the [TabStripViewPager](https://www.b4x.com/android/forum/threads/tabstripviewpager-better-viewpager.63975/#content) and my first Class which I publish.  
  
The standard library does not offer much customizability and thats the reason why I did this class. The class has many settings and thanks to Erel for sharing methods with the JavaObjects.  
  
Feel free to edit it, it is not perfect, but it works for [USER=75815]@GeoffT660[/USER] (big thanks to you) and for me.  
  
**TabStripViewPagerExtendet  
Author:** Alexander Stolte  
**Version: 1.01  
  
Methods:**  

- **IndicatorColor**(tabstrip As TabStrip, color As Int)
- **IndicatorHeight**(tabstrip As TabStrip, height As Int)
- **UnderlineColor**(tabstrip As TabStrip, color As Int)
- **UnderlineHeight**(tabstrip As TabStrip, height As Int)
- **DividerColor**(tabstrip As TabStrip, color As Int)
- **GetAllTabLabels**(tabstrip As TabStrip) **As** **List**
- **TabTextColor**(tabstrip As TabStrip, colorSelected As Int , colorInactive As Int, Position As Int)
- **TabBackgroundColor**(tabstrip As TabStrip, colorSelected As Int , colorInactive As Int, Position As Int)
- **ChangeTabText**(tabstrip As TabStrip, text As String, Position As Int)
- **ChangeTabTextEllipsize**(tabstrip As TabStrip, Ellipsize As String, Position As Int)
- **SetTypeFaces**(tabstrip As TabStrip,TypeFaces As Typeface,Position As Int)
- **SetTextGravity**(tabstrip As TabStrip,gravitys As Int,Position As Int)
- **SetTabHeight**(tabstrip As TabStrip,height As Int,Position As Int)
- **SetTabLeft**(tabstrip As TabStrip,left As Int,Position As Int)
- **SetTabPadding**(tabstrip As TabStrip,padding() As Int,Position As Int)
- **SetTabSingleline**(tabstrip As TabStrip,singleline As Boolean,Position As Int)
- **SetTabTag**(tabstrip As TabStrip,Tag As Object,Position As Int)
- **GetTabTag**(tabstrip As TabStrip, position As Int) **As** **Object**
- **TabTop**(tabstrip As TabStrip,Top As Int,Position As Int)
- **TabWidth**(tabstrip As TabStrip,Width As Int,Position As Int)
- **TabVisible**(tabstrip As TabStrip,Visible As Boolean,Position As Int)
- **InsertPage** (tabstrip As TabStrip, Index As Int, Page As Panel, Title As String)
- **RemovePage** (tabstrip As TabStrip, Index As Int) **As** **Panel**
- **RefreshTabStrip**(tabstrip As TabStrip)
- **CenterAllTabs**(tabstrip As TabStrip, tabstripwidth As Int)

  
Example for the implementation:  
  

```B4X
Sub Process_Globals  
    
    Dim tse As TabStripViewPagerExtendet  
    
End Sub  
  
Sub Globals  
    
    Private TabStrip1 As TabStrip  
    
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("frm_main")  
  
    tse.Initialize 'to Initialize the class  
  
    TabStrip1.LoadLayout("frm_1","1")  
    TabStrip1.LoadLayout("frm_2","2")  
    TabStrip1.LoadLayout("frm_3","3")  
    TabStrip1.LoadLayout("frm_4","4")  
    TabStrip1.LoadLayout("frm_5","5")  
  
    TabStrip1.ScrollTo(0,False)  
  
    tse.UnderlineColor(TabStrip1,Colors.Red) 'change the color of the underline by runtime  
  
End Sub
```

  
  
I am available for any questions  
Greetings