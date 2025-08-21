### Resolve host to ip address (IPv4) by Erel
### 08/20/2025
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/168310/)

Add to B4XMainPage or any other module, at the end:  

```B4X
#if OBJC  
@end  
#include <netdb.h>  
#include <arpa/inet.h>  
#include <netinet/in.h>  
@interface AddressForHost : NSObject  
@end  
@implementation AddressForHost  
  
  
- (NSString *)ipv4AddressForHost:(NSString *)hostName {  
    struct addrinfo hints, *res = NULL;  
    memset(&hints, 0, sizeof(hints));  
    hints.ai_family = AF_INET;   
    hints.ai_socktype = SOCK_STREAM;  
  
    int err = getaddrinfo([hostName UTF8String], NULL, &hints, &res);  
    if (err != 0) {  
        NSLog(@"getaddrinfo error: %s", gai_strerror(err));  
        return nil;  
    }  
  
    char ip[INET_ADDRSTRLEN];  
    struct sockaddr_in *ipv4 = (struct sockaddr_in *)res->ai_addr;  
    inet_ntop(AF_INET, &(ipv4->sin_addr), ip, sizeof(ip));  
    freeaddrinfo(res);  
  
    return [NSString stringWithUTF8String:ip];  
}  
#End If
```

  
  
Usage example:  

```B4X
Private Sub Button1_Click  
    Dim no As NativeObject  
    no = no.Initialize("AddressForHost").RunMethod("new", Null)  
    Dim ip As String = no.RunMethod("ipv4AddressForHost:", Array("google.com")).AsString  
    Log(ip)  
End Sub
```