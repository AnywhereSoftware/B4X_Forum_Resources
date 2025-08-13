### Standardize Keys in Key-Value Maps by William Lancee
### 03/03/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/159642/)

I have often used Maps as a means of sending property information to Subs  
One problem, easily fixed, is that the person specifying the map with 'CreateMap' may use a different case-ness in the keys than expected.  
Also, they (you) may inadvertently add spaces at start or end of key.  
In both situations the receiving sub won't find the expected item in the map.  
  
Here is an extremely simple way to allow for variations in naming keys without affecting functionality.  

```B4X
'Returns a Map which has the same keys and values as the original - keywords are set to lowerCase and are Trim-med  
Private Sub StandardizeKeywords(mp As Map) As Map  
    Dim newM As Map  
    newM.initialize  
    For Each kw As String In mp.Keys  
        newM.Put(kw.ToLowerCase.trim, mp.Get(kw))  
    Next  
    Return newM  
End Sub
```

  
  
When the receiving Sub looks at an externally prepared Map, it should be wrapped in StandardizeKeywords(theMap)  
  

```B4X
Private Sub ReceivingSub(theMap as Map)  
    Dim properties As Map = StandardizeKeywords(theMap)  
    '…'  
End Sub
```

  
  
Example of use see <https://www.b4x.com/android/forum/threads/b4x-a-b4xpages-class-for-displaying-a-flexible-horizontal-tree.159614/>