###   Store and access the positions of B4XViews by b4x-de
### 07/14/2026
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/171546/)

[In this thread, Knoppi was looking for](https://www.b4x.com/android/forum/threads/save-position-of-b4xviews.171526/) a way to store and access the positions of B4XViews. I use this approach in all my B4X projects, and maybe others will find it useful too. That's why I'm posting it here in the Code Snippets section of the forum.  
  

```B4X
' Declare it like this  
Private mxvpDefaultPositions As XViewPositions  
' …  
  
' Capture positions  
mxvpDefaultPositions.capture(lblTitleComplete.As(B4XView))  
  
' Get the position  
Dim posTitleComplete As XViewPosition = mxvpDefaultPositions.from(lblTitleComplete.As(B4XView))  
  
' Use the position  
lblTitleComplete.Top = posTitleComplete.Top + 10dip
```

  
  
The code above is based on this class.  
  

```B4X
' Class XViewPositions  
Sub Class_Globals  
    Type XViewPosition (Left As Int, Top As Int, Width As Int, Height As Int)  
    Private mmapPositionsByView As Map  
End Sub  
  
' Initializes the position store.  
Public Sub Initialize  
    mmapPositionsByView.Initialize  
End Sub  
  
' Removes all captured positions.  
Public Sub clear  
    mmapPositionsByView.Clear  
End Sub  
  
' Returns True when a position exists for the view.  
' pView - View that acts as storage key.  
Public Sub contains(pView As B4XView) As Boolean  
  
    If pView = Null Or Not(pView.IsInitialized) Then  
        Log("View missing")  
        Return False  
    End If  
  
    Return mmapPositionsByView.ContainsKey(pView)  
End Sub  
  
' Captures current bounds of a view and stores them.  
' pView - View to capture. Null or uninitialized views return a zero position.  
' Returns captured XViewPosition.  
Public Sub capture(pView As B4XView) As XViewPosition  
    Dim posCaptured As XViewPosition  
  
    posCaptured = createPositionFromView(pView)  
  
    If Not(pView = Null) And pView.IsInitialized Then  
        mmapPositionsByView.Put(pView, posCaptured)  
        Return posCaptured  
    End If  
  
    Log("View missing")  
    Return posCaptured  
End Sub  
  
' Stores a position for a view key.  
' pView - View that acts as storage key.  
' pPosition - Position to store for the view.  
Public Sub put(pView As B4XView, pPosition As XViewPosition)  
  
    If pView = Null Or Not(pView.IsInitialized) Then  
        Log("View missing")  
        Return  
    End If  
  
    mmapPositionsByView.Put(pView, pPosition)  
End Sub  
  
' Returns stored position for a view or a zero position.  
' pView - View that acts as storage key.  
' Returns stored XViewPosition or zero position when missing.  
Public Sub from(pView As B4XView) As XViewPosition  
  
    If contains(pView) Then  
        Return mmapPositionsByView.Get(pView)  
    End If  
  
    Log("Position missing")  
    Return createPosition(0, 0, 0, 0)  
End Sub  
  
' Removes stored position for a view.  
' pView - View that acts as storage key.  
Public Sub remove(pView As B4XView)  
  
    If pView = Null Or Not(pView.IsInitialized) Then  
        Log("View missing")  
        Return  
    End If  
  
    If mmapPositionsByView.ContainsKey(pView) Then  
        mmapPositionsByView.Remove(pView)  
    End If  
  
    xlog.finishMethod  
End Sub  
  
' Returns number of stored positions.  
Public Sub getSize As Int  
    Return mmapPositionsByView.Size  
End Sub  
  
' Creates a position from view bounds or zero values.  
' pView - View to read from.  
' Returns XViewPosition based on current view bounds.  
Private Sub createPositionFromView(pView As B4XView) As XViewPosition  
    If pView = Null Or Not(pView.IsInitialized) Then  
        Return createPosition(0, 0, 0, 0)  
    End If  
  
    Return createPosition(pView.Left, pView.Top, pView.Width, pView.Height)  
End Sub  
  
' Creates a detached position value.  
' pintLeft - Left coordinate in dips.  
' pintTop - Top coordinate in dips.  
' pintWidth - Width in dips.  
' pintHeight - Height in dips.  
' Returns new XViewPosition.  
Public Sub createPosition(pintLeft As Int, pintTop As Int, pintWidth As Int, pintHeight As Int) As XViewPosition  
    Dim posResult As XViewPosition  
    posResult.left = pintLeft  
    posResult.top = pintTop  
    posResult.width = pintWidth  
    posResult.height = pintHeight  
    Return posResult  
End Sub
```