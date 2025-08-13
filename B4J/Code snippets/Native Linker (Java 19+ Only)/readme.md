### Native Linker (Java 19+ Only) by Daestrum
### 03/02/2023
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/146510/)

I have been trying out the replacement for JNA in Java 19.  
The code needed to call a library function is far cleaner now, and requires less coding.  
  
The following in-line java calls strlen from stdlib and prints the length of the string. (Not exciting code but shows how little you need to write now).  
Just a taster for now.  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
    ' ### needed for java 19 ###  
    #VirtualMachineArgs: –enable-preview –enable-native-access=ALL-UNNAMED  
    #PackagerProperty: VMArgs = –enable-preview  
    ' ##########################  
#End Region  
' the usual app here that calls the inline java  
…  
#if java  
import java.lang.foreign.*;  
import java.lang.invoke.*;  
  
public static void doIt() throws Throwable {  
    // 1. Get a lookup object for commonly used libraries  
    SymbolLookup stdlib = Linker.nativeLinker().defaultLookup();  
  
    // 2. Get handle to the "strlen" function in the C standard library  
    MethodHandle strlen = Linker.nativeLinker().downcallHandle(  
        stdlib.lookup("strlen").orElseThrow(),  
        FunctionDescriptor.of(ValueLayout.OfLong.JAVA_LONG, ValueLayout.OfAddress.ADDRESS));  
  
    // 3. Convert Java String to C string and store it in off-heap memory  
    MemorySegment str = SegmentAllocator.implicitAllocator().allocateUtf8String("B4X for coding!");  
  
    // 4. Invoke the foreign function  
    long len = (long) strlen.invoke(str);  
  
    System.out.println("len = " + len);  
  }  
  
#End If
```

  
  
Looking forward to more experiments.  
  
Note: It will not run in the IDE ( I had to modify some arguments that get passed to javac in order to compile the preview code).  
  
ps. Sorry Erel if this is in the wrong part of the forum.