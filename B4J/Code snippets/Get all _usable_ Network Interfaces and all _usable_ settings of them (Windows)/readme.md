### Get all "usable" Network Interfaces and all "usable" settings of them (Windows) by Magma
### 06/02/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/140943/)

Another one "usable" routine, for those want to have more control at their network…  
  
Get all "usable" Network Interfaces and all "usable" settings of them (Windows)…  
copy - paste at your module:  

```B4X
Sub Class_Globals  
    Type netinterface(Index As String,macaddress As String,Name As String,NetConnectionID As String,DefaultIPGateway As String,DHCPEnabled As String,ipaddress As String,IPSubnet As String)  
…  
…  
  
Sub readinterfaces As ResumableSub  
      
    Dim js As Shell  
    Dim params As List  
    Dim netcards As List  
    Dim netcards2 As List  
    Dim nnetcards As List  
    netcards.Initialize  
    netcards2.Initialize  
    nnetcards.Initialize  
    params.Initialize  
      
    params.Add("nic")  
    params.Add("where")      
    params.Add("netenabled=true")  
    params.Add("get")      
    params.Add("Index,MACAddress,Name,NetConnectionID")  
    params.Add("/format:csv")  
    js.Initialize("js", "wmic.exe", params)  
    js.WorkingDirectory="c:\windows\system32"  
    'If Main.ShellEncoding.Length>0 Then js.Encoding=Main.ShellEncoding  
    js.Run(-1)           
    Wait for (js) js_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success=True Then  
        Dim netcards As List=Regex.Split(Chr(13) & Chr(10),StdOut)  
        For k=2 To netcards.Size-1  
            Dim ls As List=Regex.Split(",",netcards.Get(k))  
            Dim atype As netinterface  
            atype.Index=ls.Get(1)  
            atype.macaddress=ls.Get(2)  
            atype.Name=ls.Get(3)  
            atype.NetConnectionID=ls.Get(4).As(String).Replace(Chr(13),"")  
            nnetcards.Add(atype)  
        Next  
    End If  
     
    params.clear  
    params.Add("nicconfig")  
    params.Add("where")  
    params.Add(QUOTE & "IPEnabled  = True" & QUOTE)  
    params.Add("get")  
    params.Add("DefaultIPGateway,DHCPEnabled,IPAddress,Index,IPSubnet,MacAddress")  
    params.Add("/format:csv")  
    js.Initialize("js", "wmic.exe", params)  
    'If Main.ShellEncoding.Length>0 Then js.Encoding=Main.ShellEncoding  
    js.WorkingDirectory="c:\windows\system32"  
    js.Run(-1)  
    Wait for (js) js_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)  
    If Success=True Then  
        Dim netcards2 As List=Regex.Split(Chr(13) & Chr(10),StdOut)  
        For k=2 To netcards2.Size-1  
        Dim ls1 As List=Regex.Split(",",netcards2.Get(k))  
        Log(netcards2.Get(k))  
        Dim atype As netinterface  
        atype.Index=ls1.Get(3)  
        atype.DefaultIPGateway=ls1.Get(1).As(String).Replace("{","").Replace("}","")  
        atype.DHCPEnabled=ls1.Get(2)  
        atype.ipaddress=getfirstvalue(ls1.Get(4).As(String))  
        atype.IPSubnet=getfirstvalue(ls1.Get(5).As(String))  
          
            For x=0 To nnetcards.Size-1  
                Dim btype As netinterface=nnetcards.Get(x)  
                If btype.Index=atype.Index Then  
                    btype.ipaddress=atype.ipaddress  
                    btype.DefaultIPGateway=atype.DefaultIPGateway  
                    btype.DHCPEnabled=atype.DHCPEnabled  
                    btype.ipsubnet=atype.IPSubnet  
                    nnetcards.Set(x,btype)                  
                End If  
            Next  
        Next  
    End If  
      
    Return nnetcards  
End Sub  
  
Sub getfirstvalue(a As String) As String  
    Dim b As String=a.Replace("{","").Replace("}","")  
    Dim c As List=Regex.Split(";",b)  
    Return c.get(0).As(String).trim  
End Sub
```

  
  
Use it, like here:  

```B4X
    Wait for (readinterfaces) complete (netcards As List)  
      
    For k=0 To netcards.Size-1  
        Dim atype As netinterface=netcards.Get(k)  
        Log(atype.ipaddress)  
'        Log(atype.IPSubnet)  
'        Log(atype.DefaultIPGateway)  
'        Log(atype.macaddress)  
'        Log(atype.DHCPEnabled)  
'        Log(atype.NetConnectionID)  
'        Log(atype.Name)  
'        Log("———-")  
    Next
```

  
  
…More coming…