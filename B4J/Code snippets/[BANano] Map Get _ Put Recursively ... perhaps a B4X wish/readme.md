### [BANano] Map Get / Put Recursively ... perhaps a B4X wish... by Mashiane
### 06/19/2021
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/131795/)

Ola  
  
With the jsPDF library that i'm using, the data structures are deeply imbedded, for example.  
  

```B4X
data.cell.styles.textColor = [0. 255. 50]
```

  
  
So I was thinking, what if one was able to recursively execute a map get/set using a path?  
  
In normal circumstances to create a map object like this tree structure (image from console.log)  
  
![](https://www.b4x.com/android/forum/attachments/115201)  
  
One has to write source code like this..  
  

```B4X
Dim m As Map = CreateMap()  
    Dim user As Map = CreateMap()  
    Dim address As Map = CreateMap()  
    address.Put("addressline1", "")  
    address.Put("addressline2", "")  
    address.Put("city", "")  
    address.Put("province", "")  
    address.Put("country", "")  
    user.put("firstname", "")  
    user.Put("lastname", "")  
    user.Put("address", address)  
    m.Put("user", user)
```

  
  
Comes in ***RecursivePut***… (for BANano)  
  

```B4X
Sub RecursivePut(data As Map, path As String, value As Object)  
    Dim prevObj As BANanoObject = data  
    Dim items As List = BANano.Split(".", path)  
    Dim iTot As Int = items.Size  
    Dim iCnt As Int  
    '  
    Dim strprev As String = ""  
    Dim prtObj As BANanoObject  
    Dim litem As String = items.Get(iTot - 1)  
    '  
    For iCnt = 1 To iTot - 1  
        'get the previos path  
        strprev = items.Get(iCnt - 1)  
        'the parent object  
        prtObj = prevObj.GetField(strprev)  
        'this does not exist, create it  
        If BANano.IsUndefined(prtObj) Then  
            Dim no As Object  
            prevObj.SetField(strprev, no)  
            prevObj = prevObj.GetField(strprev)  
        Else  
            prevObj = prtObj  
        End If  
    Next  
    prevObj.SetField(litem, value)  
End Sub
```

  
  
So if we run this example, even, if the map is initialized empty  
  

```B4X
Dim m as Map = CreateMap()  
RecursivePut(m, "user.firstname", "Anele")  
    RecursivePut(m, "user.lastname", "Mbanga")  
    RecursivePut(m, "user.address.addressline1", "40.71")  
    RecursivePut(m, "user.address.addressline2", "-73.98")  
    RecursivePut(m, "user.address.city", "Moon Colony")  
    RecursivePut(m, "user.address.province", "Close to Mars")  
    RecursivePut(m, "user.address.country", "Outer Space")  
    RecursivePut(m, "user.firstname", "Ozzie")  
    RecursivePut(m, "user.loves", "B4X")
```

  
  
We get (image from console.log)  
  
![](https://www.b4x.com/android/forum/attachments/115202)  
   
  
Imma try and get the Get working….  
  
Enjoy!