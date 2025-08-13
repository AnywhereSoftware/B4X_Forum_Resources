###  Find all reachable ips in the local network by Erel
### 03/12/2025
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/166100/)

Slightly based on: <https://stackoverflow.com/questions/16035636/how-to-get-all-ip-address-of-systems-connected-to-same-wi-fi-network-in-android/21091575#21091575>  
Compatible with B4A and B4J.  
  
Manifest editor (B4A only):  

```B4X
AddPermission(android.permission.ACCESS_WIFI_STATE)  
AddPermission(android.permission.INTERNET)
```

  
  
Depends on (j)Network library.  
Code:  

```B4X
Private Sub ScanNetwork  
    Dim server As ServerSocket 'ignore  
    Dim MyIp As String = server.GetMyIP  
    If MyIp = "127.0.0.1" Then  
        Log("Not connected to network.")  
        Return  
    End If  
    Dim InetAddress As JavaObject  
    InetAddress.InitializeStatic("java.net.InetAddress")  
    Dim host As JavaObject = InetAddress.RunMethod("getByName", Array(MyIp))  
    Dim ip() As Byte = host.RunMethod("getAddress", Null)  
    Dim jME As JavaObject = Me  
    For i = 1 To 254  
        ip(3) = i  
        Dim address As JavaObject = InetAddress.RunMethod("getByAddress", Array(ip))  
        jME.RunMethod("checkAddress", Array(address, 300, False)) 'change to true to try and resolve host names. It will be a bit slower.  
    Next  
    For i = 1 To 254  
        Wait For Address_Checked (HostAddress As String, Reachable As Boolean, HostName As String)  
        If Reachable Then  
            Log(HostAddress & ", " & HostName)  
        End If  
    Next  
    Log("done")  
End Sub  
  
  
#if Java  
public void checkAddress(java.net.InetAddress address, int timeout, boolean getHostName) {  
    final String hostAddress = address.getHostAddress();  
    BA.runAsync(getBA(), null, "address_checked", new Object[] {false, hostAddress, ""}, new java.util.concurrent.Callable<Object[]>() {  
        public java.lang.Object[] call() throws Exception {  
                if (address.isReachable(timeout))  
                    return new Object[] {hostAddress, true, getHostName ? address.getHostName() : ""};  
                else  
                    return new Object[] {hostAddress, false, ""};  
            }  
            }  
      
    );  
}  
#End If
```

  
  
This should be called from a class, such as B4XMainPage.  
It runs pretty fast. Takes maybe 3 seconds to scan the network here (and it doesn't block the main thread).