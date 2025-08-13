### [PyBridge] Finding local minimum of a function with SciPy by Erel
### 05/05/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166881/)

SciPy is a very powerful scientific library with a vast range of features: <https://scipy.org/>. This code snippet provides a tiny glimpse to this library.  
  
Imports:  
pip install scipy  
pip install matplotlib  
  
It uses the optimize module to find a local minimum of a n-dimension function.  
  
First example:  

```B4X
Dim func As PyWrapper = Py.Lambda("x: (x - 3) ** 2 + 2 * x - 1") '** is the power operator: (x - 3) ^ 2 + 2 * x - 1  
Dim res As PyWrapper = optimize.Run("minimize").Arg(func).Arg(Array(10)) '10 is the starting point for the optimization algorithm.  
res.Print
```

  
  
  
  
![](https://www.b4x.com/android/forum/attachments/163886)  
Second example with a 2d function:  

```B4X
Dim func As PyWrapper = Py.Lambda("x: np.sin(x[0]) + np.cos(x[1]) + 0.1 * (x[0] ** 2 + x[1] ** 2)") 'x is a vector with 2 elements  
Dim res As PyWrapper = optimize.Run("minimize").Arg(func).Arg(Array(2, 2)) '(2, 2) is the starting point.  
res.Print
```

  
np is the numpy module.  
  
![](https://www.b4x.com/android/forum/attachments/163887)  
  
Project is attached.