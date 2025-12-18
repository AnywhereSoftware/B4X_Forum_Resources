### [pybridge] Mac notarized standalone package with embedded python by Erel
### 12/16/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/169760/)

![](https://www.b4x.com/android/forum/attachments/168912)  
  
This process requires a few extra steps. Before you start, make sure to be familiar with [B4J-Bridge](https://www.b4x.com/android/forum/threads/38804/#content) and [MacSigner](https://www.b4x.com/android/forum/threads/130890/#content). MacSigner v2.01+ is required.  
  
1. Download standalone python and remove quarantine flags:  
  
Python 3.11 for arm64 Mac: <https://github.com/astral-sh/python-build-standalone/releases/download/20251209/cpython-3.11.14+20251209-aarch64-apple-darwin-install_only.tar.gz>  
Unzip it inside the "tempjars" folder. This is the folder where the app is being copied to when running with B4J-Bridge.  
  
Run this command from the terminal (run it from the python folder)  

```B4X
xattr -dr com.apple.quarantine .
```

  
  
You should now be able to run python:  

```B4X
cd bin  
./python
```

  
And install packages with pip (./pip)  
  
2. Configure PyBridge to find python:  
  

```B4X
Dim opt As PyOptions = Py.CreateOptions(FindPython) 'In B4XPage_Created  
Private Sub FindPython As String  
    Dim paths As List = B4XCollections.CreateList(Null)  
    paths.Add(File.Combine(File.DirApp, "../runtime/Contents/Home/bin/python/bin/python")) 'running from inside the app package  
    paths.Add(File.Combine(File.DirApp, "python/bin/python")) 'running with B4J-Bridge  
    paths.Add(File.Combine(GetSystemProperty("java.home", ""), "bin/python/bin/python")) 'running by double clicking the app  
    For Each PythonPath As String In paths  
        If File.Exists(PythonPath, "") Then  
            Return PythonPath  
        End If  
    Next  
    Log("Failed to find python")  
    Return ""  
End Sub
```

  
  
Tip: B4J-Bridge names the copied jar AsyncInput1 or 2. Rename it to match your app name and add the jar extension, before you select it with MacSigner.  
  
3. When you are ready to package the app, run MacSigner and after the Linking step, you need to copy the complete python folder into temp/build/bin  
Test run.command.  
  
4. Further steps are as usual: package the app (test it), notarize, wait for the process to complete (check the status with the id), once accepted click on the Staple button.  
  
The app package is fully standalone with its own copy of Java and Python runtimes.