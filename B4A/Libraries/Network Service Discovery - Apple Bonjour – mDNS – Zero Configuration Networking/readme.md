### Network Service Discovery - Apple Bonjour – mDNS – Zero Configuration Networking by Dylan Meng
### 12/30/2019
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/112597/)

Hi, I am designing an IoT device that required an auto-discovery service. I did not find any way to easily read a Bonjour Answer (mDNS - 224.0.0.251 [5353]).  
  
To fix my problem I decided to wrap the Network service discovery (NSD) from android. <https://developer.android.com/training/connect-devices-wirelessly/nsd>  
  
Library Code : <https://github.com/DylanMeng/B4A-LIB_NetworkServiceDiscovery>  
  
B4A Code:  

```B4X
Public Sub SearchForDevices  
      
    Dim nsd As NetworkServiceDiscovery  
    nsd.Initialize("nsd")  
    nsd.setService("SMART-D-LED", "_sdledV1._tcp.", 5353)  
    nsd.discoverServices()  
    'nsd.registerService() NOT TESTED  
      
End Sub  
  
'Resolve Listener  
Sub nsd_onResolveFailed(aErrorCode As Int)  
    Log("NetworkServiceDiscovery - Resolve failed - Error code:" & aErrorCode)  
End Sub  
  
Sub nsd_onServiceResolved(aService As String, aServiceName As String, aServiceHost As String, aServicePort As Int)  
    Log("NetworkServiceDiscovery - Resolve Succeeded")  
    Log("Smart D-LED device discovered at " & aServiceHost & ":" & aServicePort)  
End Sub  
  
'Registration Listener  
Sub nsd_onServiceRegistered(aServiceName As String)  
    Log("NetworkServiceDiscovery - Service registered: " & aServiceName)  
End Sub  
  
Sub nsd_onRegistrationFailed(aErrorCode As Int)  
    Log("NetworkServiceDiscovery - Service registration failed - Error code: " & aErrorCode)  
End Sub  
  
Sub nsd_onServiceUnregistered(aServiceName As String)  
    Log("NetworkServiceDiscovery - Service unregistered: " & aServiceName)  
End Sub  
  
Sub nsd_onUnregistrationFailed(aErrorCode As Int)  
    Log("NetworkServiceDiscovery - Service unregistration failed - Error code: " & aErrorCode)  
End Sub  
  
'Discovery Listener  
Sub nsd_onDiscoveryStarted(aRegType As String)  
    Log("NetworkServiceDiscovery - Service discovery started: " & aRegType)  
End Sub  
  
Sub nsd_onServiceFound(aService As String, aServiceName As String, aServiceType As String)  
    Log("NetworkServiceDiscovery - Service discovery success: " & aService)  
End Sub  
  
Sub nsd_onServiceLost(aService As String)  
    Log("NetworkServiceDiscovery - Service lost: " & aService)  
End Sub  
  
Sub nsd_onDiscoveryStopped(aServiceType As String)  
    Log("NetworkServiceDiscovery - Discovery stopped: " & aServiceType)  
End Sub  
  
Sub nsd_onStartDiscoveryFailed(aErrorCode As Int)  
    Log("NetworkServiceDiscovery - On start Discovery failed - Error code: " & aErrorCode)  
End Sub  
  
Sub nsd_onStopDiscoveryFailed(aErrorCode As Int)  
    Log("NetworkServiceDiscovery - On Stop Discovery failed - Error code:" & aErrorCode)  
End Sub
```

  
  
Resolve Succeeded - Example   
![](https://www.b4x.com/android/forum/attachments/86898)  
  
Change Log:  
  
V1.01 – To-Do  
  
V1.00 – Initial release (Experimental)  
  
  
Well, I hope this can help someone. Keep in mind that it’s the first time that I wrapped a Java library. More work will be needed to stabilize.