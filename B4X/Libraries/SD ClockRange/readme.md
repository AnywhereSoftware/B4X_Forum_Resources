###  SD ClockRange by Star-Dust
### 02/16/2022
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/138287/)

I wanted to create a view that would help me for a Timer. (MinRange - MaxRange)  
It could be for minutes or hours and then an editable Range. Furthermore, the user had to be able to choose where to start and where to end (MinValue - MaxValue)  
The timer when it started had to show how far it had gone (MinLevel-Max\_Level)  
Here is the result  
  
**NOTE**: *You can use this library for personal and commercial use. Include it in your projects.. Attention, even if it is a **B4XLib** library, it is not allowed to decompress it, modify it, change its name or redistribute it without the permission of the author*  
  
**SD\_ClockRange  
  
Author:** Star-Dust  
**Version:** 0.04  

- **SD\_ClockRange**

- **Events:**

- **ChangeValue** (MinValue As Int, MaxValue As Int)

- **Fields:**

- **mBase** As B4XView
- **Tag** As Object

- **Functions:**

- **BringToFront**
- **DesignerCreateView** (Base As Object, Lbl As Label, Props As Map)
*Base type must be Object*- **GetBase** As B4XView
- **Initialize** (Callback As Object, EventName As String)
- **RemoveViewFromParent**
- **RequestFocus**
- **SendToBack**
- **Snapshot** As B4XView
- **StartPoint** (Degree As Int)
*Degree=90 UP; 135 Left; 180 Down; 215 Right;  
 Degree=112 UP-Left; 202 Down-Left; 67 Up-Right; 237 Down-Rigt*
- **Properties:**

- **BallSize** As Int
- **ColorBase** As Int
- **ColorLevel** As Int
- **ColorStick** As Int
- **Enable** As Boolean
- **Height** As Int
- **Left** As Int
- **LevelVisible** As Boolean
- **MaxLevel** As Float
- **MaxRange** As Float
- **MaxValue** As Int
- **MinLevel** As Float
- **MinRange** As Float
- **MinValue** As Int
- **SizeFont** As Int
- **StickSize** As Int
- **TextColor** As Int
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  
  

- 0.01

- Possibility to select an arc range between two numerical digits. Minimum and maximum range limit is set by design or code
- Possibility of having a colored arc independent of the selected limits (Leve)

- 0.02

- Added the possibility to insert a colored arc along the selected area

- 0.03

- Added properties StickSize and BallSize. They allow you to determine the size / thickness of the selection spheres and the circular bar

  
![](https://www.b4x.com/android/forum/attachments/125321) ![](https://www.b4x.com/android/forum/attachments/125322)