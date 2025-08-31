### get HWND of form without JNA or JNI - pure java by Daestrum
### 08/25/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168386/)

Was bored so revisited FFM (java Foreign Function & Memory - allows access to things outside the JVM)  
  
Example for Windows only and Java 21+  
  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
End Sub  
  
Sub Button1_Click  
    '**********************  
    'java 21+ Windows only (needs –enable-preview if used < java 22)  
    '**********************  
    Dim title As String = MainForm.Title ' save title  
    MainForm.Title="find me cos I am hiding"  ' change name to make it easy to find  
    Log("HWND = " & Me.as(JavaObject).RunMethod("getHWND",Array(MainForm.title)))  
    MainForm.title=title ' restore it to original  
End Sub  
#if java  
import java.lang.foreign.*;  
import java.lang.invoke.*;  
import java.nio.charset.*;  
  
public static long getHWND(String title) throws Throwable {  
    Linker linker = Linker.nativeLinker();  
  
    SymbolLookup user32 = SymbolLookup.libraryLookup("C:/windows/system32/user32.dll", Arena.global());  
  
    MethodHandle findWindow = linker.downcallHandle(  
        user32.find("FindWindowW").orElseThrow(),  
        FunctionDescriptor.of(ValueLayout.JAVA_LONG, ValueLayout.ADDRESS, ValueLayout.ADDRESS)  
    );  
    try (Arena arena = Arena.ofConfined()) {  
        byte[] utf16le = (title + "\0").getBytes(StandardCharsets.UTF_16LE);  
        MemorySegment lpWindowName = arena.allocate(utf16le.length, 2);  
        lpWindowName.copyFrom(MemorySegment.ofArray(utf16le));  
    Long hwnd = (long)findWindow.invoke(MemorySegment.NULL, lpWindowName);  
        
// for testing  
  
    MethodHandle getWindowText = linker.downcallHandle(  
        user32.find("GetWindowTextW").orElseThrow(),  
        FunctionDescriptor.of(ValueLayout.JAVA_INT, ValueLayout.JAVA_LONG, ValueLayout.ADDRESS, ValueLayout.JAVA_INT)  
    );  
  
    try (Arena arena1 = Arena.ofConfined()) {  
        MemorySegment buffer = arena1.allocate(512 * 2); // 512 WCHARs  
        int charsCopied = (int) getWindowText.invoke(hwnd, buffer, 512);  
        
         String actualTitle = decodeWideString(buffer, charsCopied);  
  
        IO.println("Chk = " + actualTitle);  
    }  
        return hwnd;  
    }  
}  
static String decodeWideString(MemorySegment segment, int length) {  
    byte[] bytes = new byte[length * 2]; // WCHAR = 2 bytes  
    for (int i = 0; i < bytes.length; i++) {  
        bytes = segment.get(ValueLayout.JAVA_BYTE, i);  
    }  
    return new String(bytes, StandardCharsets.UTF_16LE);  
}  
#End If
```