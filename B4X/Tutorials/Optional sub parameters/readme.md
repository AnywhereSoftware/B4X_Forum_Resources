###  Optional sub parameters by Erel
### 08/26/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/171906/)

This is a new feature that will be added to the B4X tools.  
  
Optional sub parameters are parameters that are declared with a default value. If an optional parameter is omitted when the sub is called, the compiler inserts the default value.  
This provides an opportunity to set reasonable defaults without restricting the flexibility of the API. Many cases where we currently have multiple similar methods could be organized better using optional parameters.  
  
Declaring a sub with optional parameters is done by adding = [value] after each optional parameter.  
A required (non-optional) parameter can't come after an optional parameter. This means that all optional parameters must be listed at the end.  
The default value can be a string, number, Null or other simple expressions. In the case of default values declared in Java / OBJC libraries, expressions are not supported.  

```B4X
Public Sub ExecQuerySingleResult(Query As String, Args As List = Null, DefaultValue As Object = Null) As Object  
'Calling:  
ExecQuerySingleResult("query here")  
ExecQuerySingleResult("query here", Array(args, here))  
ExecQuerySingleResult("query here", Array(args, here), DefaultValueHere)  
  
Public Sub ToString (MaxNumberOfRows As Int = 5) As String  
'Calling:  
ToString  
ToString(10)
```

  
  
Declaring optional sub parameters in Java library:  

```B4X
    public static String BytesToString(byte[] Data, @DefaultValue("0") int StartOffset, @DefaultValue("-1")int Length,  
            @DefaultValue("UTF-8") String CharSet)  
  'calling:  
BytesToString(b)  
BytesToString(b, 0, b.Length, "CP-1252")  
  
  public Object RunMethod(String MethodName, @DefaultValue("Null") Object[] Params)  
'calling  
jo.RunMethod("clear")  
jo.RunMethod("clear", Null)  
jo.RunMethod("clear", Array(1, 2, 3))
```

  
Note that it is always a string value. It will be parsed when the library is loaded based on the parameter type.  
  
As this is a compile-time feature, dynamically calling subs with CallSub requires all parameters.