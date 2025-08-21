### Starchild_B4J_Dialogs by Starchild
### 04/12/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/115571/)

This library contains three simple and stylish Dialog classes. They are intended to provide an App styled user interface to the B4J window/form environment.  
  

- A **ToastMsg** class to present a single or multi-line banner momentarily on top of the owner form.
- A **MsgBox** class to present more complex information to the user with an icon, title and multi-line message body then requesting the user to acknowledge by clicking on one of the three button choices. This is a NON-BLOCKING dialog box that presents centrally on top of the owner form.
- An **InputBox** class to firstly present the user with information but requesting user data entry (can use limited text types, lengths, multi-line, etc) then requesting the user to acknowledge by clicking on one of the three button choices. This is a NON-BLOCKING dialog box that presents centrally on top of the owner form.

Dialogs are a convenient way to interrupt the normal program operation, grab the user’s immediate attention, and provide a controlled and simplified data entry and user response mechanism that can be easily and sequentially coded using “Wait For” and “Select Case” language commands.  
  

```B4X
Dim MB as Starchild_B4J_MsgBox  
Dim TM as Starchild_B4J_ToastMsg  
  
MB.Initialize(MainForm,Me)  
TM.Initialize(MainForm,Me)  
  
MB.MsgBox(“Hello World”,“This is a MsgBox”)  
  
Wait For (MB) Click  
  
Select MB.Response  
    Case MB. RESPONSE_POSITIVE  
        TM.ToastMsg(“You Clicked the <OK> button”)  
        Wait For (TM) Finished  
End Select  
  
Log (“Done”)
```

  
  
  
  
  
  
![](https://www.b4x.com/android/forum/attachments/90880)  
![](https://www.b4x.com/android/forum/attachments/90881)  
  
![](https://www.b4x.com/android/forum/attachments/90868)  
  
![](https://www.b4x.com/android/forum/attachments/90869)  
  
Currently Library v2.01