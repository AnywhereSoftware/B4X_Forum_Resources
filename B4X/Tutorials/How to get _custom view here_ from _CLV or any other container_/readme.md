###  How to get <custom view here> from <CLV or any other container> by Erel
### 09/10/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/117992/)

This is a common question and for a good reason.  
  
Custom views classes are not views by themselves.  
The views tree only holds views.  
This means that this code **cannot** work:  

```B4X
Dim B4XFloatTextField1 As B4XFloatTextField = CLV.GetPanel(x).GetView(y)
```

  
The actual view that is added to the views tree, with most custom views, is the "base" panel, usually named mBase.  
  
To solve this problem the following convention is used in all XUI Views and is recommended for all new custom views:  
The class instance is set to the base panel Tag property.  
This allows developers to get the class instance using the base panel Tag property:  

```B4X
'Will work  
Dim B4XFloatTextField1 As B4XFloatTextField = CLV.GetPanel(x).GetView(y).Tag
```

  
Another convention is to add a Tag property to the class and set it like this:  

```B4X
Sub Class_Globals  
    Private mEventName As String 'ignore  
    Private mCallBack As Object 'ignore  
    Public mBase As B4XView 'ignore  
    Private xui As XUI 'ignore  
    Public Tag As Object '<—  
End Sub  
  
Public Sub DesignerCreateView (Base As Object, lbl As Label, Props As Map)  
    mBase = Base  
    Tag = mBase.Tag '<– store the designer set tag value  
    mBase.Tag = Me '<– set the class reference discussed above
```

  
Developers can use the class Tag field to store their additional data.  
  
As these conventions are rather new, they are not used by some popular custom views such as xCLV. You can set the base panel tag yourself in such cases. For example:  

```B4X
Activity.LoadLayout("1")  
clv.AsView.Tag = clv  
'now we can get the clv with:  
Dim c As CustomListView = Activity.GetView(<clv index>).Tag
```