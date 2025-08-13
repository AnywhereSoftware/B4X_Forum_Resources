### Using Java 8+ lambdas with inline Java code by Erel
### 04/17/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/160551/)

1. Download attached library and put in additional libraries folder.  
2. Add to main module:  

```B4X
#AdditionalJar: core-lambda-stubs.jar, ReferenceOnly
```

  
  
  
Example:  

```B4X
'in B4XPage  
#if java  
import java.util.*;  
public void test() {  
 List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);  
    numbers.forEach( (n) -> BA.Log("" + n) );  
}  
#End If
```

  
  

```B4X
Me.as(JavaObject).RunMethod("test", Null)
```