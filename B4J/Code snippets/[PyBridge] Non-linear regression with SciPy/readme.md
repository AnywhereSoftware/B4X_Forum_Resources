### [PyBridge] Non-linear regression with SciPy by Erel
### 05/13/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166985/)

![](https://www.b4x.com/basic4android/images/java_XLOnwdMrvc.gif)  
  
New implementation similar to: <https://www.b4x.com/android/forum/threads/playing-with-linear-regression.110759/#content>  
Using SciPy (<https://www.b4x.com/android/forum/threads/pybridge-finding-local-minimum-of-a-function-with-scipy.166881/#content>) to find the best fit function parameters.  
  
It is based on scipy.optimize.curve\_fit which takes as an input a function and X and Y values, and tries to find the parameters that minimize the error.  
  
Functions are defined with Py.Lambda:  

```B4X
functions.Add(CreateMyFunction(Py.Lambda("x, a, b: a * x + b"), xui.Color_Blue)) 'linear function  
functions.Add(CreateMyFunction(Py.Lambda("x, a, b, c: a * x ** 2 + b * x + c"), xui.Color_Green)) '2nd degree polynom  
functions.Add(CreateMyFunction(Py.Lambda("x, a, b, c, d: a * x ** 3 + b * x ** 2 + c * x + d"), xui.Color_Gray)) '3rd degree polynom
```

  
  
Adding support for serialization of numpy.ndarrays:  

```B4X
Dim converters As PyWrapper = Py.Bridge.GetField("comm").GetField("serializator").GetField("converters")  
converters.Set(np.GetField("ndarray"), Py.Lambda("arr: arr.tolist()"))
```

  
  
Note that the functions aren't limited to polynomial functions.