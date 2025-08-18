###  - AH_CheckInternet - Check network status (Library) by alirezahassan
### 05/23/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/130875/)

Hi all,  
With this library you will have the following possibility.  
  
**Currently version v1.5 (2021/05/23)**  
  
1️. Check the status of the airplane mode  
2. Check internet connection status  
3. Check the roaming status of the device  
4. Check VPN connection status  
5. Check Data State status  
6. Get the name of the mobile operator  
7. Get the type of mobile data connection  
8. Get Sim Operator  
9. Get the type of internet connection (WiFi, mobile data)  
10. Get IP Address IPv4  
11. Get IP Address IPv6  
12. Get Get mac address  
13. Check is IPv4 or IPv6  
14. Get Ping Host  
15. Get Ping  
16. Get Ping Log  
17. Get Ping States  
18. More features coming soon …  
  

```B4X
    Dim AH_CheckInternet As AH_CheckInternet  
    Label1.Text = $"  
    **(V1.0)**  
    Check_AirplaneMode: ${AH_CheckInternet.Check_AirplaneMode}  
    Check_NetworkConnection: ${AH_CheckInternet.Check_NetworkConnection}  
    Check_NetworkRoaming: ${AH_CheckInternet.Check_NetworkRoaming}  
    Check_Vpn: ${AH_CheckInternet.Check_Vpn}  
    Get_DataState: ${AH_CheckInternet.Get_DataState}  
    Get_NetworkOperatorName: ${AH_CheckInternet.Get_NetworkOperatorName}  
    Get_NetworkType: ${AH_CheckInternet.Get_NetworkType}  
    Get_SimOperator: ${AH_CheckInternet.Get_SimOperator}  
    Get_WifiOrDataMobile: ${AH_CheckInternet.Get_WifiOrDataMobile}  
  
    **(V1.5)**  
    Get_IPAddress (IPv4): ${AH_CheckInternet.Get_IPAddress(True)}  
    Get_IPAddress (IPv6): ${AH_CheckInternet.Get_IPAddress(False)}  
    Get_MACAddress wlan0: ${AH_CheckInternet.Get_MACAddress("wlan0")}  
    Get_MACAddress eth0: ${AH_CheckInternet.Get_MACAddress("eth0")}  
    Check_IPv4orIPv6 (FE80::D433:A7FF:FEE8:5CCC): ${AH_CheckInternet.Check_IPv4orIPv6("FE80::D433:A7FF:FEE8:5CCC")}  
    Check_IPv4orIPv4 (192.168.1.1): ${AH_CheckInternet.Check_IPv4orIPv6("192.168.1.1")}  
    Get_PingHost (119.147.15.13): ${AH_CheckInternet.Get_PingHost("119.147.15.13")}  
    Get_Ping (127.0.0.1): ${AH_CheckInternet.Get_Ping("127.0.0.1")}  
    Get_PingLog (119.147.15.13): ${AH_CheckInternet.Get_PingLog("119.147.15.13")}  
    Get_PingStats (127.0.0.1): ${AH_CheckInternet.Get_PingStats("127.0.0.1")}  
    "$
```

  
  
**Preview**  
  
![](https://www.b4x.com/android/forum/attachments/113840)  
  
**Changes log  
-V1.5 **(2021/05/23)****  
you can get IP and Ping  
**-V1.0**  
Make library.  
  
this zip file have a library and a sample.  
‍Please like this post to increase my motivation. :)  
You can subscribe to my Telegram channel to use my text and video tutorials : [@B4X\_Develop](https://t.me/B4X_Develop)