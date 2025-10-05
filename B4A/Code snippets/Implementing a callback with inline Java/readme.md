### Implementing a callback with inline Java by Erel
### 10/03/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/168878/)

This is a template that you can use when implementing a callback with inline Java, whether it is an interface or abstract class, inside a B4A/B4J class, such as B4XMainPage.  
  

```B4X
#if Java  
public static class MyNetworkCallback extends android.net.ConnectivityManager.NetworkCallback {  
    private final BA ba;  
    public MyNetworkCallback(B4AClass me) {  
        this.ba = me.getBA();  
    }  
    @Override  
        public void onAvailable(android.net.Network network) {  
            super.onAvailable(network);  
            ba.raiseEvent(this, "network_state", true, network);  
        }  
        @Override  
        public void onUnavailable() {  
            super.onUnavailable();  
            ba.raiseEvent(this, "network_state", false, null);  
        }  
}  
#End If
```

  
  
1. public static class …  
  
2. The constructor expects a B4AClass. This is the B4X class instance. It gets the "ba" object from this instance, which makes it simple to raise events.  
  
3. Implement code. Use ba.raiseEvent or raiseEventFromUI. Remember that the event name must be lowercase and should include an underscore (to avoid obfuscation issues). If not sure then use ba.raiseEventFromUI.  
  
4. Create a callback instance with JavaObject  

```B4X
Dim callback As JavaObject  
callback.InitializeNewInstance(GetType(Me) & "$MyNetworkCallback", Array(Me)) '$ + class name. And pass Me to the constructor
```

  
  
5. Optional step - use Wait For to wait for the event:  

```B4X
 Wait For Network_State (Available As Boolean, Network As Object)
```