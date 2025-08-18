### Automated synchronous FTP-client by peacemaker
### 09/08/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/122000/)

Automated synchronous FTP-client based on standard FTP-object.  
Functions:  

- Periodical auto-synchronization of files from a chosen root folder on a FTP server: ZIP-like files (.zip, .apk, .xlsx…) integrity is [checked](https://www.b4x.com/android/forum/threads/how-to-check-if-a-file-is-zip-archive-without-unpacking.121885/) and if corrupted - the ZIP-file is re-downloaded.
- Manual upload, download and deletion of a file: make files queue
- Errors handling, event-driven log: check and control each file and its status

![](https://www.b4x.com/android/forum/attachments/99672)  
It's the first release - any updates are welcome to this topic.  
Depedencies in B4A 10.0+:  
![](https://www.b4x.com/android/forum/attachments/99673)  
The class is included into a test project.  
Note that you need your own FTP-server account to test, setting the host, login, password of it into the code.  
  
Versions:  
0.14 - errors counters and limit are added: network errors and ZIP-file integrity errors. If counter > limit - re-connect (re-downloading corrupted ZIP-file) loop is stopped.  
0.13 - all manual operations can be queued, and Activity is with the files list to check the local\_folder synchronized with FTP. Zero-sized files are removed.  
0.12 - manual downloads cannot be in a queue