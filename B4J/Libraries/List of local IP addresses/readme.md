### List of local IP addresses by npsonic
### 01/13/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/112985/)

Didn't find class exactly like this, so here it is if someone needs it.  
Easy way to list all local IP addresses.  
  

```B4X
Dim localIP As LocalIP  
localIP.Initialize  
Dim ips As List = localIP.GetIP  
For Each ip As String In ips  
    Log(ip)  
Next  
ips.Clear
```