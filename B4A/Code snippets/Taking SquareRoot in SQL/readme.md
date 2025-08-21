### Taking SquareRoot in SQL by RB Smissaert
### 10/22/2019
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/110722/)

SQLite doesn't have SQTR as a standard function, so you would normally do this in code.  
There is a way though to do this in SQL with a CTE:  
  

```B4X
 strSQL = "update Table1 set xValue = (" & _  
    "with Guesses(FindRootOf, " & _  
    "guessRoot) as (" & _  
    "select xValue, " & _  
    "case when xValue < 0 then null else xValue / 2.0 end " & _  
    "union " & _  
    "select FindRootOf, " & _  
    "(GuessRoot + FindRootOf / GuessRoot) / 2.0 As NewGuessRoot " & _  
    "from Guesses " & _  
    "where GuessRoot > 0.0) " & _  
    "select GuessRoot " & _  
    "from Guesses " & _  
    "order by abs(GuessRoot * GuessRoot - FindRootOf) limit 1)"  
 SQL1.ExecNonQuery(strSQL)  


```B4X
This is about 4x faster than taking the values with a select statement, taking the SQRT in B4A code and  
updating the new value back.  
  
RBS
```
```