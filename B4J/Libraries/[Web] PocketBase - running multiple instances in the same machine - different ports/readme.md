### [Web] PocketBase - running multiple instances in the same machine - different ports by Mashiane
### 09/13/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/151330/)

Hi  
  
[Download PocketBase](https://pocketbase.io/)  
  
By default, after configuring PocketBase, i.e. the **SQLite WebServer**, it can run on port 8090 when you start it and use it for your back-ends.  
  
![](https://www.b4x.com/android/forum/attachments/145823)  
  
I have just learned that you can run multiple instances of PocketBase on the same machine and on different ports.  
  
1. Ensure that you save each instance in its own folder so these are different. Remember, PocketBase is a webserver, meaning you can also publish and deploy a website / webapp to it on the pb\_public folder.  
2. In windows, I am starting an instance using a .bat file. So you can create a bat file inside the folder of another pocketbase installation. For this example, we will run another instance on port 8091.  
  

```B4X
pocketbase serve –http="127.0.0.1:8091"  
pause
```

  
  
We save the bat file and execute it, it will start pocketbase on the port and we can then sign in with admin account and set our collections etc.  
  
Happy Coding  
  
PS: Remember to update your code to use the new port as by default its 8090 on the connection strings of your app.