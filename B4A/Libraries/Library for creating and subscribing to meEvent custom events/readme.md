### Library for creating and subscribing to meEvent custom events by Darsiar
### 07/12/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/120083/)

The library of simple creation and subscription to user events meEvent allows you to create an event variable in any module (class), and then in other modules (classes) it is easy to subscribe or unsubscribe from these events.  
  
Any number of receivers can be subscribed to one source of any event.  
  
Events can be activated without a parameter or with a parameter that will be transmitted to all receivers.  
The parameter of the event can be a simple quantity, or any complex object, for example, Map  
  
The way to use the library is very simple:  
  

```B4X
' the Event Source Module  
Sub Class_Globals  
    Public NewMessage As meEvent ' source event variable  
End Sub  
  
' Let's say you accept new letters  
Sub NewMessage( messageText as string)  
  
' You are doing something here with your code.  
' ….   
' ….  
  
' Now let's raise an event without a parameter or with a parameter (one of these is one)  
  
NewMessage.RaiceEvent  
NewMessage.RaiceEvent2(messageText)  
  
End Sub
```

  
  
Now subscribe to the event in a different class.  
Please note that when you destroy the class instance or terminate the module, you must unsubscribe from the event, otherwise an error will occur!  

```B4X
Public Sub Initialize (Callback As Object, EventName As String, ServerUrl As String)  
  meEventSouceClass.NewMessage.Add(me, "Print_Message")  
End Sub  
  
Sub Class_Destroy  
  meEventSouceClass.NewMessage.Remove(me, "Print_Message")  
End Sub  
  
Sub Print_Message()  
  
End Sub  
 ' Or if you want with parameter  
Sub Print_Message(value as Object)  
  
End Sub
```