### [BANano] Serializing & De-Serializing Objects - "Type" to Json/Map and back by Mashiane
### 09/18/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/122520/)

Ola  
  
M sitting here and thinking if I can work with a "type" object as a "map" object and vise versa and or even "type to json". For example, I can define my stuff as a type variable, serialize it as JSON, save to a db and then get it back and JSON and then convert to Type, update it and save it back etc etc.  
  
This is possible because of BANano.FromJSON and BANano.ToJSON  
  
1. Define a type object.  
  

```B4X
Type Order(ProductKey As String, Amount As Double, Comment As String)
```

  
  
2. Initialize an instance and convert to JSON i.e. Serialize  
  

```B4X
Dim myorder As Order  
    myorder.Initialize  
    myorder.Amount = 10.00  
    myorder.Comment = "This is a test…"  
    myorder.ProductKey = "123456"  
    '  
    Dim toJSON As String = BANano.ToJson(myorder)
```

  
  
***Output (NB: note the \_ prefix)***  
  
![](https://www.b4x.com/android/forum/attachments/100242)  
  
You can save this serialized object to a db or something.  
  
3. Convert the JSON back to the type i.e. Deserialize  
  

```B4X
Dim fromJSON As Order = BANano.FromJson(toJSON)  
    Log("JSON to Type")  
    Log(fromJSON.Amount)  
    Log(fromJSON.Comment)  
    Log(fromJSON.ProductKey)  
    Log(fromJSON)
```

  
  
**Q. What if you want to use the type as a MAP object?**  
  
Convert the JSON string to a map and update the amount *(Note the prefix \_)*  
  

```B4X
'comvert the serialized JSON to Map  
Dim orderMap As Map = BANano.FromJson(toJSON)  
    Log("Type to Map")  
    Log(orderMap)  
    orderMap.put("_amount", 1000.00)
```

  
  
Convert the MAP back to the Type  
  

```B4X
'convert a map to a type  
Dim m2j As String = BANano.ToJson(orderMap)  
    Dim ut As Order = BANano.FromJson(m2j)  
    Log("Map to Type")  
    Log(ut)  
    Log(ut.Amount)
```

  
  
The Type to Map functionality is not necessarily needed as you can just update, serialize and de-serialize the type object using ToJSON and FromJSON, but has been added for brevity.  
  
Ta!