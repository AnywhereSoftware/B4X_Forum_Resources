Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=1
@EndOfDesignText@

Sub Class_Globals
    Private mJavaTree As JavaObject
End Sub

'Creates a Sort-Tile-Recursive R-tree spatial index.
'nodeCapacity: maximum number of entries per tree node. Recommended value: 10.
Public Sub Initialize(nodeCapacity As Int)
    Dim args(1) As Object
    args(0) = nodeCapacity
    mJavaTree.InitializeNewInstance("org.locationtech.jts.index.strtree.STRtree", args)
End Sub

'Inserts an element into the index with its bounding envelope.
'env: the bounding box of the element.
'element: any object to store, e.g. a String ID, Integer index, or JTSGeometry.
Public Sub Insert(env As JTSEnvelope, element As Object)
    mJavaTree.RunMethod("insert", Array(env.GetJavaEnv, element))
End Sub

'Returns all elements whose envelope overlaps searchEnv.
'May include false positives - run exact Intersects() on results to confirm.
'searchEnv: the bounding box to search within.
Public Sub Query(searchEnv As JTSEnvelope) As List
    Dim rawList As JavaObject
    rawList = mJavaTree.RunMethod("query", Array(searchEnv.GetJavaEnv))
    Dim result As List
    result.Initialize
    Dim sz As Int
    sz = rawList.RunMethod("size", Null)
    Dim i As Int
    For i = 0 To sz - 1
        result.Add(rawList.RunMethod("get", Array(i)))
    Next
    Return result
End Sub

'Removes an element from the index. Returns True if found and removed.
'env: the envelope used when inserting.
'element: the object that was inserted.
Public Sub Remove(env As JTSEnvelope, element As Object) As Boolean
    Return mJavaTree.RunMethod("remove", Array(env.GetJavaEnv, element))
End Sub

'Returns the total number of elements stored in the index.
Public Sub GetSize As Int
    Return mJavaTree.RunMethod("size", Null)
End Sub

'Returns True if no elements have been inserted into the index.
Public Sub IsEmpty As Boolean
    Return mJavaTree.RunMethod("isEmpty", Null)
End Sub

'Explicitly builds the tree structure. Normally called automatically on first Query,
'but can be called manually to control the timing of the build operation.
Public Sub Build
    mJavaTree.RunMethod("build", Null)
End Sub
