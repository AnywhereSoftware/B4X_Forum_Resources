### [Example]Using the Within Class Full Access Feature by William Lancee
### 08/25/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/133740/)

When my assumptions are challenged I listen.  
We all know Public variables and subs in a class are available to procedures external to the class.  
But recently I learned from [USER=51832]@LucaMs[/USER] that Private variables and subs are also available to instances of class within the definition of that class.  
  
<https://www.b4x.com/android/forum/threads/private-class-variable-visibility.133677/>  
  
Access to private members of other instances of a class can be risky but also powerful and interesting. I decided to explore how this feature could be used safely.  
  
Let's take an example from [USER=51832]@LucaMs[/USER]'s thread. A person class has multiple instances, including one person who acts as a registrar.  
All variables are Private to the outside world. Some methods are available to to all members, other methods should be restricted to the registrar.  
The technique shown in the code below demonstrate how this can be achieved with this feature.  
  

```B4X
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Dim registrar As clsPerson  
    Dim people As String = _  
$"  
Charlie, 20000  
Francine, 30000  
Malcome, 300000  
Angela, 120000  
"$  
    registrar.Initialize("William", "Admin1234*")  
    registrar.Register(people)  
  
    registrar.AllPersons("Admin1234*")  
    
    Log("————")  
    registrar.SalaryOf("Charlie", "Admin1234*")  
    Log("————")  
    Dim Francine As clsPerson = registrar.getPerson("Francine", "Admin1234*")  
    Log(Francine.Colleagues)  
  
    Dim Charlie As clsPerson = registrar.getPerson("Charlie", "Admin1234*")  
    Log(Charlie.Colleagues)  
    Log("————")  
    
    Log(Charlie.AllPersons(""))  
End Sub
```

  
  
And in the clsPerson definition:  
  

```B4X
Sub Class_Globals  
    Private mName As String  
    Private mSalary As Double  
    Private mRegister As List  
    Private mRegistrar As clsPerson  
    Private mPassword As String  
    Private mMapByName As Map  
End Sub  
  
Public Sub Initialize(name As String, password As String)  
    mPassword = password  
    mName = name  
    mSalary = "NaN"  
    If password<>"" Then  
        mRegister.Initialize  
        mRegistrar = Me  
        mRegister.Add(Me)  
        mMapByName.Initialize  
        mMapByName.Put(mName, Me)  
    End If  
End Sub  
  
Public Sub Register(people As String)  
    Dim v() As String = Regex.Split(CRLF, people)  
    For Each s As String In v  
        Dim w() As String = Regex.Split(",", s)  
        If w.Length = 2 Then  
            Dim person As clsPerson  
            person.Initialize(w(0), "")  
            person.mSalary = w(1)  
            mRegister.Add(person)  
            person.mRegistrar = mRegistrar  
            mMapByName.Put(w(0), person)  
        End If  
    Next  
End Sub  
  
Public Sub AllPersons(password As String)  
    If password = mPassword And mRegister.isInitialized Then  
        For Each person As clsPerson In mRegister  
            Log(person.mName & TAB & person.mSalary)  
        Next  
    Else  
        Log("Access Denied")  
    End If  
End Sub  
  
Public Sub SalaryOf(name As String, password As String)  
    If password = mPassword And mRegister.isInitialized Then  
        Log(name & TAB & mMapByName.Get(name).As(clsPerson).mSalary)  
    Else  
        Log("Access Denied")  
    End If  
End Sub  
  
Public Sub getPerson(name As String, password As String) As clsPerson  
    If password = mPassword And mRegister.isInitialized Then  
        Return mMapByName.Get(name)  
    Else  
        Log("Access Denied")  
        Return Null  
    End If  
End Sub  
  
Public Sub Colleagues As List  
    Dim theList As List  
    theList.Initialize  
    For Each person As clsPerson In mRegistrar.mRegister  
        If person.mName <> mName Then theList.Add(person.mName)  
    Next  
    Return theList  
End Sub
```

  
  