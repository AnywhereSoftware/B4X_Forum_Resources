### [Objective C] Writing libraries for B4i by Erel
### 09/03/2026
[B4X Forum - B4i - Tutorials](https://www.b4x.com/android/forum/threads/47024/)

B4i libraries are written in Objective C. You need to use a Mac with Xcode and you need to know Objective C.  
From my experience it is more difficult to write B4i libraries compared to B4A / B4J libraries.  
  
Libraries are made of three files: library.a, library.h and library.xml.  
  
The xml file is created automatically from the h file using the tool attached to this thread.  
This is a command line tool written with B4J. You need to pass two arguments: path to the h file and path to the output file.  
For example:  

```B4X
java -jar B4Ih2xml.jar test.h test.xml
```

  
Note that this tool parses the file line by line. It will not handle properly signatures that span multiple lines.  
  
The a and h files should be eventually copied to the Libs folder on the Mac and the xml file should be copied to the IDE libraries folder.  
  
Libraries should include two binaries: arm64 and armv7.  
  
**Supported types**  
  
The following types can be exposed to B4i: BOOL, unsigned char, unichar, short, int, long long, float, double and any objc object. Other types cannot be directly exposed.  
  
**Header file**  
  
The xml is derived from a single h file. This means that all the interfaces that should be exposed need to be defined in this h file.  
You need to add all kinds of attributes to the h file (similar to B4A annotations).  
This is done by writing a comment that starts with:  
//~  
  
For example:  

```B4X
//~shortname:LocationManager  
//~event:LocationChanged (Location1 As Location)  
//~event:AuthorizationStatusChanged (Status As int)  
//~event:LocationError  
//~event:HeadingChanged (MagneticHeading As Double, TrueHeading As Double)  
//~event:AllowCalibration As Boolean  
//~version:1.00  
//~dependsOn:CoreLocation.framework  
@interface B4ILocationManager : NSObject<CLLocationManagerDelegate>
```

  
  
The attributes are case-insensitive and the values are trimmed from extra spaces.  
  
**Attributes**  

- ShortName - The B4i type name.
- Event - The type events. Can be used multiple times.
- Version - library version
- Author - library author
- RaisesSynchronousEvents - Tells the compiler that calling this method may cause an event to be raised (before the code returns).
//~RaisesSynchronousEvents:true- ObjectWrapper - If the type is a thin wrapper and it inherits from B4IObjectWrapper then this attribute should be set with the native type name.
//~ObjectWrapper:CLLocation\*- DependsOn - Tells the compiler that this library depends on other frameworks or a files.
//~dependsOn:CoreLocation.framework
If the framework is an external framework then you need to add .3:
//~dependson:GoogleMaps.framework.3
DependsOn with a file (the extension is omitted):
//~dependson:GoogleAdMobAds
**Methods**  
  
The exposed methods can have any number of parameters. However the parameter names should be empty:  

```B4X
- (B4IMarker *)AddMarker: (double)Lat :(double)Lon :(NSString *)Title;
```

  
  
**B4IObjectWrapper**  
  
If your object is a thin wrapper over a different object then you can inherit from B4IObjectWrapper. Such objects should not have any instance variables (including not properties that are implicitly back by a variable).  
You need to create a class method named getClass that returns the native object class:  

```B4X
+(Class)getClass {  
  return [CLLocation class];  
}
```

  
  
Don't use this type if you are not sure.  
  
  
**Raising events / B4I object**  
  
The B4I object is similar to B4A/B4J BA object. You use this object to raise events.  
B4IObjectWrapper includes several class methods that help with raising events. You can use it even if your class doesn't subclass B4IObjectWrapper.  
  
The first method is:  

```B4X
[B4IObjectWrapper setBIAndEventName:self :bi :EventName];
```

  
This method takes the B4I object and the EventName parameter and stores them in the object associated map. The bi object is stored with a weak reference.  
It is important to remember that the bi and EventName are tied to the object passed to this method. In this case it is 'self'.  
  
Raising event:  

```B4X
[B4IObjectWrapper raiseEvent:self :@"_authorizationstatuschanged:" :@[@((int)status)]];
```

  
**Don't forget to include the colons in the method name!**  
  
Two similar methods: raiseUIEvent and raiseEventFromDifferentThread. These methods send a message to the message queue which will cause the event to be raised when the message is processed.  
  
**Tips**  
  
- Add a reference to iCore.h in your library project.  
  
Two libraries projects are attached. The iLocation library and iAdMob library.  
  
Latest version of iAdMob is available here: <https://github.com/AnywhereSoftware/B4i_iAdMob>  
  
  
**Updates**  
- v1.01 - Added support for default values.  
  
Example:  

```B4X
//in header file  
- (B4IArray */*unsigned char,1*/)GetBytes:(NSString *)CharSet /* = UTF-8 */;
```