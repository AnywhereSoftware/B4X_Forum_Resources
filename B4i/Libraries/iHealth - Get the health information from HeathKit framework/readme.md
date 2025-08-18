### iHealth - Get the health information from HeathKit framework by Alberto Iglesias
### 01/04/2021
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/95536/)

![](http://vnsoft.es/download/b4i/ihealth/TopiHealth.png)  
  
**iHealth - Get the health information from HeathKit framework**  
  
Installation instructions:  
  
- Copy the \*.a and \*.h files into the folder "Libs" in your MAC or in your MAC HOSTED by AnywhereSoftware, normally in "B4i-MacServer\Libs" folder  
  
-Copy the iHealth.xml to your custom libraries folder in B4i  
- Select in your REFERENCED LIBRARIES  
  
![](http://vnsoft.es/download/b4i/ihealth/RefMessage.png)  
  
**iHealth  
Author:** Alberto Iglesias ([email]alberto@visualnet.inf.br[/email])  
**Version:** 1.02  

- **HealhKit**
Events:

- **onInitialized** ( )
- **ReceivedSteps** (Steps as List )
- **ReceivedBirthday** (Birthday as String )

- **Methods:**

- **Initialize:** (EventName As String)
*Initializes the object*- **GetSteps::** (StartDate As String, EndDate As String)
*Get Steps*- **GetBirthday As String**
*Get Birthday*- **isHealthDataAvailable As Boolean**
*Is HeathData Available*- **LicenseShow**
*Show License*
- **Properties:**

- **DebugMode As Boolean**
*Enable/Disable Debug mode from Library*- **Author As String** *[read only]*
Author of this Library- **Version As **String**** *[read only]*
Version of this Library- **LicenseEmail As **String****
*License Email*- **LicenseKey As **String****
*License Key*
  
*![](http://vnsoft.es/download/b4i/ihealth/ExampleCode.png)*  
  
![](http://vnsoft.es/download/b4i/ihealth/devices2.jpg)  
  
  
![](http://vnsoft.es/download/b4i/ihealth/screen4.jpg)  
  
  
And import thing is for this, you need from apple the correct provisioning profile with this application service  
![](http://vnsoft.es/download/b4i/ihealth/appid.png)  
  
  
You can get your license key in our library store:  
(you don't have limit of time if you don't want to buy)  
  
[![](http://vnsoft.es/images/misc/shopnow.png)](http://visualnet.inf.br/store)