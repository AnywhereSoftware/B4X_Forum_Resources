###  SNTP class by Erel
### 01/30/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/86088/)

This class sends a request to a SNTP server (time server) and finds the offset between the local clock and the remote clock.  
  
Usage example:  

```B4X
SntpClient.Initialize 'global variable. Put in Starter service in B4A  
Wait For(SntpClient.UpdateOffsets) Complete (Result As Boolean)  
If Result Then  
   Log("Time updated successfully.")  
   Log($"$Time{SntpClient.Now}"$)  
End If
```

  
  
You only need to calculate the offsets once. Once calculated you can call Sntp.Now to get the current time.  
  
This class will work in B4A, B4J and B4i.  
  
Depends on: Network and RandomAccessFile.  
  
It is based on Android source code - Apache license 2.0.