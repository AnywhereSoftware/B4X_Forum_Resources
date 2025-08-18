### Asynchronous modbus TCP master by Coldrestart
### 09/22/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/119437/)

Hello everyone,  
  
Here a modbus TCP master library, fully programmed in b4j.  
This library is asynchronous, by use of the asyncstreams and Callback method.  
The response is an event, a separate sub, different then your sub where you did the request.  
This has the advantage that an unresponsive server will not slow down your application.  
  
The zip file here is a command line example, with the library.  
You can compile this library as internal library as desired, but like this, you can look inside the code of the lib.  
  
Supported functions:  
-Read holding registers  
-Read input registers  
-Read coils  
-Read discrete inputs  
-Write single register  
-Write multiple registers  
-Write single coil  
-Write multiple coils  
  
Please note that I am not a professional programmer, so comments or feedback is always appreciated!  
  
Kind regards,  
Coldrestart.  
  
  
\*\* UPDATE on 25/07/2020\*\*  
Changes made in the library in the GUI version;  
-Fixed typo in function name.  
-TCP port and IP address are now in the Connect function instead of the initialization of the object.  
  
\*\*UPDATE on 18/08/2020\*\*  
Added: type selection, only for the representation, in signed, unsigned, hex and binary.  
  
\*\*UPDATE on 22/09/2020\*\*  
Changes made in the CLI version:  
-The port and IP adress are passed when using the function "ConnectServer", instead of the initialization function.  
Changes made for the CLI and GUI version: Conversion sub "ToBinaryString" was returning 9 bits instead of 8.  
This issue was reported by the user "Madru" of the forum, thanks to him for reporting this issue.  
  
  
![](https://www.b4x.com/android/forum/attachments/97619)