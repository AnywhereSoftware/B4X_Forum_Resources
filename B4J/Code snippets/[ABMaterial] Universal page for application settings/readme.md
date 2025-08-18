### [ABMaterial] Universal page for application settings. by MichalK73
### 06/12/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/131563/)

Hello.  
  
I would like to introduce the Settings module that I wrote and use for most of my client applications. The module is ready to be connected to your ABMaterial application and very easy to use.  
In the main directory of the application (or wherever you want) create a configuration file. I have config.txt. Text file because it can be easily edited from the server console or any notebook. Based on this file, a page with our application settings is generated with full support for changing parameters.  
Available types of variables: **text, number, email, password, data, combo,checkbox**.  
  
The structure of the config  
  
> ## Server parameters <-Name of the settings group  
> #Service name;text <- Description of the text (;text) type setting  
> APPNAME = set <-variable name and saved value  
> #Server adress; text  
> SERVERNAME = localhost  
> #Port http; int <-Description of the variable visible to the user of the number type (; int)  
> PORT = 80  
> #Port SSL; int  
> PORTSSL = 443  
> #Should the server use SSL; bool <-type checkbox  
> SSL = 0  
>   
> #Color;combo (red, blue, green) <-Combo use  
> TITLECOLOR=red

  
These are the ones I use for the first time in my applications. We need 2 declarations in Main.  
  
  

```B4X
    Public config As Map  
    Public FileConfig As String = "config.txt"
```

  
  
and reading variables from a file in AppStart  

```B4X
    If File.Exists(File.DirApp, FileConfig) Then  
        config= File.ReadMap(File.DirApp, FileConfig)  
    Else  
        Log("config file not found")  
        ExitApplication2(1)  
    End If
```

  
  
Calling the variables from any other page is done, for example  
  

```B4X
    theme.Label("red").ForeColor=ABM.COLOR_RED  
    theme.AddLabelTheme("blue")  
    theme.Label("blue").ForeColor=ABM.COLOR_BLUE  
    theme.AddLabelTheme("green")  
    theme.Label("green").ForeColor=ABM.COLOR_GREEN  
    Dim title As ABMLabel  
    title.Initialize(page, "title", Main.config.Get("TITLETEXT"), Main.config.Get("TITLESIZE"),True,Main.config.Get("TITLECOLOR"))  
     
    page.Cell(2,1).AddComponent(title)  
     
    Dim labssl As ABMLabel  
    labssl.Initialize(page, "ssl", "",ABM.SIZE_H3,False,"")  
    If Main.config.Get("SSL") = "1" Then  
        labssl.Text = "Use HTTPS on the server"  
    Else  
        labssl.Text = "Use only HTTP on the server"  
    End If  
    page.Cell(3,1).AddComponent(labssl)  
     
    Dim calendar As ABMCalendar  
    calendar.Initialize(page, "cal", Main.config.Get("DATA"), ABM.FIRSTDAYOFWEEK_MONDAY,"en",ABM.CALENDAR_DEFAULTVIEW_MONTH,"")  
    page.Cell(4,1).AddComponent(calendar)
```

  
  
Includes a complete demo of using the settings page with the module source.  
Maybe someone will find it useful, it makes it easier in many cases.  
  
![](https://www.b4x.com/android/forum/attachments/114833)