### Render a Node by Patent
### 01/02/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/158374/)

Dear community,  
  
here is a snip about NEW rendering of any node in any size you want.  
Yery useful: the original Node is not altered.  
  
Works with B4J, not tested with B4A.  
  
Enjoy  
  
  

```B4X
Private Sub RenderNode (factorX As Double, factorY as Double, sourceView As B4XView) As B4XBitmap  
      
        Dim scale As JavaObject  
        scale.InitializeNewInstance("javafx.scene.transform.Scale", Array(factorX , factorY))        
              
        Dim snapParas As JavaObject  
        snapParas.InitializeNewInstance("javafx.scene.SnapshotParameters",Null)  
        snapParas.RunMethodJO("setTransform",Array(scale))  
              
        Dim nod As JavaObject = sourceView.As(Node)  
        Dim snapshot As JavaObject = nod.RunMethodJO("snapshot", Array(snapParas,Null))        
                  
        Return snapshot.As(B4XBitmap)  
  
End Sub
```

  
  

```B4X
Dim snap As B4XBitmap = RenderNode(3.0, 3.0, B4XPages.MainPage.Root)  
  
Dim out As OutputStream  
out = File.OpenOutput("C:\", "Snap.png", False)  
snap.WriteToStream(out, 100, "PNG")  
out.Close
```