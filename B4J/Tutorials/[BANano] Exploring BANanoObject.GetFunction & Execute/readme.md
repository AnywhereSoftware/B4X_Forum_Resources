### [BANano] Exploring BANanoObject.GetFunction & Execute by Mashiane
### 11/06/2019
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/111171/)

Ola  
  
The newest version of BANano comes with a lot of enhancements and some very interesting stuff. There's so much to learn.  
  
So I decided to check one interesting thing out, Getting / Executing a function.  
  
What does this really mean, I thought.  
  
Let's make a simple assumption based on a javascript Object.  
  

```B4X
var cody = new Object();   
cody.living = true;   
cody.age = 33;   
cody.gender = 'male';   
cody.getGender = function () { return cody.gender; };   
console.log(cody.getGender()); // Logs 'male'.
```

  
  
To try and demonstrate this, we will NOT use a map but an actual object and initialize it. For this I have created a JSObject class in my code. This JSObject class tries and replicates the simple example to create the above object.  
  
1. var cody = new Object();  
  

```B4X
obj.Initialize2("Object", Null)
```

  
  
2. cody.living = true; We will use the .setField for this  
  

```B4X
obj.SetField(k, v)
```

  
  
and later..  
  
3. cody.getGender = function () { return cody.gender; };   
  
We need to create a callback function for this. We will do this in our module and use a global variable.  
  
We have created a shortcut for this in our JSObject class.  
  

```B4X
obj.setCallBack("getGender", Me, "getGender", Null)
```

  
  
Lets define a method to assign a callback to an object property.  
  

```B4X
Sub getGender As String  
    Return obj.get("gender")  
End Sub
```

  
  
The property is getGender and the function to call should return the "gender" property of the object.  
  
This .setCallBack method has been defined as..  
  

```B4X
'set a callback  
Sub setCallBack(k As String, module As Object, methodname As String, params As List)  
    Dim cb As BANanoObject = BANano.CallBack(module, methodname, params)  
    obj.SetField(k, cb)  
End Sub
```

  
  
We pass it the module, method name and the params it needs.  
  
To be able to run out "getGender" property, we need a way to have the function/callback execute from the object itself. For that we have created a method in our JSObject class to call.  
  

```B4X
Log(obj.getCallBack("getGender"))
```

  
  
As our method is not passed any variables, we just define and call it with null. What getCallBack does is to read the property we previsouly defined. i.e. getGender => callback and then executes it.  
  

```B4X
'get callback  
Sub getCallBack(k As String) As BANanoObject  
    Dim cb As BANanoObject = obj.GetFunction(k)  
    Return cb.Execute(Null)  
End Sub
```

  
  
We can extend this to have it accept params and pass them to .Execute. Because the "getGender" method returns something, thats why I have returned cb.Execute.  
  
I'm also getting my head around this, however I hope it provides some green lights into the methodology.  
  
#You are welcome to add/improve/correct anything on the thread.  
  
#TheUsualExperimentor  
  
PS: The complete code  
  

```B4X
'Static code module  
Sub Process_Globals  
    Private BANano As BANano  'ignore  
    Private obj As JSObject  
End Sub  
  
  
Sub Init  
    obj.Initialize  
    obj.set("living", True)  
    obj.set("age", 33)  
    obj.set("gender", "male")  
    obj.setCallBack("getGender", Me, "getGender", Null)  
      
    Log(obj.It)  
    Log(obj.ToJSON)  
    Log(obj.getCallBack("getGender"))  
End Sub  
  
  
Sub getGender As String  
    Return obj.get("gender")  
End Sub
```

  
  
Results of the logs  
  
![](https://www.b4x.com/android/forum/attachments/85302)