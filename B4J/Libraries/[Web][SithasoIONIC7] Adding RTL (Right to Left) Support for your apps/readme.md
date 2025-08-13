### [Web][SithasoIONIC7] Adding RTL (Right to Left) Support for your apps by Mashiane
### 01/30/2024
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/158924/)

Hi Fam  
  
Let's add RTL (Right to Left) support for our app, so that is looks like this.  
  
![](https://www.b4x.com/android/forum/attachments/150184)  
  
In pgInitialize  
  

```B4X
Sub Initialize  
    'initialize the app, show ios mode  
    BANano.Await(app.Initialize(Me, "ios"))  
    app.RTL = True
```

  
  
add the code line **app.RTL = True**  
  
All the best coding your mobile apps.  
  
#Coming to the next update