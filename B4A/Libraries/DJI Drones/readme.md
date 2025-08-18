### DJI Drones by Erel
### 07/17/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/75244/)

DJI Drones are very popular and advanced drones. DJI provides an Android app that is used during flights to control the drone.  
The Android device connects to the remote controller with a USB cable (USB debug mode should be enabled).  
  
DJI are also providing a feature-rich SDK that allows us, developers, to create alternative applications to control the drone. It is quite amazing to be able to easily program a drone to do all kinds of sophisticated tasks.  
  
The following video is an example created with B4A and the DJI library. On the left side you can see the drone camera feed and various parameters. On the right side there is a standard Google Map. Touching on a point in the map starts a hotspot mission. The drone will rotate automatically around the spot.  
  
[MEDIA=youtube]FGRXkdyx7o4[/MEDIA]  
  
**How to use**  
  
1. Register with DJI: <https://developer.dji.com/> and create an app in the User Center page. You will see an App Key that you need to add to the manifest editor.  
The bundle identifier must match your app package name.  
2. Add this code to the manifest editor:  

```B4X
AddReplacement($DJI_KEY$, XXXXXXXXX)  
CreateResourceFromFile(Macro, DJI.DJI)
```

  
Replace XXXXXXXXXX with your App key.  
3. Add to the main activity code:  

```B4X
#BridgeLogger: true  
#MultiDex: true  
#AdditionalJar: dji-sdk-provided-4.16, ReferenceOnly  
#AdditionalJar: kotlin-stdlib-1.5.10
```

  
  
4. You might need to install a few components with B4A Sdk Manager: <https://www.b4x.com/android/forum/threads/dji-library-example-error-resource-android-attr-lstar-not-found.141799/post-898956>  
5 Initialize the SDK when the application starts. The RegisteredResult event will be raised. If successful then call sdk.StartConnectionToProduct to start a connection.  
6. The ProductConnected event will be raised. If AircraftData is not Null then you are good to go and can initialize the DJIAircraft object and the other features (see how it is done in the example).  
7 Most of the operations are asynchronous. They are built to work with the Wait For keyword.  
8. Expect disconnections and other errors.  
9. **New:** See the Activity\_Resume code in the example. It is needed to handle reconnections.  
  
See the attached example.  
  
**Tips & Notes**  
  
- Make sure that you are able to connect to the drone with the DJI app. Not all Android devices have proper support for USB connected devices.  
- **You will see a dialog that asks you whether you always want to start the DJI app when the USB is connected. Click on "This time only".** Otherwise you will need to uninstall the DJI app as it will get an exclusive permission to use the USB device.  
- Use B4A-Bridge to connect the IDE to the Android device.  
- Supported drones: <https://developer.dji.com/mobile-sdk/documentation/introduction/product_introduction.html#supported-products>  
- **Use the simulator to test your app**. It works well.  
<https://developer.dji.com/mobile-sdk/documentation/application-development-workflow/workflow-testing.html>  
  
**- Don't fly the drone indoors.  
- Check the GPS status. All the nice automatic features will fail without the GPS. Should be 4 or 5.  
- Make sure that the home location is set before flight.  
- Always be prepared to manually control the drone.**   
  
Download the native libraries and copy them to the additional libraries folder:  
[www.b4x.com/android/files/dji\_additional.zip](https://www.b4x.com/android/files/dji_additional.zip)  
Note that only 64 bit binary is included inside dji-sdk-4.15.aar. You can download the full aar with both 32 bit and 64 bit binaries here:  
<https://repo1.maven.org/maven2/com/dji/dji-sdk/4.16/dji-sdk-4.16.aar>  
  
During development it will be faster to use the smaller aar file.  
  
Download the attached library and copy it as well.  
  
**Updates**  
  
- 4.80: Based on SDK 4.16. Requires B4A v11.5+. Please add to Main module:  

```B4X
#MultiDex: true  
#AdditionalJar: dji-sdk-provided-4.16, ReferenceOnly  
#AdditionalJar: kotlin-stdlib-1.5.10
```

  
- 4.70: Based on SDK 4.15. Check the updated example and don't miss the Activity\_Resume code.  
- 4.60: It is based on DJI SDK v4.14-trial1.  
It requires B4A v11.5+  
The minimum Android version is 5.0.  
  
Start with the attached example. Note that the hotspot mission calls ExitApplication. You must configure a reasonable coordinate before you test it (and remove the ExitApplication).  
The example needs to be updated with the attributes mentioned in v4.80 update above.