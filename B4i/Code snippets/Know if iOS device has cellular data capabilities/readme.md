### Know if iOS device has cellular data capabilities by Filippo
### 01/19/2025
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/165162/)

Hi,  
  
I was looking for such a function for my apps and found it at [stackoverflow](https://stackoverflow.com/questions/7101206/know-if-ios-device-has-cellular-data-capabilities).  
  

```B4X
Public Sub HasCellular As Boolean  
    Dim no As NativeObject = Me  
    Return no.RunMethod("hasCellular", Null).AsBoolean  
End Sub  
  
#If ObjC  
#import <ifaddrs.h>  
- (bool) hasCellular {  
    struct ifaddrs * addrs;  
    const struct ifaddrs * cursor;  
    bool found = false;  
    if (getifaddrs(&addrs) == 0) {  
        cursor = addrs;  
        while (cursor != NULL) {  
            NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];  
            if ([name isEqualToString:@"pdp_ip0"]) {  
                found = true;  
                break;  
            }  
            cursor = cursor->ifa_next;  
        }  
        freeifaddrs(addrs);  
    }  
    return found;  
}  
#End If
```