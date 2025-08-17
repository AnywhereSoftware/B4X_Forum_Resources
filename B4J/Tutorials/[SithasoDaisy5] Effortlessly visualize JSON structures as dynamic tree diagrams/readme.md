### [SithasoDaisy5] Effortlessly visualize JSON structures as dynamic tree diagrams by Mashiane
### 03/27/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/166337/)

Hi Fam  
  
With SithasoDaisy5, you have the capability to view JSON files as dynamic trees. This is wrapping this [Github](https://github.com/xzitlou/jsontr.ee) project.  
  
![](https://www.b4x.com/android/forum/attachments/162972)  
  
  
The code is as simple as feeding the component your Map. You can also feed it a JSON string.  
  

```B4X
Sub Show(MainApp As SDUI5App)  
    app = MainApp  
    BANano.LoadLayout(app.PageView, "jsontreeview")  
    pgIndex.UpdateTitle("SDUI5JsonTree")  
    '  
    Dim members As List  
    members.Initialize   
    members.Add(CreateMap("name": "Molecule Man", "age": 29, "secretIdentity": "Dan Jukes", "powers": Array("Radiation resistance", "Turning tiny", "Radiation blast")))  
    members.Add(CreateMap("name": "Madame Uppercut", "age": 39, "secretIdentity": "Jane Wilson", "powers": Array("Million tonne punch", "Damage resistance", "Superhuman reflexes")))  
    '  
      
    '  
    Dim j As Map = CreateMap()  
    j.Put("squadName", "Super hero squad")  
    j.Put("homeTown", "Metro City")  
    j.Put("formed", 2016)  
    j.Put("secretBase", "Super tower")  
    j.Put("active", True)  
    j.Put("members", members)  
    jTree.JSON = j  
    jTree.Refresh  
      
End Sub
```