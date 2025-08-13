### Recursive Tree Parsing - simple example by Mashiane
### 10/16/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/143558/)

Hi  
  
The json tree source code inspires this example.   
  
1. You have a map object with a "children" key.   
2. This "children" key holds a list of items, which can also have other "children" keys.  
3. This returns a list of all items where each child has an "attributes" key  
  
Usage:  
  

```B4X
Dim treeSchema As List  
Dim tree As Map = CreateMap("children": …)  
treeSchema = ParseTree(tree)
```

  
  
Snippet  
  

```B4X
Sub ParseTree(root As Map)  
    'does this contains children  
    If root.ContainsKey("children") Then  
        'get the children  
        Dim children As List = root.Get("children")  
        'loop through each child  
        For Each child As Map In children  
            'create a new record  
            Dim nitem As Map = CreateMap()  
            'get some prop  
            Dim tagName As String = child.GetDefault("tagName", "")  
            Dim parentID As String = root.GetDefault("id", "")  
            'update new record  
            nitem.Put("tagname", tagName)  
            nitem.Put("parent", parentID)  
            'does this child have attributes  
            If child.ContainsKey("attributes") = False Then Continue  
            'get the attributes  
            Dim attrs As Map = child.get("attributes")  
            For Each attr As String In attrs.Keys  
                Dim attrv As String = attrs.Get(attr)  
                nitem.Put(attr, attrv)  
            Next  
            treeSchema.Add(nitem)  
            ParseTree(child)  
        Next  
    End If  
End Sub
```