### [PyBridge] SSH / SFTP with AsyncSSH by Erel
### 08/12/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/168197/)

This is a wrapper for Python AsyncSSH library: <https://asyncssh.readthedocs.io/en/latest/>  
AsyncSSH is a very versatile library. This wrapper exposes the SFTP features and RunCommand which runs commands on the remote machine.  
  
Installation:  
- Open the global or local Python shell:  

```B4X
pip install asyncssh
```

  
  
All methods are asynchronous and should be called with Wait For (ssh…) Complete (Result As PyWrapper).  
All methods return a PyWrapper object. You can check Result.IsSuccess to determine whether the operation completed successfully.  
Methods that return other information, return it in Result.Value. Check the documentation.  
Note that it can be used in UI, console and server apps.  
  
Example:  

```B4X
Dim ssh As AsyncSSH  
ssh.Initialize(Me, "ssh", Py)  
Dim rs As Object = ssh.ConnectSkipHostsCheck(Host, 22, username, password)  
    Wait For (rs) Complete (Result As PyWrapper)  
    If Result.IsSuccess = False Then  
        Log("Error connecting: " & Result.ErrorMessage)  
    Else  
        Log("Success")  
        Log("Running command")  
        Wait For (ssh.RunCommand("ls -h", 0)) Complete (Result As PyWrapper)  
        Log(Result.Value)  
        Wait For (ssh.SFTPList("Downloads")) Complete (Result As PyWrapper)  
        For Each entry As Map In Result.Value.As(List)  
            Log(entry)  
        Next  
        Wait For (ssh.SFTPGet("Downloads/some file.txt", "C:\Users\H\Downloads", False)) Complete (Result As PyWrapper)  
        Log("File downloaded successfully? " & Result.IsSuccess)  
        Wait For (ssh.SFTPExists("Downloads/test")) Complete (Result As PyWrapper)  
        Log("File exists? " & Result.Value) 'the actual result is in Result.Value  
        If Result.Value = False Then  
            Wait For (ssh.SFTPMkDir("Downloads/test")) Complete (Result As PyWrapper)  
            Log("Mkdir success? " & Result.IsSuccess)  
        End If  
         'recursively upload a folder:  
        Wait For (ssh.SFTPPut("C:\Users\H\Documents\test", "Downloads/test", True)) Complete (Result As PyWrapper)  
        Wait For (ssh.SFTPRemove("Downloads/test/logs.txt")) Complete (Result As PyWrapper)  
        Log(Result.IsSuccess)  
        Log("closing")  
        Wait For (ssh.CloseConnection) Complete (Result As PyWrapper)  
    End If
```