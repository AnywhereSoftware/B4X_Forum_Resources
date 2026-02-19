### WiFi info with NEHotspotNetwork by Yanik Freeman
### 02/15/2026
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/170332/)

CNCopyCurrentNetworkInfo is deprecated and will always return nil or an empty dictionary when an app is linked against the iOS 26 SDK (Xcode 26), even with the correct entitlements and permissions. This example uses the NEHotspotNetwork.fetchCurrent() method with callback instead and is backwards compatible to iOS 13+.  
  

```B4X
#Entitlement: <key>com.apple.developer.networking.wifi-info</key><true/>  
  
.  
.  
.  
  
Private Sub StartLocationUpdates  
    Dim no As NativeObject = Me  
      
    gstSSID = ""  
      
    Try  
        'if the user allowed us to use the location service or if we never asked the user before then we call LocationManager.Start.  
        If LocManager.IsAuthorized Or LocManager.AuthorizationStatus = LocManager.AUTHORIZATION_NOT_DETERMINED Then  
            LocManager.Start(0)  
            no.RunMethod("fetchWiFi:", Null)  
        End If  
    Catch  
    End Try  
End Sub  
  
Sub WiFi_Available (Success As Boolean, SSID As String, BSSID As String)  
    If Success Then  
        gstSSID = SSID  
        Log("Current SSID: " & gstSSID)  
    End If  
End Sub  
  
#If OBJC  
#import <NetworkExtension/NetworkExtension.h>  
  
- (void)fetchWiFi:(NSObject*)tag {  
    [NEHotspotNetwork fetchCurrentWithCompletionHandler:^(NEHotspotNetwork * _Nullable currentNetwork) {  
        if (currentNetwork != nil) {  
            // Signal strength is often 0 or unpopulated in this specific API  
            [self.bi raiseEvent:nil event:@"wifi_available:::" params:@[@YES, currentNetwork.SSID, currentNetwork.BSSID]];  
        } else {  
            [self.bi raiseEvent:nil event:@"wifi_available:::" params:@[@NO, @"", @""]];  
        }  
    }];  
}  
#End If
```