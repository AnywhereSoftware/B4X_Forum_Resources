### [Class]ClsWheel  Input wheels by klaus
### 11/04/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/24319/)

Attached you find a new CLASS ClsWheel.  
  
 It allows to display different data input screens with wheels.  
  
 What can be done ?  
 You can define nine different types of Wheel input screens:  

- DATE a date input : year / month / day
A default value can be defined or Now, the current date.
The returned value has the current DateFormat.- TIME\_HM a time input : hour / minute
A default value can be defined or Now, the current time.
The returned value has the current TimeFormat.- TIME\_HMS a time input : hour / minute / second
A default value can be defined or Now, the current time.
The returned value has the current TimeFormat.- DATE\_TIME a date + time input : year / month / day / hour / minute
A default value can be defined or Now, the current date and time.
The returned value has the current DateFormat and TimeFormat.- CUSTOM a custom input with user defined input values.
The number of side by side wheels is user defined (max. 5 wheels).
A default value can be defined.
A specific separation character can be defined, a blanc character is default.- INTEGER positive and negative integers
- INTEGER\_POS only positive integers
- NUMBER positive and negative numbers
- NUMBER\_POS only positive numbers

Main functions:  
 **Initialize** initializes the wheel class Note: the Initialize routine hasone more parameter cContinusScrolling As Boolean (since version 1.3) .  
Example :  
 [FONT=Courier New]whlDate.Initialize(Me, Activity, "Enter date", 3, Null, 24, 0, True)[/FONT]  
 Me = calling module, the current  
 Activity =  
 Enter date = title of the input  
 3 = number of wheels, this number is used only for CUSTOM input types  
 Null = no input data, set internally  
 24 = text size  
 0 = DATE input type  
True = continus scrolling  
  
 **Show** show the input wheel(s)  
 Example :  
 [FONT=Courier New]whlDate.Show(lblSelection, "11/22/2001")[/FONT]  
 lblSelection = Label which gets the result  
 11/22/2001 = Default value to preset the wheels  
  
**Show2** show the input wheel(s)  
 Example :  
 [FONT=Courier New]whlCustum.Show2("whlCustom", "")[/FONT]  
 "whlCustom" = EventName  
"" = no default value  
The event is called 'Closed'.  
The event routine in the calling module, for the example, must be  
[FONT=Courier New]Sub whlCustom\_Closed(Canceled As Boolean, Selection As String)[/FONT]  
  
 The width and height are defined by the program according to the font size.  
  
 If the width or the height exceed the screen width or height the font size is downscaled.  
  
 You can change most of the colors.  
  
Needs the [Reflection library](http://www.b4x.com/forum/additional-libraries-classes-official-updates/6767-reflection-library-8.html#post39256).  
  
 Bug reports and suggestions are welcome.  
  
 I hope that the code is enough self explanatory, but if you want more explanations I can add them.  
 Anyway the best way to know what can be done is to test it.  
  
PS. There is no logic in the custom input screen just to demonstrate the possibility.  
  
 Best regards.  
  
  
EDIT: 2020.11.25 Version 2.7  
Amended warning in line 946: Comparison of Object to other types will fail if exact types do not match.  
EDIT: 2015.04.29 Version 2.0  
Added a Tag property  
  
EDIT: 2017.06.27 Version 2.6  
Replaced DoEvents by Sleep(0)  
Needs B4A version 7.00+  
  
EDIT: 2017.03.30 Version 2.5  
Amended the wish expressed [HERE](https://www.b4x.com/android/forum/threads/clswheel-problem-mit-minus-zeichen.77823/#post-493399)  
Different font sizes for title and wheels.  
With long titles, the font size of both, title and wheels, was reduced.  
Now only the title font size is reduced.  
  
EDIT: 2017.03.28 Version 2.4  
Amended the error reported [HERE](https://www.b4x.com/android/forum/threads/clswheel-problem-mit-minus-zeichen.77823/#post-493237)  
Problem with +/- in number wheels  
  
EDIT: 2015.09.22 Version 2.3  
Amended the error reported in post #185  
  
EDIT: 2015.05.10 Version 2.2  
Amended the variable declaration problem reported in post #175  
  
EDIT: 2015.05.10 Version 2.1  
Amended the timer problem reported in post #170  
  
EDIT: 2014.09.09 Version 1.9  
Added number wheels INTEGER, INTEGER\_POS, NUMBER, NUMBER\_POS wheels  
Amended day scroll problem reported in [post #141](http://www.b4x.com/android/forum/threads/class-clswheel-input-wheels.24319/page-8#post-271841)  
  
EDIT: 2014.04.21 Version 1.7  
Amended OutOfMemory problem reported [HERE](http://www.b4x.com/android/forum/threads/out-of-memory-error.40122/#post-239344).  
  
EDIT: 2013.09.15 Version 1.6  
Added min MinYear and NumberOfYears properties to adapt the years to select  
  
EDIT: 2013.08.08 Version 1.5  
Added StartScroll and EdnScroll events  
  
EDIT: 2013.06.14 Version 1.4  
Modified OK event to Closed event post#37  
Amended screen color problem post#36  
Amendet getSeparationText error post #41  
  
EDIT: 2013.06.12 Version 1.3  
Mofied property routines.  
Added Show2 for raising an event when clicking the OK button  
Added optional continus scrolling  
  
EDIT: 2013.05.28 Version 1.2  
Amended the bug reported in post #32  
  
EDIT: 2012.12.15 Version 1.1  
Amended the reported bugs.