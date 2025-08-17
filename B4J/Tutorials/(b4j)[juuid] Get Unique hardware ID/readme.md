### (b4j)[juuid] Get Unique hardware ID by behnam_tr
### 05/11/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132277/)

Get Unique hardware ID in b4j  
tested on windows only you can test on mac or linux  
  
**8 method to get Unique hardware id**  
  
![](https://www.b4x.com/android/forum/attachments/115909)  
  
  
  
[SPOILER="Update List"]  
  
updated v1.8  
fixed error in none\_ui apps  
removed all unnecessary methods  
two new method added  
Get\_HWID1  
Get\_HWID2  
  
updated v2.0  
Using java standard functions without modification  
Changed Lib Name to juuid (jpadina deprecated)  
added Get\_MachineID2  
added Email Validation  
  
updated v2.1  
added Get\_HddId3  
  
updated v2.2  
added Get\_HddID4(String Driveletter)  
  
updated v2.3  
added Get\_LocalHardisk\_Info  
  
updated v2.4  
Added :  
 Get\_CPUID2  
 Get\_CPUName  
 Get\_TotalPhysicalMemory  
 Get\_MotherBoardName  
 Get\_AllMacIds  
 Get\_GpuName  
 Get\_GpuID  
 Get\_RandomUuid  
  
updated v2.5  
Added :  
 Linux\_UUID1  
 Linux\_UUID2  
 Linux\_UUID3  
 Linux\_UUID4  
 Linux\_MacId  
 Some Fixes >> Get\_LocalHardisk\_Info  
  
updated v2.6  
 Some Fixes and changes in Get\_LocalHardisk\_Info  
 bug fixed in Linux Methods [#43](https://b4x.com/android/forum/threads/b4j-juuid-get-unique-hardware-id.132277/post-960182)  
added OS\_SerialNumber  
added OS\_Version  
added Get\_CPULogicalProcessors  
added Get\_BiosVersion  
added OS\_Name  
  
updated v2.7  
check the disk free space of a partition > getFreeSpace("C")  
check the total space of a partition > getTotalSpace("C")  
get MyIP  
MD5(String YourText)  
SHA1(String YourText)  
SHA256(String YourText)  
AES\_Encrypt(String strToEncrypt, String secretkey)  
AES\_Decrypt(String strToDecrypt, String secretkey)  
  
updated v2.8 (2025/01)  
some fixes  
DiskSerialWithPowerShell  
CPUSerialWithPowerShell  
MainBoardSerialWithPowerShell  
  
updated v2.9 (2025/04)  
getPrintersList() as list  
getDefaultPrinter() as string  
  
[/SPOILER]  
  
  
  
How Use :  

```B4X
    Dim pdd As jUUID  
  
    Log(pdd.Get_CPUID )  
    Log( pdd.Get_HddID1 )  
    Log( pdd.Get_HddID2 )  
    Log( pdd.Get_HddID3 )  
    Log( pdd.Get_HddID4("C") )  //disk drive letter  
    Log ( pdd.Get_MachineID )  
    Log ( pdd.Get_MachineID2 )  
    Log ( pdd.Get_MacId )  
    Log ( pdd.Get_MotherboardSN )  
    Log( pdd.Get_HWID1 )  'hardware + software > can change with changing windows or user  
    Log( pdd.Get_HWID2 )  'hardware + software > can change with changing windows or user
```

  
  
  

```B4X
'Hardware information  
'Windows Only  
'system information  
  
    Dim p As jUUID  
    Log("OS_Name : "&p.OS_Name)  
    Log("OS_Version: "&p.OS_Version)  
    Log("OS_Arch : "&p.OS_Arch)  
    Log("OS_username : "&p.OS_UserName)  
    Log("OS_SerialNumber : "&p.OS_SerialNumber)  
    Log("MainBoard Name : "&p.Get_MotherBoardName)  
    Log("CPU Name : "&p.Get_CPUName)  
    Log("CPU Cores : "&p.Get_CPUCores)  
    Log("CPU LogicalProcessors : "&p.Get_CPULogicalProcessors)  
    Log("Total PhysicalMemory : "&Round(p.Get_TotalPhysicalMemory/1024/1024)&" MB")  
    Log("Free PhysicalMemory : "&Round(p.Get_AvailablePhysicalMemory/1024)&" MB")  
    Log("GPU Name: "&p.Get_GpuName)  
    Log("Bios Version : "&p.Get_BiosVersion)
```

  
  
get installed printers list  

```B4X
 Dim p As jUUID  
 Dim list1 As List = p.PrintersList  
 Log(p.DefaultPrinter)  
   
For Each PrinterName As String In list1  
    Log(PrinterName)  
Next
```

  
  
  
Any function that has no result returns a null value  
lib (jar and xml files) atteched.