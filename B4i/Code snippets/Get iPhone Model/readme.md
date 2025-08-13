### Get iPhone Model by Emme Developer
### 09/30/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/80077/)

Updated code: <https://www.b4x.com/android/forum/threads/new-get-iphone-model.143225/>  
  
Based on [this](https://www.b4x.com/android/forum/threads/is-there-a-way-to-read-the-device-model-number.69602/#post-441675) answer from [USER=1]@Erel[/USER]  

```B4X
Sub GetDeviceModelName As String  
    Dim no As NativeObject = Me  
    Return no.RunMethod("deviceName", Null).AsString  
End Sub  
  
#if OBJC  
#import <sys/utsname.h>  
- (NSString*) deviceName  
{  
struct utsname systemInfo;  
  
uname(&systemInfo);  
  
NSString* code = [NSString stringWithCString:systemInfo.machine  
encoding:NSUTF8StringEncoding];  
  
static NSDictionary* deviceNamesByCode = nil;  
  
if (!deviceNamesByCode) {  
  
deviceNamesByCode = @{@"i386" :@"Simulator",  
@"x86_64" :@"Simulator",  
@"iPod1,1" :@"iPod Touch", // (Original)  
@"iPod2,1" :@"iPod Touch", // (Second Generation)  
@"iPod3,1" :@"iPod Touch", // (Third Generation)  
@"iPod4,1" :@"iPod Touch", // (Fourth Generation)  
@"iPod7,1" :@"iPod Touch", // (6th Generation)  
@"iPhone1,1" :@"iPhone", // (Original)  
@"iPhone1,2" :@"iPhone", // (3G)  
@"iPhone2,1" :@"iPhone", // (3GS)  
@"iPhone3,1" :@"iPhone 4", // (GSM)  
@"iPhone3,3" :@"iPhone 4", // (CDMA/Verizon/Sprint)  
@"iPhone4,1" :@"iPhone 4S", //  
@"iPhone5,1" :@"iPhone 5", // (model A1428, AT&T/Canada)  
@"iPhone5,2" :@"iPhone 5", // (model A1429, everything else)  
@"iPhone5,3" :@"iPhone 5c", // (model A1456, A1532 | GSM)  
@"iPhone5,4" :@"iPhone 5c", // (model A1507, A1516, A1526 (China), A1529 | Global)  
@"iPhone6,1" :@"iPhone 5s", // (model A1433, A1533 | GSM)  
@"iPhone6,2" :@"iPhone 5s", // (model A1457, A1518, A1528 (China), A1530 | Global)  
@"iPhone7,1" :@"iPhone 6 Plus", //  
@"iPhone7,2" :@"iPhone 6", //  
@"iPhone8,1" :@"iPhone 6S", //  
@"iPhone8,2" :@"iPhone 6S Plus", //  
@"iPhone8,4" :@"iPhone SE", //  
@"iPhone9,1" :@"iPhone 7 (CDMA)", //  
@"iPhone9,3" :@"iPhone 7 (GSM)", //  
@"iPhone9,2" :@"iPhone 7 Plus (CDMA)", //  
@"iPhone9,4" :@"iPhone 7 Plus (GSM)", //  
@"iPhone10,1" :@"iPhone 8 (CDMA)", //  
@"iPhone10,4" :@"iPhone 8 (GSM)", //  
@"iPhone10,2" :@"iPhone 8 Plus (CDMA)", //  
@"iPhone10,5" :@"iPhone 8 Plus (GSM)", //  
@"iPhone10,3" :@"iPhone X (CDMA)", //  
@"iPhone10,6" :@"iPhone X (GSM)", //  
@"iPhone11,2" :@"iPhone XS", //  
@"iPhone11,4" :@"iPhone XS Max", //  
@"iPhone11,6" :@"iPhone XS Max China", //  
@"iPhone11,8" :@"iPhone XR", //  
@"iPhone12,8" :@"iPhone SE (2nd generation)", //  
@"iPhone13,1" :@"iPhone 12 mini", //  
@"iPhone13,2" :@"iPhone 12", //  
@"iPhone13,3" :@"iPhone 12 Pro", //  
@"iPhone13,4" :@"iPhone 12 Pro Max", //  
  
@"iPad1,1" :@"iPad", // (Original)  
@"iPad2,1" :@"iPad 2 Wifi", // (model A1395)  
@"iPad2,2" :@"iPad 2 GSM", // (model A1396)  
@"iPad2,3" :@"iPad 2 3G", // (model A1397)  
@"iPad2,4" :@"iPad 2 Wifi", //(model A1395)  
@"iPad2,5" :@"iPad Mini Wifi ", // (model A1432)  
@"iPad2,6" :@"iPad Mini Wifi + Cellular", // (model A1454)  
@"iPad2,7" :@"iPad Mini Wifi + Cellular", // (model A1455)  
@"iPad3,1" :@"iPad 3", // (3rd Generation)  
@"iPad3,2" :@"iPad 3 Wifi + Cellular", // (model A1403)  
@"iPad3,3" :@"iPad 3 Wifi + Cellular", // (model A1430)  
@"iPad3,4" :@"iPad 4 Wifi ", // (model A1458)  
@"iPad3,5" :@"iPad 4 Wifi + Cellular", // (model A1459)  
@"iPad3,6" :@"iPad 4 Wifi + Cellular", // (model A1460)  
@"iPad4,1" :@"iPad Air Wifi", // 5th Generation iPad (iPad Air) - Wifi (model A1474)  
@"iPad4,2" :@"iPad Air Wifi + Cellular", // (model A1475)  
@"iPad4,3" :@"iPad Air Wifi + Cellular", // (model A1476)  
@"iPad4,4" :@"iPad Mini 2 Wifi", // (2nd Generation iPad Mini - Wifi)  
@"iPad4,5" :@"iPad Mini 2 Wifi + Cellular", // (2nd Generation iPad Mini - Cellular) (model A1490)  
@"iPad4,6" :@"iPad Mini 2 Wifi + Cellular", // (2nd Generation iPad Mini - Cellular) (model A1491)  
@"iPad4,7" :@"iPad Mini 3 Wifi", // 3rd Generation iPad Mini - Wifi (model A1599)  
@"iPad4,8" :@"iPad Mini 3 Wifi + Cellular", // 3rd Generation iPad Mini - Wifi + Cellular (model A1600)  
@"iPad4,9" :@"iPad Mini 3 Wifi + Cellular", // 3rd Generation iPad Mini - Wifi + Cellular (model A1601)  
@"iPad5,1" :@"iPad Mini 4 Wifi", // 4th Generation iPad Mini - Wifi (model A1538)  
@"iPad5,2" :@"iPad Mini 4 Wifi + Cellular", // 4th Generation iPad Mini - Wifi + Cellular (model A1550)  
@"iPad5,3" :@"iPad Air 2 Wifi", // 2nd Generation iPad Air - Wifi (model A1566)  
@"iPad5,4" :@"iPad Air 2 Wifi + Cellular ", // 4th Generation iPad Mini - Wifi + Cellular (model A1567)  
@"iPad6,3" :@"iPad Pro (9.7\")", // iPad Pro 9.7 inches - (model A1673)  
@"iPad6,4" :@"iPad Pro (9.7\")", // iPad Pro 9.7 inches - (models A1674 and A1675)  
@"iPad6,7" :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)  
@"iPad6,8" :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)  
@"iPad6,11" :@"iPad 5 Wifi", // iPad (5th Generation) - (model A1822)  
@"iPad6,12" :@"iPad 5 Wifi + Cellular", // iPad (5th Generation) - (model A1823)  
@"iPad7,1" :@"iPad Pro 2 (12.9\") Wifi", // iPad Pro (12.9") 2nd Generation - (model A1670)  
@"iPad7,2" :@"iPad Pro 2 (12.9\") Wifi + Cellular", // iPad Pro (12.9") 2nd Generation - (model A1671 - model A1821)  
@"iPad7,3" :@"iPad Pro (10.5\") Wifi", // iPad (5th Generation) - (model A1701)  
@"iPad7,4" :@"iPad Pro (10.5\") Wifi + Cellular", // iPad (5th Generation) - (model A1709)  
@"Watch1,1" :@"Apple Watch 38mm", // Apple Watch 38mm case  
@"Watch1,2" :@"Apple Watch 38mm", // Apple Watch 38mm case  
@"Watch2,3" :@"Apple Watch Series 2 38mm", // Apple Watch Series 2 38mm case  
@"Watch2,4" :@"Apple Watch Series 2 42mm", // Apple Watch Series 2 42mm case  
@"Watch2,6" :@"Apple Watch Series 1 38mm", // Apple Watch Series 1 38mm case  
@"Watch2,7" :@"Apple Watch Series 1 42mm", // Apple Watch Series 1 42mm case  
@"Watch3,1" :@"Apple Watch Series 3 38mm (GPS+Cellular)", // Apple Watch Series 3 38mm case (GPS+Cellular)  
@"Watch3,2" :@"Apple Watch Series 3 42mm (GPS+Cellular)", // Apple Watch Series 3 42mm case (GPS+Cellular)  
@"Watch3,3" :@"Apple Watch Series 3 38mm (GPS)", // Apple Watch Series 3 38mm case (GPS)  
@"Watch3,4" :@"Apple Watch Series 3 42mm (GPS)", // Apple Watch Series 3 42mm case (GPS)  
@"Watch4,1" :@"Apple Watch Series 4 40mm (GPS)", // Apple Watch Series 4 40mm case (GPS)  
@"Watch4,2" :@"Apple Watch Series 4 44mm (GPS)", // Apple Watch Series 4 44mm case (GPS)  
@"Watch4,3" :@"Apple Watch Series 4 40mm (GPS+Cellular)", // Apple Watch Series 4 40mm case (GPS+Cellular)  
@"Watch4,4" :@"Apple Watch Series 4 44mm case (GPS+Cellular)" // Apple Watch Series 4 44mm case (GPS+Cellular)  
};  
}  
  
NSString* deviceName = [deviceNamesByCode objectForKey:code];  
  
if (!deviceName) {  
// Not found on database. At least guess main device type from string contents:  
  
if (

```B4X
.location != NSNotFound) {  
deviceName = @"iPod Touch";  
}  
else if(

```B4X
.location != NSNotFound) {  
deviceName = @"iPad";  
}  
else if(

```B4X
.location != NSNotFound){  
deviceName = @"iPhone";  
}  
else {  
deviceName = @"Unknown";  
}  
}  
  
return deviceName;  
}  
#end if
```

  
  
Last update:  iPhone 12, SE 2nd generation
```
```
```