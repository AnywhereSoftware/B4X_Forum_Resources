### Get fingerprint validation using B4J + Python + DLL (Windows Only) by Daestrum
### 08/20/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168318/)

Been playing with Winbio (Windows Hello) - finally getting it to work from B4J.  
  
Convoluted path so far  
Tried calling from Java directly using FFM - didn't work (so far)  
Got it working in B4J with Python with a DLL bridge to WInbio.  
The Python script spawns another Python script, running elevated privileges (needed for winbio).  
  
As it stands it will confirm if a user is registered with Windows Hello. There are lots of other parts of Winbio I haven't used.  
  
B4J Code calls py\_runner.py with 2 params :  
1, The path to Python (it has to spawn a new python)  
2, The path of the second python script to run.  
  

```B4X
Private Sub chk_user As ResumableSub  
	wait for ((Py.RunCode("start", Array("D:/Python313/python.exe",getAssetFile("py_fp_test.py")), readAsset("py_runner.py")).fetch)) Complete (v As PyWrapper)  
	Return v.value  
End Sub
```

  
The two routines gettAssetFile and readAsset are just convenience methods - the first returns the path, the second the contents of the file as a string.  

```B4X
Private Sub getAssetFile(name As String) As String  
	Dim tmp As String = File.GetUri(File.DirAssets,name)  
	If GetSystemProperty("os.name","").ToLowerCase.StartsWith("win") Then  
        Return tmp.ToLowerCase.Replace("file:/","")  
	Else  
		Return tmp.Replace("file:/","").Replace("File:/","")  
	End If	  
End Sub  
  
private Sub readAsset(s As String) As String  
	Return File.ReadString("",getAssetFile(s))  
End Sub
```

  
  
py\_runner.py  
This creates a socket (for the elevated python to talk to as pipes and stdout etc break across elevation)  

```B4X
import subprocess  
import time  
import socket  
import os  
  
def start(python_path,sub_process_path):  
    #create server here  
    serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
    serversocket.bind(('localhost', 0))  
    port = serversocket.getsockname()[1]  
    serversocket.listen(1) # become a server socket, maximum 1 connections  
    python_exec = os.path.normpath(python_path.strip('"'))  
    sub_process_exec = os.path.normpath(sub_process_path.strip('"'))  
  
    # build command for elevated script  
    cmd = [  
        "powershell",  
        "-Command",  
         f"Start-Process -FilePath '{python_exec}' "  
         f"-ArgumentList '\"{sub_process_exec}\" \"{port}\"' "   
        "-Verb RunAs -Wait"  # the runas causea elevation of the process  
    ]  
    #run the subprocess with elevated privileges  
    subprocess.run(cmd)  
    reply = ""  
    print("waiting for reply")  
    # Wait for connection  
    while True:  
        connection, address = serversocket.accept()  
        buf = connection.recv(1024)  
        if len(buf) > 0:  
            reply = buf  
            break  
  
    # Read result  
    result = reply.decode().strip()  
    #print("result:", result)  
  
    #return result to B4J  
    serversocket.close()  
    return result
```

  
  
py\_Fp\_test.py  
This runs as an elevated process so it can access Winbio (well the link dll)  
  

```B4X
import ctypes  
import os  
import sys  
import time  
import socket  
  
def main():  
    os.system("title Press fingerprint reader now")  
    if len(sys.argv) < 2:  
        sys.exit()  
    # Load the DLL  
    port =int(sys.argv[1])  
    s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
    dll_path = r"C:\Temp\MyFingerprintReader.dll"  
    fingerprint = ctypes.WinDLL(dll_path)  
    # Prepare reply buffer  
    reply = ctypes.create_string_buffer(1024)  
  
    # Define function signature  
    fingerprint.verifyFingerprint.argtypes = [ctypes.c_char_p]  
    fingerprint.verifyFingerprint.restype = None  
    # Call the function  
    fingerprint.verifyFingerprint(reply)  
    # send reply back  
    try:  
        s.connect(('localhost', port))  
        result = reply.value.decode('utf-8')  
        s.sendall(result.encode())  
    except Exception as e:  
        sys.exit()  
    finally:  
        time.sleep(1.0)  
        s.close()  
        sys.exit(0)  
  
if __name__ == "__main__":  
    main()
```

  
  
Finally the dll source code (posted as source as you need to set the unitId for the reader you have) - compile to .dll (it is C++ code as its easier to interface to Winbio)  
  

```B4X
#include <windows.h>  
#include <winbio.h>  
#include <string>  
  
class FingerprintVerifier {  
public:  
    std::string verify() {  
        WINBIO_SESSION_HANDLE sessionHandle;  
        HRESULT hr = WinBioOpenSession(  
            WINBIO_TYPE_FINGERPRINT,  
            WINBIO_POOL_SYSTEM,  
            WINBIO_FLAG_DEFAULT,  
            NULL, 0,  
            WINBIO_DB_DEFAULT,  
            &sessionHandle);  
        if (FAILED(hr)) return "ERROR - Session";  
  
        WINBIO_UNIT_ID unitId = 3;   // **** CHANGE THIS TO WHERE YOUR READER IS *****  
        WINBIO_IDENTITY identity;  
        WINBIO_BIOMETRIC_SUBTYPE subFactor;  
        WINBIO_REJECT_DETAIL rejectDetail;  
  
        hr = WinBioIdentify(sessionHandle, &unitId, &identity, &subFactor, &rejectDetail);  
        WinBioCloseSession(sessionHandle);  
  
        if (FAILED(hr)) return "FAILED - Unknown user";  
        return "VALID - User is known";  
    }  
};  
  
extern "C" __declspec(dllexport)  
void verifyFingerprint(char* reply) {  
    FingerprintVerifier verifier;  
    std::string result = verifier.verify();  
    strncpy_s(reply, 1024, result.c_str(), _TRUNCATE);  // allows for 1024 bytes to be sent back - I use about 21 in this  
    reply[1023] = '\0';  
}
```

  
  
Was fun getting it to work - also UAC is triggered as the 2nd python script is fired off with elevated credentials.  
  
Bits that may be of use - How to elevate a python script to Admin from a python script using Powershell with RunAs