### SD ScheduledAnimations by Star-Dust
### 06/26/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/96675/)

This library creates animations of the views and performs them step by step. Originally this library was based on an idea by [USER=18697]@LordZenzo[/USER], which was fundamentally different from the current one. But not wanting to use an idea that is not mine, for the correctness of [USER=18697]@LordZenzo[/USER] I modified the library in a generator with more step-by-step animations.  
  
The animations are added to a list of STEP and are executed one after the other. You can set to stop the execution of the animations for each animation step made or you can perform all the steps of the animations to follow.  
  
Obviously it is a panel and like every panel it is possible to add some views inside it  
  
**SD\_ScheduledAnimations  
  
Author:** Star-Dust  
**Version:** 0.03  

- **AnimatedPanel**

- **Events:**

- **Click**
- **ClickInfo** (ID As String, Position As Int)
- **EndAnimation**
- **EndSingleMove** (ID As String, Position As Int)

- **Fields:**

- **TimeLapse** As Int

- **Functions:**

- **AddPause** (ID As String, Time As Long) As AnimatedPanel
- **AddView** (View As View, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **BringToFront** As String
- **Class\_Globals** As String
- **ClearMove** As String
- **ContinueAnimation** As String
- **DesignerCreateView** (Base As Panel, Lbl As Label, Props As Map) As String
- **GetAllViewsRecursive** As List
- **GetBase** As Panel
- **GetView** (IndexView As Int) As View
- **Initialize** (Callback As Object, EventName As String) As String
- **InitializeAddtoParent** (Callback As Object, EventName As String, Parent As Panel, Left As Int, Top As Int, Width As Int, Height As Int) As String
- **IsInitialized** As Boolean
*Verifica se l'oggetto sia stato inizializzato.*- **MoveTo** (ID As String, X As Float, Y As Float, Time As Long) As AnimatedPanel
- **MoveToWards** (ID As String, V As View, Time As Long) As AnimatedPanel
- **RemoveAllViews** As String
- **RemoveView** As String
- **RequestFocus** As String
- **ReSetEvent** (Callback As Object, EventName As String) As String
- **Rotate** (ID As String, DegreeX As Float, DegreeY As Float, DegreeZ As Float, Time As Long) As AnimatedPanel
- **SendToBack** As String
- **Start** As String
- **StartFromID** (ID As String) As String
- **StartFromPosition** (Position As Int) As String
- **Stop** As String

- **Properties:**

- **Enable** As Boolean
- **Height** As Int
- **Left** As Int
- **Tag** As Object
- **Top** As Int
- **Visible** As Boolean
- **Width** As Int

  
This is an example of how you can set up some animation steps.  
   
This will be the result