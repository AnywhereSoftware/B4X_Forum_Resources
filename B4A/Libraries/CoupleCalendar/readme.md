### CoupleCalendar by DonManfred
### 05/12/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/102209/)

This is a wrap for this [Github project](https://github.com/yuyakaido/CouplesCalendar).  
  
**CoupleCalendar**  
*<link>…|<https://www.b4x.com></link>*  
**Author:** yuyakaido (Github)/DonManfred (Wrapper)  
**Version:** 0.1  

- **CCEvent**

- **Functions:**

- **Initialize** (EventName As String)
- **IsInitialized** As Boolean
- **setDurationType**

- **Properties:**

- **DurationType** As com.yuyakaido.android.couplescalendar.model.DurationType [read only]
- **EndAt** As Long
- **EndAtDateTime** As Long [read only]
- **EventColor** As Int
- **EventDays** As java.util.List [read only]
- **EventType** As com.yuyakaido.android.couplescalendar.model.EventType
- **LinePosition** As com.yuyakaido.android.couplescalendar.model.LinePosition
- **RecurrenceRule** As String
- **StartAt** As java.util.Date

- **CouplesCalendarView**

- **Events:**

- **onDateClick** (date As Long)
- **onMonthChange** (date As Long)

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (base As Panel, lw As Label, props As Map)
- **Initialize** (EventName As String)
- **Invalidate**
- **Invalidate2** (arg0 As android.graphics.Rect)
- **Invalidate3** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **IsInitialized** As Boolean
- **RemoveView**
- **RequestFocus** As Boolean
- **SendToBack**
- **SetBackgroundImage** (arg0 As android.graphics.Bitmap) As BitmapDrawable
- **SetColorAnimated** (arg0 As Int, arg1 As Int, arg2 As Int)
- **SetLayout** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int)
- **SetLayoutAnimated** (arg0 As Int, arg1 As Int, arg2 As Int, arg3 As Int, arg4 As Int)
- **SetVisibleAnimated** (arg0 As Int, arg1 As Boolean)

- **Properties:**

- **Background** As android.graphics.drawable.Drawable
- **Color** As Int [write only]
- **Enabled** As Boolean
- **ETNormal** As com.yuyakaido.android.couplescalendar.model.EventType [read only]
- **ETRecurring** As com.yuyakaido.android.couplescalendar.model.EventType [read only]
- **ETTransient** As com.yuyakaido.android.couplescalendar.model.EventType [read only]
- **Events** As List [write only]
- **Height** As Int
- **Left** As Int
- **LinePositionLower** As com.yuyakaido.android.couplescalendar.model.LinePosition [read only]
- **LinePositionUpper** As com.yuyakaido.android.couplescalendar.model.LinePosition [read only]
- **Padding** As Int()
- **Parent** As Object [read only]
- **Tag** As Object
- **Theme** As com.yuyakaido.android.couplescalendar.model.Theme
- **ThemeBlue** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemeGREEN** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemeLIGHT\_BLUE** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemeNAVY\_BLUE** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemeORANGE** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemePINK** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemePURPLE** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemeRED** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemeTIFFANY\_BLUE** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **ThemeYELLOW** As com.yuyakaido.android.couplescalendar.model.Theme [read only]
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  

```B4X
    Dim evList As List  
    evList.Initialize  
  
    Dim event As CCEvent  
    event.Initialize("")  
    Dim startAt As Long = DateTime.DateTimeParse("01/12/2019","08:00:00")  
    Dim endAt As Long = DateTime.DateTimeParse("01/14/2019","08:30:00")  
    event.setDurationType  
    event.StartAt = startAt  
    event.EndAt = endAt  
    event.EventColor = Colors.Blue  
    event.LinePosition = ccv1.LinePositionUpper  
    evList.Add(event)  
  
    Dim event As CCEvent  
    event.Initialize("")  
    Dim startAt As Long = DateTime.DateTimeParse("02/01/2019","00:00:00")  
    Dim endAt As Long = DateTime.DateTimeParse("02/01/2019","23:59:59")  
    event.setDurationType  
    event.StartAt = startAt  
    event.EndAt = endAt  
    event.EventColor = Colors.Black  
    event.LinePosition = ccv1.LinePositionUpper  
    evList.Add(event)  
  
    Dim event As CCEvent  
    event.Initialize("")  
    Dim startAt As Long = DateTime.DateTimeParse("02/02/2019","00:00:00")  
    Dim endAt As Long = DateTime.DateTimeParse("02/02/2019","22:00:00")  
    event.setDurationType  
    event.StartAt = startAt  
    event.EndAt = endAt  
    event.EventColor = Colors.Magenta  
    event.LinePosition = ccv1.LinePositionUpper  
    evList.Add(event)  
  
    Dim event As CCEvent  
    event.Initialize("")  
    Dim startAt As Long = DateTime.DateTimeParse("02/18/2019","00:00:00")  
    Dim endAt As Long = DateTime.DateTimeParse("02/22/2019","00:00:00")  
    event.setDurationType  
    event.StartAt = startAt  
    event.EndAt = endAt  
    event.EventColor = Colors.Red  
    event.LinePosition = ccv1.LinePositionLower  
    evList.Add(event)  
  
    ccv1.Events = evList  
    ccv1.Theme = ccv1.ThemeGREEN
```

  
  
results in  
![](https://www.b4x.com/android/forum/attachments/77035)  
  
Notes:  
- To get it working with Android X you need to add  

```B4X
#AdditionalJar: androidx.legacy:legacy-support-v4
```

  
and use the res-Folder from the zip res.Couplescalendar-AndroidX.zip