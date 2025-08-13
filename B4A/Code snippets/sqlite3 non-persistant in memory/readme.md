### sqlite3 non-persistant in memory by optionexplicit
### 02/03/2024
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/159010/)

not yet tested but should work:  
  
using a reserved pseudo-filename like :memory: you should be able to have an sqlite db in memory [1].  
Especially for accessing complex tuples and for sorting them, it could be usefull to have access to a relatonal database which is just an in memory thing.  
like hardcoding all entries into the code, while filtering it with sql.  
this could circumvent the asset read-only problem, and the missing sync function in B4A.  
the better way would be an r/w asset or an auto sync thing supported in B4A, but there is no possibility (which is very easy to use for a lazy programmer).  
the problem is, during testing i want to manipulate my db quickly, and want to make it be sync everytime i start or stop the debugger.  
maybe this can do the job for others, too. (if it works, if not it should be implemented quickly, i think its no hassle)  
  
[1] <https://www.sqlite.org/inmemorydb.html>