### [ListOfArrays] wLOAExtras.b4xlib for Evaluating Expressions of Columns in ListOfArrays - and More by William Lancee
### 03/31/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170728/)

The wLOAExtras library has two classes:  
**wLOAEval**: class modeled after <https://www.b4x.com/android/forum/threads/b4x-eval-expressions-evaluator.54629/>  
**wLOAExtras**: the works  
  
wLOAExtras has 3 evaluation methods: **EvalReplace EvalAppend EvalCreate**  
They are the same except for where the results end up (replacement of original; appended as extra columns; as a new LOA)  
Think about the evaluator as an interpreter for single lines of B4X code.  
For example, if '**wLOA**' is instance of **wLOAExtras** and A, B, C and D are names of columns of a LOA:  

```B4X
Dim LOA2 As ListOfArrays = wLOA.evalCreate(LOA1, Array(Result), "A + B * (C - D)")
```

  
The arguments are as follows:  
1. The name of the source of all the data LOA  
2. A columns specification which is very flexible  
 - Column names As List  
 - Column names As Array of Objects as in above example  
 - Column name As String will be converted to Array(theString)  
 - Null or "" which will be converted to Array() which signifies "All colums in LOA  
3. The expression to be evaluated  
 - The operators can be any of + - \* / & mod (surrounded by spaces - mod is internally changed to "|")  
 - literal strings - surrounded by SINGLE quotes - are turned into tokens as a first step  
 - numerical values are treated as expected  
 - The function calls can be any of the standard native B4X plus some extras  
 **Min Max Sin Cos Tan Abs Floor Ceil Round Sqrt ATan Power Logarithm And Nand Or Nor Not   
 Asc Chr Length Substring2 Substring Replace ToLowerCase ToUpperCase ToCamelCase ToTitleCase Contains  
 Indexof Indexof2 Lastindex Lastindexof2 Standardize Normalize DegreesToRadians RadiansToDegrees**  
 - Note that Min Max And Nand Or Nor can have more than two arguments  
 - If a specified operation or function can not be applied to its operands, the result will be the Null object.  
 - All angles in trigonometry functions will be in degrees.  
 - All ? in the expression will be replaced by the name of the current column being processed  
  
**wLOAExtras** has 5 convenient creation functions - particularly useful for creating test LOAs.  
They are: **Constants, Sequence, Collect, RandomInt, RandomDouble**  
You specify the shape of the table: nrows and ncols.  
**Collect** takes what is provided in the Array(…) and cycles through the items to fill the table.  
  
You can also shuffle the items afterwards in place with **ShuffleRows, ShuffleCols  
  
wLOAExtras** has methods for selecting rows - A new LOA with new rows is created:  
a. when a evaluation expression (as specified above) is true. [**RowsIfTrue**]  
b. when all items in a row are valid (non-Null and with an object type equal to  
 the column's predominant object type (>95% of items have this type) [**RowsIfValid**]  
  
You can also create new LOAs by selecting columns from another LOA (in any order), or by excluding columns (keeping order): **SelectCols** and **ExcludeCols**  
  
Two functions are extremely useful in statistical work and machine learning projects. Both produce new LOAs with new rows:  
a. **Recode**: changes a value into another using a Map. The newly created LOA has new rows.  
b. **One-Hot:** transforms one column of categorical data into multiple columns of 0 or 1 if the value=category  
  
Column names in newly created LOAs in this library are generated automatically based on a schema you specify.  
"c": c\_1 c\_2 c\_3 etc. [This is the default if you don't specify anything]  
"C": C1 C2 C3 etc.  
"\_": \_1\_ \_2\_ \_3\_ etc.  
"A": A B C … Z AA BB CC etc.  
"a": a b c … z aa bb cc etc.  
You can make your own schema by calling wLOA.NameSchema with a callback reference to a Sub.  
That sub should change a column index into a name string. The sub '**applyStyle(**)' in wLOA may help to do that.  
  
After a LOA is created, you can change any of its column names with the **RenameColumns** method which uses a Map.  
  
There is a fancy **wLOA.Display** method that tries to keep the columns aligned in the Logs.  
It can display any number of rows and format numerical data.  
For the curious among you who looked at the examples running in B4J: where did the name of the LOA come from?  
You'll have to unzip the wLOAExtras.b4xlib and look at the wLOA module in the Display method.  
  
There is informative error handling for unknown column names and unknown function references.  
  
There are many **DateTime** functions. This subject will be discussed in a later post.  
  
The **ListOfArrays** is an excellent object to use for vector and matrix specification for  
a wide variety of tools. For example:  
 summary statistics: sum mean variance stdDev frequencies median percentiles  
 matrix operations: reshape transpose inverse  
 other: regression breakdown graphs grid  
   
I invite you to contribute additional items to this list.  
If you are interested, take a look at the source code for **wLOAExtras**  
Copy wLOAExtras.b4xlib to a new folder, change name to wLOAExtras.zip and unzip.  
  
Post here for suggestions for improvement of if you encountered a bug. You may also PM me.  
  
Note: I have tested in B4J console, B4Pages (both B4J and B4A) and B4A default templates.