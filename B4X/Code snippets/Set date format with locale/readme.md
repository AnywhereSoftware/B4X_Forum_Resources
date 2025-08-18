###  Set date format with locale by Erel
### 02/20/2022
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/138604/)

Cross platform code to change the date format with an explicit locale:  

```B4X
Private Sub SetDateFormat(Language As String, Country As String, format As String)  
    #if B4A or B4J  
    Dim locale As JavaObject  
    locale.InitializeNewInstance("java.util.Locale", Array(Language, Country))  
    Dim DateFormat As JavaObject  
    DateFormat.InitializeNewInstance("java.text.SimpleDateFormat", Array(format, locale))  
    Dim r As Reflector  
    r.Target = r.RunStaticMethod("anywheresoftware.b4a.keywords.DateTime", "getInst", Null, Null)  
    r.SetField2("dateFormat", DateFormat)  
    #else if B4i  
    Dim locale As NativeObject  
    locale = locale.Initialize("NSLocale").RunMethod("alloc", Null).RunMethod("initWithLocaleIdentifier:", Array(Language & "_" & Country))  
    DateTime.As(NativeObject).GetField("dateFormat").SetField("locale", locale)  
    DateTime.DateFormat = format  
    #End if  
End Sub
```

  
  
Depends on (j)Reflection in B4A and B4J.  
  
Usage example:  

```B4X
Private Sub Button1_Click  
    Dim format As String = "dd MMM, yyyy"  
    SetDateFormat("en", "US", format)  
    Log(DateTime.Date(DateTime.Now))  
    SetDateFormat("he", "IL", format)  
    Log(DateTime.Date(DateTime.Now))  
End Sub
```