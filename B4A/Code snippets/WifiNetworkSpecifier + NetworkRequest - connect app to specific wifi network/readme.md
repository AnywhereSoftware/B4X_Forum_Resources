### WifiNetworkSpecifier + NetworkRequest - connect app to specific wifi network by Erel
### 10/05/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168860/)

Requires Android 10+ (api level 29+).  
  
Allows your app to connect to a specific network, provided by its SSID and password. Note that this makes a local connection, which means that only your app will use this network.  
The user will need to approve the connection on the first time.  
  
Manifest editor:  

```B4X
AddPermission("android.permission.CHANGE_NETWORK_STATE")
```

  
  
Code (in a class module such as B4XMainPage):  
  

```B4X
Private Sub ConnectToNetwork (SSID As String, Password As String, TimeoutMs As Int) As ResumableSub  
    Dim builder As JavaObject  
    builder.InitializeNewInstance("android.net.wifi.WifiNetworkSpecifier.Builder", Null)  
    builder.RunMethod("setSsid", Array(SSID))  
    builder.RunMethod("setWpa2Passphrase", Array(Password))  
    Dim specifier As JavaObject = builder.RunMethod("build", Null)  
    Dim RequestBuilder As JavaObject  
    RequestBuilder.InitializeNewInstance("android.net.NetworkRequest.Builder", Null)  
    RequestBuilder.RunMethod("addTransportType", Array(1)) 'TRANSPORT_WIFI  
    RequestBuilder.RunMethod("setNetworkSpecifier", Array(specifier))  
    Dim NetworkRequest As JavaObject = RequestBuilder.RunMethod("build", Null)  
    Dim context As JavaObject  
    context.InitializeContext  
    Dim cm As JavaObject = context.RunMethod("getSystemService", Array("connectivity"))  
    Dim callback As JavaObject  
    callback.InitializeNewInstance(GetType(Me) & "$MyNetworkCallback", Array(Me))  
    cm.RunMethod("requestNetwork", Array(NetworkRequest, callback, TimeoutMs))  
    Wait For Network_State (Available As Boolean, Network As Object)  
    Log("Available? " & Available)  
      
    If Available Then  
        cm.RunMethod("bindProcessToNetwork", Array(Network))  
    End If  
    Return Available  
End Sub  
  
#if Java  
public static class MyNetworkCallback extends android.net.ConnectivityManager.NetworkCallback {  
    private final BA ba;  
    public MyNetworkCallback(B4AClass me) {  
        this.ba = me.getBA();  
    }  
    @Override  
        public void onAvailable(android.net.Network network) {  
            super.onAvailable(network);  
            BA.Log("Network available: " + network);  
            ba.raiseEvent(this, "network_state", true, network);  
        }  
        @Override  
        public void onUnavailable() {  
            super.onUnavailable();  
            BA.Log("Network onUnavailable");  
            ba.raiseEvent(this, "network_state", false, null);  
        }  
}  
#End If
```

  
  
Usage:  

```B4X
Wait For (ConnectToNetwork("ssid here", "and password")) Complete (Success As Boolean)  
'Try to make the request even if Success is False. It might still work.  
    Dim job As HttpJob  
    job.Initialize("", Me)  
    job.Download("https://www.google.com")  
    Wait For (job) JobDone(job As HttpJob)  
    If job.Success Then  
       Log(job.GetString)  
    End If  
    job.Release
```