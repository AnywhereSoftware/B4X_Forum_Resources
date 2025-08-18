###  A solution for SQL Brute force Protection by Magma
### 06/24/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/104562/)

Hi there,  
  
I want to share a tactic / **a small guard for MySQL/MariaDB DataBases**..  
  
Well all we know that having a Database online and not in localhost is difficult to protect from brute force attacks / ransomware attacks…  
  
Well i ll give a little "pebble" to help others to think / different - but have in mind that **i personally believe that SQL must stay at localhost/127.0.0.1**.. or if it not possible through **VPN** at **local network logic**…  
  
My thought is that… let's say we have a MySQL database at port 3306 (better change that to something else)…  
  
When someone go to access a user with different username/password - then Application events have "Access Denied…" for MySQL… then will block IP to our PC…  
  
It's just simple and you can think more… uses windows applications events / but you can use system events or anything you want…  
  
My first thoughts was using more native commands but there is nothing in my meters.. so using some batch files and windows commands.. :)  
  
Old days i ve made at VB6 a firewall using packetX library / WinPcap… there is no big difference… at idea…  
  
**From libraries… using only jshell and wevutil (windows command/app), netsh (ipsec) command of windows (with some changes you can make it for linux/debian systems)…**  
  
The code:  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 300  
#End Region  
  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Public timer1 As Timer  
    Dim shl As Shell  
    Dim errsource As String  
    Dim errdate As String  
    Dim errdesc As String  
    Dim rulecount As Long  
    Private Label1 As Label  
    Private Label2 As Label  
End Sub  
  
Sub AppStart (form1 As Form,Args() As String)  
  
    DateTime.TimeFormat = "HH:mm:ss"  
    DateTime.DateFormat = "yyyy-MM-dd"  
    MainForm = form1  
    MainForm.RootPane.LoadLayout("a1") ' Or you layout  
  
    MainForm.Title="BB for MySQL/MariaDB" 'just want a name Block BruteForce…  
    MainForm.show  
  
  
    shl.Initialize("sh1","delpol.bat", Null)  
    shl.WorkingDirectory = File.DirApp  
    shl.Run(-1)  
  
  
    timer1.Initialize("timers1",1000)  
    timer1.Enabled=True  
  
  
End Sub  
  
Sub timers1_tick  
    timer1.Enabled=False  
    'Log("search for new events…")  
  
  
    shl.Initialize("sh1","apperr.bat", Null)  
    shl.WorkingDirectory = File.DirApp  
    shl.Run(-1)  
  
    Dim inp As InputStream  
    inp = File.OpenInput(File.DirApp,"apperr.txt")  
    Dim b As Int  
    Dim my_buf(inp.BytesAvailable) As Byte  
    b = inp.ReadBytes(my_buf,0,inp.BytesAvailable)  
    inp.Close  
    Dim data As String = BytesToString(my_buf,0,b,"cp1253") ' might be cp1253  
  
    Dim inp As InputStream  
    inp = File.OpenInput(File.DirApp,"apperr.bak")  
    Dim b As Int  
    Dim my_buf(inp.BytesAvailable) As Byte  
    b = inp.ReadBytes(my_buf,0,inp.BytesAvailable)  
    inp.Close  
    Dim data2 As String = BytesToString(my_buf,0,b,"cp1253") ' might be cp1253  
  
    If data<>data2 Then  
  
    errdate=data.SubString2(data.IndexOf("Date:")+5,data.IndexOf2(CRLF,data.IndexOf("Date:")+5)).trim  
    errsource=data.SubString2(data.IndexOf("Source:")+7,data.IndexOf2(CRLF,data.IndexOf("Source:")+7)).trim  
    errdesc=data.SubString(data.LastIndexOf("Description:")+12).trim  
  
  
    Log(errdate)  
    Log(errsource)  
    Log(errdesc)  
    If errsource="MySQL" Then  
    If errdesc.StartsWith("Access denied for user")=True Then  
        Dim checkip As String=errdesc.SubString2(errdesc.IndexOf("@'")+2 , errdesc.LastIndexOf("'"))  
        checkandblock(checkip.trim)  
    End If  
    End If  
  
  
    End If  
  
  
    timer1.Enabled=True  
  
End Sub  
  
Sub getip(ip As String) As String  
    shl.Initialize("sh1","ping1.bat",Array As String(ip))  
    shl.WorkingDirectory = File.DirApp  
    shl.Run(10000)  
    Dim newip As String=File.ReadString(File.DirApp,"ip.txt")  
    If newip.indexof("[")>1 Then  
        Return newip.SubString2(newip.indexof("[")+1,newip.indexof("]"))  
    Else  
        Return ip  
    End If  
End Sub  
  
Sub checkandblock(ip As String)  
  
    Dim whatip As String=getip(ip)  
  
  
    Dim stream As OutputStream = File.OpenOutput(File.dirapp,"accessdenied.log",True)  
    Dim LogString As String  
    LogString = DateTime.Date(DateTime.Now) & " | " & DateTime.time(DateTime.Now) &  " | " & whatip & " | " & errdesc.Replace(Chr(13)," ") & Chr(13) & Chr(10)  
    Dim Data() As Byte  
    Data = LogString.GetBytes("UTF8")  
    stream.WriteBytes(Data,0,Data.Length)  
    stream.Close  
  
    If IsNumber(whatip.Replace(".",""))=True Then  
            rulecount=rulecount+1  
            Label2.Text = rulecount 'You  can.. Remove if you want to be silent…  
            blockipsec(whatip.Trim,rulecount)  
    End If  
  
    whatip=Null  
    ip=Null  
  
End Sub  
  
Sub blockipsec(ip As String, rule As Int)  
  
    'MBB 1  
  
    Dim r As String  
    r=rule  
  
    ' use ipsec  
    shl.Initialize("sh1", "blockip.bat", Array As String(r.trim,ip.trim))  
    shl.WorkingDirectory = File.DirApp  
  
    shl.Run(10000)  
  
End Sub  
  
Sub shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success And ExitCode = 0 Then  
        Log("Success")  
        Log(StdOut)  
    Else  
        Log("Error: " & StdErr)  
    End If  
    ExitApplication 'here you can handle with different way if you want…  
End Sub  
  
'Return true to allow the default exceptions handler to handle the uncaught exception.  
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean  
    Return True  
End Sub
```

  
  
  
**here the blockip.bat**  

```B4X
netsh ipsec static add filter filterlist=MBB_%1 srcaddr=%2 dstaddr=Me  
netsh ipsec static add filteraction name=MBB_ACTIONFOR_%1 action=block  
netsh ipsec static add policy name=MBB_POL_1 assign=yes  
netsh ipsec static add rule name=MBB_%1 policy=MBB_POL_1 filterlist=MBB_%1  filteraction=MBB_ACTIONFOR_%1 activate=yes
```

  
  
**here the delpol.bat**  
don't forget to run this - will reset ipsec policy we've use…  

```B4X
netsh ipsec static delete policy name=MBB_POL_%1
```

  
  
**here the ping1.bat**  
at ping we' ve just pinging domain/ip to resolve ip address… :)  

```B4X
ping -n 1 %1 >ip.txt
```

  
  
**here the apperr.bat**  
at wevutil we ve just taking that last windows application error…  

```B4X
copy /y apperr.txt apperr.bak  
wevtutil qe Application /c:1 /f:Text /rd:true >apperr.txt
```

  
  
**And here a special tip - for those who want to unblock ips…  
delrule.bat**  

```B4X
netsh ipsec static delete rule name=MBB_%1 MBB_POL_1
```

  
  
**don't forget to run delpol.bat at the end of the Testing purposes… because you will block ip addresses forever :)  
  
ps: Every time - you rebooting your pc ipsec policy is alive… with delpol.bat - erasing your policy ! - Actually you can do that every 4-5 days if it is a server - pc's with ransomwares keep tries for 3 days… / some trying to 20days :-(**  
ps-2: For those don't want to use windows events and windows commands - they can open mysql/mariadb logs file… but there require to enable logs first…  
  
**in MBB.zip… in folder object… .bat (batch) files are already included!!!  
  
Don't Forget… You can donate me… the code is free to use it…  
  
[![](https://www.b4x.com/android/forum/proxy.php?image=https%3A%2F%2Fwww.paypalobjects.com%2Fen_US%2Fi%2Fbtn%2Fbtn_donate_SM.gif&hash=683b4605c0a712d6c2a44193301c6bd0)](https://www.paypal.com/donate/?hosted_button_id=AZPHUVAH99LZ8)**