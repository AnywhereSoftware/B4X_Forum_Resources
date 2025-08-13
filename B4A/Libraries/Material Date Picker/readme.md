### Material Date Picker by intellvold
### 10/10/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/139559/)

[HEADING=1][SIZE=6]Material Date - Time Picker Dialog[/SIZE][/HEADING]  
[HEADING=1]**Updated :)**[/HEADING]  
  
**This Library wrape for [this github](https://github.com/wdullaer/MaterialDateTimePicker)   
  
work on B4a v11  
  
SetMinDate  
SetMaxDate  
CancelColor  
CancelText  
OkColor  
OkText  
Title  
DarkMode  
On Cancel  
OnDateset  
2 layout Mode  
Added Dismiss\_Dialog  
  
  
Events :   
  
\_OnCancelDate()  
\_OnDateSet()  
\_OnCancelTime ()  
\_OnTimeSet()**  
  
  
Added this line in activity:  

```B4X
#Extends : android.support.v4.app.FragmentActivity
```

  
  
  

```B4X
Sub Globals  
   Dim Datepicker As Intellvold_DatePicker  
   Dim Mycalendar As Intellvold_Calendar  
   Dim Timepicker As Intellvold_TimePicker  
End Sub  
  
  
Sub Activity_Create(FirstTime As Boolean)  
Activity.LoadLayout("Layout")  
End Sub  
  
Sub Button1_Click  
    Datepicker.Initialize("Date",2022 ,DateTime.GetMonth(DateTime.Now) ,DateTime.GetDayOfMonth(DateTime.Now))  
    Mycalendar.Initialize("dd.mm.yyyy",Mycalendar.PRC,"2.02.1990") 'start date  
'   Datepicker.SetThemeDark  
    Datepicker.SetMinDate(Mycalendar)  
    Mycalendar.Initialize("dd.mm.yyyy",Mycalendar.PRC,"2.02.2030") 'end date  
    Datepicker.SetMaxDate(Mycalendar)  
    Datepicker.CancelColor = Colors.Red  
    Datepicker.OkColor = Colors.Green  
    Datepicker.Title = "IntellVold"  
    Datepicker.CancelText = "yox"  
    Datepicker.OkText = "bəli"  
'   Datepicker.SetThemeDark  
    Datepicker.SetOnCancel("can")  
'   Datepicker.show("bir")  
    Datepicker.show2("iki")  
    Datepicker.About  
    Sleep(10000)  
'   Datepicker.Dismiss_Dialog  
End Sub  
  
  
Sub Date_OnDateSet (year As Int ,monthOfYear As Int , dayOfMonth As Int)  
    ToastMessageShow(year&"/"&(NumberFormat(monthOfYear,2 ,0))&"/"&NumberFormat(dayOfMonth ,2 ,0) ,False)  
    Msgbox(year&"/"&(NumberFormat(monthOfYear,2 ,0))&"/"&NumberFormat(dayOfMonth ,2 ,0) ,"")  
End Sub  
  
Sub can_OnCancelDate ()  
    ToastMessageShow("cancel" ,False)  
End Sub  
  
Private Sub Button2_Click  
    Timepicker.Initialize("Time" ,21 ,45 ,True)  
    Timepicker.CancelColor = Colors.Red  
    Timepicker.CancelText = "yox"  
    Timepicker.OkColor = Colors.Yellow  
    Timepicker.OkText = "bəli"  
    Timepicker.SetOnCancel("Time")  
'   Timepicker.SetThemeDark  
    Timepicker.show("bir")  
    Timepicker.Title = "TimeIntellvold"  
    Sleep(4000)  
'   Timepicker.Dismiss_Dialog  
End Sub  
  
Sub Time_OnCancelTime ()  
    Log("Time_OnCancelTime")  
End Sub  
  
Sub Time_OnTimeSet (hourOfDay As Int ,minute As Int , second As Int)  
    ToastMessageShow(hourOfDay&":"&minute&":"&second ,False)  
    Msgbox(hourOfDay&":"&minute&":"&second ,"")  
End Sub
```

  
  
  
  
**Set custom theme color—> colorAccent in manifest for change time picker color.**  
  

```B4X
SetApplicationAttribute(android:theme, "@style/MyAppTheme")  
CreateResource(values, theme.xml,  
<resources>  
    <style name="MyAppTheme" parent="Theme.AppCompat.Light.NoActionBar">  
   
   
   
   
 <item name="colorAccent">#040925</item>  
        <item name="windowNoTitle">true</item>  
        <item name="windowActionBar">false</item>  
        <item name="android:navigationBarColor">#FF000000</item>  
   
   
   
    </style>  
</resources>  
)
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/134611)![](https://www.b4x.com/android/forum/attachments/134612)  
  
  
  
  
![](http://intellvold.com/api/FilesMe/date2.gif)![](http://intellvold.com/api/FilesMe/time2.gif)