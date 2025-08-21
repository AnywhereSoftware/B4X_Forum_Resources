###  [XUI] SD: B4XViewEvent by Star-Dust
### 12/24/2019
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/92507/)

Using the XUI views I realized the need to follow the events of Touch, Drag, Click and Release in a unique way. Required **XUI 1.72+**  
  
In Android I would use this command:  

```B4X
Sub EventName_Touch (Action As Int, X As Float, Y As Float)
```

  
  
In B4J I would use this:  

```B4X
Sub EventName_MouseDragged (EventData As MouseEvent)  
Sub EventName_MouseClicked (EventData As MouseEvent)  
Sub EventName_MouseReleased (EventData As MouseEvent)
```

  
  
I wanted to create an XUI class that manages things in a standard way, so if we write apps using XUI views we can also have a standard when we write code related to events, without having to use #IF B4A, #IF B4J  
  
> In B4A the result is the same that you would get by setting the Touch event with JavaObject.SetOnTouchListener  
>   
> In B4J the result is the same that you would get the same as creating an Event with o.CreateEvent ("javafx.event.EventHandler", "Event")  
>   
> **B4i** not available at the moment

  
**SD\_B4XViewEvent**  
  
**Author:** Star-Dust  
**Version:** 0.01  

- **ManagerEvent**

- **Events:**

- **TouchEvent** (action As Int, Coordinate() As TCoordinate)
' Cordinate is array for Multi-touch (Only B4A)
- **Fields:**

- **Action\_Click** As Int
- **Action\_DoubleClick** As Int
- **Action\_Down** As Int
- **Action\_Drag** As Int
- **Action\_LongClick** As Int
- **Action\_LoseTouch** As Int
- **Action\_Up** As Int
- **MinMoveAccept** As Int ' Default is 2dip (only B4A)

- **Functions:**

- **Class\_Globals** As String
- **CreateViewSetEvent** (View As View, EventName As String) As B4XView
- **getLastClick** As Long
- **Initialize** (mCallBack As Object) As String
*Initializes the object. You can add parameters to this method if needed.*- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **SetEvent** (View As View, EventName As String) As ManagerEvent

- **Properties:**

- **LastClick** As Long [read only]

- **TCoordinate**

- **Fields:**

- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **X** As Float
- **Y** As Float

- **Functions:**

- **Initialize**
*Inizializza i campi al loro valore predefinito.*