### Translation Memory by xulihang
### 04/15/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170824/)

I created a library for translation memory.  
  
What is translation memory? It is a pair of source text and target text.   
  
For example:  
  
source text: I love my dog.  
target text: 我爱我的狗。  
  
source text: I love my cat.  
target text: 我爱我的猫。  
  
The library stores the translation memory in a SQLite database with an extra note field.   
  
It supports fuzzy match. It enables the FTS4 full text search for quick retrieval of text with keywords and then uses edit distance to calculate the similarity of the query and the stored text.  
  
It is mainly used in my computer-aided translation tools.  
  
Usage:  
  
1. Create a database.  
  

```B4X
Dim externalTM As TM  
externalTM.Initialize(File.DirApp,"test.db","ja","zh")
```

  
  
2. Import translation memory from csv, tab-delimited text or TMX.  
  

```B4X
Dim files As List  
files.Initialize  
files.Add(File.Combine(File.DirApp,"data.csv"))  
files.Add(File.Combine(File.DirApp,"data.txt"))  
files.Add(File.Combine(File.DirApp,"data.tmx"))  
externalTM.Clear  
externalTM.Import(files)
```

  
  
3. Fuzzy match.  
  

```B4X
wait for (externalTM.getMatchList("一匹の子犬",0.7,False,100)) complete (result As List)  
Log(result)
```