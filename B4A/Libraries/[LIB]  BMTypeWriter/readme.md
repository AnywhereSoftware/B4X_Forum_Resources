### [LIB]  BMTypeWriter by Brian Michael
### 04/03/2023
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/146041/)

Hello everyone, here I bring you a tool to create the writing effect.  
It is basic but functional.  
  
Thank you for viewing this library.  
  
![](https://www.b4x.com/android/forum/attachments/139106)  
  
  
**BMTypeWriter  
  
Author:   
Version:** 1  

- **BMTypeWriter**
*Create a simple TypeWriter Effect on any TextView  
 Example:  
   
 Writer1.Initialize(Me, "Writer1")  
 Writer1.Text = $"Hi, my name is B4X Writer!"$  
 Writer1.start  
 'To listen to the animation you must use the event :  
 Sub Writer1\_Writer(Text as String)  
 Log(Text)  
 End Sub*

- **Events:**

- **Pause**
- **Stop**
- **Writer** (Text As String)

- **Fields:**

- **mCallBack** As Object
- **mEventName** As String

- **Functions:**

- **Class\_Globals** As String
- **getInterval** As Int
- **getText** As String
- **Initialize** (CallBack As Object, EventName As String) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Prueba si acaso el objeto ha sido inicializado.*- **pause** As String
*Pause the typing animation.*- **reset**
*Start from the beginning the typing animation.*- **setInterval** (Interval As Int) As String
- **setText** (Text As String) As String
- **start** As String
*Start the typing animation.*- **stop** As String
*Stop the typing animation and delete the string.*
- **Properties:**

- **Interval** As Int
- **Text** As String

  
  
  

```B4X
    Writer1.Initialize(Me, "Writer1")  
    Writer1.Text = $"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.  
The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.!"$  
    Writer1.Interval = 100  
   
  
    Writer1.start
```

  
  

```B4X
Sub Writer1_Writer(Text as String)  
    Log(Text)  
End Sub
```