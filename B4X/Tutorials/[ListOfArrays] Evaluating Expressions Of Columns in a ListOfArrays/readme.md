### [ListOfArrays] Evaluating Expressions Of Columns in a ListOfArrays by William Lancee
### 03/24/2026
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/170669/)

Consider a ListOfArrays with columns "A", "B", and "C" with 5 rows of numbers.  
You would like to see the result of A + B \* C.  
This is possible with 'wLOAUtils'.  
  
I used the bones of the expression evaluator class created by [USER=1]@Erel[/USER]  
<https://www.b4x.com/android/forum/threads/b4x-eval-expressions-evaluator.54629/>  
  
I was surprised by how well it works, mostly due to the elegant two-way recursion in the original eval class.  
This is a simple demo - see the attached project for many other more complex examples.  
  

```B4X
    'Create a 5 x 3 table of random integers with default column names  
    Dim LOA1 As ListOfArrays = wLOAUtils.randomInt(5, 3, Array(1, 10))     
      
    'Rename columns for demo  
    wLOAUtils.renameColumns(LOA1, CreateMap("c_1": "A", "c_2": "B", "c_3": "C"))  
      
    'Display the table  
    wLOAUtils.display(LOA1, 0, 0)  
      
    'Modify the table by computing a new column based on an evaluated expression  
    wLOAUtils.eval(LOA1, "Result", "A + B * C")     
    wLOAUtils.display(LOA1, 0, 0)  
      
#if demoLog  
  
A     B     C   
――――――――――――――――――――――――  
1     4     9   
5     1     6   
6     9     10  
4     3     3   
7     3     7   
―――――――――――― #rows=5 #cols=3  
      
EVAL: Result = A + B * C  
A     B     C      Result  
――――――――――――――――――――――――  
1     4     9      37         
5     1     6      11         
6     9     10     96         
4     3     3      13         
7     3     7      28         
―――――――――――― #rows=5 #cols=4  
  
#end if
```

  
  
The source code is attached, as well as an extensive set of auxilliary utility functions for LOA.  
They are arranged in three code modules so that they are available from anywhere in your App.  
  
It is still early since the introduction of LOA, so [USER=1]@Erel[/USER] may have plans to expand on LOAUtils functions and ListOfArrays methods.  
He is free to use any of the ideas in the modules in the development of LOA, in any way he thinks fit.  
  
If you have any questions or suggestions please post here.