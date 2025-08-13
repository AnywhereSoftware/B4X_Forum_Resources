### DateTimePicker UPDATE 2023 by Guenter Becker
### 11/16/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/138816/)

Version: 3 NEW UPDATE 11/2023  
This is a B4A Class. It opens a Time-, Date- or DateTime-Picker Dialog based on the B4XPreferencesDialog.  
  
![](https://www.b4x.com/android/forum/attachments/147789)![](https://www.b4x.com/android/forum/attachments/147790)![](https://www.b4x.com/android/forum/attachments/147791)![](https://www.b4x.com/android/forum/attachments/147792)  
**Features:**  

- Individual or Default Parameter Setup for Dialog Colors and Item Text.
- All 3 Dialog types in one class.
- Returned Result is in B4X Ticks.

  
**Installation**:   
Copy the TD\_DateTimePicker Class in your Projekt.  
Copy the Files .json Files to the Files Folder of your Project.  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
      
    Private TD_DateTimePicker1 As TD_DateTimePicker  
    Private TDDateTimePicker1Parameter As Map  
End Sub  
  
Public Sub Initialize  
    TDDateTimePicker1Parameter.initialize  
End Sub
```

  
  

```B4X
Sub SetupDialog(UseDefault As Boolean)     
    TDDateTimePicker1Parameter.clear  
    If UseDefault=False Then  
        ' Setup of Individual Dialog TDDateTimePicker1  
        ' TDDateTimePicker1Parameter listetd below are an example and similar to the default TDDateTimePicker1 Parameters  
        TDDateTimePicker1Parameter.Put("DLGWidth",75%x)  
        TDDateTimePicker1Parameter.Put("DLGHeight",50%x)  
        TDDateTimePicker1Parameter.Put("Theme","THEME_LIGHT")  
        TDDateTimePicker1Parameter.Put("InfoTitle","Help")  
        TDDateTimePicker1Parameter.Put("InfoDateDLG","Click on Date to open Calendar.")  
        TDDateTimePicker1Parameter.Put("InfoTimeDLG","Time in 24h format.")  
        TDDateTimePicker1Parameter.Put("InfoDateTimeDLG","Click on Date to open Calendar. Time in 24h format.")  
        TDDateTimePicker1Parameter.Put("TitleBarColor",Colors.blue)  
        TDDateTimePicker1Parameter.Put("TitleBarHeight",50dip)  
        TDDateTimePicker1Parameter.Put("TitleTextColor",Colors.White)  
        TDDateTimePicker1Parameter.Put("Top", 100dip)  
        TDDateTimePicker1Parameter.Put("BackgroundColor",Colors.White)  
        TDDateTimePicker1Parameter.Put("BodyTextColor",Colors.White)  
        TDDateTimePicker1Parameter.Put("BorderColor",Colors.Black)  
        TDDateTimePicker1Parameter.Put("BorderWidth", 2dip)  
        TDDateTimePicker1Parameter.Put("BorderCornerRadius",5dip)  
        TDDateTimePicker1Parameter.put("ItemDate", "Date:")  
        TDDateTimePicker1Parameter.put("ItemTimeHour", "Hour:")  
        TDDateTimePicker1Parameter.put("ItemTimeMinute", "Minute:")  
        TDDateTimePicker1Parameter.put("ItemTimeSecond", "Second:")  
        TDDateTimePicker1Parameter.Put("btOKString", "OK")  
        TDDateTimePicker1Parameter.Put("btOKWidth",20dip)  
        TDDateTimePicker1Parameter.Put("btOKLeft",50dip)  
        TDDateTimePicker1Parameter.Put("btOKColor", Colors.Blue)  
        TDDateTimePicker1Parameter.Put("btOKTextColor", Colors.White)  
        TDDateTimePicker1Parameter.Put("btCancelString", "Cancel")  
        TDDateTimePicker1Parameter.Put("btCancelWidth",20dip)  
        TDDateTimePicker1Parameter.Put("btCancelLeft",40dip)  
        TDDateTimePicker1Parameter.Put("btCancelColor", Colors.Blue)  
        TDDateTimePicker1Parameter.Put("btCancelTextColor", Colors.White)  
    Else  
        TDDateTimePicker1Parameter.Clear  
    End If  
    TD_DateTimePicker1.DLGParam = TDDateTimePicker1Parameter
```

  
  

```B4X
Sub btDateTime_Click  
    ' Setupb Basic Dialog TDDateTimePicker1Parametereter  
    SetupDialog(True)  
    ' Setup SecificDialog TDDateTimePicker1Parametereter  
    ' YOu must use this parameter!  
    ' DLType: Date Time DateTime (case sensitive)  
    TDDateTimePicker1Parameter.Put("DLGTitle", "Select a Date")  
    TDDateTimePicker1Parameter.Put("DLGType", "DateTime")  
    ' Initialize and configure the Dialog  
    ' ID, the root object of this page  
    ' PageName, the Name of this Page  
    ' Eventname, The Sub-Name of the resuklt event  
    ' Parameter, Map with individual Parameter  
    ' Initialize(ID As B4XView,PageName As String,Eventname As String,DLGTDDateTimePicker1Parametereter As Map)  
    TD_DateTimePicker1.Initialize(Root,"mainpage","TD_DateTimePicker1",TDDateTimePicker1Parameter)  
    ' Show DTPicker  
    TD_DateTimePicker1.showDialog  
End Sub
```

  
  

```B4X
Sub TD_DateTimePicker1_Result(result As Long)  
    Log(result)  
End Sub
```