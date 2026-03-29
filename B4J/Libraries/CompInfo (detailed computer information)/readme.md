### CompInfo (detailed computer information) by jmon
### 03/27/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170692/)

Hi,  
  
While reading [this post](https://www.b4x.com/android/forum/threads/win32-release-window-control-clipboard-services-power-processes-system-info.170394/) by [USER=21400]@Peter Simpson[/USER] , I realized that I was still using a *very old* (!) Autoit function to retrieve my computer informations: [CompInfo by JSThePatriot](https://www.autoitscript.com/forum/topic/29404-computer-info-udfs/)  
  
Until now, I was executing this AutoIt function and returning to result as Json to parse in B4J. So I have converted it to B4J using Gemini as a base and developed further on it.  
  
The class contains about 30 methods that give very detailed information about your computer (or a remote computer). To use it locally just use "" as the computer name, or to execute it remotely you can give the computer name or ip address.  
  
**Libraries used:**  
Json, jShell  
  
**Note about remote execution:**  
For the remote execution to work across a network, the following conditions must be met:  
1. Network/Domain: Both computers generally need To be on the same network, And ideally on the same Active Directory Domain.  
2. Permissions: The Windows account running your B4J app must have Administrator or WMI-access privileges on the target remote computer.  
3. WinRM Enabled: The target computer must have Windows Remote Management (WinRM) And PowerShell remoting enabled  
 (usually done by running **Enable-PSRemoting -Force** in an admin PowerShell prompt on the target PC).  
4. Firewall: The target PC's firewall must allow incoming WMI and WinRM traffic.  
  
> ⚠️ !! Enabling WinRM increase security risks !! Read about it before doing it. ⚠️

  
**Note about the Types:**  
Each function returns a list of specific Types (all starting with "CompInfo\_") so that it's easy to retrieve the information. Each Type also contains a "AsMap" method in case you need to store the raw data in a DB for example. There is an example code snippet for each method.  
  
**Note about Video Controllers:**  
Since the function is based on WMI Win\_32, it can't display more than 4 GB of ram for the GPU, so I added another function called "ComputerGetGPUInfo"  
  
**Note about bytes:**  
A lot of methods return the data as bytes, so I added a method to convert the bytes to human readable string:  

```B4X
Log(ci.FormatBytes(GPU2.VRAMBytes))
```

  
  
**Note:**  
Since it's using WMI and Powershell, it's Windows ONLY!  
  
I included both the compiled library and the source code, as well as an example B4J project.  
  

```B4X
Dim ci As CompInfo  
ci.Initialize("")  
  
For Each App As CompInfo_InstalledSoftware In ci.ComputerGetInstalledSoftwares  
    Log("DisplayName: " & App.DisplayName)  
    Log("DisplayVersion: " & App.DisplayVersion)  
    Log("Publisher: " & App.Publisher)  
    Log("UninstallString: " & App.UninstallString)  
Next
```