### AmazonDeviceMessaging (ADM) by DonManfred
### 03/30/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/115518/)

Amazon Device Messaging (ADM) lets you send messages to Amazon devices that run your app, so you can keep users up to date and involved. Whether you're giving a user a game update or letting them know that a message from their buddy has arrived, ADM helps you stay in touch.  
Thank you [USER=11312]@cooperlegend[/USER] for motivating me (?) :cool:  
  
*Note that ADM is not supported on Kindle Fire (1st Generation) devices.*  
  
<https://developer.amazon.com/de/docs/adm/overview.html>  
  
To start you need to Create your app in Amazon App console.  
  
<https://developer.amazon.com/de/docs/adm/obtain-credentials.html>  
  
After you got the credentials and your apptoken you need to place the apptoken in the file api\_key.txt inside the project Assets (Files folder).  
  
Similar to FirebaseMessaging this Library depends on a similar setup. You need to have a Service named AmazonMessaging.  
See the Example project on how the code may look for. Even the starter is adapted in this Example.  
  
Also note the needed Manifestchanges:  

```B4X
CreateResourceFromFile(Macro, ADM.ADM)  
CreateResource(values, strings.xml,  
<resources>  
    <string name="app_name">ADMMessenger</string>  
    <string name="menu_settings">Settings</string>  
    <string name="title_activity_main">MainActivity</string>  
    <string name="json_data_msg_key">message</string>  
    <string name="json_data_time_key">timeStamp</string>  
    <string name="json_data_consolidation_key">collapse_key</string>  
    <string name="intent_msg_action">com.amazon.sample.admmessenger.ON_MESSAGE</string>  
    <string name="intent_msg_category">com.amazon.sample.admmessenger.MSG_CATEGORY</string>  
    <string name="server_address">http://webhook.basic4android.de/</string>  
    <string name="server_port">80</string>  
</resources>  
  
)
```

  
  
Add the following line to your Main  

```B4X
#DebuggerForceStandardAssets: true
```

  
It forces the IDE to organize the Assets in a way ADM expects.  
  
A B4J Project for the Sender-Part is also provided. You need to have your Apps Client-Id and Secret to send a Notification.  
  
**ADM**  
*<link>…|<https://www.b4x.com></link>*  
**Author:** DonManfred  
**Version:** 0.1  

- **ADM**

- **Functions:**

- **checkManifestAuthoredProperly**
- **Initialize** (EventName As String)
- **IsInitialized** As Boolean
- **startRegister**
- **startUnRegister**

- **Properties:**

- **IS\_ADM\_AVAILABLE** As Boolean [read only]
- **IS\_ADM\_V2** As Boolean [read only]
- **isClassAvailable** As Boolean [read only]
- **RegistrationId** As String [read only]
- **Supported** As Boolean [read only]

- **AmazonMessaging**

- **Events:**

- **MessageArrived** (MessageJSON As String)

- **Functions:**

- **HandleIntent** (Intent As android.content.Intent) As Boolean
*Should be called from Service\_Start. Returns true if the intent was  
 handled.*- **Initialize** (EventName As String)
- **wrap** (o As Object) As Object

  
  
For any Question you have:  
- Please create a new Thread in the B4A Questions Forum.  
- Prefix your threadtitle with [ADM].