### Connect to wifi network programmatically - NEHotspotConfigurationManager by Erel
### 01/04/2026
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/169946/)

Allows connecting to a wifi network programmatically. Note that the user will need to approve the connection if it is new.  
Note that error handling of this API is broken and there is no straightforward method to identify whether connection was successful or not.,  
  
Step 1: Add the Hotspot capability to the app identifier in Apple developer console. Revoke the old provision profile and download a new one.  
  
Step 2: Add to main module:  

```B4X
#Entitlement:  <key>com.apple.developer.networking.HotspotConfiguration</key><true/>
```

  
  
Step 3:  

```B4X
Private Sub ConnectToWifi (SSID As String, Password As String)  
    Me.As(NativeObject).RunMethod("connectToWifi:::", Array(SSID, Password, False))  
    Wait For Connection_State (MaybeSuccess As Boolean)  
    Log("Connection_State: " & MaybeSuccess)  
    If MaybeSuccess = False Then  
         Log(LastException)  
    Else  
        'Maybe there is a connection now. Make a network call to test it.  
    End If  
End Sub  
  
  
#if OBJC  
#import <NetworkExtension/NetworkExtension.h>  
- (void)connectToWifi: (NSString*)ssid :(NSString*)password :(BOOL)joinOnce {  
  
    NEHotspotConfiguration *config =  
        [[NEHotspotConfiguration alloc] initWithSSID:ssid  
                                           passphrase:password  
                                                 isWEP:NO];  
  
    config.joinOnce = joinOnce;  
  
    [[NEHotspotConfigurationManager sharedManager]  
     applyConfiguration:config  
     completionHandler:^(NSError * _Nullable error) {  
  
        if (error)  
            [B4I shared].lastError = error;  
        [self.bi raiseUIEvent:nil event:@"connection_state:" params:@[@(error == nil)]];  
    }];  
}  
#End If
```