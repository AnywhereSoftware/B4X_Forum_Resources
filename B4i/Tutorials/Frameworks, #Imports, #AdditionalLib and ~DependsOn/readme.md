### Frameworks, #Imports, #AdditionalLib and ~DependsOn by Erel
### 11/05/2025
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/169223/)

We will start with the steps to create a new native (non-b4xlib) for B4i v10+ with Xcode.   
In the past libraries were compiled as fat .a archives. Starting with v10.0 libraries must be compiled as xcframeworks. This provides many benefits.  
  
Steps:  
  
1. Create a new project and choose Framework as the type and Objective C as the language.  
2. Drag iCore.xcframework from the Libs folder to "Frameworks and Libraries" (Target settings - General). You can also add more frameworks as needed.  
3. Switch to the "Build Settings" tag, search for "mach" and change the Mac-O Type to Static Library.  
  
Follow the same steps if you want to convert an existing library. You can drag all files from the old project to the new one, EXCEPT of the main header file. You should instead copy the contents of the old one and paste it in the existing framework header. Otherwise it will not be treated as the framework public header (you can see it under Build Phases - Headers).  
  
Compile the framework once with "Any iOS device" as the target and once with "Any iOS simulator".  
Top menu - Product - Show Build Product in Finder. Find the two built frameworks and combine them to a xcframework with:  

```B4X
xcodebuild -create-xcframework -framework MyFramework-device.framework  -framework MyFramework-simulator.framework   -output MyFramework.xcframework
```

  
  
**Dependencies**  
  
There are several new flags that can be added to the library name in order to properly reference it.  

```B4X
'B4i  
#AdditionalLib: MLKit/MLKitTextRecognition.framework.3  
#AdditionalLib: MLKit/MLKitTextRecognitionCommon.framework.3  
#AdditionalLib: MLKit/GoogleDataTransport.noheader.3  
#AdditionalLib: MLKit/GoogleToolboxForMac.noheader.3  
'library header file  
//~dependson:CoreBluetooth.framework  
//~dependson:MobileCoreServices.framework  
//~dependson:Firebase/GoogleMobileAds.xcframework.swift_placeholder.3  
//~dependsOn:Firebase/UserMessagingPlatform.xcframework.3
```

  
  
The format is:<optional folder><library name with extension (.a is omitted)><optional flags>  
.3 - This is not a system library and it will be located under Libs\Extra  
.noheader - The compiler will not import the library header. In most cases the header isn't needed.  
.swift\_placeholder - The compiler will add an empty Swift file to the project. This fixes issues with missing swift compatibility libraries. At most one stub swift file will be added.  
.cpp - Library depends on c++ libraries. This replaces the ~objcpp flag.  
.swift - The header name is <framework>-Swift.h.  
  
  
iAdMob framework project is attached as an example.