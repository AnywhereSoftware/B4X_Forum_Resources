### [Web][SithasoDaisy] The eye opening truth about the FlatPickr Date / Time Picker by Mashiane
### 03/21/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/160009/)

Hi Fam  
  
Key: Let's keep it simple.  
  
**NB: If you choose to use a display format, the date picker INTERNALLY creates 2 inputs, one for the actual value and one for the display value. This is done by using your existing input and then creating another one. This newly created input gets to copy the "class" attribute details to the new one created.**   
  
*Side Note: This second input has been rather challenging in some use cases and we have hopefully cleared these issues. If you experience any issues please send us word.*  
  
**DATA: For this example, the data used for dates has been CAPTURED and STORED in this format.**  
  

```B4X
"dob":"1999-04-20", "tob":"20:04", "dod":"2004-04-20", "doo":"2004-04-20 10:04"
```

  
  
**1. Using the date time picker on the Table.**  
  
You can add this as a date picker, a time picker, a date time picker etc. This will allow you to select a date, time, or both time and time.  
  
![](https://www.b4x.com/android/forum/attachments/151961)  
  
In the example above, we have activated the "display" format for both Date of Birth and Date of Death. How?  
  
This is done by activating the Display/Alt Format of the date.  
  
This is how these columns are created.  
  

```B4X
tb4.AddColumnDatePicker("dob", "Date of Birth", False, "Y-m-d", "F j, Y", False, False, False)  
    tb4.AddColumnTimePicker("tob", "Time of Birth", False, "H:i", True)  
    tb4.AddColumnDatePicker1("dod", "Date of Death", False, "Y-m-d", "d/m/Y", False, False, False, "it")
```

  
  
**Date of Birth**  
  

```B4X
tb4.AddColumnDatePicker("dob", "Date of Birth", False, "Y-m-d", "F j, Y", False, False, False)
```

  
  
The **INTERNAL** date format is 1999-04-20 i.e. Y-m-d, this is what will be stored in the database.  
The **DISPLAY** date format is F j, Y - displaying the date as April 20, 1999  
  
In your records and database, the date SHOULD BE STORED as YYYY-MM-DD, i.e. 1999-04-20 for example. When you enter the date on the input field, you should enter it as YYYY-MM-DD format also.  
  
![](https://www.b4x.com/android/forum/attachments/151962)  
  
**Time of Birth**  
  

```B4X
tb4.AddColumnTimePicker("tob", "Time of Birth", False, "H:i", True)
```

  
  
The **INTERNAL** time format is 20:04 i.e. H:i, this is what will be stored in the database.  
The **DISPLAY** time format is H;I - displaying the date as April 20:04, times have been hard coded to follow this format.  
  
In your records and database, the time SHOULD BE STORED as HH:mm, i.e. 20:04 for example. When you enter the time on the input field, you should enter it as HH:mm format also.  
  
![](https://www.b4x.com/android/forum/attachments/151963)  
  
**Date of Death**  
  

```B4X
  tb4.AddColumnDatePicker1("dod", "Date of Death", False, "Y-m-d", "d/m/Y", False, False, False, "it")
```

  
  
The **INTERNAL** date format is 1999-04-20 i.e. Y-m-d, this is what will be stored in the database.  
The **DISPLAY** date format is d/m/Y - displaying the date as 20/04/2004  
  
This also has a locale of "it", changing the calendar to use that locale.  
  
In your records and database, the date SHOULD BE STORED as YYYY-MM-DD, i.e. 2004-04-20 for example. When you enter the date on the input field, you should enter it as YYYY-MM-DD format also.  
  
![](https://www.b4x.com/android/forum/attachments/151964)  
  
**Date Time Picker**  
  
To use a date time picker, your INTERNAL format should be "Y-m-d H:i" and your output format can be anything you want. For more formats, see this [link](https://flatpickr.js.org/formatting/).  
  
Let's add another column to demonstrate this which will also use the "es" locale  
  

```B4X
tb4.AddColumnDateTimePicker1("doo", "Date of Opening", False, "Y-m-d H:i", "d/m/Y H:i", False, False, False, "es")
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/151965)  
![](https://www.b4x.com/android/forum/attachments/151978)  
  
  
  
**2. Using a different INTERNAL date time format.**  
  
Let's assume that you decided to swap these around  
  
from  
  

```B4X
tb4.AddColumnDatePicker("dob", "Date of Birth", False, "Y-m-d", "F j, Y", False, False, False)
```

  
  
to  
  

```B4X
tb4.AddColumnDatePicker("dob", "Date of Birth", False, "F j, Y",  "Y-m-d", False, False, False)
```

  
  
This means that the INTERNAL date format will now be, "April 20, 1999", meaning that when you enter your dates and save them in the database, you need to type in "April 20, 1999" and not "1999-04-20" like before. Your DISPLAY date will be 1999-04-20 though in this case.  
  
Remember, its easy to sort dates stored in YYYY-MM-DD / "Y-m-d" (FlatPickr format) when stored as strings.  
  
For more examples see the demo app, Tables - Code > Table 5  
  
NB: If you dont want the date to be displayed in a different output format, you can leave the Display / AltFormat blank.  
  
If the date format is not specified, it will take a format of YYYY-MM-DD HH:MM, and will assume your data follows that structure.  
  
**3. Using the Date Time Picker on Forms.  
  
Date Time Picker Via Code**  
  

```B4X
txtFlickDate7 = page.Cell(8, 1).AddDateTimePicker1("flatpickdate7", "Flat Pick Date Locale", "", "", "", True, "Y-m-d H:i", "none", True, "F j, Y H:i", False, False, "es")
```

  
  
![](https://www.b4x.com/android/forum/attachments/151979)  
  
For more examples see the demo app, Form Controls - Code > FlatPicker Date  
  
One can also "refresh" the datepicker for those added by code, e.g.  
  

```B4X
txtFlickDate = page.Cell(2, 1).AddFlatPickDateTime("flatpickdate1", "Flat Pick Date", "", "", "", False)  
txtFlickDate.Size = txtFlickTime.SizeSM  
txtFlickDate.Color = app.COLOR_PRIMARY  
txtFlickDate.RefreshDateTimePicker
```

  
  
This ensures that its formatted to suit the provided parameters.  
  
**Date Time Picker via the Abstract Designer**  
  
For more examples see the demo app, Form Controls - Designer > AD DatePicker  
  
![](https://www.b4x.com/android/forum/attachments/151980)  
  
In the abstract designer, these are the properties that have been set including the locale settings.  
  
![](https://www.b4x.com/android/forum/attachments/151982)