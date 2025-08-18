### Tag management for UI Nodes by Heuristx
### 06/30/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/132125/)

In B4XPages we rely heavily on tags to identify UI elements. Yet tags are valuable for connecting data to the UI, too, and it is easy to feel we are wasting tags for identification.  
There is a very simple and obvious way to use tags in a more flexible way, though. The following idea is not earth-shattering, just a demonstration of how we can solve the problem of the dearth of tags.  
The starting point is:  
  
1) In the UI designer(internal designer) we can only type strings as tag values.  
2) In code we can assign any object to tags.  
3) We don't have to assign values to or read values from tags directly, we can do it through simple Subs that reside in the Main module or in some "Global" code module.  
4) This way we can dynamically create and assign Maps as tag values on the fly:  
  

```B4X
Public Sub GetTag(ANode As Node, AKey As String) As Object  
  
    Private AMap As Map  
  
    If ANode.Tag = Null Then  
  
        AMap.Initialize  
  
      ANode.Tag = AMap  
  
      Return Null  
  
    Else If ANode.Tag Is Map Then  
  
    AMap = ANode.Tag  
  
        Return AMap.Get(AKey)  
  
    Else If ANode.Tag Is String Then 'Obviously, the tag was set in the designer, so it contains the name of the node.   
       'Create a map dynamically and move the node name into it with the key "Name".  
  
        AMap.Initialize  
  
        AMap.Put("Name", ANode.Tag)  
  
        Return AMap.Get(AKey)  
  
    Else  
  
        Log($"Get tag: Node had a tag ${ANode.Tag} already."$) 'It means we violated our own rule and accessed the tag directly.  
  
        AMap.Initialize  
  
        ANode.Tag = AMap  
  
        Return Null 'We lose the data here, but that is because our own code violates the rule that we should access node tags only through these Subs. Go and fix the code.  
  
    End If  
  
End Sub
```

  
  
Assigning a value:  
  

```B4X
Public Sub SetTag(ANode As Node, AKey As String, AVal As Object)  
  
    Private AMap As Map  
  
    If ANode.Tag = Null Then  
  
        AMap.Initialize  
  
        AMap.Put(AKey, AVal)  
  
        ANode.Tag = AMap  
  
    Else If ANode.Tag Is Map Then  
  
        AMap = ANode.Tag  
  
        AMap.Put(AKey, AVal)     
  
    Else If ANode.Tag Is String Then  
  
        AMap.Initialize     
  
        AMap.Put("Name", ANode.Tag)  
  
        AMap.Put(AKey, AVal)  
  
        ANode.Tag = AMap  
  
    Else  
  
        Log($"Set tag: Node had a tag ${N.Tag} already."$)     
  
        AMap.Initialize  
  
        AMap.Put(AKey, AVal)  
  
        ANode.Tag = AMap  
  
    End If  
  
End Sub
```

  
  
This is the basic stuff.  
We can make other convenience methods with these.  
For example, walk the node tree and find a node by name:  
  

```B4X
Public Sub GetNode(APane As Pane, AName As String) As Node  
  
  Private ANodeName As String  
  
  For Each ANode As Node In APane.GetAllViewsRecursive  
  
        ANodeName = GetTag(ANode, "Name")  
  
        If (ANodeName = Null) Or (ANodeName = "") Then Continue  
  
        If ANodeName.EqualsIgnoreCase(AName) Then Return ANode  
  
  Next  
  
    Return Null  
  
End Sub
```

  
  
And then extend this to get a node tag value by node name and key:  
  

```B4X
Public Sub GetNodeTag(APane As Pane, AName As String, AKey As String) As Object  
  
    Private ANode As Node = GetNode(APane, AName)  
  
    If ANode = Null Then Return Null  
  
    Return GetTag(ANode, AKey)  
  
End Sub
```

  
  
Next, we can think about the case of dynamically(in code) created nodes, where we may not know how many nodes exist, and names would be a pain to manage.  
Since we have Maps in Tags, we can assign a Name in the maps, and also an Index. So when you create an ImageView in code and add it to a panel, you can set its name to something like "imgWhatever", and its index to a value that grows in the code.  
Then finding it is easy:  
  

```B4X
Public Sub GetIndexedNode(APane As Pane, AName As String, AnIndex As Int) As Node  
  
  For Each ANode As Node In APane.GetAllViewsRecursive  
  
        Private ANodeName As String = GetTag(ANode, "Name")  
  
        Private ANodeIndex As Int  
  
        If (ANodeName = Null) Or (ANodeName = "") Then Continue  
  
        If ANodeName.EqualsIgnoreCase(AName) Then  
  
            Private AnObj As Object = GetTag(ANode, "Index")  
  
            If (AnObj <> Null) And (AnObj Is Int) Then  
  
                ANodeIndex = AnObj  
  
                If AnIndex = ANodeIndex Then Return ANode  
  
            End If  
  
        End If  
  
  Next  
  
    Return Null  
  
End Sub
```

  
  
This will only work well if you do not remove nodes in code.  
If you have similarly named nodes in a pane, and your code may remove some of them, then reindexing the remaining nodes would be a "pane in the…"  
In that case just set a List in the parent pane's tag, maybe like  
  

```B4X
Private Alist As List  
  
AList.Initialize  
  
SetTag(AParentPane, "Images", AList)
```

  
  
and manage the dynamically added/removed nodes from there.  
It is easy to extend this kind of tag management. After trying it out, I now adopted it as the way to manage UI node tags. Your mileage may vary, this is just an idea.