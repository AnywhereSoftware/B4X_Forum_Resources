### [PyBridge] The very basics by Erel
### 02/17/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/165654/)

PyBridge is a framework that allows accessing Python libraries from within B4J.  
  
It works by starting a Python process that connects to the B4J process. The Python process receives commands from the B4J process and executes them.  
From the developer perspective it is very similar to accessing native APIs with JavaObject or with inline Java. There are two important differences:  
1. The execution happens in a different process.  
2. Python is nicer than Java. Especially with small code snippets and dynamic context.  
  
![](https://www.b4x.com/android/forum/attachments/161791)  
All the communication happens under the hood with AsyncStreams + B4XSerializator. This is important as not all types can be serialized (it is possible to extend the serialization process with custom types).  
  
A command looks like this:  
  
![](https://www.b4x.com/android/forum/attachments/161792)  
  
Note that the flow is generally unidirectional - B4J sends commands to Python. The commands are also unidirectional. The allows the commands to be queued, and B4J doesn't wait for the commands to actually be executed. It is very important in terms of performance.  
  
Lets start with an example:  

```B4X
Dim Tuple As PyWrapper = Py.WrapObject(Array(1, 2, 3, 4, 5))  
Tuple.Print  
Tuple.TypeOf.Print2("type is:", "", False)  
Dim list As PyWrapper = Tuple.ToList  
list.Run("append").Arg(6)  
list.Print  
Log("after")
```

  
  
Py.WrapObject - sends the object to Python. The result of sending a B4J array is a Python Tuple. Tuple ~= read only array.  
Tuple.Print - tells Python to print the object.  
Tuple.TypeOf.Print2 - Get the type of the object and print it.  
ToList - convert the object to a list. This is very useful in Python. All iterable objects can be converted to a list.  
And now for something important:  

```B4X
list.Run("append").Arg(6)
```

  
list.Run - starts a call to the append method. After this call we can add positional or named arguments using Arg or ArgNamed. This makes it easier to access Python methods that sometimes have many many arguments.  
So the output of this code:  
![](https://www.b4x.com/android/forum/attachments/161793)  
As you can see, the Python process output (captured by Shell library) is logged with blue color.   
Note that "after" was logged before everything else. As previously stated, the B4J process doesn't wait for the Python process. It runs ahead.  
If for some reason we do want to wait for all commands to complete:  

```B4X
list.Print  
Wait For (Py.Flush) Complete (Success As Boolean)  
Log("after")
```

  
Now Log("after") will only run after all previous commands were actually processed.  
  
We have a list in the python process. We want to fetch it back to B4J. Tip: Don't fetch too much. It will slow down the execution.  

```B4X
Wait For (list.Fetch) Complete (list As PyWrapper)  
Log(list.Value)  
Dim MyList As List = list.Value
```

  
Don't forget to call Fetch as the execution will not continue without it.  
  
Calling PyWrapper.Value will raise an exception if there was an error in the Python process. You can catch it and there are also methods to check it.