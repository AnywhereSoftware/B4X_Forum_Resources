### Cloning Class Instances, Semi-Automatic Self-Replication, and a Trick by William Lancee
### 02/20/2022
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/138612/)

Disclaimer:  
None of the techniques used here are new to our community and you may have seen the 'Trick' used by me before.  
  
The Problem:  
We are using classes more frequently, especially with B4XPages. After laboriously creating an instance  
of a class, we often need another one just like it (except prehaps for some small differences).  
  
We know how to create a Clone Sub in the Class that will spawn another instance.  
  

```B4X
'In use:    Dim Instance2 as ClassName = Instance1.Clone  
'In ClassName:  
Public Sub Clone As ClassName  
    Dim newInstance as ClassName  
    newInstance.Initialize  
    newInstance.propertyX = propertyX  
    'etc.  
    return NewInstance  
End Sub
```

  
  
If the class has few properties we can do this manually.  
However, Classes can become complex with numerous properties and variables.  
These can be arrays, and other structures that can be difficult to copy.  
  
The Trick:  
In the IDE we copy the properties section and paste it into a Smart String  
  

```B4X
Sub Class_Globals  
    Private fx As JFX  
    Private xui As XUI  
    Private ser As B4XSerializator  
  
    'Properties    and variables for cloning  
    Private mNames() As String  
    Private mAge, mHeight As Int  
    Private mChildren As List  
    Private mBox As B4XView  
    Public OnState As Boolean  
    Private i = 0, j = 2, k = 5 As Int                                                'ignore  
    Private txt = "test" As String, value = 1.05 As Double, flag = False As Boolean 'ignore  
     
    'Smart string version  
    Private propsToClone As String = $"  
    Private mNames() As String  
    Private mAge, mHeight As Int  
    Private mChildren As List  
    Private mBox As B4XView  
    Public OnState As Boolean  
    Private i = 0, j = 2, k = 5 As Int                                                'ignore  
    Private txt = "test" As String, value = 1.05 As Double, flag = False As Boolean 'ignore  
    "$  
End Sub
```

  
  
By parsing and processing "propsToClone" we can generate "copying code" for the Clone Sub  
This code is put on the Clipboard, available for pasting in the Clone Sub.  
  

```B4X
Public Sub Initialize(FirstName As String, LastName As String)  
    mChildren.Initialize  
    mNames = Array As String(FirstName, LastName)  
    OnState = True  
End Sub  
  
Public Sub Clone As classA  
    CloningCodeToClipboard    'The Smart string version is parsed and code is generated and placed on clipboard.  
    Dim newInstance As classA  
    newInstance.Initialize(mNames(0), mNames(1))  
     
    'After 1st attempt at cloning, paste clipboard contents below.  
    '_____________________________I have pasted the contents of clipboard, before I did that this section was empty  
    newInstance.mNames = copyStringArray(mNames)  
    newInstance.mAge = mAge  
    newInstance.mHeight = mHeight  
    newInstance.mChildren = copyStructure(mChildren)  
    newInstance.mBox = copyPanel(mBox)  
    newInstance.OnState = OnState  
    newInstance.i = i  
    newInstance.j = j  
    newInstance.k = k  
    newInstance.txt = txt  
    newInstance.value = value  
    newInstance.flag = flag  
    '_____________________________  
  
    Return newInstance  
End Sub
```

  
  
You'll see that the generated code relies on a number of helper functions. One requires the RandomAccessFile library.  
The Example with the CloningCodeToClipboard Sub, and Helper Subs is attached as a .zip file.  
  
The use of the example above…  

```B4X
Private Sub demonstrate  
    Dim InstanceA As classA  
    InstanceA.Initialize("Alpha", "Beta")  
    InstanceA.Age = 45  
    InstanceA.Height = 181  
    InstanceA.MakeBox  
     
    Dim InstanceB As classA = InstanceA.Clone        
    'If the class is a B4XPage then you need to register it with B4XPages.AddPage now.  
    InstanceB.Age = 75  
    InstanceB.AddChild("William")  
    InstanceB.AddChild("Suzanna")  
     
    Log(InstanceA.Names(0) & TAB & InstanceA.Names(1) & TAB & InstanceA.Age & TAB & InstanceA.Height & TAB & InstanceA.Children.Size)  
    Log(InstanceB.Names(0) & TAB & InstanceB.Names(1) & TAB & InstanceB.Age & TAB & InstanceA.Height & TAB & InstanceB.Children.Size)  
    Log(InstanceB.Box.Width)  
     
'    Alpha    Beta    45    181    0  
'    Alpha    Beta    75    181    2  
'    300  
End Sub
```

  
  
For Consideration:  
Manipulating code like this should be considered as a possible time saver, but is not generally recommended.  
It could lead to errors (for example: was there or will there be something unexpected on the Clipboard?).  
I'll use it, since I am very methodical in how I code, and I check and test every step of the way.  
  
Finally, the attachment has a series of Helper Subs that are useful in their own right. Take a look.  
Feedback is welcome.