### [server] Run a Server on a VPS by Erel
### 01/22/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/60378/)

The steps required to run a B4J server on a hosted server (such as a VPS) are:  
  
1. Download OpenJDK 19: <https://www.oracle.com/java/technologies/javase/jdk19-archive-downloads.html>  
  
If you are not familiar with Linux then download it to your development computer, unzip it and upload the files with FTP. You do not need to install anything.  
  
2. Upload the compiled jar with any additional files (www folder for example).  
  
3. Start the server with:  

```B4X
nohup path_to_java/bin/java -jar somejar.jar > nohup.out &
```

  
The console output will be written to nohup.out.  
You need to use nohup as otherwise the server will be killed when you log out.  
  
4. Make sure that the relevant port is open in the firewall settings.  
  
5. If you want to kill the server you can use this command to find the process number:  

```B4X
ps -ef | grep java  
kill <process number>
```

  
  
6. Tip: Use tail -f nohup.out  
To monitor the server logs.  
  
If you see an error related to the temporary folder then explicitly set it with:  

```B4X
nohup path_to_java/bin/java -Djava.io.tmpdir="temp" -jar somejar.jar > nohup.out &
```

  
  
If there is another http server running on the computer, like Apache or IIS, then you **should not** copy the B4J server to its public\_html / www / or any other publicly accessible folder.