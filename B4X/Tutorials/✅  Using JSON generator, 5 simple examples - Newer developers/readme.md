### ✅  Using JSON generator, 5 simple examples - Newer developers by Peter Simpson
### 07/28/2021
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/132762/)

Hello all,  
Well here we are with a simple example on how to use the JSON generator, this applies to B4A, B4J and also B4i.  
  
I've created 5 different examples using B4XPages for new B4X developers to hopefully learn from.  
  
Using JSON generator is not difficult and in theory should only take a novice developer a short time to learn. You just need to carefully follow the code flow in the attached examples and within no time you will be generating both simple and more complicated JSON data like a pro.  
  
By mixing and matching Lists with Maps, you can easily create any JSON data structure necessary for your projects.  
  
**Libraries needed:**  
![](https://www.b4x.com/android/forum/attachments/116776)  
  
**PLEASE NOTE:** There are 5 different build configurations, one configuration for each JSON generator example  
![](https://www.b4x.com/android/forum/attachments/116777)  
  
**PLEASE NOTE, Again:**  

1. In some of the examples I have deliberately use a backslash \ like in '\Phones' and in '\age' etc, you can remove the \ as I only placed them there so that the logs will be easier for you to read whilst learning, otherwise those items end up near the bottom of the list and can easily make reading the logs a bit confusing.
2. You can also remove '.Replace("\", "")', but as I've found whilst using some online services, they don't always accept the \ when receiving JSON data.
3. If need be you can delete all of the lines after line 103 in the B4XMainPage, they are the original JSON structures that I was recreating for this tutorial.

  
**Example taken from JSONStructure build configuration**  

```B4X
{  
     "Squad name": "Super hero squad",  
     "Home town": "Metro city",  
     "Formed": 2016,  
     "Secret base": "Super tower",  
     "Active": true,  
     "Members": [  
          {  
               "name": "Molecule Man",  
               "age": 29,  
               "secretIdentity": "Dan Jukes",  
               "Powers": [  
                    "Radiation resistance",  
                    "Turning tiny",  
                    "Radiation blast"  
               ]  
          },  
          {  
               "name": "Madame Uppercut",  
               "age": 39,  
               "secretIdentity": "Jane Wilson",  
               "Powers": [  
                    "Million tonne punch",  
                    "Damage resistance",  
                    "Superhuman reflexes"  
               ]  
          },  
          {  
               "name": "Eternal Flame",  
               "age": 1000000,  
               "secretIdentity": "Unknown",  
               "Powers": [  
                    "Immortality",  
                    "Heat Immunity",  
                    "Inferno",  
                    "Teleportation",  
                    "Interdimensional travel"  
               ]  
          }  
     ]  
}
```

  
  
  
**Enjoy…**