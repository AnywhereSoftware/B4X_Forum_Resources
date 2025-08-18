### NFC - Reading Ndef tags by Erel
### 10/07/2020
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/84784/)

iOS 11 adds support for reading Ndef tags.  
This feature is supported by iPhone 7 and newer devices.  
  
  
![](https://www.b4x.com/basic4android/images/SS-2017-10-08_17.55.13.png)  
  
Reading tags is quite simple, though it requires some configuration:  
  
1. Must use an explicit app id (without a wildcard - \*).  
2. You need to enable NFC Tag Reading in the app id features:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-10-08_17.56.42.png)  
  
3. Add these attributes:  

```B4X
#MinVersion: 11  
'privacy description:  
#PlistExtra: <key>NFCReaderUsageDescription</key><string>Read nfc tags.</string>  
#Entitlement: <key>com.apple.developer.nfc.readersession.formats</key><array><string>NDEF</string><string>TAG</string></array>
```

  
4. Make sure to compile with the correct provision profile (the one that references the app id you created).  
  
The code itself is simple. You need to initialize an NFC object. Check the Supported property to make sure that NFC is supported.  
Call Scan to start a scan session. The TagDetected event will be raised with the detected messages.  
The code in the example parses plain text and URI tags.  
  
**Starting from B4i v5.51 the following code should be added:**  

```B4X
#AdditionalLib: CoreNFC.framework, ReferenceOnly  
#DeviceCapabilities: nfc
```

  
  
You must use B4i v5.51+ with NFC.  
  
Updates:  
- There was a bug in the example code related to reading of UTF 16 text messages.