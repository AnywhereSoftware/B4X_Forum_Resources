###  PocketBase - How to reach api via smartphone on the same network when hosted locally by Alexander Stolte
### 02/10/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/165548/)

<https://www.b4x.com/android/forum/threads/b4x-pocketbase-open-source-backend-in-1-file.165213/#content>  
  
If you develop with B4J with Pocketbase, then you simply enter the localhost address (127.0.0.1:8090) and reach the pocketbase api.  

```B4X
xPocketbase.Initialize("http://127.0.0.1:8090") 'Localhost -> B4J only
```

  
  
However, in order to access the pocketbase api via smartphone, the pocketbase api must be started using a different command.  
The documentation says to start the api like this:  

```B4X
pocketbase serve
```

  
This means that the api only listens to the localhost and the smartphone in the same network cannot reach the api.  
To solve this, the Pocketbase api must be started with the following parameter:  

```B4X
pocketbase serve –http=0.0.0.0:8090
```

  
**Explanation:**  

- [ICODE]0.0.0.0[/ICODE] makes the server listen on all network interfaces (not just localhost)
- [ICODE]:8090[/ICODE] specifies the port (you can change it if needed)

If you are using a **firewall** or **Windows Defender**, make sure to allow traffic on **port 8090**  
  

```B4X
Public xPocketbase As Pocketbase  
#If B4J  
xPocketbase.Initialize("http://127.0.0.1:8090") 'Localhost -> B4J only  
#Else  
xPocketbase.Initialize("http://192.168.188.142:8090") 'IP of your PC  
#End If
```