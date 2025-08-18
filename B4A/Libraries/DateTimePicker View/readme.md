### DateTimePicker View by jtare
### 07/18/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/118156/)

DateTimePicker view is based on the CustomListView and snapCLV with a design similar to the ios datetime picker. This view has only been tested in B4A, it is not very useful in B4i since for ios the built-in picker is better.  
  
  
![](https://www.b4x.com/android/forum/attachments/94622) ![](https://www.b4x.com/android/forum/attachments/116584) ![](https://www.b4x.com/android/forum/attachments/116590)  
  
1. Add the module and layout to your project (attached files). You should not modify this layout, it is for internal use only.  
Download de layout file depending on the platform you want to use, .bal for B4A. For B4i and B4j download the zip file with the corresponding name.  
2. Add the DateTimePicker custom view to your own layout in the designer.  
3. Set the min,max dates and it is ready to use.  
  
Remember to add the CustomListView and XUI library to your project.  
  
Example:  

```B4X
Sub Globals  
    Private DateTimePicker1 As DateTimePicker  
End Sub  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("1") 'Layout with the datetimepicker custom view  
  
    ToastMessageShow("Click the activity",True)  
    DateTimePicker1.SetMinDate(DateTime.Now-DateTime.TicksPerDay*15)  
    DateTimePicker1.SetMaxDate(DateTime.Now+DateTime.TicksPerDay*15)  
    DateTimePicker1.SetSelectedValue(DateTime.Now)  
    DateTimePicker1.Show  
End Sub  
Sub Activity_Click  
    If DateTimePicker1.Selected > 0 Then  
        Log($"$DateTime{DateTimePicker1.Selected}"$)  
        ToastMessageShow($"$DateTime{DateTimePicker1.Selected}"$,True)  
    End If  
End Sub
```

  
  
**UPDATE:   
Version 1.4**  
-Added "fade away" effect  
-Return the date as long value or a list of the selected values, each as a string  
-Fixed an issue that didn't draw the lines in B4j  
  
Version 1.3  
-Probably Multiplatform. Download de layout file depending on the platform you want to use, .bal for B4A. For B4i and B4j download the zip file with the corresponding name.  
-Fixed an issue that may prevent some cases to compile.  
  
Version 1.2  
-Fixed an issue that returned datetime = -1  
-Now you can set the text color, line color and background color  
-Other minor details