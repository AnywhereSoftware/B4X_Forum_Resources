### NHEnvironentVariables - Get a map with all environment variables of all platforms - As of 20250124 by hatzisn
### 01/24/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/158264/)

**(20250124)** - Added the same functionality for all platforms. Now you can do the same for Windows and mac.  
  
With this library you can get a map with all environment variables of a Linux Distribution all platforms (Windows, Linux, Mac). The keys of the map are the enviroment variable names and the values of the map the corresponding values of the environment variables. The code does not break in Windows and MacOS but it returns an empty map. Usage:  
  

```B4X
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Private env As EnvironmentVariables  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
   
    env.Initialize  
    Dim m As Map = env.GetTheEnvironmentVariables  
    Log(m)  
   
    'HOME = Some environment variable  
    Log(m.Get("HOME"))  
    Log(GetEnvironmentVariable("HOME", Null))  
End Sub
```