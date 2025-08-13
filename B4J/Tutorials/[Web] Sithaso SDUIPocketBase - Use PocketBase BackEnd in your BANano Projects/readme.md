### [Web] Sithaso SDUIPocketBase - Use PocketBase BackEnd in your BANano Projects by Mashiane
### 10/19/2024
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/163646/)

Hi Fam  
  
Please find attached a pocketbase class based on the [PocketBase JavaScript SDK](https://github.com/pocketbase/js-sdk)  
  
In your BANano project, you need to add this line in App Start  
  

```B4X
BANano.Header.AddJavascriptFile("pocketbase.umd.js")
```

  
  
You declare a variable…  
  

```B4X
Private pb As SDUIPocketBase
```

  
  
Then you initialize it  
  

```B4X
pb.Initialize(Me, "pb", "http://127.0.0.1:8090", "projects")
```

  
  
For any CRUD related actions, you need to define the schema. This tells the class the field names and what types are they. For example  
  

```B4X
pb.SchemaAddText(Array("id", "name"))
```

  
  
There are various methods to add the schema fields.  
  
Related Content  
  
<https://www.b4x.com/android/forum/threads/web-mastering-pocketbase-your-ultimate-guide-to-a-flawless-sqlite-webserver-install-on-windows.161538/#content>  
  
<https://www.b4x.com/android/forum/threads/banano-using-pocketbase-firebase-alternative-for-your-apps.143589/#content>  
  
You can also [perform a search](https://www.b4x.com/android/forum/pages/results/?query=pocketbase) to get all PocketBase related content in the forum