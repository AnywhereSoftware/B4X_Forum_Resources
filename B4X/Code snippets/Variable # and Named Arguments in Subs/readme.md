###  Variable # and Named Arguments in Subs by William Lancee
### 10/21/2023
[B4X Forum - B4X - Code snippets](https://www.b4x.com/android/forum/threads/156341/)

Many of you know how to do this. In the past I have used a variety of techniques, and finally decided on  
one method that feels natural to me, and that remains true to the spirit of B4X.  
  

```B4X
'In Globals: Type namedPar(name As String, value As Object)  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    testPar(Array(1, 2, True, "ABC", ARG("temperature", 75)))  
End Sub  
  
Private Sub testPar(a() As Object)  
    Dim pars As B4XOrderedMap = parsePars(a)  
    Dim npars As Int = pars.Get(0)        'number of parameters is saved in map at 0  
      
    'To iterate through all parameters  
    For i = 1 To npars  
        Log(i & TAB & pars.Get(i))  
    Next  
'    1    1  
'    2    2  
'    3    True  
'    4    ABC  
'    5    75  
  
    'To retieve the value of the third parameter  
    Log(pars.Get(3))        '    True  
  
    'To retieve the value of the fifth parameter  
    Log(pars.Get(5))        '    75  
      
    'To retrieve the value of a named parameter  
    Log(pars.Get("temperature"))        'in this case, it is the same as pars.Get(5) => 75  
      
    'To get the name of the 5th parameter  
    Log(pars.Keys.Get(pars.Keys.IndexOf(5) + 1))    '    temperature  
End Sub
```

  
  

```B4X
#Region Utilities  
Private Sub parsePars(a() As Object) As B4XOrderedMap  
    Dim m As B4XOrderedMap  
    m.Initialize  
    For i = 1 To a.Length  
        If a(i - 1) Is NamedPar Then  
            Dim NPx As NamedPar = a(i - 1)  
            m.Put(i, NPx.value)  
            m.Put(NPx.name, NPx.Value)  
        Else  
            m.Put(i, a(i - 1))  
        End If  
    Next  
    m.Put(0, a.Length)  
    Return m  
End Sub  
  
Public Sub ARG(name As String, value As Object) As NamedPar  
    Dim t1 As NamedPar  
    t1.Initialize  
    t1.name = name  
    t1.value = value  
    Return t1  
End Sub  
#End Region
```