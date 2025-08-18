### Hardware Health Monitor (using jsensors) by Magma
### 02/16/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/127706/)

Hi there…  
  
I am trying to create a Hardware (PC) Monitor using [jSensors](https://www.b4x.com/android/forum/threads/jsensors_b4j-load-fan-and-temps.92159/) and jGauges !  
  
Well i am posting here what i've done until **now** - it is simple… but it's a start…  
  
What problems i am seeing:  
  
1) Very Heavy - actually all these things using CPU a lot !! - so how it can be for health monitor when CPU is too high :-( - using Asynchronous library calls - somehow light it - but is still heavy… After that thought that if calling async alternately the sensors make it much lighter… but still heavy :-( any idea ? **(found why was heavy - it is not native java… running powershell to get from wmic the temperatures/sensors values)** - … if anyone knows better way will help..  
  
2) When i compile it - to stand alone (EXE)… and running run\_debug get this error:  **(SOLVED) - run as administrator (b4j or the exe)**  
> \*\*\* mainpage: B4XPage\_Created  
> \*\*\* mainpage: B4XPage\_Appear  
> \*\*\* mainpage: B4XPage\_Resize [mainpage]  
> b4xmainpage.\_temphdd\_result (java line: -1)  
> java.lang.ArrayIndexOutOfBoundsException: Index -1 out of bounds for length 0  
>  at b4j/b4j.example.b4xmainpage.\_temphdd\_result(Unknown Source)  
>  at [java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0](http://java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0)(Native Method)  
>  at [java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke](http://java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke)(Unknown Source)  
>  at [java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke](http://java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke)(Unknown Source)  
>  at [java.base/java.lang.reflect.Method.invoke](http://java.base/java.lang.reflect.Method.invoke)(Unknown Source)  
>  at b4j/anywheresoftware.b4a.BA.raiseEvent2(Unknown Source)  
>  at b4j/anywheresoftware.b4a.BA$3.run(Unknown Source)  
>  at javafx.graphics/com.sun.javafx.application.PlatformImpl.lambda$runLater$10(Unknown Source)  
>  at [java.base/java.security.AccessController.doPrivileged](http://java.base/java.security.AccessController.doPrivileged)(Native Method)  
>  at javafx.graphics/com.sun.javafx.application.PlatformImpl.lambda$runLater$11(Unknown Source)  
>  at javafx.graphics/com.sun.glass.ui.InvokeLaterDispatcher$Future.run(Unknown Source)  
>  at javafx.graphics/com.sun.glass.ui.win.WinApplication.\_runLoop(Native Method)  
>  at javafx.graphics/com.sun.glass.ui.win.WinApplication.lambda$runLoop$3(Unknown Source)  
>  at [java.base/java.lang.Thread.run](http://java.base/java.lang.Thread.run)(Unknown Source)

any idea ?  
  
![](https://www.b4x.com/android/forum/attachments/108101)  
**You will need** also jsensors jar files missing at thread of library post - you can get them from my gdrive [**here…**](https://drive.google.com/file/d/136-fj_zfHMaTX0kkjemUnUxoxBhKdE22/view?usp=sharing)  
  
Ofcourse attaching source code - to share it and share your ideas:  
  
[**[SIZE=5]Download Source Code Project from here ! (updated 16/2/2021-utc+3 19:01)[/SIZE]**](https://drive.google.com/file/d/1yF9tkjTsX6mh6CMHW4OPcXv7Am6Ph95a/view?usp=sharing)  
[SIZE=5]The only way to run OK this project - is to run B4J with right click Run as Administrator…  
or Run the Standalone EXE (produced by B4J) with right click Run as Administrator… (after searching… for hours)[/SIZE]