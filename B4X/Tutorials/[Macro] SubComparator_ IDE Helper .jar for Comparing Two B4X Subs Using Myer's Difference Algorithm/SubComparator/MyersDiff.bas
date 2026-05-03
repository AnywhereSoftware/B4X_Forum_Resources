B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
'Class: MyersDiff
Sub Class_Globals
    Type DiffStep(Operation As String, Text As String)
End Sub

Public Sub Initialize
End Sub

' Returns a List of DiffStep types comparing OldList to NewList
Public Sub Compare(OldList As List, NewList As List) As List
    Dim n As Int = OldList.Size
    Dim m As Int = NewList.Size
    Dim maxPath As Int = n + m
    
    ' V array stores the furthest reaching X for each diagonal K
    Dim v As Map
    v.Initialize
    v.Put(1, 0)
    
    ' Traces to backtrack the path
    Dim traces As List
    traces.Initialize
    
    Dim done As Boolean = False
    For d = 0 To maxPath
        Dim vCopy As Map
        vCopy.Initialize
        For Each key In v.Keys
            vCopy.Put(key, v.Get(key))
        Next
        traces.Add(vCopy)
        
        For k = -d To d Step 2
            Dim x As Int
            ' Decide to move down or right
            If k = -d Or (k <> d And v.GetDefault(k - 1, 0) < v.GetDefault(k + 1, 0)) Then
                x = v.GetDefault(k + 1, 0)
            Else
                x = v.GetDefault(k - 1, 0) + 1
            End If
            
            Dim y As Int = x - k
            
            ' Snaking (EQUAL)
            Do While x < n And y < m And OldList.Get(x) = NewList.Get(y)
                x = x + 1
                y = y + 1
            Loop
            
            v.Put(k, x)
            
            If x >= n And y >= m Then
                done = True
                Exit
            End If
        Next
        If done Then Exit
    Next
    
    Return Backtrack(OldList, NewList, traces)
End Sub

Private Sub Backtrack(OldList As List, NewList As List, traces As List) As List
    Dim result As List
    result.Initialize
    
    Dim x As Int = OldList.Size
    Dim y As Int = NewList.Size
    
    For d = traces.Size - 1 To 1 Step -1
        Dim v As Map = traces.Get(d)
        Dim k As Int = x - y
        
        Dim prevK As Int
        If k = -d Or (k <> d And v.GetDefault(k - 1, 0) < v.GetDefault(k + 1, 0)) Then
            prevK = k + 1
        Else
            prevK = k - 1
        End If
        
        Dim prevX As Int = v.Get(prevK)
        Dim prevY As Int = prevX - prevK
        
        ' Snaking backwards
        Do While x > prevX And y > prevY
            Dim StepX As DiffStep
            StepX.Operation = "EQUAL"
            StepX.Text = OldList.Get(x - 1)
            result.InsertAt(0, StepX)
            x = x - 1
            y = y - 1
        Loop
        
        Dim StepX As DiffStep
        If x = prevX Then
            StepX.Operation = "INSERT"
            StepX.Text = NewList.Get(y - 1)
        Else
            StepX.Operation = "DELETE"
            StepX.Text = OldList.Get(x - 1)
        End If
        result.InsertAt(0, StepX)
        
        x = prevX
        y = prevY
    Next
    
    ' Initial snaking
    Do While x > 0 And y > 0
        Dim StepX As DiffStep
        StepX.Operation = "EQUAL"
        StepX.Text = OldList.Get(x - 1)
        result.InsertAt(0, StepX)
        x = x - 1
        y = y - 1
    Loop

    Return result
End Sub

