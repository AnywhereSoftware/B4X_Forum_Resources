### Check if an IP Address is Private or Public by max123
### 01/29/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/144370/)

Hi all,  
  
this code check if an IP Addess is inside a private Local network, or Public otherwise.  
  
I use it to restrict socket access to only local network on a safety situation where I control remotely with my app a 3D printer, CNC or Laser machines.  
  
Here's the code:  

```B4X
' Check for Private network address  
Sub IsPrivateIpAddress(ipStr As String) As Boolean  
  
    Dim m As Matcher = Regex.Matcher("^(\d+)\.(\d+)\.(\d+)\.(\d+)$", ipStr)  
    If m.Find = False Then  
        Log("INVALID IP ADDRESS")  
        Return False  
    End If  
  
    Select m.Group(1)  
        Case 10  
            If Not(inRange(m.Group(2), 0, 255)) Or Not(inRange(m.Group(3), 0, 255)) Or Not(inRange(m.Group(4), 0, 255)) Then Return False  
            Return True  ' Class A: 10.0.0.0 to 10.255.255.255.  
        Case 172  
            If Not(inRange(m.Group(2), 16, 31)) Or Not(inRange(m.Group(3), 0, 255)) Or Not(inRange(m.Group(4), 0, 255)) Then Return False  
            Return True   ' Class B: 172.16.0.0 to 172.31.255.255.  
        Case 192  
            If m.Group(2) <> 168 Or Not(inRange(m.Group(3), 0, 255)) Or Not(inRange(m.Group(4), 0, 255)) Then Return False  
            Return True   ' Class C: 192.168.0.0 to 192.168.255.255.  
        Case Else  
            Return False  
    End Select  
End Sub  
  
Sub inRange(num As Int, n1 As Int, n2 As Int) As Boolean  
    Return num >= n1 And num <= n2  
End Sub
```

  
  
This code should work on B4A, B4J, (I don't know B4i) and can be adapted to B4R.  
  
Please if you see something wrong or you think it can be improved, feel free to post here your best solution.  
  
I use it this way:  

```B4X
Sub btnRemoteConnect_Click  
   
    If ServSock.GetMyWifiIP = "127.0.0.1" Then  
        MsgboxAsync("This device is not connected with network. Please connect and try again.", " A T T E N T I O N")  
'       Wait For MsgBox_Result (result As Int)  
        Return  
    End If  
   
    Dim ip As String = txtIPAddress.Text.Trim  
   
    If Settings.CNCType = Settings.TYPE_CNC_ROUTER Or Settings.CNCType = Settings.TYPE_CNC_LASER Then  
        If Not(IsPrivateIpAddress(ip)) Then  
            MsgboxAsync("FOR SAFETY REASONS, LASER and CNC Machines should only be controlled inside a Local Network" & CRLF & _  
                        "and inside a same room where you remotely control it. This is not true for 3D printers.", " A T T E N T I O N")  
'           Wait For MsgBox_Result (result As Int)  
            Return  
        End If  
    End If  
   
    …………………….  
    …………………….  
    …………………….
```