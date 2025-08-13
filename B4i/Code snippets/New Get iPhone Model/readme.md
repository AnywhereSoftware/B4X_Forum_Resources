### New Get iPhone Model by Filippo
### 09/30/2022
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/143225/)

Enclosed is the updated list.  
I have added the iPad Mini 6 Wifi + Cellular.  
  
If someone has or knows a new device, then please write here, I will update the list.  
  

```B4X
Public Sub GetDeviceName As String  
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
@"arm64" :@"iPhone Simulator",  
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
@"iPhone11,6" :@"iPhone XS Max Global", //  
@"iPhone11,8" :@"iPhone XR", //  
@"iPhone12,1" :@"iPhone 11", //  
@"iPhone12,3" :@"iPhone 11 Pro", //  
@"iPhone12,5" :@"iPhone 11 Pro Max", //  
@"iPhone12,8" :@"iPhone SE (2nd generation)", //  
@"iPhone13,1" :@"iPhone 12 mini", //  
@"iPhone13,2" :@"iPhone 12", //  
@"iPhone13,3" :@"iPhone 12 Pro", //  
@"iPhone13,4" :@"iPhone 12 Pro Max", //  
@"iPhone14,2" :@"iPhone 13 Pro", //  
@"iPhone14,3" :@"iPhone 13 Pro Max", //  
@"iPhone14,4" :@"iPhone 13 Mini", //  
@"iPhone14,5" :@"iPhone 13", //  
@"iPhone14,6" :@"iPhone SE 3rd Gen", //  
@"iPhone14,7" :@"iPhone 14", //  
@"iPhone14,8" :@"iPhone 14 Plus", //  
@"iPhone15,2" :@"iPhone 14 Pro", //  
@"iPhone15,3" :@"iPhone 14 Pro Max", //  
  
@"iPad1,1" :@"iPad", // (Original)  
@"iPad1,2" :@"iPad 3G", //  
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
@"iPad7,5" :@"iPad 6th Gen (WiFi)", //  
@"iPad7,6" :@"iPad 6th Gen (WiFi+Cellular)", //  
@"iPad7,11" :@"iPad 7th Gen 10.2-inch (WiFi)", //  
@"iPad7,12" :@"iPad 7th Gen 10.2-inch (WiFi+Cellular)", //  
@"iPad8,1" :@"iPad Pro 11 inch 3rd Gen (WiFi)", //  
@"iPad8,2" :@"iPad Pro 11 inch 3rd Gen (1TB, WiFi)", //  
@"iPad8,3" :@"iPad Pro 11 inch 3rd Gen (WiFi+Cellular)", //  
@"iPad8,4" :@"iPad Pro 11 inch 3rd Gen (1TB, WiFi+Cellular)", //  
@"iPad8,5" :@"iPad Pro 12.9 inch 3rd Gen (WiFi)", //  
@"iPad8,6" :@"iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)", //  
@"iPad8,7" :@"iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)", //  
@"iPad8,8" :@"iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular)", //  
@"iPad8,9" :@"iPad Pro 11 inch 4th Gen (WiFi)", //  
@"iPad8,10" :@"iPad Pro 11 inch 4th Gen (WiFi+Cellular)", //  
@"iPad8,11" :@"iPad Pro 12.9 inch 4th Gen (WiFi)", //  
@"iPad8,12" :@"iPad Pro 12.9 inch 4th Gen (WiFi+Cellular)", //  
@"iPad11,1" :@"iPad mini 5th Gen (WiFi)", //  
@"iPad11,2" :@"iPad mini 5th Gen", //  
@"iPad11,3" :@"iPad Air 3rd Gen (WiFi)", //  
@"iPad11,4" :@"iPad Air 3rd Gen", //  
@"iPad11,6" :@"iPad 8th Gen (WiFi)", //  
@"iPad11,7" :@"iPad 8th Gen (WiFi+Cellular)", //  
@"iPad12,1" :@"iPad 9th Gen (WiFi)", //  
@"iPad12,2" :@"iPad 9th Gen (WiFi+Cellular)", //  
@"iPad14,1" :@"iPad mini 6th Gen (WiFi)", //  
@"iPad14,2" :@"iPad mini 6th Gen (WiFi+Cellular)", //  
@"iPad13,1" :@"iPad Air 4th Gen (WiFi)", //  
@"iPad13,2" :@"iPad Air 4th Gen (WiFi+Cellular)", //  
@"iPad13,4" :@"iPad Pro 11 inch 5th Gen", //  
@"iPad13,5" :@"iPad Pro 11 inch 5th Gen", //  
@"iPad13,6" :@"iPad Pro 11 inch 5th Gen", //  
@"iPad13,7" :@"iPad Pro 11 inch 5th Gen", //  
@"iPad13,8" :@"iPad Pro 12.9 inch 5th Gen", //  
@"iPad13,9" :@"iPad Pro 12.9 inch 5th Gen", //  
@"iPad13,10" :@"iPad Pro 12.9 inch 5th Gen", //  
@"iPad13,11" :@"iPad Pro 12.9 inch 5th Gen", //  
@"iPad13,16" :@"iPad Air 5th Gen (WiFi)", //  
@"iPad13,17" :@"iPad Air 5th Gen (WiFi+Cellular)", //  
  
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
@"Watch4,4" :@"Apple Watch Series 4 44mm case (GPS+Cellular)", // Apple Watch Series 4 44mm case (GPS+Cellular)  
@"Watch5,1" :@"Apple Watch Series 5 40mm case (GPS)", //  
@"Watch5,2" :@"Apple Watch Series 5 44mm case (GPS)", //  
@"Watch5,3" :@"Apple Watch Series 5 40mm case (GPS+Cellular)", //  
@"Watch5,4" :@"Apple Watch Series 5 44mm case (GPS+Cellular)", //  
@"Watch5,9" :@"Apple Watch SE 40mm case (GPS)", //  
@"Watch5,10" :@"Apple Watch SE 44mm case (GPS)", //  
@"Watch5,11" :@"Apple Watch SE 40mm case (GPS+Cellular)", //  
@"Watch5,12" :@"Apple Watch SE 44mm case (GPS+Cellular)", //  
@"Watch6,1" :@"Apple Watch Series 6 40mm case (GPS)", //  
@"Watch6,2" :@"Apple Watch Series 6 44mm case (GPS)", //  
@"Watch6,3" :@"Apple Watch Series 6 40mm case (GPS+Cellular)", //  
@"Watch6,4" :@"Apple Watch Series 6 44mm case (GPS+Cellular)", //  
@"Watch6,6" :@"Apple Watch Series 7 41mm case (GPS)", //  
@"Watch6,7" :@"Apple Watch Series 7 45mm case (GPS)", //  
@"Watch6,8" :@"Apple Watch Series 7 41mm case (GPS+Cellular)", //  
@"Watch6,9" :@"Apple Watch Series 7 45mm case (GPS+Cellular)", //  
@"Watch6,10" :@"Apple Watch SE 40mm case (GPS)", //  
@"Watch6,11" :@"Apple Watch SE 44mm case (GPS)", //  
@"Watch6,12" :@"Apple Watch SE 40mm case (GPS+Cellular)", //  
@"Watch6,13" :@"Apple Watch SE 44mm case (GPS+Cellular)", //  
@"Watch6,14" :@"Apple Watch Series 8 40mm case (GPS)", //  
@"Watch6,15" :@"Apple Watch Series 8 44mm case (GPS)", //  
@"Watch6,16" :@"Apple Watch Series 8 40mm case (GPS+Cellular)", //  
@"Watch6,17" :@"Apple Watch Series 8 44mm case (GPS+Cellular)", //  
@"Watch6,18" :@"Apple Watch Ultra" //  
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
```
```
```